// pages/rFail/rFail.js - 识别失败：大卡推荐 + 相似景点 + 重新识别
const request = require('../../utils/request.js')
const router = require('../../utils/router.js')
const api = require('../../config/api.js')

Page({
  data: {
    featured: null,     // 第一个推荐（大卡）
    similars: []        // 相似景点（双卡）
  },

  onLoad(options) {
    if (options.rec) {
      try {
        const parsed = JSON.parse(decodeURIComponent(options.rec))
        if (Array.isArray(parsed) && parsed.length) {
          this._split(parsed)
          return
        }
      } catch (e) {}
    }
    wx.showLoading({ title: '加载推荐...', mask: true })
    request({
      url: api.scenicspotList,
      data: { pageNum: 1, pageSize: 3 },
      success: (res) => {
        wx.hideLoading()
        const rows = (res.data && res.data.rows) || []
        this._split(rows)
      },
      fail: () => { wx.hideLoading() }
    })
  },

  _split(list) {
    if (!Array.isArray(list) || !list.length) return
    const first = list[0]
    const rest = list.slice(1, 3)
    this.setData({
      featured: first.pictureUrl ? first : null,
      similars: rest
    })
    if (!first.pictureUrl && rest.length) {
      this.setData({ featured: rest[0], similars: rest.slice(1) })
    }
  },

  onFeaturedTap() {
    if (this.data.featured) router.navigateTo(`/pages/detail/detail?id=${this.data.featured.id}`)
  },

  onSimilarTap(e) {
    const id = e.currentTarget.dataset.id
    if (id) router.navigateTo(`/pages/detail/detail?id=${id}`)
  },

  onAgain() {
    router.backHome('/pages/recognize/recognize')
  }
})
