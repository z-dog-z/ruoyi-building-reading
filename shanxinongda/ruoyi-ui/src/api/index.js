import request from '@/utils/request'

/**
 * 视频列表查询参数（对应 GET /travelVideo/list）。
 * @typedef {Object} VideoQueryParams
 * @property {number} [pageNum] 页码，从 1 开始。
 * @property {number} [pageSize] 每页条数。
 * @property {number|string} [id] 视频 ID。
 * @property {string} [name] 视频名称，支持按名称查询。
 * @property {number|string} [modelId] 所属模块 ID。
 * @property {number|string} [tourId] 所属景点/旅游项目 ID。
 * @property {number} [type] 视频类型：0 文创，1 宣传视频，2 手册，3 活动。
 * @property {number} [inx] 排序值。
 * @property {string} [orderByColumn] 排序字段，页面默认按 inx 排序。
 * @property {string} [isAsc] 排序方向，页面默认使用 asc。
 */

/**
 * 视频新增/修改对象（对应 TravelVideo）。
 * @typedef {Object} VideoPayload
 * @property {number|string} [id] 视频 ID；新增时为空，修改时必填。
 * @property {string} name 视频名称，页面表单必填。
 * @property {string} cover 视频封面图片 URL，页面表单必填。
 * @property {string} video 视频文件 URL，页面表单必填，必须为视频文件地址。
 * @property {number} [inx=0] 排序值，数值越小越靠前。
 * @property {number|string} [modelId] 所属模块 ID。
 * @property {number|string} [tourId] 所属景点/旅游项目 ID。
 * @property {string} [tittle] 视频副标题/标题字段（后端字段名为 tittle）。
 * @property {number} [count] 播放次数，通常由后端维护。
 * @property {string} [content] 视频介绍内容。
 * @property {number} [type] 视频类型：0 文创，1 宣传视频，2 手册，3 活动。
 * @property {string} [startDate] 活动开始日期，格式为 yyyy-MM-dd。
 * @property {string} [endDate] 活动结束日期，格式为 yyyy-MM-dd。
 */

/**
 * 查询视频列表。
 * GET /travelVideo/list
 * @param {VideoQueryParams} queryParams 查询条件及分页参数。
 * @returns {Promise} response.rows 为视频数组，字段包含 id、name、cover、video、inx 等。
 * @returns {Promise} response.total 为视频总条数。
 */
export function getTravelList(queryParams) {
    return request({
      url:"/travelVideo/list",
      method:"get",
      params:queryParams
    })
}

/**
 * 删除视频。
 * DELETE /travelVideo/delete?id={id}
 * @param {number|string} id 视频 ID。
 * @returns {Promise} response.data 为删除结果（影响行数）。
 */
export function deleteTravelScenery(id) {
    return request({
      url:"/travelVideo/delete?id="+id,
      method:"delete"
    })
}

/**
 * 新增视频。
 * POST /travelVideo/add
 * @param {VideoPayload} queryParams 视频表单数据；name、cover、video 为页面要求的必填字段，inx 默认为 0。
 * @returns {Promise} response.data 为新增的视频记录，id 和 createTime 由后端生成。
 */
  export function saveTravelScenery(queryParams) {
    return request({
      url:"/travelVideo/add",
      method:"post",
      data:queryParams
    })
}
 
/**
 * 修改视频信息。
 * POST /travelVideo/update
 * @param {VideoPayload} data 视频表单数据，必须包含 id；仅修改排序时可只提交 id 和 inx。
 * @returns {Promise} response.data 为修改后的视频记录。
 */
  export function updateTravelScenery(data) {
    return request({
      url:"/travelVideo/update",
      method:"post",
      data:data
    })
  }
