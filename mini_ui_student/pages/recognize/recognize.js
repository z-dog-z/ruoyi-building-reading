// pages/recognize/recognize.js
// 拍照识别完整流程：chooseMedia → Canvas2D 压缩 → uploadFile 带经纬度 → scanthing → 成功/失败页
// 严格按照老师给的 6 步流程实现，只用 success 回调判断，忽略 resultCode
const api = require('../../config/api.js')
const app = getApp()

// 压缩目标：长边不超过 1080，等比缩放保证不变形（太小会降低百度以图搜图识别率）
const COMPRESS_TARGET = { w: 1080, h: 1080 }

Page({
  data: {
    previewPath: '',       // 压缩后用于展示的临时路径
    loading: false,
    statusBarHeight: 20,
    // Canvas 2D 所需的 node 引用
    canvasNode: null,
    canvasCtx: null
  },

  onLoad() {
    const info = wx.getWindowInfo ? wx.getWindowInfo() : {}
    this.setData({ statusBarHeight: info.statusBarHeight || 20 })
  },

  onBack() {
    // 有历史栈就返回，没有就回首页
    const pages = getCurrentPages()
    if (pages.length > 1) wx.navigateBack({ delta: 1 })
    else wx.reLaunch({ url: '/pages/home/home' })
  },

  /* ================= 1. 先申请位置权限，再调起相机/相册 ================= */
  onPick() {
    wx.getSetting({
      success: (res) => {
        const auth = res.authSetting['scope.userLocation']
        if (auth === true) {
          // 已授权：直接选图
          this._pick()
        } else if (auth === false) {
          // 之前拒绝过：弹窗引导去设置页开启
          wx.showModal({
            title: '需要位置权限',
            content: '识别建筑时会结合您的位置提高准确率，是否前往设置开启位置权限？',
            confirmText: '去设置',
            success: (m) => {
              if (m.confirm) {
                wx.openSetting({ complete: () => this._pick() })
              } else {
                this._pick()
              }
            }
          })
        } else {
          // 从未询问：主动申请位置权限（相册/相机权限会在选图时由微信弹窗询问）
          wx.authorize({
            scope: 'scope.userLocation',
            complete: () => this._pick()
          })
        }
      },
      fail: () => this._pick()
    })
  },

  _pick() {
    wx.chooseMedia({
      count: 1,
      mediaType: ['image'],
      sourceType: ['camera', 'album'],
      sizeType: ['compressed'],
      camera: 'back',
      success: (res) => {
        const file = res.tempFiles && res.tempFiles[0]
        if (!file) return
        this.compressImage(file.tempFilePath, file.width, file.height)
      }
    })
  },

  /* ================= 2. Canvas2D 按比例压缩 =================
       老师要求：Canvas2D 按比例压缩，约 100×150
  */
  compressImage(srcPath, origW, origH) {
    wx.showLoading({ title: '压缩中...', mask: true })

    // 按比例缩放，保证宽高比不变
    const scale = Math.min(
      COMPRESS_TARGET.w / origW,
      COMPRESS_TARGET.h / origH,
      1
    )
    const targetW = Math.max(1, Math.round(origW * scale))
    const targetH = Math.max(1, Math.round(origH * scale))

    // 用新版 Canvas 2D API
    wx.createSelectorQuery()
      .in(this)
      .select('#compress')
      .fields({ node: true, size: true })
      .exec((res) => {
        if (!res || !res[0]) {
          // Canvas2D 不可用时降级：直接传原图
          wx.hideLoading()
          this.compressedPath = srcPath
          this.setData({ previewPath: srcPath })
          this.startScan()
          return
        }
        const canvas = res[0].node
        const ctx = canvas.getContext('2d')
        const dpr = wx.getSystemInfoSync().pixelRatio || 1
        canvas.width = targetW * dpr
        canvas.height = targetH * dpr
        ctx.scale(dpr, dpr)

        // 画图片
        const img = canvas.createImage()
        img.onload = () => {
          ctx.clearRect(0, 0, targetW, targetH)
          ctx.drawImage(img, 0, 0, targetW, targetH)
          // 导出压缩后的图片
          wx.canvasToTempFilePath({
            canvas,
            fileType: 'jpg',
            quality: 0.85,
            success: (out) => {
              wx.hideLoading()
              this.compressedPath = out.tempFilePath
              this.setData({ previewPath: out.tempFilePath })
              this.startScan()
            },
            fail: () => {
              wx.hideLoading()
              // 再降级
              this.compressedPath = srcPath
              this.setData({ previewPath: srcPath })
              this.startScan()
            }
          }, this)
        }
        img.onerror = () => {
          wx.hideLoading()
          this.compressedPath = srcPath
          this.setData({ previewPath: srcPath })
          this.startScan()
        }
        img.src = srcPath
      })
  },

  /* ================= 3. 取经纬度 ================= */
  startScan() {
    if (this.data.loading) return
    this.setData({ loading: true })
    wx.showLoading({ title: '识别中...', mask: true })

    wx.getLocation({
      type: 'gcj02',
      isHighAccuracy: false,
      success: (loc) => this._uploadScan(loc.longitude, loc.latitude),
      fail: () => this._uploadScan('', '')
    })
  },

  /* ================= 4. uploadFile 上传图片和经纬度 ================= */
  _uploadScan(long, lat) {
    const filePath = this.compressedPath || this.data.previewPath
    if (!filePath) {
      this._fail('图片路径丢失')
      return
    }
    app.wxUpload(
      api.scanThing,
      filePath,
      { tag: '1', long: String(long), lat: String(lat), source: '', sourceDetail: '' },
      (resp) => this._onScanSuccess(resp),
      (err) => this._fail('网络请求失败：' + (err && err.errMsg || ''))
    )
  },

  /* ================= 5. 判断 =================
       只用 success 回调判断，忽略 resultCode
       success=true 且 travelScenicSpot 存在 → 成功
       否则 → 失败兜底
  */
  _onScanSuccess(resp) {
    wx.hideLoading()
    this.setData({ loading: false })
    const parsed = resp.data
    const success = parsed && (parsed.success === true || parsed.code === 200)
    const result = parsed && parsed.data

    if (success && result && result.travelScenicSpot) {
      wx.redirectTo({
        url: `/pages/rSuccess/rSuccess?id=${result.travelScenicSpot.id}`
      })
    } else {
      const rec = result && result.recommendTravelScenicSpots
      const recJson = rec ? encodeURIComponent(JSON.stringify(rec)) : ''
      wx.redirectTo({ url: `/pages/rFail/rFail?rec=${recJson}` })
    }
  },

  _fail(msg) {
    wx.hideLoading()
    this.setData({ loading: false })
    wx.showToast({ title: msg || '识别失败', icon: 'none' })
    setTimeout(() => {
      wx.redirectTo({ url: '/pages/rFail/rFail?rec=' })
    }, 500)
  }
})
