<template>
  <div class="app-container">
    <!-- ==================== 视图1：景点资源库列表 ==================== -->
    <div v-if="viewMode === 'list'">
      <div class="list-label">景点</div>

      <!-- 搜索栏 -->
      <div class="search-bar">
        <el-input
          v-model="queryName"
          placeholder="请输入资源库名称"
          clearable
          style="width: 240px;"
          @keyup.enter.native="getSpotList"
        ></el-input>
        <el-button type="primary" @click="getSpotList">搜索</el-button>
      </div>

      <!-- 景点卡片网格 -->
      <div class="spot-list" v-loading="loading">
        <div
          class="spot-card"
          v-for="item in spotList"
          :key="item.id"
          @click="openDetail(item)"
        >
          <div class="spot-card__img">
            <el-image :src="getCover(item.pictureUrl)" fit="cover" style="width:100%;height:100%;">
              <div slot="error" class="image-slot">
                <i class="el-icon-picture-outline"></i>
              </div>
            </el-image>
          </div>
          <div class="spot-card__name">{{ item.name }}</div>
        </div>
      </div>

      <div v-if="spotList.length === 0 && !loading" class="empty-tip">
        <i class="el-icon-picture-outline"></i>
        <p>暂无景点</p>
      </div>
    </div>

    <!-- ==================== 视图2：单个景点的识别库 ==================== -->
    <div v-if="viewMode === 'detail'">
      <!-- 顶部 Tab：官方识别库 / 用户识别库 -->
      <el-tabs v-model="activeTab" @tab-click="handleTabChange">
        <el-tab-pane label="官方识别库" name="2"></el-tab-pane>
        <el-tab-pane label="用户识别库" name="1"></el-tab-pane>
      </el-tabs>

      <!-- 操作按钮 -->
      <div class="toolbar">
        <el-button type="primary" @click="goBack">返回</el-button>
        <el-button v-if="activeTab === '2'" type="primary" icon="el-icon-plus" @click="handleAdd">新增</el-button>
        <el-button type="primary" @click="handleBatchDelete">删除</el-button>
      </div>

      <!-- 当前景点名 -->
      <div class="current-spot">当前景点：{{ currentSpot.name }}</div>

      <!-- 图片网格 -->
      <div class="pic-list" v-loading="loading">
        <div
          class="pic-item"
          v-for="item in picList"
          :key="item.id"
          :class="{ active: selectedIds.includes(item.id) }"
          @click="toggleSelect(item.id)"
        >
          <el-image :src="item.url" fit="cover" style="width:100%;height:100%;">
            <div slot="error" class="image-slot">
              <i class="el-icon-picture-outline"></i>
            </div>
          </el-image>
        </div>
      </div>

      <!-- 空提示 -->
      <div v-if="picList.length === 0 && !loading" class="empty-tip">
        <i class="el-icon-picture-outline"></i>
        <p>暂无图片</p>
      </div>
    </div>

    <!-- 新增弹窗 -->
    <el-dialog title="新增识别库图片" :visible.sync="dialogVisible" width="500px" @close="resetForm">
      <el-form ref="formRef" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="图片" prop="url">
          <el-upload
            class="avatar-uploader"
            :action="uploadFileApi"
            :headers="uploadFileHeaders"
            :show-file-list="false"
            accept="image/*"
            :on-success="handleUploadSuccess"
            :before-upload="beforeImageUpload"
          >
            <img v-if="form.url" :src="form.url" class="avatar" />
            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
          </el-upload>
        </el-form-item>
        <el-form-item label="文件名" prop="filename">
          <el-input v-model="form.filename" placeholder="请输入文件名"></el-input>
        </el-form-item>
        <el-form-item label="关联景点">
          <el-input :value="currentSpot.name" disabled></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer">
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="submitForm">确定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import {
  getLibraryPicturesList,
  addPicturesToLibrary,
  deletePicturesToLibrary
} from '@/api/recognition'
import { getTravelList, uploadFileApi, uploadFileHeaders } from '@/api/scenery'

