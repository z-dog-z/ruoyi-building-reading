<template>
  <div class="app-container wxdata-page">
    <!-- 1. 基础数据统计 -->
    <el-row :gutter="20">
      <el-col :span="24">
        <div class="chart-card">
          <div class="chart-header">
            <span class="chart-title">基础数据统计</span>
          </div>
          <div class="stat-grid">
            <div class="stat-item" v-for="item in baseList" :key="item.key">
              <div class="stat-icon" :style="{ background: item.color }">
                <i :class="item.icon"></i>
              </div>
              <div class="stat-info">
                <div class="stat-label">{{ item.name }}</div>
                <div class="stat-value">{{ baseData[item.key] || 0 }}</div>
              </div>
            </div>
          </div>
        </div>
      </el-col>
    </el-row>

    <!-- 2. 三个图表 -->
    <el-row :gutter="20" style="margin-top: 20px">
      <!-- 建筑识别排行（横向） -->
      <el-col :span="8">
        <div class="chart-card">
          <div class="chart-header">
            <span class="chart-title">建筑识别排行</span>
          </div>
          <div ref="recognitionChart" class="chart-box" style="height: 380px"></div>
        </div>
      </el-col>
      <!-- 建筑 VR 查看排行（横向） -->
      <el-col :span="8">
        <div class="chart-card">
          <div class="chart-header">
            <span class="chart-title">建筑 VR 查看排行</span>
          </div>
          <div ref="vrChart" class="chart-box" style="height: 380px"></div>
        </div>
      </el-col>
      <!-- 热门建筑排行（纵向，Y轴刻度 0~1） -->
      <el-col :span="8">
        <div class="chart-card">
          <div class="chart-header">
            <span class="chart-title">热门建筑排行</span>
          </div>
          <div ref="hotChart" class="chart-box" style="height: 380px"></div>
        </div>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import * as echarts from 'echarts'
import { getBaseData, getRecognitionRank, getVrRank, getHotRank } from '@/api/wxdata'

