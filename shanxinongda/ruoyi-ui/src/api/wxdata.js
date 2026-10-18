import request from '@/utils/request'

/**
 * 获取小程序首页基础数据统计。
 * GET /wxdata/base
 * @returns {Promise} res.data 为基础统计对象 { buildingCount, vrBuildingCount, visitorCount, scenicViewCount, recognitionCount, vrViewCount, likeCount }
 */
export function getBaseData() {
  return request({
    url: '/wxdata/base',
    method: 'get'
  })
}

/**
 * 获取建筑识别次数排行。
 * GET /wxdata/recognition
 * @param {Object} [params] 查询参数。
 * @param {number} [params.limit=10] 返回条数。
 * @returns {Promise} res.data 为排行数组 [{ name, value }]
 */
export function getRecognitionRank(params) {
  return request({
    url: '/wxdata/recognition',
    method: 'get',
    params
  })
}

/**
 * 获取建筑 VR 查看次数排行。
 * GET /wxdata/vrRank
 * @param {Object} [params] 查询参数。
 * @param {number} [params.limit=10] 返回条数。
 * @returns {Promise} res.data 为排行数组 [{ name, value }]
 */
export function getVrRank(params) {
  return request({
    url: '/wxdata/vrRank',
    method: 'get',
    params
  })
}

/**
 * 获取建筑热度排行（按浏览次数）。
 * GET /wxdata/hot
 * @param {Object} [params] 查询参数。
 * @param {number} [params.limit=10] 返回条数。
 * @returns {Promise} res.data 为排行数组 [{ name, count }]
 */
export function getHotRank(params) {
  return request({
    url: '/wxdata/hot',
    method: 'get',
    params
  })
}