export default {
  name: 'RecognitionIndex',
  data() {
    return {
      viewMode: 'list',      // list：景点列表；detail：识别库详情
      queryName: '',
      loading: false,
      spotList: [],

      // 详情视图
      activeTab: '2',        // 2：官方，1：用户
      currentSpot: {},
      picList: [],
      selectedIds: [],

      dialogVisible: false,
      form: {
        filename: '',
        url: '',
        moduleDetailId: ''
      },
      uploadFileApi,
      uploadFileHeaders,
      rules: {
        url: [{ required: true, message: '请上传图片', trigger: 'change' }],
        filename: [{ required: true, message: '请输入文件名', trigger: 'blur' }]
      }
    }
  },
  created() {
    this.getSpotList()
  },
  methods: {
    /* ---------------- 视图1：景点列表 ---------------- */
    async getSpotList() {
      this.loading = true
      try {
        const res = await getTravelList({
          pageNum: 1,
          pageSize: 100,
          moduleId: 847162,
          activity: 0,
          name: this.queryName || undefined
        })
        this.spotList = res.rows || []
      } catch (e) {
        console.error(e)
      } finally {
        this.loading = false
      }
    },

    getCover(pictureUrl) {
      return pictureUrl ? pictureUrl.split(',')[0] : ''
    },

    // 点击景点卡片 → 进入识别库详情
    openDetail(spot) {
      this.currentSpot = spot
      this.activeTab = '2'
      this.viewMode = 'detail'
      this.selectedIds = []
      this.getPicList()
    },

    /* ---------------- 视图2：识别库详情 ---------------- */
    async getPicList() {
      this.loading = true
      try {
        const res = await getLibraryPicturesList({
          moduleDetailId: this.currentSpot.id,
          source: Number(this.activeTab)
        })
        this.picList = res.rows || res.data || []
        this.selectedIds = []
      } catch (e) {
        console.error(e)
      } finally {
        this.loading = false
      }
    },

    handleTabChange() {
      this.getPicList()
    },

    toggleSelect(id) {
      const idx = this.selectedIds.indexOf(id)
      if (idx > -1) this.selectedIds.splice(idx, 1)
      else this.selectedIds.push(id)
    },

    goBack() {
      this.viewMode = 'list'
      this.picList = []
      this.selectedIds = []
    },

    handleAdd() {
      this.form = {
        filename: '',
        url: '',
        moduleDetailId: this.currentSpot.id
      }
      this.dialogVisible = true
    },

    handleUploadSuccess(res) {
      if (res.code === 200) {
        this.form.url = res.data.url
        if (!this.form.filename && res.data.name) {
          this.form.filename = res.data.name
        }
        this.$refs.formRef.validateField('url')
      } else {
        this.$message.error(res.msg || '上传失败')
      }
    },

    beforeImageUpload(file) {
      const isImage = file.type.indexOf('image/') === 0
      if (!isImage) {
        this.$message.error('只能上传图片文件!')
        return false
      }
      // 百度相似图要求文件不超过 10MB；大图先压缩再上传
      if (file.size / 1024 / 1024 > 10) {
        this.$message.error('图片不能超过 10MB!')
        return false
      }
      return this.compressImage(file)
    },

    // 超长边图片按比例压缩到 2048 以内，JPEG 0.9 质量
    compressImage(file) {
      return new Promise((resolve) => {
        // 非 jpeg/png 直接放行
        if (!/image\/(jpeg|png|jpg)/.test(file.type)) {
          resolve(file)
          return
        }
        const reader = new FileReader()
        reader.onload = (e) => {
          const img = new Image()
          img.onload = () => {
            const MAX_SIDE = 2048
            let { width, height } = img
            if (width <= MAX_SIDE && height <= MAX_SIDE && file.size / 1024 / 1024 < 2) {
              resolve(file)
              return
            }
            if (width > height && width > MAX_SIDE) {
              height = Math.round(height * MAX_SIDE / width)
              width = MAX_SIDE
            } else if (height > MAX_SIDE) {
              width = Math.round(width * MAX_SIDE / height)
              height = MAX_SIDE
            }
            const canvas = document.createElement('canvas')
            canvas.width = width
            canvas.height = height
            canvas.getContext('2d').drawImage(img, 0, 0, width, height)
            canvas.toBlob((blob) => {
              const compressed = new File([blob], file.name.replace(/\.\w+$/, '.jpg'), { type: 'image/jpeg' })
              resolve(compressed)
            }, 'image/jpeg', 0.9)
          }
          img.onerror = () => resolve(file)
          img.src = e.target.result
        }
        reader.onerror = () => resolve(file)
        reader.readAsDataURL(file)
      })
    },

    async submitForm() {
      this.$refs.formRef.validate(async (valid) => {
        if (!valid) return
        try {
          const payload = {
            ...this.form,
            tag: 1,
            moduleDetailId: this.currentSpot.id
          }
          await addPicturesToLibrary('1', payload)
          this.$message.success('新增成功')
          this.dialogVisible = false
          this.getPicList()
        } catch (e) {
          this.$message.error(e.message || '识别库添加失败！')
        }
      })
    },

    async handleBatchDelete() {
      if (this.selectedIds.length === 0) {
        return this.$message.warning('请先选择要删除的图片')
      }
      try {
        await this.$confirm(`确认删除选中的 ${this.selectedIds.length} 张图片吗?`, '提示', { type: 'warning' })
        await deletePicturesToLibrary(this.selectedIds)
        this.$message.success('删除成功')
        this.getPicList()
      } catch (e) {
        if (e !== 'cancel') console.error(e)
      }
    },

    resetForm() {
      if (this.$refs.formRef) this.$refs.formRef.resetFields()
    }
  }
}
</script>

