# 模块对应代码位置文档

## 说明

- 每个模块只给出当前代码里对应的前端页面、前端 API、后端 Controller、Service、Mapper、XML 和业务表。

## 模块总览

| 模块 | 前端页面 | 前端 API | 后端 Controller |
| --- | --- | --- | --- |
| 系统基础用户管理 | `ruoyi-ui/src/views/system/user/index.vue` | `ruoyi-ui/src/api/system/user.js` | `ruoyi-admin/src/main/java/com/ruoyi/web/controller/system/SysUserController.java` |
| 建筑板块管理 | `ruoyi-ui/src/views/scenic/index.vue` | `ruoyi-ui/src/api/travel/scenery.js`、`ruoyi-ui/src/api/travel/vr.js` | `travel/src/main/java/com/pz/travel/controller/TravelBackstageController.java`、`travel/src/main/java/com/pz/travel/controller/HistoryHumanController.java` |
| 学校活动板块管理 | `ruoyi-ui/src/views/activity/index.vue` | `ruoyi-ui/src/api/activity/index.js` | `travel/src/main/java/com/pz/travel/controller/BookActivController.java` |
| 识别库板块管理 | `ruoyi-ui/src/views/recognition/index.vue` | `ruoyi-ui/src/api/travel/recognition.js`、`ruoyi-ui/src/api/travel/scenery.js` | `travel/src/main/java/com/pz/travel/controller/TravelBackendController.java`、`travel/src/main/java/com/pz/travel/controller/TravelBackstageController.java` |
| VR 数据库板块建设 | `ruoyi-ui/src/views/vr/index.vue` | `ruoyi-ui/src/api/travel/vr.js` | `travel/src/main/java/com/pz/travel/controller/TravelBackstageController.java` |
| 轮播图管理 | `ruoyi-ui/src/views/view/index.vue` | `ruoyi-ui/src/api/travel/view.js` | `travel/src/main/java/com/pz/travel/controller/TravelBackendController.java` |
| 音频库 | `ruoyi-ui/src/views/scenic/index.vue` | `ruoyi-ui/src/api/travel/scenery.js` | `travel/src/main/java/com/pz/travel/controller/TravelBackstageController.java` |
| 视频库 | `ruoyi-ui/src/views/scenic/index.vue`、`ruoyi-ui/src/views/doorway/video.vue` | `ruoyi-ui/src/api/travel/scenery.js`、`ruoyi-ui/src/api/doorway/index.js` | `travel/src/main/java/com/pz/travel/controller/TravelBackstageController.java`、`travel/src/main/java/com/pz/travel/controller/TravelVideoController.java` |
| 剧游板块管理 | `ruoyi-ui/src/views/coverPics/index.vue`、`ruoyi-ui/src/views/activity/index.vue`、`ruoyi-ui/src/views/doorway/video.vue` | `ruoyi-ui/src/api/travel/view.js`、`ruoyi-ui/src/api/activity/index.js`、`ruoyi-ui/src/api/doorway/index.js` | `travel/src/main/java/com/pz/travel/controller/TravelBackstageController.java`、`travel/src/main/java/com/pz/travel/controller/BookActivController.java`、`travel/src/main/java/com/pz/travel/controller/TravelVideoController.java` |
| 数据统计 | `ruoyi-ui/src/views/index.vue` | `ruoyi-ui/src/api/travel/home.js` | `travel/src/main/java/com/pz/travel/controller/WxDataController.java` |

## 1. 系统基础用户管理

### 前端

- 页面：`l:\shanxinongda\ruoyi-ui\src\views\system\user\index.vue`
- API：`l:\shanxinongda\ruoyi-ui\src\api\system\user.js`

### 后端

- Controller：`l:\shanxinongda\ruoyi-admin\src\main\java\com\ruoyi\web\controller\system\SysUserController.java`
- Service 接口：`l:\shanxinongda\ruoyi-system\src\main\java\com\ruoyi\system\service\ISysUserService.java`
- Service 实现：`l:\shanxinongda\ruoyi-system\src\main\java\com\ruoyi\system\service\impl\SysUserServiceImpl.java`
- Mapper：`l:\shanxinongda\ruoyi-system\src\main\java\com\ruoyi\system\mapper\SysUserMapper.java`
- XML：`l:\shanxinongda\ruoyi-system\src\main\resources\mapper\system\SysUserMapper.xml`

### 业务表

- `sys_user`
- `sys_role`
- `sys_post`
- `sys_user_role`
- `sys_user_post`
- `sys_dept`

## 2. 建筑板块管理

### 前端

- 页面：`l:\shanxinongda\ruoyi-ui\src\views\scenic\index.vue`
- API：
  - `l:\shanxinongda\ruoyi-ui\src\api\travel\scenery.js`
  - `l:\shanxinongda\ruoyi-ui\src\api\travel\vr.js`

### 后端

