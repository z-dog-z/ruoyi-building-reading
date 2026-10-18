# 纯若依前端

本目录是若依 Vue `v3.2`（`3.2.0`）官方前端的独立副本，只保留若依框架自带的登录、首页、系统管理、监控管理和代码生成功能。

它与项目原有的 `ruoyi-ui` 完全独立，原目录中的山西农大项目代码不会被修改或删除。

为兼容本仓库后端的登录接口，新版本登录页保留了原 `ruoyi-ui` 使用的 AES 密码加密；除此之外不包含山西农大业务页面和接口。

如果连接当前项目数据库，后端仍可能返回山西农大项目的自定义菜单；要完整显示纯若依菜单，建议配套若依原生后端和数据库。

## 开发

```bash
# 克隆项目
git clone https://gitee.com/y_project/RuoYi-Vue

# 进入项目目录
cd ruoyi-ui

# 安装依赖
npm install

# 建议不要直接使用 cnpm 安装依赖，会有各种诡异的 bug。可以通过如下操作解决 npm 下载速度慢的问题
npm install --registry=https://registry.npm.taobao.org

# 启动服务
npm run dev
```

浏览器访问 http://localhost:80

## 发布

```bash
# 构建测试环境
npm run build:stage

# 构建生产环境
npm run build:prod
```
