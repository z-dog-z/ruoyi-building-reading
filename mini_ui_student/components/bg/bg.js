// components/bg/bg.js
// 启动页背景组件（写在 components/bg 下）：
// 阶段一：屏幕中央一个小圆圈，校门/灰楼/黄楼/红楼四张图在圆圈里轮播，播完一轮自动展开。
// 阶段二：圆圈放大铺满全屏，进入可左右滑动的全屏界面：
//   - 原生 swiper：手指左右滑动 + 自动轮播，滑到哪张背景（模糊铺底）就跟随哪张；
//   - 每张图等高、宽度按比例自适应，用 wx.createAnimation 的 translateX 缓慢平移，
//     把整张照片呈现出来；没有指示点，想探索哪张就滑到哪张再点“开始探索”；
//   - 右上角是四方格组件，点击进入主页面；开始探索也用微信自己的 wx.redirectTo 跳主页面。
const api = require('../../config/api.js')
const router = require('../../utils/router.js')

// 接口异常 / 还没配好后端地址时使用的四张默认图（校门、灰楼、黄楼、红楼）
const FALLBACK_LIST = [
  'https://ar-travel.1jiaohu.com/files/20250929/194507b3-bb36-4cb2-8795-1464d908710b%E5%90%AF%E5%8A%A8%E9%A1%B54.png',
  'https://ar-travel-file.1jiaohu.com/resource/20260326/bae2b181f1ee40549b708e6f3c88a80a.jpg',
  'https://ar-travel.1jiaohu.com/files/20250929/4be37779-563a-4f7c-b8f4-e16f4e69818ee5b0661bd942e8455f08b21cb2ac69d3.jpg',
  'https://ar-travel-file.1jiaohu.com/resource/20260610/d18d6024be6749f18fa5208b5cff939c.jpg'
]

// 小圆圈里每张图的停留时间（毫秒），注意轮播时间：4 张 × 2000 = 8000ms 播完一轮
const CIRCLE_INTERVAL = 1200
const PAN_DURATION = 12000
const STAGE_INTERVAL = 13000
// 小圆圈直径（rpx），与 wxss 保持一致
const CIRCLE_SIZE_RPX = 240
// 主页面路径
const HOME_URL = '/pages/home/home'

