// 通用加载遮罩组件；不依赖业务图片或业务接口。
Component({
  properties: {
    visible: {
      type: Boolean,
      value: true
    },
    text: {
      type: String,
      value: '加载中…'
    }
  }
})