<style scoped>
.app-container {
  padding: 20px;
  background-color: #f0f2f5;
  min-height: calc(100vh - 84px);
}

/* ---------- 视图1：景点列表 ---------- */
.list-label {
  font-size: 16px;
  font-weight: 600;
  color: #303133;
  padding-bottom: 10px;
  border-bottom: 2px solid #409eff;
  display: inline-block;
  margin-bottom: 20px;
}

.search-bar {
  display: flex;
  gap: 10px;
  margin-bottom: 24px;
}

.spot-list {
  display: grid;
  grid-template-columns: repeat(5, 1fr);
  gap: 20px;
}

.spot-card {
  background: #fff;
  border-radius: 6px;
  overflow: hidden;
  cursor: pointer;
  transition: all 0.2s;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
}

.spot-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 6px 18px rgba(0, 0, 0, 0.15);
}

.spot-card__img {
  width: 100%;
  height: 170px;
  background: #f5f7fa;
}

.spot-card__name {
  padding: 10px 12px;
  font-size: 15px;
  color: #303133;
  text-align: center;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

/* ---------- 视图2：识别库详情 ---------- */
.toolbar {
  display: flex;
  gap: 10px;
  margin-bottom: 12px;
}

.current-spot {
  color: #606266;
  font-size: 14px;
  margin-bottom: 16px;
}

.pic-list {
  display: grid;
  grid-template-columns: repeat(5, 1fr);
  gap: 20px;
}

.pic-item {
  width: 100%;
  height: 180px;
  border: 2px solid transparent;
  border-radius: 4px;
  overflow: hidden;
  cursor: pointer;
  transition: all 0.2s;
  background: #fff;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
}

.pic-item:hover {
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.15);
}

.pic-item.active {
  border-color: #409eff;
}

.image-slot {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
  height: 100%;
  color: #909399;
  font-size: 30px;
}

.empty-tip {
  text-align: center;
  color: #909399;
  padding: 60px 0;
}
.empty-tip i {
  font-size: 40px;
  margin-bottom: 10px;
}

/* ---------- 上传 ---------- */
.avatar-uploader {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
  width: 120px;
  height: 120px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: #fafafa;
}
.avatar-uploader:hover {
  border-color: #409eff;
}
.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
}
.avatar {
  width: 120px;
  height: 120px;
  object-fit: cover;
  display: block;
}
</style>
