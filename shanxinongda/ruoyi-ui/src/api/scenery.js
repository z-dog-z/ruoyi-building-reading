import request from '@/utils/request'
import { getToken } from '@/utils/auth'

/**
 * 景点查询参数（对应 GET /travel/backstage/search）。
 * @typedef {Object} ScenicQueryParams
 * @property {number} [pageNum] 页码，从 1 开始。
 * @property {number} [pageSize] 每页条数。
 * @property {number|string} [moduleId] 栏目（模块）ID。
 * @property {number|string} [subClafficationId] 二级分类 ID；接口字段名按后端拼写使用两个 f。
 * @property {string} [name] 景点或活动名称，支持模糊查询。
 * @property {number|string} [spotScenicId] 景点 ID，编辑时用于查询单条记录。
 * @property {number} [isVr] 是否有 VR：0 否，1 是。
 * @property {string} [remarks] 中文地址。
 * @property {number} [inx] 前端排序字段；当前 search 接口不接收该参数。
 */

/**
 * 景点新增/修改对象（对应 TravelModuleDetail）。
 * @typedef {Object} ScenicPayload
 * @property {number|string} [id] 景点 ID；新增时为空，修改时必填。
 * @property {number|string} moduleId 栏目（模块）ID。
 * @property {string} name 中文名称。
 * @property {string} englishName 英文名称。
 * @property {string} [longitude] 经纬度，格式为“纬度,经度”（景点必填，活动可不填）。
 * @property {string} [pictureUrl] 景点封面 URL，多个地址用逗号分隔。
 * @property {string} [backgroundCover] 景点背景图 URL，多个地址用逗号分隔。
 * @property {string} [audioUrl] 音频 URL（兼容旧字段）。
 * @property {string} [content] 中文介绍 HTML。
 * @property {string} [englishIntroduction] 英文介绍 HTML。
 * @property {string} [remarks] 中文地址。
 * @property {string} [address] 英文地址。
 * @property {string} [chineseOpenTime] 中文开放时间。
 * @property {string} [englishOpenTime] 英文开放时间。
 * @property {string} [ticket] 中文门票信息。
 * @property {string} [englishTicket] 英文门票信息。
 * @property {string} [level] 中文建筑级别。
 * @property {string} [englishLevel] 英文建筑级别。
 * @property {string} [introduction] 景点简介/VR 简介。
 * @property {string} [phoneNumber] 联系电话。
 * @property {number} [inx] 排序值。
 * @property {number} [isVr] 是否关联 VR：0 否，1 是。
 * @property {number|string} [vrId] 关联的 VR ID。
 * @property {number} [isUser] 是否开启用户识别：0 关，1 开。
 * @property {string} [human] 历史人物 JSON 字符串。
 * @property {number} [activity] 是否为活动：0 否，1 是。
 * @property {string} [activityName] 活动名称。
 * @property {string} [activityUrl] 活动链接。
 * @property {Array<Object>} [travelJointList] 景点分类关联；元素字段 classificationId 为分类 ID。
 * @property {Array<Object>} [travelModelVideos] 音频列表；元素字段 name、url、inx、theme、people、content。
 * @property {Array<number|string>} [relateDetailIds] 关联景点 ID 列表。
 */

/** 栏目返回字段：data 为栏目数组，元素包含 id、name、status、flag、createBy、createTime。 */
export function getColumnList() {
  return request({
    url:"/travel/backstage/selectTravelModule",
    method:"get"
  })
}

/**
 * 新增栏目。
 * @param {{name: string, status?: number, flag?: number}} data
 * @param {string} data.name 栏目名称（必填）。
 * @param {number} [data.status] 状态：1 正常，0 失效。
 * @param {number} [data.flag] 标记：1 系统预定义，0 动态添加。
 */
export function addColumnApi(data) {
  return request({
    url:"/travel/backstage/insertModule",
    method:"post",
    params:data
  })
}

/**
 * 删除栏目。
 * @param {number|string} id 栏目 ID。
 */
export function deleteColumnApi(id) {
  return request({
    url:"/travel/backstage/moudule/"+id,
    method:"delete",
  })
}

/**
 * 查询景点/活动列表。
 * @param {ScenicQueryParams} queryParams 查询条件；响应中的 rows 为景点数组，total 为总条数。
 * @returns {Promise} response.rows 常用字段包括 id、name、pictureUrl、vrId、pageviews、moduleId、travelJointList、travelModelVideos、relateDetailList 等。
 */
export function getTravelList(queryParams) {
  return request({
    url:"/travel/backstage/search",
    method:"get",
    params:queryParams
  })
}

/**
 * 删除景点。
 * @param {number|string} id 景点 ID。
 */
export function deleteTravelScenery(id) {
  return request({
    url:"/travel/backstage/scenicspot/"+id,
    method:"delete"
  })
}

/**
 * 新增景点或活动。
 * @param {ScenicPayload} queryParams 景点表单数据。
 */
export function saveTravelScenery(queryParams) {
  return request({
    url:"/travel/backstage/add",
    method:"post",
    data:queryParams
  })
}

/**
 * 修改景点或活动。
 * @param {ScenicPayload} data 景点表单数据，必须包含 id。
 */
export function updateTravelScenery(data) {
  return request({
    url:"/travel/backstage/update",
    method:"put",
    data:data
  })
}

/**
 * 富文本编辑器上传图片/视频。
 * @param {FormData} file FormData，字段名必须为 file。
 * @returns {Promise} response.data.url 为文件访问地址，response.data.name 为原文件名。
 */
export function upload(file) {
  return request({
    url:"/travel/oss/upload",
    method:"post",
    data: file
  })
}

/** el-upload 使用的文件上传地址（请求字段名为 file）。 */
export const uploadFileApi = process.env.VUE_APP_BASE_API + '/travel/oss/upload';

/** el-upload 请求头，Authorization 值为 Bearer + 登录令牌。 */
export const uploadFileHeaders = {
  Authorization:'Bearer ' + getToken()
}

/**
 * 查询二级分类。
 * @returns {Promise} response.data 为分类数组，元素包含 id、name、status、moduleId、orderBy、createBy、createTime。
 */
export function getClassApi() {
  return request({
    url:"/travel/backstage/selectTravelSubClassification",
    method:"get"
  })
}

/**
 * 新增二级分类。
 * @param {{name: string, orderBy?: number, moduleId: number|string}} queryParams
 * @param {string} queryParams.name 分类名称（必填）。
 * @param {number} [queryParams.orderBy] 排序值。
 * @param {number|string} queryParams.moduleId 所属栏目 ID。
 */
export function addClassApi(queryParams) {
  return request({
    url:"/travel/backstage/insertTravelSubClassification",
    method:"post",
    params:queryParams
  })
}

/**
 * 修改二级分类。
 * @param {{id: number|string, name: string, orderBy?: number, moduleId: number|string}} queryParams
 * @param {number|string} queryParams.id 分类 ID。
 * @param {string} queryParams.name 分类名称。
 * @param {number} [queryParams.orderBy] 排序值。
 * @param {number|string} queryParams.moduleId 所属栏目 ID。
 */
export function editClassApi(queryParams) {
  return request({
    url:"/travel/backstage/updateTravelSubClassfication",
    method:"put",
    params:queryParams
  })
}

/**
 * 删除二级分类。
 * @param {number|string} id 分类 ID。
 */
export function deleteClassApi(id) {
  return request({
    url:"/travel/backstage/deleteTravelsubclassfication/"+id,
    method:"delete"
  })
}
