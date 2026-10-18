// 通用顶部栏组件；通过 title 和 showBack 控制显示内容。
Component({
  properties: {
    title: { type: String, value: '' },
    showBack: { type: Boolean, value: false }
  },
  methods: {
    goBack() {
      const pages = getCurrentPages()
      if (pages.length > 1) wx.navigateBack()
    }
  }
})
