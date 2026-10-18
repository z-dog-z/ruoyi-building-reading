const request = require('../../utils/request.js')
const api = require('../../config/api.js')

Page({
  data: {
    human: null,
    contentHtml: ''
  },

  onLoad(options) {
    // custom navigationStyle 已接管，不需要 setNavigationBarColor
    if (!options.id) {
      wx.showToast({ title: '参数错误', icon: 'none' })
      setTimeout(() => wx.navigateBack(), 800)
      return
    }
    const pages = getCurrentPages()
    const prev = pages[pages.length - 2]
    if (prev && prev.data && prev.data.humans && prev.data.humans.length) {
      const match = prev.data.humans.find((h) => String(h.id) === String(options.id) || h.name === options.name)
      if (match) {
        this.setData({ human: match, contentHtml: this._wrapContent(match) })
        return
      }
    }
    this.loadHuman(options.id, options.name)
  },

  onBack() {
    wx.navigateBack({ fail: () => wx.switchTab({ url: '/pages/home/home' }) })
  },

  _wrapContent(human) {
    if (!human || !human.content) return ''
    let html = String(human.content)
    // 已经是 HTML 的不动
    if (html.includes('<')) return html
    // 把每段用 <p> 包起来，识别小标题行
    const paragraphs = html.split(/\n+/).filter((s) => s.trim())
    // 判断一行是否是小标题：长度 ≤ 12 且不以常见结束标点结尾
    const isSubTitle = (line) => {
      const t = line.trim()
      if (t.length === 0 || t.length > 12) return false
      // 排除以句号问号感叹号逗号分号冒号等结尾的
      if (/[。！？，、；：…\.!?,;:]$/.test(t)) return false
      return true
    }
    return paragraphs
      .map((p) => {
        const t = p.trim()
        if (isSubTitle(t)) return `<p class="sub-h">${t}</p>`
        return `<p>${t}</p>`
      })
      .join('')
  },

  loadHuman(id, name) {
    request({
      url: api.humanList,
      data: { pageNum: 1, pageSize: 50 },
      success: (res) => {
        const rows = (res.data && res.data.rows) || []
        const human = rows.find((h) => String(h.id) === String(id) || h.name === name)
        if (human) {
          this.setData({ human, contentHtml: this._wrapContent(human) })
        } else {
          wx.showToast({ title: '未找到人物', icon: 'none' })
        }
      },
      fail: () => wx.showToast({ title: '加载失败', icon: 'none' })
    })
  },

  onShareAppMessage() {
    const h = this.data.human
    return {
      title: h ? h.name : '历史人物',
      path: `/pages/humanDetail/humanDetail?id=${h ? h.id : ''}`
    }
  }
})
