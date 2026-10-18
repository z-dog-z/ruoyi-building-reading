import request from '@/utils/request'
import { getToken } from '@/utils/auth'

/**
 * 首页轮播图对象（对应 TravelSlideshow）。
 * @typedef {Object} SlideshowPayload
 * @property {number|string} [id] 轮播图 ID；新增时为空，更新时必填。
 * @property {string} pictureUrl 轮播图图片 URL；新增时必填。
 * @property {number} [status] 状态：1 启用，0 禁用。
 * @property {string} [createBy] 创建者（后端返回，通常不提交）。
 * @property {string} [createTime] 创建时间（后端返回，通常不提交）。
 */

/**
 * 封面图对象（对应 TravelCover）。
 * @typedef {Object} CoverPayload
 * @property {string} pictureUrl 封面图片 URL，必填。
 * @property {number} identity 封面类型：0 拍照识别封面，1 建筑可阅读封面。
 */

/**
 * 获取首页轮播图列表。
 * GET /travel/backend/slideshow/list
 * @returns {Promise} response.rows 为轮播图数组，字段包含 id、pictureUrl、status、createBy、createTime。
 * @returns {Promise} response.total 为轮播图总条数。
 */
export function getView() {
  return request({
    url:"/travel/backend/slideshow/list",
    method:"get"
  })
}

/**
 * 添加或更新首页轮播图。
 * POST /travel/backend/slideshow/addOrUpdate
 * @param {SlideshowPayload} queryform 轮播图表单数据；新增至少需要 pictureUrl，更新需要 id。
 * @returns {Promise} response.data 为新增或更新后的轮播图 ID。
 */
export function addPicApi(queryform) {
  return request({
    url:"/travel/backend/slideshow/addOrUpdate",
    method:"post",
    data:queryform
  })
}

/**
 * 删除首页轮播图。
 * DELETE /travel/backend/slideshow/deleteSlideshow/{id}
 * @param {number|string} id 轮播图 ID。
 * @returns {Promise} response.data 为删除结果（影响行数）。
 */
export function deleteViewApi(id) {
  return request({
    url:"/travel/backend/slideshow/deleteSlideshow/"+id,
    method:"delete",
  })
}



/** el-upload 使用的文件上传地址（轮播图和封面图共用，请求字段名为 file）。 */
export const uploadFileApi = process.env.VUE_APP_BASE_API + '/travel/oss/upload';

/** el-upload 请求头，Authorization 值为 Bearer + 当前登录用户的 JWT。 */
export const uploadFileHeaders = {
  Authorization:'Bearer ' + getToken()
}



/**
 * 获取模块封面图。
 * GET /travel/backstage/getCoverPicture/{identity}
 * @param {number} identity 封面类型：0 为拍照识别封面，1 为建筑可阅读封面。
 * @returns {Promise} response.data 为封面图片 URL。
 */
export function getCoverApi(identity) {
  return request({
    url:"/travel/backstage/getCoverPicture/"+identity,
    method:"get",
  })
}

/**
 * 修改模块封面图。
 * POST /travel/backstage/updateCoverPicture
 * @param {CoverPayload} queryForm 封面信息；pictureUrl 和 identity 必填，参数通过 URL 查询参数发送。
 * @returns {Promise} response.data 为修改结果。
 */
export function editCoverApi(queryForm) {
  return request({
    url:"/travel/backstage/updateCoverPicture",
    method:"post",
    params:queryForm
  })
}
