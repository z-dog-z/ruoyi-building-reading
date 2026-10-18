import request from '@/utils/request'

/**
 * 识别库图片对象及接口参数，对应后端 TravelRecognitionLibrary 实体。
 *
 * @typedef {Object} RecognitionPayload
 * @property {number|string} [id] 识别库记录 ID；删除时使用。
 * @property {string} filename 文件名称；新增官方图片时必填。
 * @property {string} url 图片访问地址；新增官方图片时必填。
 * @property {number} [tag] 所属栏目标记：1 景点，2 文创。
 * @property {number|string} [moduleDetailId] 关联的景点/模块详情 ID。
 * @property {number} [source] 图片来源：1 用户，2 官方。
 * @property {string} [contSign] 百度识别库图片签名，由后端维护。
 * @property {number} [isStorage] 是否已入库：0 否，1 是。
 * @property {string} [storageTime] 入库时间，格式为 yyyy-MM-dd HH:mm:ss。
 */

/**
 * 识别库列表查询参数（对应 GET /travel/backend/recognitionLibrary/list）。
 *
 * @typedef {Object} RecognitionQueryParams
 * @property {string} [filename] 文件名称。
 * @property {string} [url] 图片访问地址。
 * @property {number} [tag] 所属栏目标记：1 景点，2 文创。
 * @property {number|string} [moduleDetailId] 关联的景点/模块详情 ID。
 * @property {number} [source] 图片来源：1 用户，2 官方。
 * @property {number} [isStorage] 是否已入库：0 否，1 是。
 */

/**
 * 查询识别库图片列表。
 * GET /travel/backend/recognitionLibrary/list
 *
 * @param {RecognitionQueryParams} [queryParams] 查询条件；常用 moduleDetailId 和 source，字段按实体属性匹配。
 * @returns {Promise} response.rows 为识别库图片数组，元素字段包括 id、filename、url、tag、moduleDetailId、source 等。
 * @returns {Promise} response.total 为符合条件的记录总数。
 */
export function getLibraryPicturesList(queryParams) {
  return request({
    url:"/travel/backend/recognitionLibrary/list",
    method:"get",
    params:queryParams
  })
}

/**
 * 将图片加入官方识别库。
 * GET /travel/backend/recognitionLibrary/storage/{tag}
 *
 * 虽然该接口执行新增操作，后端路由仍使用 GET；图片文件本身应先通过上传接口取得 URL。
 *
 * @param {number|string} tag 栏目标记：1 景点，2 文创；后端仅允许这两个值。
 * @param {RecognitionPayload} queryParams 图片信息，至少包含 filename、url、moduleDetailId。
 * @returns {Promise} 成功时返回 CommonResult；失败时 response.msg 会说明栏目或入库错误。
 */
export function addPicturesToLibrary(tag,queryParams) {
  return request({
    url:"/travel/backend/recognitionLibrary/storage/"+tag,
    method:"get",
    params:queryParams
  })
}

/**
 * 批量删除识别库图片。
 * POST /travel/backend/recognitionLibrary/delete
 *
 * @param {Array<number|string>} data 要删除的识别库记录 ID 数组，请求体直接传数组。
 * @returns {Promise} response.data 为成功删除的记录数；未传 ID 时返回提示信息。
 */
export function deletePicturesToLibrary(data) {
  return request({
    url:"/travel/backend/recognitionLibrary/delete",
    method:"post",
    data:data
  })
}