Component({
  data: {
    bgList: [],            // 轮播图列表：[{ url, renderWidth }]
    circleCurrent: 0,      // 小圆圈轮播当前下标
    activeIndex: 0,        // 全屏 swiper 当前下标（同时驱动背景跟随）
    currentBgUrl: '',      // 背景层当前显示的图片（跟随 activeIndex）
    bgOpacity: 1,          // 背景切换淡入淡出
    expanded: false,       // 是否已从圆圈展开到全屏界面
    winWidth: 0,           // 屏幕宽度 px
    winHeight: 0,          // 屏幕高度 px（图片等高的依据）
    gridTop: 48,           // 右上角四方格距顶部的距离（避开微信胶囊按钮）
    circleInterval: CIRCLE_INTERVAL,
    stageInterval: STAGE_INTERVAL,
    circleAnimation: {},   // 绑定给小圆圈的动画（放大用）
    panAnimations: []      // 每张图各自的平移动画
  },

  lifetimes: {
    attached() {
      // 记录每张图“加载完成/失败”是否已结算，避免重复计数
      this.settled = { circle: {}, stage: {} }
      this.circleTimer = null   // 圆圈播完一轮的定时器
      this.hasExpanded = false  // 防止动画重复触发
      this.panToken = 0         // 平移动画令牌，快速切换时丢弃过期动画

      this.initWindow()
      // 先用默认图渲染，保证没有后端也能正常播放
      this.applyList(FALLBACK_LIST)
      // 再请求老师给的轮播接口，成功就替换成接口返回的图片
      this.fetchSlideshow()
      // 小圆圈放大动画实例（微信自己提供的 wx.createAnimation）
      this.circleAnim = wx.createAnimation({
        duration: 600,
        timingFunction: 'ease-in-out'
      })
    },

    detached() {
      // 组件销毁时清理定时器，防止内存泄漏
      if (this.circleTimer) {
        clearTimeout(this.circleTimer)
        this.circleTimer = null
      }
    }
  },

  methods: {
    /** 取屏幕尺寸，作为“等高 + 宽度自适应”的计算依据 */
    initWindow() {
      const info = wx.getWindowInfo ? wx.getWindowInfo() : { windowWidth: 375, windowHeight: 667 }
      // 右上角四方格放在微信胶囊按钮下方，避免和胶囊重叠
      let gridTop = (info.statusBarHeight || 20) + 50
      if (wx.getMenuButtonBoundingClientRect) {
        const menu = wx.getMenuButtonBoundingClientRect()
        if (menu && menu.bottom) gridTop = menu.bottom + 8
      }
      this.setData({
        winWidth: info.windowWidth,
        winHeight: info.windowHeight,
        gridTop
      })
    },

    /** 请求 /travel/slideshow/random 随机轮播接口 */
    fetchSlideshow() {
      wx.request({
        url: api.slideshow,
        method: 'GET',
        timeout: 3000,
        success: (res) => {
          // 已经展开后就不再替换，避免打断全屏动画
          if (this.hasExpanded) return
          const list = this.normalizeList(res.data)
          if (list.length) this.applyList(list)
        },
        fail: (err) => {
          // 接口没配好 / 网络不通时继续使用默认四张图
          console.warn('slideshow 接口请求失败，使用默认轮播图：', err)
        }
      })
    },

    /** 兼容后端常见的几种返回结构，提取出图片地址数组 */
    normalizeList(data) {
      let raw = data
      if (raw && !Array.isArray(raw) && raw.data !== undefined) raw = raw.data
      if (raw && !Array.isArray(raw)) {
        raw = raw.list || raw.records || raw.rows || raw.items || []
      }
      if (!Array.isArray(raw)) return []
      const keys = ['url', 'imgUrl', 'image', 'img', 'pic', 'photo', 'src', 'cover']
      return raw.map((item) => {
        let url = typeof item === 'string' ? item : ''
        if (!url && item && typeof item === 'object') {
          for (let i = 0; i < keys.length; i++) {
            if (item[keys[i]]) { url = item[keys[i]]; break }
          }
        }
        if (!url) return ''
        // 相对路径补全为完整地址
        if (/^https?:\/\//.test(url)) return url
        return api.baseUrl + (url.charAt(0) === '/' ? url : '/' + url)
      }).filter(Boolean)
    },

    /** 更新轮播图数据；renderWidth 先按屏幕宽度占位，图片 load 后再按真实比例修正 */
    applyList(list) {
      this.settled = { circle: {}, stage: {} }
      if (this.circleTimer) {
        clearTimeout(this.circleTimer)
        this.circleTimer = null
      }
      const bgList = list.map((url) => ({ url, renderWidth: this.data.winWidth }))
      this.setData({ bgList, panAnimations: [] })
    },

    /** 小圆圈 swiper 切换时同步下标，展开时好与全屏界面对上同一张图 */
    onCircleChange(e) {
      this.setData({ circleCurrent: e.detail.current })
    },

    /**
     * 全屏 swiper 切换（自动轮播和手指左右滑动都会触发）：
     * 单一数据源 —— 前景 swiper、背景铺底都以这个下标为准。
     */
    onStageChange(e) {
      const index = e.detail.current
      const item = this.data.bgList[index]
      if (!item) return

      // 背景先淡出，换成当前图片后再淡入，实现“轮播到哪张背景就是哪张”
      this.setData({ activeIndex: index, bgOpacity: 0 })
      setTimeout(() => {
        this.setData({ currentBgUrl: item.url, bgOpacity: 1 })
      }, 250)

      // 新切到的图片重新开始从左向右缓慢平移
      this.playPan(index)
    },

    /** 图片加载完成（bindload） */
    onImageLoad(e) {
      const { phase, index } = e.currentTarget.dataset
      const { width, height } = e.detail || {}
      const item = this.data.bgList[index]
      if (!item) return

      // 全屏阶段：按图片真实宽高比计算宽度 —— 高度固定等于屏幕高（等高），宽度自适应
      if (phase === 'stage' && width && height) {
        const renderWidth = Math.round(this.data.winHeight * width / height)
        this.setData({ [`bgList[${index}].renderWidth`]: renderWidth })
        // 当前正在展示的图拿到真实尺寸后，开始从左向右平移
        if (this.data.expanded && index === this.data.activeIndex) {
          this.playPan(index)
        }
      }

      this.markSettled(phase, index)
    },

    /** 图片加载失败（binderror） */
    onImageError(e) {
      const { phase, index } = e.currentTarget.dataset
      console.warn('图片加载失败：', phase, index, e.detail && e.detail.errMsg)
      const item = this.data.bgList[index]
      // 加载失败时换成对应的默认图兜底，保证轮播不会空
      if (item) {
        const fallback = FALLBACK_LIST[index % FALLBACK_LIST.length]
        if (item.url !== fallback) {
          this.settled[phase][index] = false
          this.setData({
            [`bgList[${index}].url`]: fallback,
            [`bgList[${index}].renderWidth`]: this.data.winWidth
          })
          return // 等默认图重新触发 load/error，再结算
        }
      }
      this.markSettled(phase, index)
    },

    /** 结算一张图（成功或失败都算），小圆圈四张图全部结算后开始倒计时 */
    markSettled(phase, index) {
      if (this.settled[phase][index]) return
      this.settled[phase][index] = true
      if (phase !== 'circle' || this.hasExpanded) return
      const total = this.data.bgList.length
      if (total > 0 && Object.keys(this.settled.circle).length >= total) {
        this.startCircleTimer()
      }
    },

    /** 定时器：四张图播完一轮后，自动把圆圈放大进入全屏界面 */
    startCircleTimer() {
      if (this.circleTimer) clearTimeout(this.circleTimer)
      this.circleTimer = setTimeout(() => {
        this.expandToStage()
      }, this.data.bgList.length * CIRCLE_INTERVAL)
    },

    /** 小圆圈放大铺满全屏：放大倍数保证圆圈放大后能盖住整个屏幕（含四角） */
    expandToStage() {
      if (this.hasExpanded) return
      this.hasExpanded = true
      if (this.circleTimer) {
        clearTimeout(this.circleTimer)
        this.circleTimer = null
      }

      const { winWidth, winHeight } = this.data
      const diameter = winWidth * CIRCLE_SIZE_RPX / 750
      const scale = Math.ceil(Math.sqrt(winWidth * winWidth + winHeight * winHeight) / diameter)

      this.circleAnim.scale(scale, scale).step()
      this.setData({ circleAnimation: this.circleAnim.export() })

      // 放大动画结束后切换到全屏界面
      setTimeout(() => {
        this.enterStage()
      }, 620)
    },

    /** 进入全屏探索界面（两个 swiper 首次渲染都直接定位到圆圈里正在展示的那一张） */
    enterStage() {
      const index = this.data.circleCurrent
      this.setData({
        expanded: true,
        activeIndex: index
      })
      // 界面渲染后开始缓慢平移
      setTimeout(() => {
        this.playPan(index)
      }, 120)
    },

    /**
     * 单张图片从左向右缓慢平移（核心平移动画）：
     * 图片等高铺满屏幕后比屏幕宽，translateX 从 0 移到 -(超出部分)，整张照片就呈现出来了。
     * 用 panToken 丢弃快速滑动时产生的过期动画，避免前后两次动画互相打架。
     */
    playPan(index) {
      const item = this.data.bgList[index]
      if (!item) return
      const token = ++this.panToken
      const { winWidth } = this.data
      const imgWidth = item.renderWidth || winWidth
      const overflow = imgWidth - winWidth
      const finalX = overflow > 0 ? -overflow : (winWidth - imgWidth) / 2

      // 先瞬间回到起点（无动画）
      const resetAnim = wx.createAnimation({ duration: 0, timingFunction: 'linear' })
      resetAnim.translateX(0).step()
      this.setData({ [`panAnimations[${index}]`]: resetAnim.export() })

      // 下一帧再开始平移，确保先复位再动画
      setTimeout(() => {
        if (token !== this.panToken) return
        const panAnim = wx.createAnimation({
          duration: overflow > 0 ? PAN_DURATION : 0,
          timingFunction: 'linear'
        })
        panAnim.translateX(finalX).step()
        this.setData({ [`panAnimations[${index}]`]: panAnim.export() })
      }, 80)
    },

    /** “开始探索”：把当前停在哪张图带给主页面 —— 想探索哪张就滑到哪张 */
    onExploreTap() {
      const index = this.data.activeIndex
      const item = this.data.bgList[index]
      const url = item ? encodeURIComponent(item.url) : ''
      router.redirectTo(`${HOME_URL}?index=${index}&url=${url}`)
    },

    /** 右上角四方格组件：进入主页面 */
    onGridTap() {
      router.redirectTo(HOME_URL)
    }
  }
})
