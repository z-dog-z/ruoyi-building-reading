// pages/home/home.js
// 主页面（建筑可阅读）
const request = require('../../utils/request.js')
const router = require('../../utils/router.js')
const api = require('../../config/api.js')
const app = getApp()

// 入口卡默认封面（后端“封面图管理”未配置时兜底）
const DEFAULT_RECOGNIZE = 'https://ar-travel-file.1jiaohu.com/resource/20260610/571efc98d49549dea908da666de2fe0a.png'
const DEFAULT_BUILDING = 'https://ar-travel-file.1jiaohu.com/resource/20260610/e8f8d5130b6c461881d07c0467739e70.jpg'

// 压缩目标：长边不超过 1080，等比缩放保证不变形（太小会降低百度以图搜图识别率）
const COMPRESS_TARGET = { w: 1080, h: 1080 }

Page({
  data: {
    banners: [],          // 顶部轮播：取景点封面图做轮播
    currentBanner: 0,     // 轮播当前下标
    activity: null,       // 酷跑活动（为您推荐）
    videos: [],           // 热剧游山农大（视频列表）
    spots: [],
    recognizeCover: DEFAULT_RECOGNIZE,
    buildingCover: DEFAULT_BUILDING,
    scanning: false       // 识别流程进行中，防止重复点击
  },

  onLoad() {
    this.loadBanners()
    this.loadActivity()
    this.loadVideos()
    this.loadSpots()
    this.loadCovers()
  },

  onShow() {
    // 从设置页/封面图管理回来时刷新封面
    this.loadCovers()
  },

  // 封面图管理：type=0 拍照识别封面，type=1 建筑可阅读封面
  loadCovers() {
    request({
      url: api.coverPicture(0),
      success: (res) => {
        const url = res.data && res.data.data
        if (typeof url === 'string') this.setData({ recognizeCover: url })
      }
    })
    request({
      url: api.coverPicture(1),
      success: (res) => {
        const url = res.data && res.data.data
        if (typeof url === 'string') this.setData({ buildingCover: url })
      }
    })
  },

  /* ------------------- 顶部轮播：取 Banner 管理的图 ------------------- */
  loadBanners() {
    request({
      url: api.bannerList,
      success: (res) => {
        const list = (res.data && res.data.data) || []
        const banners = list
          .filter((s) => s.background)
          .map((s) => ({ id: s.id, url: s.background, title: s.name || '', link: s.url || '', type: s.type }))
        if (banners.length) this.setData({ banners })
        else this.setData({ banners: [] })
      },
      fail: () => {
        this.setData({ banners: [] })
      }
    })
  },

  /* ------------------- 活动列表：筛选"酷跑活动" ------------------- */
  loadActivity() {
    request({
      url: api.getActivityList,
      data: { pageNum: 1, pageSize: 20 },
      success: (res) => {
        const rows = (res.data && res.data.rows) || []
        // 按名称匹配"酷跑活动"
        const activity = rows.find((a) =>
          a.name && (a.name.indexOf('酷跑') !== -1 || a.name.indexOf('跑酷') !== -1)
        )
        if (activity) this.setData({ activity })
      }
    })
  },

  /* ------------------- 热剧游山农大：VideoList ------------------- */
  loadVideos() {
    request({
      url: api.videoList,
      data: { pageNum: 1, pageSize: 10 },
      success: (res) => {
        const rows = (res.data && res.data.rows) || []
        this.setData({ videos: rows })
      }
    })
  },

  /* ------------------- 建筑可阅读列表 ------------------- */
  loadSpots() {
    request({
      url: api.scenicspotList,
      data: { pageNum: 1, pageSize: 30 },
      success: (res) => {
        const rows = (res.data && res.data.rows) || []
        this.setData({ spots: rows })
      }
    })
  },

  /* ------------------- 事件 ------------------- */

  onBannerChange(e) {
    this.setData({ currentBanner: e.detail.current })
  },

  // 点轮播图：按 banner 管理配置的地址跳转
  // type=1 内部 → banner地址填小程序页面路径（如 /pages/building/building）
  // type=2 外部 → banner地址填网页链接，用 web-view 打开
  // 地址没配或格式不对时，兜底进"建筑可阅读"列表页
  onBannerTap(e) {
    const item = this.data.banners[e.currentTarget.dataset.index] || {}
    const link = (item.link || '').trim()
    if (item.type === 2 && /^https?:\/\//i.test(link)) {
      router.navigateTo(`/pages/webview/webview?url=${encodeURIComponent(link)}`)
      return
    }
    if (link.charAt(0) === '/') {
      router.navigateTo(link)
      return
    }
    router.navigateTo('/pages/building/building')
  },

  // 点活动卡片
  onActivityTap() {
    router.navigateTo('/pages/activityList/activityList')
  },

  // 点"查看全部" → 热剧游山农大完整列表页
  onVideoAll() {
    router.navigateTo('/pages/videos/videos')
  },

  // 点视频卡片
  onVideoTap(e) {
    const v = this.data.videos[e.currentTarget.dataset.index]
    if (!v) return
    router.navigateTo(`/pages/detail/detail?videoId=${v.id}`)
  },

  // 拍照识别入口：不跳转
  // 流程：位置框 → 相机/相册框 → 同意弹选图 → 拒绝给提示
  onRecognize() {
    if (this.data.scanning) return
    // 第 1 步：获取位置（首次调用弹底部位置权限框）
    wx.getLocation({
      type: 'gcj02',
      isHighAccuracy: false,
      success: (loc) => {
        this._scanLocation = { lng: loc.longitude, lat: loc.latitude }
        this._requestCamera()
      },
      fail: () => {
        // 位置拒绝也继续，弹相机/相册框
        this._scanLocation = null
        this._requestCamera()
      }
    })
  },

  // 第 2 步：请求相机/相册权限（首次弹底部系统框，绿色允许/灰色拒绝）
  _requestCamera() {
    wx.authorize({
      scope: 'scope.camera',
      success: () => {
        // 用户同意 → 弹出选图界面
        this._pickFromAlbum()
      },
      fail: () => {
        // 用户拒绝 → 提示
        wx.showModal({
          title: '权限提示',
          content: '需要允许开启相机/相册权限才能使用拍照识别功能，是否前往设置开启？',
          confirmText: '去设置',
          cancelText: '取消',
          success: (m) => {
            if (m.confirm) {
              wx.openSetting({
                success: (s) => {
                  // 用户从设置回来，如果已授权则继续
                  if (s.authSetting['scope.camera']) {
                    this._pickFromAlbum()
                  }
                }
              })
            }
          }
        })
      }
    })
  },

  // 选图界面（从相册选）
  _pickFromAlbum() {
    wx.chooseMedia({
      count: 1,
      mediaType: ['image'],
      sourceType: ['album', 'camera'],
      sizeType: ['compressed'],
      camera: 'back',
      success: (res) => {
        const file = res.tempFiles && res.tempFiles[0]
        if (!file) return
        this._compressImage(file.tempFilePath, file.width, file.height)
      },
      fail: () => {
        // 用户取消选图
      }
    })
  },

  // Canvas2D 按比例压缩（首页需存在隐藏的 #compress canvas 节点）
  _compressImage(srcPath, origW, origH) {
    this.setData({ scanning: true })
    wx.showLoading({ title: '压缩中...', mask: true })

    const scale = Math.min(
      COMPRESS_TARGET.w / origW,
      COMPRESS_TARGET.h / origH,
      1
    )
    const targetW = Math.max(1, Math.round(origW * scale))
    const targetH = Math.max(1, Math.round(origH * scale))

    wx.createSelectorQuery()
      .in(this)
      .select('#compress')
      .fields({ node: true, size: true })
      .exec((res) => {
        if (!res || !res[0]) {
          // Canvas2D 不可用时降级：直接传原图
          wx.hideLoading()
          this.compressedPath = srcPath
          this._startScan()
          return
        }
        const canvas = res[0].node
        const ctx = canvas.getContext('2d')
        const dpr = wx.getSystemInfoSync().pixelRatio || 1
        canvas.width = targetW * dpr
        canvas.height = targetH * dpr
        ctx.scale(dpr, dpr)

        const img = canvas.createImage()
        img.onload = () => {
          ctx.clearRect(0, 0, targetW, targetH)
          ctx.drawImage(img, 0, 0, targetW, targetH)
          wx.canvasToTempFilePath({
            canvas,
            fileType: 'jpg',
            quality: 0.85,
            success: (out) => {
              wx.hideLoading()
              this.compressedPath = out.tempFilePath
              this._startScan()
            },
            fail: () => {
              wx.hideLoading()
              this.compressedPath = srcPath
              this._startScan()
            }
          }, this)
        }
        img.onerror = () => {
          wx.hideLoading()
          this.compressedPath = srcPath
          this._startScan()
        }
        img.src = srcPath
      })
  },

  // 压缩完成后上传识别（经纬度已在 onRecognize 时获取）
  _startScan() {
    wx.showLoading({ title: '识别中...', mask: true })
    const loc = this._scanLocation
    this._uploadScan(loc ? loc.lng : '', loc ? loc.lat : '')
  },

  _uploadScan(long, lat) {
    const filePath = this.compressedPath
    if (!filePath) {
      this._scanFail('图片路径丢失')
      return
    }
    app.wxUpload(
      api.scanThing,
      filePath,
      { tag: '1', long: String(long), lat: String(lat), source: '', sourceDetail: '' },
      (resp) => this._onScanSuccess(resp),
      (err) => this._scanFail('网络请求失败：' + (err && err.errMsg || ''))
    )
  },

  _onScanSuccess(resp) {
    wx.hideLoading()
    this.setData({ scanning: false })
    const parsed = resp.data
    const success = parsed && (parsed.success === true || parsed.code === 200)
    const result = parsed && parsed.data

    if (success && result && result.travelScenicSpot) {
      wx.navigateTo({
        url: `/pages/rSuccess/rSuccess?id=${result.travelScenicSpot.id}`
      })
    } else {
      const rec = result && result.recommendTravelScenicSpots
      const recJson = rec ? encodeURIComponent(JSON.stringify(rec)) : ''
      wx.navigateTo({ url: `/pages/rFail/rFail?rec=${recJson}` })
    }
  },

  _scanFail(msg) {
    wx.hideLoading()
    this.setData({ scanning: false })
    wx.showToast({ title: msg || '识别失败', icon: 'none' })
    setTimeout(() => {
      wx.navigateTo({ url: '/pages/rFail/rFail?rec=' })
    }, 500)
  },

  // 进入建筑可阅读
  onBuilding() {
    router.navigateTo('/pages/building/building')
  },

  /* ------------------- 分享 ------------------- */
  onShareAppMessage() {
    const banner = (this.data.banners && this.data.banners[0]) || {}
    return {
      title: '山西农大 · 建筑可阅读',
      path: '/pages/home/home',
      imageUrl: banner.url || ''
    }
  },
  onShareTimeline() {
    const banner = (this.data.banners && this.data.banners[0]) || {}
    return {
      title: '山西农大 · 建筑可阅读',
      imageUrl: banner.url || ''
    }
  }
})
