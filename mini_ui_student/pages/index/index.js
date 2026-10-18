const app = getApp()

Page({
  data: {
    status: '正在尝试无感登录…'
  },

  onLoad() {
    this.silentLogin()
  },

  silentLogin() {
    this.setData({ status: '正在登录…' })
    app.getToken(
      () => this.setData({ status: '无感登录成功，已取得后端 token。' }),
      (error) => this.setData({
        status: `登录未完成：${(error && error.errMsg) || '请检查后端地址、AppID 和接口配置。'}`
      })
    )
  },

  retryLogin() {
    wx.removeStorageSync('login')
    this.silentLogin()
  }
})
