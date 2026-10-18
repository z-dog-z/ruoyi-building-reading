// pages/videos/videos.js - 热剧游山农大完整列表（两个一排）
const request = require('../../utils/request.js')
const router = require('../../utils/router.js')
const api = require('../../config/api.js')

Page({
  data: { videos: [] },

  onLoad() {
    wx.showLoading({ title: '加载中...', mask: true })
    request({
      url: api.videoList,
      data: { pageNum: 1, pageSize: 20 },
      success: (res) => {
        wx.hideLoading()
        this.setData({ videos: (res.data && res.data.rows) || [] })
      },
      fail: () => wx.hideLoading()
    })
  },

  onTap(e) {
    const id = e.currentTarget.dataset.id
    router.navigateTo(`/pages/detail/detail?videoId=${id}`)
  },

  onShareAppMessage() {
    const first = (this.data.videos && this.data.videos[0]) || {}
    return {
      title: '热剧游山农大',
      path: '/pages/videos/videos',
      imageUrl: first.cover || ''
    }
  },
  onShareTimeline() {
    const first = (this.data.videos && this.data.videos[0]) || {}
    return {
      title: '热剧游山农大',
      imageUrl: first.cover || ''
    }
  }
})
