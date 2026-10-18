// 业务接口集中维护（后端在 ruoyi-admin @ 8020）
// 与老师 api.js 对齐：videoList -> /travelVideo/list，scanThing 驼峰，新增 coverPicture
const env = require('./env.js')

const baseUrl = env.baseUrl
const appId = env.appId

module.exports = {
  baseUrl,
  appId,

  // wx.login 返回的一次性 code 交给后端换取业务 token。
  wxLogin(code) {
    return `${baseUrl}/wx/user/${encodeURIComponent(appId)}/login?code=${encodeURIComponent(code)}`
  },

  // 浏览量上报接口（用于触发首次登录）
  insertViews: baseUrl + '/views/insertViews',
  // VR查看事件上报
  insertVrViews: baseUrl + '/views/insertVrViews',

  // ============ 启动页 ============
  slideshow: baseUrl + '/travel/slideshow/random',
  slideshowList: baseUrl + '/travel/slideshow/list',

  // ============ Banner（首页轮播图，对应 admin 的 Banner 管理） ============
  bannerList: baseUrl + '/travel/banner/list',

  // ============ 景点/建筑（建筑可阅读） ============
  scenicspotList: baseUrl + '/travel/scenicspot/list',
  scenicspotInfo: (id) => `${baseUrl}/travel/scenicspot/${id}`,
  scenicspotVrType: (type) => `${baseUrl}/travel/scenicspot/vrType/${type}`,
  scenicspotNear: baseUrl + '/travel/near',
  searchName: (name) => `${baseUrl}/travel/list?name=${encodeURIComponent(name)}`,
  subClassification: baseUrl + '/travel/getSubClassification',
  classificationScenic: baseUrl + '/travel/classification/selectScenicByClassificatin',
  vrList: baseUrl + '/travel/getVrList',
  updatePageViews: (id) => `${baseUrl}/travel/updatePageViews/${id}`,
  // 封面图：type=0 拍照识别封面，type=1 建筑可阅读封面
  coverPicture: (type) => `${baseUrl}/travel/backstage/getCoverPicture/${type}`,

  // ============ 历史人物 ============
  humanList: baseUrl + '/travel/human/list',

  // ============ 活动（酷跑活动等） ============
  getActivityList: baseUrl + '/travel/getActivityList',

  // ============ 视频（热剧游山农大） ============
  videoList: baseUrl + '/travelVideo/list',
  videoDetail: (id) => `${baseUrl}/travelVideo/detail?id=${id}`,

  // ============ 拍照识别 ============
  scanThing: baseUrl + '/travel/scanthing',

  // ============ 上传 ============
  ossUpload: baseUrl + '/travel/oss/upload'
}
