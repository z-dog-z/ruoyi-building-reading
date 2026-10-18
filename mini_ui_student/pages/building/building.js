// pages/building/building.js - 建筑可阅读列表（搜索栏 + 分类标签 + 卡片网格）
const request = require('../../utils/request.js')
const router = require('../../utils/router.js')
const api = require('../../config/api.js')

// 固定标签；中间的二级分类由后端 /travel/getSubClassification 动态拼入
const FIXED_ALL = { id: '', name: '全部', type: 'all' }
const FIXED_VR = { id: 'VR', name: 'VR阅读', type: 'vr' }
const FIXED_RED = { id: 'RED', name: '红色印记', type: 'red' }

Page({
  data: {
    keyword: '',
    tabs: [FIXED_ALL, FIXED_VR, FIXED_RED],
    activeTab: 0,
    spots: [],
    colLeft: [],        // 瀑布流左列
    colRight: [],       // 瀑布流右列
    pageNum: 1,
    pageSize: 12,
    noMore: false,
    loading: false
  },

  onLoad() {
    this.loadTabs()
    this.loadMore(true)
  },

  /* ------------------- 分类标签：全部 + 后端返回的二级分类（VR/红色由后端返回什么显示什么） ------------------- */
  loadTabs() {
    request({
      url: api.subClassification,
      data: {},
      success: (res) => {
        const list = (res.data && res.data.data) || []
        if (!Array.isArray(list) || !list.length) {
          this.setData({ tabs: [FIXED_ALL, FIXED_VR, FIXED_RED] })
          return
        }
        const fixedNames = new Set([FIXED_ALL.name, FIXED_VR.name, FIXED_RED.name])
        const dynTabs = []
        list.forEach((item) => {
          const name = typeof item === 'string' ? item : (item.name || '')
          if (!name || fixedNames.has(name)) return
          const id = typeof item === 'string' ? item : String(item.id != null ? item.id : name)
          dynTabs.push({ id, name, type: 'sub' })
        })
        // 固定的 VR/红色 如果后端也返回了同名，保留后端返回的（type 改成正确的 type）
        const allNames = list.map((i) => typeof i === 'string' ? i : (i.name || ''))
        const vrTab = allNames.indexOf(FIXED_VR.name) !== -1
          ? { id: FIXED_VR.id, name: FIXED_VR.name, type: 'vr' }
          : FIXED_VR
        const redTab = allNames.indexOf(FIXED_RED.name) !== -1
          ? { id: FIXED_RED.id, name: FIXED_RED.name, type: 'red' }
          : FIXED_RED
        this.setData({ tabs: [FIXED_ALL].concat(dynTabs, [vrTab, redTab]) })
      }
    })
  },

  onTabTap(e) {
    const index = Number(e.currentTarget.dataset.index)
    if (index === this.data.activeTab) return
    this.setData({ activeTab: index, spots: [], colLeft: [], colRight: [], noMore: false })
    this.loadMore(true)
  },

  // 瀑布流：按顺序交替放进左右两列；pictureUrl 可能多张逗号拼接，只取第一张
  splitCols(list) {
    const colLeft = []
    const colRight = []
    list.forEach((item, i) => {
      const card = Object.assign({}, item, {
        cover: String(item.pictureUrl || '').split(',')[0]
      })
      if (i % 2 === 0) colLeft.push(card)
      else colRight.push(card)
    })
    this.setData({ colLeft, colRight })
  },

  /* ------------------- 搜索 ------------------- */
  onInput(e) {
    this.setData({ keyword: e.detail.value })
  },

  onSearch() {
    const kw = (this.data.keyword || '').trim()
    if (!kw) {
      this.loadMore(true)
      return
    }
    wx.showLoading({ title: '搜索中...', mask: true })
    request({
      url: api.searchName(kw),
      success: (res) => {
        wx.hideLoading()
        const data = res.data && res.data.data
        const rows = Array.isArray(data) ? data : (data ? [data] : [])
        this.setData({ spots: rows, noMore: true })
        this.splitCols(rows)
      },
      fail: () => {
        wx.hideLoading()
        // 后端搜索不可用时，回退到本地关键字过滤
        const kwLower = kw.toLowerCase()
        const rows = (this._allSpots || []).filter((s) =>
          (s.name && s.name.indexOf(kw) !== -1) ||
          (s.englishName && s.englishName.toLowerCase().indexOf(kwLower) !== -1)
        )
        this.setData({ spots: rows, noMore: true })
        this.splitCols(rows)
      }
    })
  },

  /* ------------------- 离我最近 ------------------- */
  onNearTap() {
    wx.getLocation({
      type: 'gcj02',
      success: (loc) => {
        wx.showLoading({ title: '定位中...', mask: true })
        request({
          url: api.scenicspotNear,
          data: { longitude: loc.longitude, latitude: loc.latitude, pageNum: 1, pageSize: 12 },
          success: (res) => {
            wx.hideLoading()
            const rows = (res.data && res.data.rows) || []
            this.setData({ spots: rows, noMore: true })
            this.splitCols(rows)
          },
          fail: () => wx.hideLoading()
        })
      },
      fail: () => wx.showToast({ title: '无法获取位置', icon: 'none' })
    })
  },

  /* ------------------- 列表加载 / 分页 ------------------- */
  onPullDownRefresh() {
    this.loadMore(true, () => wx.stopPullDownRefresh())
  },

  onReachBottom() {
    if (!this.data.noMore) this.loadMore(false)
  },

  loadMore(reset, cb) {
    if (this.data.loading) return
    const tab = this.data.tabs[this.data.activeTab] || FIXED_ALL
    const pageNum = reset ? 1 : this.data.pageNum + 1

    let url = api.scenicspotList
    let data = { pageNum, pageSize: this.data.pageSize }
    if (tab.type === 'vr') {
      url = api.vrList
    } else if (tab.type === 'sub' && tab.id) {
      url = api.classificationScenic
      data = { classficationId: tab.id, pageNum, pageSize: this.data.pageSize }
    } else if (tab.type === 'red') {
      data = { blockId: '1', pageNum, pageSize: this.data.pageSize }
    }

    if (reset) wx.showLoading({ title: '加载中...', mask: true })
    this.setData({ loading: true })
    request({
      url,
      data,
      success: (res) => {
        wx.hideLoading()
        const rows = (res.data && res.data.rows) || []
        const total = (res.data && res.data.total) || 0
        const spots = reset ? rows : this.data.spots.concat(rows)
        if (reset) this._allSpots = rows
        this.setData({
          spots,
          pageNum,
          noMore: rows.length < this.data.pageSize || (total > 0 && spots.length >= total),
          loading: false
        })
        this.splitCols(spots)
        cb && cb()
      },
      fail: () => {
        wx.hideLoading()
        this.setData({ loading: false })
        cb && cb()
      }
    })
  },

  onSpotTap(e) {
    const id = e.currentTarget.dataset.id
    router.navigateTo(`/pages/detail/detail?id=${id}`)
  },

  onShareAppMessage() {
    const first = (this.data.spots && this.data.spots[0]) || {}
    return {
      title: '山西农大建筑可阅读 · 发现校园之美',
      path: '/pages/building/building',
      imageUrl: first.pictureUrl || ''
    }
  },
  onShareTimeline() {
    const first = (this.data.spots && this.data.spots[0]) || {}
    return {
      title: '山西农大建筑可阅读',
      imageUrl: first.pictureUrl || ''
    }
  }
})