export default {
  data() {
    return {
      // 基础统计项
      baseList: [
        { key: "buildingCount", name: "建筑总数", icon: "el-icon-office-building", color: "#2588FF" },
        { key: "vrBuildingCount", name: "VR建筑", icon: "el-icon-view", color: "#36CBCB" },
        { key: "visitorCount", name: "访问用户", icon: "el-icon-user", color: "#FAD337" },
        { key: "scenicViewCount", name: "建筑浏览", icon: "el-icon-data-line", color: "#975FE5" },
        { key: "recognitionCount", name: "建筑识别", icon: "el-icon-aim", color: "#F2637B" },
        { key: "vrViewCount", name: "VR查看", icon: "el-icon-monitor", color: "#5DD5C8" },
        { key: "likeCount", name: "点赞总数", icon: "el-icon-star-on", color: "#FF9F40" },
      ],
      // 基础数据数值
      baseData: {
        buildingCount: 0,
        vrBuildingCount: 0,
        visitorCount: 0,
        scenicViewCount: 0,
        recognitionCount: 0,
        vrViewCount: 0,
        likeCount: 0
      },
      // 建筑识别排行
      recognitionData: [],
      // 建筑 VR 查看排行
      vrData: [],
      // 热门建筑排行
      hotData: [],
      // 图表实例
      recognitionChart: null,
      vrChart: null,
      hotChart: null
    }
  },
  mounted() {
    this.$nextTick(() => {
      this.initCharts()
      this.loadData()
      // 每 30 秒自动刷新一次
      this._timer = setInterval(() => this.loadData(), 30000)
    })
  },
  beforeDestroy() {
    this.recognitionChart?.dispose()
    this.vrChart?.dispose()
    this.hotChart?.dispose()
    window.removeEventListener('resize', this.resizeCharts)
    if (this._timer) clearInterval(this._timer)
  },
  methods: {
    async loadData() {
      try {
        const [baseRes, recRes, vrRes, hotRes] = await Promise.all([
          getBaseData(),
          getRecognitionRank({ limit: 10 }),
          getVrRank({ limit: 10 }),
          getHotRank({ limit: 10 })
        ])
        if (baseRes && baseRes.data) {
          this.baseData = baseRes.data
        }
        // null/undefined name 兜底为 "未知景点"，显示但不丢失数据
        const recList = ((recRes && recRes.data) || []).map(item => item.name ? item : { ...item, name: '未知景点' })
        const vrList = ((vrRes && vrRes.data) || []).map(item => item.name ? item : { ...item, name: '未知景点' })
        const hotList = ((hotRes && hotRes.data) || []).map(item => item.name ? item : { ...item, name: '未知景点' })
        this.recognitionData = recList
        this.vrData = vrList
        this.hotData = hotList
        // 图表重新渲染：两个横向图统一偶数刻度 0、2、4、6、8…
        this.renderHorizontalChart(this.recognitionChart, this.recognitionData, 'rec')
        this.renderHorizontalChart(this.vrChart, this.vrData, 'vr')
        this.renderVerticalChart(this.hotChart, this.hotData)
      } catch (e) {
        console.warn('加载图表数据失败，保持默认', e)
      }
    },
    initCharts() {
      this.recognitionChart = echarts.init(this.$refs.recognitionChart)
      this.vrChart = echarts.init(this.$refs.vrChart)
      this.hotChart = echarts.init(this.$refs.hotChart)

      this.renderHorizontalChart(this.recognitionChart, this.recognitionData, 'rec')
      this.renderHorizontalChart(this.vrChart, this.vrData, 'vr')
      this.renderVerticalChart(this.hotChart, this.hotData)

      window.addEventListener('resize', this.resizeCharts)
    },
    resizeCharts() {
      this.recognitionChart?.resize()
      this.vrChart?.resize()
      this.hotChart?.resize()
    },

    // ---------- 横向柱状图（建筑识别、VR查看） ----------
    renderHorizontalChart(chartInstance, data, mode) {
      const sorted = [...data].sort((a, b) => b.value - a.value)
      const categories = sorted.map(item => item.name)
      const values = sorted.map(item => item.value)
      chartInstance.setOption(this.buildHorizontalOption(categories, values, mode), true)
    },

    buildHorizontalOption(categories, values, mode) {
      const dataMax = values.length ? Math.max(...values) : 0
      // 坐标轴始终从 0 开始（柱子比例真实，value=1 也可见），
      // 两个图统一偶数刻度 0、2、4、6、8…，至少到 10，并在最大值上方留一格余量
      const axisMax = Math.max(10, Math.ceil((dataMax + 1) / 2) * 2)
      const empty = categories.length === 0
      return {
        title: empty ? {
          text: '暂无数据',
          left: 'center',
          top: 'center',
          textStyle: { color: '#bbb', fontSize: 14, fontWeight: 'normal' }
        } : undefined,
        tooltip: {
          trigger: 'axis',
          axisPointer: { type: 'shadow' },
          formatter: params => `${params[0].name}<br/>数量：${params[0].value}`
        },
        grid: { left: '2%', right: '8%', bottom: 24, top: 24, containLabel: true },
        xAxis: {
          type: 'value',
          min: 0,
          max: axisMax,
          interval: 2,
          axisLine: { show: false },
          axisTick: { show: false },
          axisLabel: { color: '#999' },
          splitLine: { lineStyle: { color: '#EEF1F6' } }
        },
        yAxis: {
          type: 'category',
          data: categories,
          inverse: true,
          axisLine: { lineStyle: { color: '#E5E9F2' } },
          axisTick: { show: false },
          axisLabel: {
            color: '#333',
            fontSize: 12,
            // 最多显示 7 个汉字，悬浮 tooltip 可看全名
            formatter: value => (value && value.length > 7 ? value.slice(0, 7) + '…' : value)
          }
        },
        series: [{
          type: 'bar',
          data: values,
          barWidth: '45%',
          itemStyle: { color: '#409EFF', borderRadius: [0, 3, 3, 0] },
          label: {
            show: true,
            position: 'right',
            distance: 6,
            color: '#666',
            fontSize: 12
          }
        }]
      }
    },

    // ---------- 纵向柱状图（热门建筑排行） ----------
    renderVerticalChart(chartInstance, data) {
      // 后端返回 {name, value}，兼容字段名
      const normalized = data.map(item => ({
        name: item.name,
        value: item.value != null ? item.value : (item.count || 0)
      }))
      const sorted = [...normalized].sort((a, b) => b.value - a.value)
      const categories = sorted.map(item => item.name)
      const values = sorted.map(item => item.value)
      chartInstance.setOption(this.buildVerticalOption(categories, values, sorted), true)
    },

    buildVerticalOption(categories, values, fullData) {
      const maxVal = values.length ? Math.max(...values) : 1
      // 从 0 开始、整数刻度、顶部留一格
      const axisMax = Math.max(2, maxVal + 1)
      const empty = categories.length === 0
      return {
        title: empty ? {
          text: '暂无数据',
          left: 'center',
          top: 'center',
          textStyle: { color: '#bbb', fontSize: 14, fontWeight: 'normal' }
        } : undefined,
        tooltip: {
          trigger: 'axis',
          axisPointer: { type: 'shadow' },
          formatter: params => {
            const idx = params[0].dataIndex
            const item = fullData[idx]
            return `${item.name}<br/>排名：第 ${idx + 1} 名<br/>数量：${item.value}`
          }
        },
        grid: { left: '2%', right: '6%', bottom: 24, top: 24, containLabel: true },
        xAxis: {
          type: 'category',
          data: categories,
          axisLabel: {
            color: '#333',
            interval: 0,
            formatter: value => (value && value.length > 6 ? value.slice(0, 6) + '…' : value)
          },
          axisLine: { lineStyle: { color: '#E5E9F2' } },
          axisTick: { show: false }
        },
        yAxis: {
          type: 'value',
          min: 0,
          max: axisMax,
          interval: 1,
          // 隐藏 0 刻度
          axisLabel: { color: '#999', formatter: v => (v === 0 ? '' : v) },
          splitLine: { lineStyle: { color: '#EEF1F6' } },
          axisLine: { show: false },
          axisTick: { show: false }
        },
        series: [{
          type: 'bar',
          data: values,
          barWidth: '40%',
          itemStyle: { color: '#409EFF', borderRadius: [3, 3, 0, 0] },
          label: {
            show: true,
            position: 'top',
            color: '#666',
            fontSize: 12
          }
        }]
      }
    }
  }
}
</script>

