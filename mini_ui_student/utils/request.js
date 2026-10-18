// 统一请求入口：复用 app.js 中的无感登录、Token 注入和 401 重试。
// 业务页面不直接调用 wx.request，统一从这里发起请求。
const app = getApp()

/**
 * @param {Object} options
 * @param {string} options.url 请求地址
 * @param {string} [options.method='GET'] 请求方法
 * @param {Object} [options.data={}] 请求参数
 * @param {Function} [options.success] 成功回调，参数为 wx.request 响应
 * @param {Function} [options.fail] 失败回调
 */
function request(options = {}) {
  const {
    url,
    method = 'GET',
    data = {},
    success,
    fail
  } = options

  if (!url) {
    const error = { errMsg: 'request 缺少 url' }
    if (fail) fail(error)
    return
  }

  app.wxRequest(method, url, success, fail, data)
}

module.exports = request
