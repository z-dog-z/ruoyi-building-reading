
const CURRENT_ENV = 'dev'

const ENV_MAP = {
  dev: {
    // 本地 Java 后端示例地址；不要填入生产服务器地址或任何密钥。
    baseUrl: 'http://127.0.0.1:8020',
    appId: 'wx32b3ddca38855194'
  },
  test: {
    baseUrl: '',
    appId: ''
  },
  prod: {
    baseUrl: '',
    appId: ''
  }
}

module.exports = ENV_MAP[CURRENT_ENV]