<style scoped>
.wxdata-page {
  padding: 20px;
  background: #f0f2f5;
}
.chart-card {
  background: #fff;
  border-radius: 8px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
  padding: 20px;
}
.chart-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 16px;
}
.chart-title {
  font-size: 16px;
  font-weight: 600;
  color: #333;
}
.stat-grid {
  display: flex;
  flex-wrap: wrap;
  gap: 16px;
}
.stat-item {
  flex: 1 1 calc((100% - 6 * 16px) / 7);
  display: flex;
  align-items: center;
  background: #fafafa;
  border-radius: 6px;
  padding: 12px 16px;
  transition: background 0.2s;
  min-width: 0;
}
.stat-item:hover {
  background: #f0f2f5;
}
.stat-icon {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #fff;
  font-size: 20px;
  margin-right: 12px;
  flex-shrink: 0;
}
.stat-info {
  display: flex;
  flex-direction: column;
  overflow: hidden;
}
.stat-label {
  font-size: 14px;
  color: #999;
  white-space: nowrap;
}
.stat-value {
  font-size: 24px;
  font-weight: 600;
  color: #333;
  line-height: 1.4;
}
.chart-box {
  width: 100%;
  min-height: 380px;
}
@media (max-width: 1200px) {
  .stat-item { flex: 1 1 calc((100% - 4 * 16px) / 5); }
}
@media (max-width: 992px) {
  .stat-item { flex: 1 1 calc((100% - 3 * 16px) / 4); }
}
@media (max-width: 768px) {
  .stat-item { flex: 1 1 calc((100% - 2 * 16px) / 3); }
}
</style>
