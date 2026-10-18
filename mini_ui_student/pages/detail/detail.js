// pages/detail/detail.js - 通用详情页：建筑(id)、活动(id)、视频(videoId)
const request = require('../../utils/request.js')
const api = require('../../config/api.js')

// 页面固定文字：中文 / English
const I18N = {
  zh: {
    audio: '语音导览', vr: 'VR漫游', nav: '景点导航',
    level: '保护级别', address: '建筑地址', openTime: '开放时间', ticket: '门票信息',
    humans: '历史人物', views: '浏览量',
    noAudio: '暂无语音导览', noVr: '暂无VR漫游', noCoord: '暂无坐标',
    audioFail: '音频播放失败', vrFail: '打开VR失败', detailFail: '详情'
  },
  en: {
    audio: 'Audio Guide', vr: 'VR Tour', nav: 'Navigation',
    level: 'Protection Level', address: 'Address', openTime: 'Opening Hours', ticket: 'Ticket',
    humans: 'Historical Figures', views: 'Views',
    noAudio: 'No audio guide', noVr: 'No VR tour', noCoord: 'No location',
    audioFail: 'Audio failed', vrFail: 'VR failed', detailFail: 'Detail'
  }
}

Page({
  data: {
    type: 'spot',      // spot | activity | video
    spot: null,        // 景点/活动详情
    video: null,       // 视频详情
    relatedVideos: [], // 视频详情下的"更多精彩内容"
    humans: [],        // 历史人物列表
    showHumanModal: false,
    selectedHuman: {},
    contentHtml: '',   // HTML 富文本
    lang: 'zh',        // 中/英切换
    labels: I18N.zh,   // 当前语言下的页面文字
    loading: true
  },

  onLoad(options) {
    if (options.videoId) {
      this.setData({ type: 'video' })
      this.loadVideo(options.videoId)
    } else if (options.id) {
      const type = options.type === 'activity' ? 'activity' : 'spot'
      this.setData({ type })
      this.loadSpot(options.id)
    } else {
      wx.showToast({ title: '参数错误', icon: 'none' })
      setTimeout(() => wx.navigateBack(), 800)
    }
  },

  /* ------------------- 建筑/活动详情 ------------------- */
  loadSpot(id) {
    request({
      url: api.scenicspotInfo(id),
      success: (res) => {
        const spot = res.data && res.data.data
        this.setData({
          spot,
          contentHtml: this.buildContent(spot, 'zh'),
          loading: false
        })
        wx.setNavigationBarTitle({ title: (spot && spot.name) || this.data.labels.detailFail })
        // 浏览量 +1（后端 updatePageViews）
        request({ url: api.updatePageViews(id), method: 'PUT' })
        // 历史人物
        if (spot && spot.human) this.loadHumans(spot.human)
      },
      fail: () => {
        this.setData({ loading: false })
        wx.showToast({ title: '详情加载失败', icon: 'none' })
      }
    })
  },

  // 根据传入的 lang 返回对应语言的简介（不能用 this.data.lang，setData 是异步的）
  buildContent(spot, lang) {
    if (!spot) return ''
    const target = lang || this.data.lang
    if (target === 'en') {
      return spot.englishIntroduction
        || '<p style="color:#999;font-size:26rpx;line-height:1.8;">English introduction is being updated. Please switch to Chinese.</p>'
    }
    return spot.content || spot.introduction
      || '<p style="color:#999;font-size:26rpx;line-height:1.8;">简介内容正在完善中...</p>'
  },

  /* ------------------- 历史人物：spot.human(逗号分隔) → /travel/human/list ------------------- */
  loadHumans(humanStr) {
    const names = String(humanStr)
      .split(/[,，]/)
      .map((s) => s.trim())
      .filter(Boolean)
    if (!names.length) return
    request({
      url: api.humanList,
      data: { pageNum: 1, pageSize: 50 },
      success: (res) => {
        const rows = (res.data && res.data.rows) || []
        const matched = rows.filter((h) => names.indexOf(h.name) !== -1)
        // 后端没有对应人物时，按名字顺序构造占位，保证设计不空缺
        const humans = matched.length
          ? matched
          : names.map((n) => ({ id: n, name: n, photo: '' }))
        this.setData({ humans })
      },
      fail: () => {
        this.setData({ humans: names.map((n) => ({ id: n, name: n, photo: '' })) })
      }
    })
  },

  /* ------------------- 历史人物点击 ------------------- */
  onHumanTap(e) {
    const idx = Number(e.currentTarget.dataset.index)
    const human = this.data.humans[idx]
    if (!human) return
    wx.navigateTo({
      url: `/pages/humanDetail/humanDetail?id=${human.id}&name=${encodeURIComponent(human.name)}`
    })
  },
  onCloseHumanModal() {},

  /* ------------------- 视频详情 ------------------- */
  loadVideo(id) {
    request({
      url: api.videoDetail(id),
      success: (res) => {
        const v = res.data && res.data.data
        this.setData({ video: v, loading: false })
        // 视频详情不改导航栏标题，保持默认"建筑可阅读"
        // 顺带拉视频列表 → "更多精彩内容"（排除当前视频）
        request({
          url: api.videoList,
          data: { pageNum: 1, pageSize: 50 },
          success: (listRes) => {
            const all = (listRes.data && listRes.data.rows) || []
            const related = all.filter((x) => String(x.id) !== String(id))
            this.setData({ relatedVideos: related })
          }
        })
      },
      fail: () => this.setData({ loading: false })
    })
  },

  onRelatedVideoTap(e) {
    const id = e.currentTarget.dataset.id
    // 替换式跳转，避免相关推荐无限堆叠返回栈
    wx.redirectTo({ url: `/pages/detail/detail?videoId=${id}` })
  },

  /* ------------------- 中/英切换 ------------------- */
  onLangTap(e) {
    const lang = e.currentTarget.dataset.lang
    if (lang === this.data.lang) return
    this.setData({
      lang,
      labels: I18N[lang],
      contentHtml: this.buildContent(this.data.spot, lang)
    })
    const spot = this.data.spot
    if (spot) {
      wx.setNavigationBarTitle({ title: lang === 'en' ? (spot.englishName || spot.name) : spot.name })
    }
  },

  /* ------------------- 景点导航 ------------------- */
  onNav() {
    const spot = this.data.spot
    if (!spot) return
    const parts = String(spot.longitude || '').split(',')
    if (parts.length >= 2 && parts[0] && parts[1]) {
      wx.openLocation({
        latitude: Number(parts[0]),
        longitude: Number(parts[1]),
        name: this.data.lang === 'en' ? (spot.englishName || spot.name) : spot.name,
        address: spot.remarks || spot.address || ''
      })
    } else {
      wx.showToast({ title: this.data.labels.noCoord, icon: 'none' })
    }
  },

  /* ------------------- 语音导览 ------------------- */
  onAudio() {
    const spot = this.data.spot
    const url = spot && spot.audioUrl
    if (!url) {
      wx.showToast({ title: this.data.labels.noAudio, icon: 'none' })
      return
    }
    if (this._audio) {
      this._audio.stop()
      this._audio.destroy()
      this._audio = null
      return
    }
    const audio = wx.createInnerAudioContext()
    audio.src = url
    audio.onEnded(() => { this._audio = null })
    audio.onError(() => {
      this._audio = null
      wx.showToast({ title: this.data.labels.audioFail, icon: 'none' })
    })
    audio.play()
    this._audio = audio
  },

  /* ------------------- VR漫游 ------------------- */
  onVr() {
    const spot = this.data.spot
    // 先上报 VR 查看事件（event_type=3）
    // 注意：后端是普通参数绑定（非 @RequestBody），必须拼在 URL query 上，
    // 不能放 wx.request 的 data 里（默认 application/json 后端收不到）
    if (spot && spot.id) {
      wx.request({
        url: `${api.insertVrViews}?scenicId=${spot.id}&source=mini&sourceDetail=detail_vr_button`,
        method: 'POST',
        fail: () => {}
      })
    }
    // VR 演示页面（后端静态资源 vr.html）
    const url = 'http://127.0.0.1:8020/vr.html'
    wx.navigateTo({
      url: `/pages/webview/webview?url=${encodeURIComponent(url)}`,
      fail: () => wx.showToast({ title: '打开失败', icon: 'none' })
    })
  },

  onPreview(e) {
    const url = e.currentTarget.dataset.url
    if (url) wx.previewImage({ urls: [url] })
  },

  onShareAppMessage() {
    const spot = this.data.spot
    const video = this.data.video
    if (this.data.type === 'video' && video) {
      return {
        title: video.name || '热剧游山农大',
        path: `/pages/detail/detail?videoId=${video.id}`,
        imageUrl: video.cover || ''
      }
    }
    if (spot) {
      const title = this.data.lang === 'en' ? (spot.englishName || spot.name) : spot.name
      return {
        title: title || '建筑可阅读',
        path: `/pages/detail/detail?id=${spot.id}`,
        imageUrl: spot.pictureUrl || spot.backgroundCover || ''
      }
    }
    return { title: '山西农大 · 建筑可阅读', path: '/pages/home/home' }
  },
  onShareTimeline() {
    const spot = this.data.spot
    const video = this.data.video
    if (this.data.type === 'video' && video) {
      return { title: video.name || '热剧游山农大', imageUrl: video.cover || '' }
    }
    if (spot) {
      return {
        title: (spot.englishName || spot.name || '建筑可阅读'),
        imageUrl: spot.pictureUrl || ''
      }
    }
    return { title: '山西农大 · 建筑可阅读' }
  }
})