- Controller：
  - `l:\shanxinongda\travel\src\main\java\com\pz\travel\controller\TravelBackstageController.java`
  - `l:\shanxinongda\travel\src\main\java\com\pz\travel\controller\HistoryHumanController.java`
- Service：
  - `l:\shanxinongda\travel\src\main\java\com\pz\travel\service\TravelBackstageService.java`
  - `l:\shanxinongda\travel\src\main\java\com\pz\travel\service\TravelModuleService.java`
  - `l:\shanxinongda\travel\src\main\java\com\pz\travel\service\TravelSubClassificationService.java`
  - `l:\shanxinongda\travel\src\main\java\com\pz\travel\service\TravelVrService.java`
  - `l:\shanxinongda\travel\src\main\java\com\pz\travel\service\TravelJointService.java`
  - `l:\shanxinongda\travel\src\main\java\com\pz\travel\service\HistoryHumanService.java`
- Mapper：
  - `l:\shanxinongda\travel\src\main\java\com\pz\travel\mapper\TravelBackstageMapper.java`
  - `l:\shanxinongda\travel\src\main\java\com\pz\travel\mapper\TravelVrMapper.java`
  - `l:\shanxinongda\travel\src\main\java\com\pz\travel\mapper\HistoryHumanMapper.java`
- XML：
  - `l:\shanxinongda\travel\src\main\resources\mapper\travel\TravelBackstageMapper.xml`
  - `l:\shanxinongda\travel\src\main\resources\mapper\travel\TravelVrMapper.xml`

### 业务表

- `travel_module_detail`
- `travel_module`
- `travel_sub_classification`
- `travel_joint`
- `travel_vr`
- `history_human`

## 3. 学校活动板块管理

### 前端

- 页面：`l:\shanxinongda\ruoyi-ui\src\views\activity\index.vue`
- API：`l:\shanxinongda\ruoyi-ui\src\api\activity\index.js`

### 后端

- Controller：`l:\shanxinongda\travel\src\main\java\com\pz\travel\controller\BookActivController.java`
- Service：`l:\shanxinongda\travel\src\main\java\com\pz\travel\service\BookActivService.java`
- Mapper：`l:\shanxinongda\travel\src\main\java\com\pz\travel\mapper\BookActivMapper.java`

### 业务表

- `book_activ`

## 4. 识别库板块管理

### 前端

- 页面：`l:\shanxinongda\ruoyi-ui\src\views\recognition\index.vue`
- API：
  - `l:\shanxinongda\ruoyi-ui\src\api\travel\recognition.js`
  - `l:\shanxinongda\ruoyi-ui\src\api\travel\scenery.js`

### 后端

- Controller：
  - `l:\shanxinongda\travel\src\main\java\com\pz\travel\controller\TravelBackendController.java`
  - `l:\shanxinongda\travel\src\main\java\com\pz\travel\controller\TravelBackstageController.java`
- Service：
  - `l:\shanxinongda\travel\src\main\java\com\pz\travel\service\TravelService.java`
  - `l:\shanxinongda\travel\src\main\java\com\pz\travel\service\TravelRecognitionLibraryService.java`
- Mapper：`l:\shanxinongda\travel\src\main\java\com\pz\travel\mapper\TravelRecognitionLibraryMapper.java`
- XML：`l:\shanxinongda\travel\src\main\resources\mapper\travel\TravelRecognitionLibraryMapper.xml`

### 业务表

- `travel_recognition_library`
- `travel_module_detail`

## 5. VR 数据库板块建设

### 前端

- 页面：`l:\shanxinongda\ruoyi-ui\src\views\vr\index.vue`
- API：`l:\shanxinongda\ruoyi-ui\src\api\travel\vr.js`

### 后端

- Controller：`l:\shanxinongda\travel\src\main\java\com\pz\travel\controller\TravelBackstageController.java`
- Service：`l:\shanxinongda\travel\src\main\java\com\pz\travel\service\TravelVrService.java`
- Mapper：`l:\shanxinongda\travel\src\main\java\com\pz\travel\mapper\TravelVrMapper.java`
- XML：`l:\shanxinongda\travel\src\main\resources\mapper\travel\TravelVrMapper.xml`

### 业务表

- `travel_vr`

## 6. 轮播图管理

### 前端

- 页面：`l:\shanxinongda\ruoyi-ui\src\views\view\index.vue`
- API：`l:\shanxinongda\ruoyi-ui\src\api\travel\view.js`

### 后端

- Controller：`l:\shanxinongda\travel\src\main\java\com\pz\travel\controller\TravelBackendController.java`
- Service：`l:\shanxinongda\travel\src\main\java\com\pz\travel\service\TravelService.java`
- Mapper：`l:\shanxinongda\travel\src\main\java\com\pz\travel\mapper\TravelSlideshowMapper.java`
- XML：`l:\shanxinongda\travel\src\main\resources\mapper\travel\TravelSlideshowMapper.xml`

### 业务表

- `travel_slideshow`

