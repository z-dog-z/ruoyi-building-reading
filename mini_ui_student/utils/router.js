// 路由封装：统一使用微信小程序自己提供的路由 API。
// redirectTo：关闭当前页跳到目标（启动页→主页、识别页→成功/失败页用这个）
// navigateTo：保留当前页，压栈新页（主页→详情/拍照/列表 等内部跳转用这个）
// reLaunch：兜底，销毁所有页面重新进入

function redirectTo(url) {
  wx.redirectTo({ url, fail: () => wx.reLaunch({ url }) })
}

function navigateTo(url) {
  wx.navigateTo({ url, fail: () => wx.redirectTo({ url }) })
}

function reLaunch(url) {
  wx.reLaunch({ url })
}

// 从任意页面回到首页（识别成功/失败后的"再拍一次"、"进入建筑可阅读"用）
function backHome(url) {
  wx.reLaunch({ url: url || '/pages/home/home' })
}

module.exports = { redirectTo, navigateTo, reLaunch, backHome }
