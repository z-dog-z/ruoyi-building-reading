# mini_ui_student

这是给学生使用的小程序基础框架，不包含景点、活动、视频、支付等业务页面和业务资源。

## 使用方式

1. 在 `config/env.js` 中填写自己的 Java 后端地址和小程序 AppID。
2. 在微信开发者工具中导入本目录，并使用自己的 AppID。
3. 启动后首页会自动调用 `wx.login`，将一次性 code 交给后端换取业务 token；本地已有 token 时直接复用，因此不需要单独登录页面。
4. 业务接口统一使用 `utils/request.js`（或 `app.js` 中的 `wxRequest`/`wxUpload`），具体接口由学生自行增加到 `config/api.js` 或业务模块中。封装已经包含 Token 注入和 401 自动重试。

小程序端不放 AppSecret、云服务 AK/SK、数据库密码等服务端凭证。
