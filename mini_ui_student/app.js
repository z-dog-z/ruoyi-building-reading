// 小程序入口：只保留通用初始化和无感登录，不包含任何业务请求。
// 说明：首次登录不再由 index 页面主动调用，而是由 onShow 里的 insertViews 顺带触发。
const api = require('./config/api.js')

App({
  onLaunch() {
    // 清理旧版本可能留下的 sessionKey；学生框架不使用它。
    wx.removeStorageSync('sessionKey')

    // 计算自定义导航栏需要的尺寸；页面可以从 getApp().globalData 读取。
    const windowInfo = typeof wx.getWindowInfo === 'function' ? wx.getWindowInfo() : {}
    const menu = wx.getMenuButtonBoundingClientRect
      ? wx.getMenuButtonBoundingClientRect()
      : { top: windowInfo.statusBarHeight || 0, height: 32 }
    const statusBarHeight = windowInfo.statusBarHeight || 0

    this.globalData.navBarHeight =
      (menu.top - statusBarHeight) * 2 + menu.height + statusBarHeight
    this.globalData.reHeight = menu.top
  },

  /*
   * onShow：小程序启动 / 从后台回到前台时触发。
   * 这里调用 insertViews 浏览量接口，顺带完成首次无感登录：
   *   insertViews -> wxRequest -> _sendRequest -> ensureLogin
   * 如果本地没有 token，ensureLogin 会自动走 wx.login 拿 code 换 token。
   */
  onShow() {
    // 只上报一次，避免频繁切前台重复触发
    if (this.globalData.hasInsertedViews) return
    this.globalData.hasInsertedViews = true

    this.wxRequest(
      'POST',                // 如果后端要求 GET，改成 'GET'
      api.insertViews,
      (res) => {
        console.log('insertViews 成功', res.data)
      },
      (err) => {
        console.warn('insertViews 失败', err)
      },
      {}                     // 需要传的参数，例如 { page: 'home' }
    )
  },

  /*
   * 无感登录流程：
   * 1. 本地已有后端 token 时直接复用，用户无需看到登录页。
   * 2. 没有 token 时调用 wx.login，拿一次性 code 请求后端登录接口。
   * 3. 后端校验 code 后返回业务 token，前端只保存后端 token。
   * 4. 接口返回 401 时清除旧 token，并自动重新登录重试一次。
   *
   * wx.login 返回的 code 不是登录态，不能当作长期 token 使用。
   */
  ensureLogin(onToken, onError, forceRefresh = false) {
    if (!forceRefresh) {
      const cached = wx.getStorageSync('login')
      if (cached) {
        onToken && onToken(cached)
        return
      }
    }

    if (!api.baseUrl) {
      const error = { errMsg: '请先在 config/env.js 配置 baseUrl 和 appId' }
      onError && onError(error)
      return
    }

    wx.login({
      success: (res) => {
        if (!res.code) {
          onError && onError(res)
          return
        }
        wx.request({
          url: api.wxLogin(res.code),
          method: 'GET',
          header: {
            'content-type': 'application/x-www-form-urlencoded;charset=utf-8'
          },
          success: (response) => {
            const data = response.data && response.data.data
            if (!data || !data.token) {
              onError && onError(response)
              return
            }
            wx.setStorageSync('login', data.token)
            // 学生框架只保存后端业务 token，不把微信 sessionKey 写入本地缓存。
            onToken && onToken(data.token)
          },
          fail: (error) => onError && onError(error)
        })
      },
      fail: (error) => onError && onError(error)
    })
  },

  // 通用 JSON 请求封装；业务页面只需要传入自己的 URL 和数据。
  wxRequest(method, url, callback, errFun, data = {}) {
    this._sendRequest(method, url, callback, errFun, data, false)
  },

  _sendRequest(method, url, callback, errFun, data, retried) {
    this.ensureLogin((token) => {
      wx.request({
        url,
        method,
        data,
        header: {
          'content-type': 'application/x-www-form-urlencoded;charset=utf-8',
          Authorization: token
        },
        dataType: 'json',
        success: (response) => {
          const code = response.data && response.data.code
          if ((response.statusCode === 401 || code === 401) && !retried) {
            wx.removeStorageSync('login')
            this._sendRequest(method, url, callback, errFun, data, true)
            return
          }
          callback && callback(response)
        },
        fail: (error) => errFun && errFun(error)
      })
    }, errFun)
  },

  // 文件上传封装，与 wxRequest 使用同一套无感登录和 401 重试逻辑。
  wxUpload(url, filePath, formData, callback, errFun) {
    this._sendUpload(url, filePath, formData, callback, errFun, false)
  },

  _sendUpload(url, filePath, formData, callback, errFun, retried) {
    this.ensureLogin((token) => {
      wx.uploadFile({
        url,
        filePath,
        name: 'file',
        header: { Authorization: token },
        formData: formData || {},
        success: (response) => {
          let parsed = null
          try {
            parsed = JSON.parse(response.data)
          } catch (e) {
            // 后端返回非 JSON 文本时，继续把原始响应交给调用方。
          }
          const code = parsed && parsed.code
          if ((response.statusCode === 401 || code === 401) && !retried) {
            wx.removeStorageSync('login')
            this._sendUpload(url, filePath, formData, callback, errFun, true)
            return
          }
          callback && callback({ ...response, data: parsed == null ? response.data : parsed })
        },
        fail: (error) => errFun && errFun(error)
      })
    }, errFun)
  },

  // 只获取 token，不主动请求业务接口。
  getToken(callback, errFun) {
    this.ensureLogin(callback, errFun)
  },

  globalData: {
    navBarHeight: 0,
    reHeight: 0,
    hasInsertedViews: false   // 防止 onShow 重复上报
  }
})