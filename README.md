# ruoyi框架+建筑可阅读

山西农业大学「建筑可阅读」导览系统，包含 **RuoYi 框架后端管理端** 与 **微信小程序端** 两部分源码。

## 项目简介

面向校园建筑的导览与识别系统：用户在微信小程序中拍照识别建筑，获取建筑详情、语音导览、VR 全景漫游与景点导航；管理员通过后台管理端维护建筑信息、识别库、轮播图与视频等内容。

## 目录结构

```
ruoyi框架+建筑可阅读/
├── shanxinongda/          # RuoYi 框架后端 + 后台管理前端
│   ├── ruoyi-admin/       # 启动模块（含配置文件）
│   ├── ruoyi-common/      # 通用工具与实体
│   ├── ruoyi-framework/   # 安全、JWT、数据源等框架层
│   ├── ruoyi-generator/   # 代码生成
│   ├── ruoyi-quartz/      # 定时任务
│   ├── ruoyi-system/      # 系统管理
│   ├── travel/            # 建筑可阅读业务模块（小程序接口、百度识别、VR）
│   ├── ruoyi-ui/          # 后台管理前端（Vue + Element UI）
│   ├── dev/               # 本地开发辅助（docker-compose 等）
│   └── pom.xml
└── mini_ui_student/       # 微信小程序端
    ├── pages/             # 启动页、首页、建筑列表/详情、拍照识别、视频等
    ├── components/        # 自定义组件
    ├── config/            # 环境与接口地址配置
    ├── utils/             # 请求封装等工具
    └── app.json
```

## 技术栈

| 部分 | 技术 |
| --- | --- |
| 后端 | Spring Boot、Spring Security + JWT、MyBatis、MySQL、Redis、Druid |
| 后台前端 | Vue 2、Element UI、ECharts、Axios |
| 小程序 | 微信小程序原生框架（WXML/WXSS/JS） |
| 第三方 | 百度智能云图像识别（相似图入库/检索）、阿里云 OSS、微信小程序登录 |

## 主要功能

- **小程序端**：无感登录、启动页动画、首页轮播、建筑列表与分类筛选、建筑详情、语音导览、VR 全景漫游、景点导航、拍照识别建筑、识别失败推荐、视频播放与推荐、文档下载、跳转第三方小程序。
- **后台管理端**：建筑管理（含封面、音频、VR 开关）、识别库管理（景点卡片 + 官方/用户识别库、图片上传与压缩）、首页数据统计（ECharts 图表）、轮播图管理、视频管理。

## 运行说明

### 后端

1. 准备 MySQL 8 与 Redis，创建数据库并执行初始化 SQL。
2. 修改 `shanxinongda/ruoyi-admin/src/main/resources/application-dev.yml`，填入你自己的数据库、Redis 与第三方配置。
3. 在 `shanxinongda` 目录执行：

```bash
mvn clean package
java -jar ruoyi-admin/target/ruoyi-admin.jar
```

后台管理前端：

```bash
cd shanxinongda/ruoyi-ui
npm install
npm run dev
```

### 小程序

1. 用微信开发者工具打开 `mini_ui_student` 目录。
2. 在 `mini_ui_student/config/env.js` 中把 `baseUrl` 改为你的后端地址。
3. 编译预览即可。

## 配置说明

仓库中的 `application-dev.yml`、`application-test.yml` 已将所有账号密钥替换为占位符（数据库密码、Redis 密码、微信小程序 secret、微信支付商户密钥、百度智能云 api-key/secret-key）。运行前请自行填写。

请勿将真实密钥提交到公开仓库。

## 说明

本项目为在校实训项目，基于 RuoYi 开源框架（v3.2.0）二次开发。
