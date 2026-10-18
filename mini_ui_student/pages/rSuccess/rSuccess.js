// pages/rSuccess/rSuccess.js - 识别成功，从后端拉建筑详情
const request = require('../../utils/request.js')
const router = require('../../utils/router.js')
const api = require('../../config/api.js')

Page({
  data: { spot: null },

  onLoad(options) {
    const id = options.id
    if (!id) {
      wx.redirectTo({ url: '/pages/rFail/rFail?rec=' })
      return
    }
    wx.showLoading({ title: '加载中...', mask: true })
    request({
      url: api.scenicspotInfo(id),
      success: (res) => {
        wx.hideLoading()
        const spot = res.data && res.data.data
        if (spot) this.setData({ spot })
        else wx.showToast({ title: '未获取到详情', icon: 'none' })
      },
      fail: () => { wx.hideLoading() }
    })
  },

  onRead() {
    const spot = this.data.spot
    if (!spot) return
    router.navigateTo(`/pages/detail/detail?id=${spot.id}`)
  },

  onNav() {
    const spot = this.data.spot
    if (!spot) return
    // 经度纬度格式 "37.424698,112.5820" -> split
    const parts = (spot.longitude || '').split(',')
    if (parts.length >= 2) {
      wx.openLocation({ latitude: Number(parts[0]), longitude: Number(parts[1]) })
    } else {
      wx.showToast({ title: '暂无坐标', icon: 'none' })
    }
  },

  onAgain() {
    router.redirectTo('/pages/recognize/recognize')
  }
})
