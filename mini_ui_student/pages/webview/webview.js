// pages/webview/webview.js - 承载 VR 漫游等外部 H5 页面
Page({
  data: { url: '' },
  onLoad(options) {
    if (options.url) {
      this.setData({ url: decodeURIComponent(options.url) })
    }
  }
})