## 7. 音频库

### 前端

- 页面：`l:\shanxinongda\ruoyi-ui\src\views\scenic\index.vue`
- API：`l:\shanxinongda\ruoyi-ui\src\api\travel\scenery.js`

### 后端

- Controller：`l:\shanxinongda\travel\src\main\java\com\pz\travel\controller\TravelBackstageController.java`
- Service：`l:\shanxinongda\travel\src\main\java\com\pz\travel\service\TravelBackstageService.java`
- Mapper：`l:\shanxinongda\travel\src\main\java\com\pz\travel\mapper\TravelBackstageMapper.java`
- XML：`l:\shanxinongda\travel\src\main\resources\mapper\travel\TravelBackstageMapper.xml`

### 关联字段

- `audioUrl`
- `travelModelVideos`

### 业务表

- `travel_module_detail`

## 8. 视频库

### 前端

- 页面：
  - `l:\shanxinongda\ruoyi-ui\src\views\scenic\index.vue`
  - `l:\shanxinongda\ruoyi-ui\src\views\doorway\video.vue`
- API：
  - `l:\shanxinongda\ruoyi-ui\src\api\travel\scenery.js`
  - `l:\shanxinongda\ruoyi-ui\src\api\doorway\index.js`

### 后端

- Controller：
  - `l:\shanxinongda\travel\src\main\java\com\pz\travel\controller\TravelBackstageController.java`
  - `l:\shanxinongda\travel\src\main\java\com\pz\travel\controller\TravelVideoController.java`
- Service：
  - `l:\shanxinongda\travel\src\main\java\com\pz\travel\service\TravelBackstageService.java`
  - `l:\shanxinongda\travel\src\main\java\com\pz\travel\service\TravelVideoService.java`
- Mapper：
  - `l:\shanxinongda\travel\src\main\java\com\pz\travel\mapper\TravelBackstageMapper.java`
  - `l:\shanxinongda\travel\src\main\java\com\pz\travel\mapper\TravelVideoMapper.java`
- XML：
  - `l:\shanxinongda\travel\src\main\resources\mapper\travel\TravelBackstageMapper.xml`
  - `l:\shanxinongda\travel\src\main\resources\mapper\travel\TravelVideoMapper.xml`

### 业务表

- `travel_module_detail`
- `travel_video`

## 9. 剧游板块管理

### 前端

- 页面：
  - `l:\shanxinongda\ruoyi-ui\src\views\coverPics\index.vue`
  - `l:\shanxinongda\ruoyi-ui\src\views\activity\index.vue`
  - `l:\shanxinongda\ruoyi-ui\src\views\doorway\video.vue`
- API：
  - `l:\shanxinongda\ruoyi-ui\src\api\travel\view.js`
  - `l:\shanxinongda\ruoyi-ui\src\api\activity\index.js`
  - `l:\shanxinongda\ruoyi-ui\src\api\doorway\index.js`

### 后端

- Controller：
  - `l:\shanxinongda\travel\src\main\java\com\pz\travel\controller\TravelBackstageController.java`
  - `l:\shanxinongda\travel\src\main\java\com\pz\travel\controller\BookActivController.java`
  - `l:\shanxinongda\travel\src\main\java\com\pz\travel\controller\TravelVideoController.java`
- Service：
  - `l:\shanxinongda\travel\src\main\java\com\pz\travel\service\TravelCoverService.java`
  - `l:\shanxinongda\travel\src\main\java\com\pz\travel\service\BookActivService.java`
  - `l:\shanxinongda\travel\src\main\java\com\pz\travel\service\TravelVideoService.java`
- Mapper：
  - `l:\shanxinongda\travel\src\main\java\com\pz\travel\mapper\TravelCoverMapper.java`
  - `l:\shanxinongda\travel\src\main\java\com\pz\travel\mapper\BookActivMapper.java`
  - `l:\shanxinongda\travel\src\main\java\com\pz\travel\mapper\TravelVideoMapper.java`
- XML：
  - `l:\shanxinongda\travel\src\main\resources\mapper\travel\TravelCoverMapper.xml`
  - `l:\shanxinongda\travel\src\main\resources\mapper\travel\TravelVideoMapper.xml`

### 业务表

- `travel_cover`
- `book_activ`
- `travel_video`

## 10. 数据统计

### 前端

- 页面：`l:\shanxinongda\ruoyi-ui\src\views\index.vue`
- API：`l:\shanxinongda\ruoyi-ui\src\api\travel\home.js`

### 后端

- Controller：`l:\shanxinongda\travel\src\main\java\com\pz\travel\controller\WxDataController.java`
- Mapper：`l:\shanxinongda\travel\src\main\java\com\pz\travel\mapper\WxDataMapper.java`
- XML：`l:\shanxinongda\travel\src\main\resources\mapper\travel\WxDataMapper.xml`

### 业务表

- `travel_scenic_view`
- `travel_views`
- `travel_module_detail`
