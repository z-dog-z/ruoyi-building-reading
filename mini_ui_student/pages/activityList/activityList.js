// pages/activityList/activityList.js - 活动列表（为您推荐）
const request = require('../../utils/request.js')
const router = require('../../utils/router.js')
const api = require('../../config/api.js')

Page({
  data: { activities: [], loading: true },

  onLoad() {
    request({
      url: api.getActivityList,
      data: { pageNum: 1, pageSize: 50 },
      success: (res) => {
        this.setData({
          activities: (res.data && res.data.rows) || [],
          loading: false
        })
      },
      fail: () => this.setData({ loading: false })
    })
  },

  onTap(e) {
    const id = e.currentTarget.dataset.id
    router.navigateTo(`/pages/detail/detail?id=${id}&type=activity`)
  },

  onShareAppMessage() {
    return { title: '为您推荐', path: '/pages/activityList/activityList' }
  }
})
