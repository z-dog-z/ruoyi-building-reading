import request from '@/utils/request'

/**
 * VR 对象（对应 TravelVr）。
 * @typedef {Object} VrPayload
 * @property {number|string} [id] VR 资源 ID。
 * @property {string} name VR 名称。
 * @property {number} [status] 状态：1 启用，0 关闭；新增时不传默认为 1。
 * @property {string} identify VR 标识。
 * @property {string} [vrCover] VR 封面图 URL。
 * @property {string} [travelVrUrl] VR 访问地址（后端返回，新增/修改通常不提交）。
 */

/**
 * VR 列表查询参数。
 * @typedef {Object} VrQueryParams
 * @property {number} [pageNum] 页码，从 1 开始。
 * @property {number} [pageSize] 每页条数。
 * @property {string} [name] VR 名称，按名称模糊查询；景点关联下拉框不使用该字段。
 */

/**
 * 历史人物对象（对应 HistoryHuman）。
 * @typedef {Object} HistoryHumanPayload
 * @property {number|string} [id] 人物 ID。
 * @property {string} name 姓名。
 * @property {string} date 生辰信息。
 * @property {string} photo 照片 URL。
 * @property {string} content 人物简介。
 */

/**
 * 历史人物列表查询参数。
 * @typedef {Object} HistoryHumanQueryParams
 * @property {number} [pageNum] 页码，从 1 开始。
 * @property {number} [pageSize] 每页条数。
 * @property {string} [name] 姓名（后端支持按对象字段查询）。
 */

/**
 * 获取景点关联的 VR 资源。
 * @param {VrQueryParams} [queryParams] 分页参数；list1 接口只查询 status=1 的资源。
 * @returns {Promise} response.rows 为 VR 数组，字段包含 id、name、status、identify、vrCover、travelVrUrl。
 * @returns {Promise} response.total 为 VR 总条数。
 */
export function getScenicVrList(queryParams) {
  return request({
    url:"/travel/backstage/vr/list1",
    method:"get",
    params:queryParams
  })
}

/**
 * 按名称查询 VR 资源。
 * @param {VrQueryParams} queryParams 查询参数。
 * @returns {Promise} response.rows 为 VR 数组，response.total 为总条数。
 */
export function getVrList(queryParams) {
  return request({
    url:"/travel/backstage/vr/list",
    method:"get",
    params:queryParams
  })
}

/**
 * 新增 VR 资源。
 * @param {VrPayload} data VR 表单数据；name 和 identify 必填，identify 不能重复。
 * @returns {Promise} response.data 为新增结果（影响行数）。
 */
export function addVr(data) {
  return request({
    url:"/travel/backstage/vr",
    method:"post",
    data:data
  })
}

/**
 * 删除 VR 资源。
 * @param {number|string} id VR 资源 ID。
 * @returns {Promise} response.data 为删除结果（影响行数）。
 */
export function delVr(id) {
  return request({
    url:"/travel/backstage/vr/"+id,
    method:"delete"
  })
}

/**
 * 修改 VR 资源。
 * @param {VrPayload} data VR 表单数据，必须包含 id；name、identify、vrCover 为空时后端会清空对应字段。
 * @returns {Promise} response.data 为修改结果（影响行数）。
 */
export function editVrList(data) {
  return request({
    url:"/travel/backstage/modifyVr",
    method:"put",
    data:data
  })
}

/**
 * 修改 VR 启用状态。
 * @param {number} status 状态：1 启用，0 关闭。
 * @param {number|string} id VR 资源 ID。
 * @returns {Promise} response.data 为状态修改结果；同时会同步关联景点的状态。
 */
export function useVrBtn(status,id) {
  return request({
    url:"/travel/backstage/vr/"+status+"/"+id,
    method:"put",
  })
}

/**
 * 查询历史人物列表（scenic/index 用于“历史人物”下拉框）。
 * @param {HistoryHumanQueryParams} [queryParams] 分页参数。
 * @returns {Promise} response.rows 为人物数组，字段包含 id、name、date、photo、content。
 * @returns {Promise} response.total 为人物总条数。
 */
export function getPersonList(queryParams) {
  return request({
    url:"/travel/human/list",
    method:"get",
    params:queryParams
  })
}

/**
 * 新增历史人物。
 * @param {HistoryHumanPayload} data 人物表单数据；name、date、photo、content 为页面要求的字段。
 * @returns {Promise} response.data 为新增的人物记录。
 */
export function savePerson(data) {
  return request({
    url:"/travel/human/save",
    method:"post",
    data:data
  })
}

/**
 * 修改历史人物。
 * @param {HistoryHumanPayload} data 人物表单数据，必须包含 id。
 * @returns {Promise} response.data 为修改后的人物记录。
 */
export function updatePerson(data) {
  return request({
    url:"/travel/human/update",
    method:"post",
    data:data
  })
}

/**
 * 批量删除历史人物。
 * @param {Array<number|string>} data 人物 ID 数组，请求体直接传数组。
 * @returns {Promise} response.data 为删除结果。
 */
export function deletePerson(data) {
  return request({
    url:"/travel/human/delete",
    method:"delete",
    data:data
  })
}
