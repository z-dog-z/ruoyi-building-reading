// src/api/banner.js
import request from '@/utils/request'

// ===== 活动（Banner）查询 =====
export function activityList(query) {
  return request({
    url: '/activ/list',
    method: 'get',
    params: query
  })
}

// ===== 新增 =====
export function activityAdd(data) {
  return request({
    url: '/activ/add',
    method: 'post',
    data: data
  })
}

// ===== 修改 =====
export function activityUpdate(data) {
  return request({
    url: '/activ/update',
    method: 'post',
    data: data
  })
}

// ===== 删除 =====
export function activityDelete(id) {
  return request({
    url: '/activ/delete?id='+id,
    method: 'delete',
  })
}
