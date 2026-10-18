<template>
  <div class="cover-page">
    <el-row :gutter="40">
      <!-- 左列：拍照封面 -->
      <el-col :span="12">
        <div class="cover-section">
          <el-upload
            class="upload-btn"
            :action="uploadFileApi"
            :headers="uploadFileHeaders"
            :show-file-list="false"
            :on-success="(res) => handleCoverSuccess(res, 0)"
            :before-upload="beforeUpload"
          >
            <el-button type="primary">修改拍照封面</el-button>
          </el-upload>
          <div class="img-box">
            <img v-if="photoCover" :src="photoCover" class="cover-img" alt="拍照封面" />
            <div v-else class="no-img">暂无图片</div>
          </div>
        </div>
      </el-col>

      <!-- 右列：阅读封面 -->
      <el-col :span="12">
        <div class="cover-section">
          <el-upload
            class="upload-btn"
            :action="uploadFileApi"
            :headers="uploadFileHeaders"
            :show-file-list="false"
            :on-success="(res) => handleCoverSuccess(res, 1)"
            :before-upload="beforeUpload"
          >
            <el-button type="primary">修改阅读封面</el-button>
          </el-upload>
          <div class="img-box">
            <img v-if="readCover" :src="readCover" class="cover-img" alt="阅读封面" />
            <div v-else class="no-img">暂无图片</div>
          </div>
        </div>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import { getCoverApi, editCoverApi, uploadFileApi, uploadFileHeaders } from '@/api/view'

export default {
  name: 'CoverPage',
  data() {
    return {
      photoCover: '', // 拍照封面 (identity = 0)
      readCover: '',  // 阅读封面 (identity = 1)
      uploadFileApi,
      uploadFileHeaders
    }
  },
  created() {
    this.getCovers()
  },
  methods: {
    async getCovers() {
      try {
        // 获取拍照封面
        const res0 = await getCoverApi(0)
        this.photoCover = res0.data || ''
      } catch (error) {
        console.error('获取拍照封面失败', error)
      }

      try {
        // 获取阅读封面
        const res1 = await getCoverApi(1)
        this.readCover = res1.data || ''
      } catch (error) {
        console.error('获取阅读封面失败', error)
      }
    },
    beforeUpload(file) {
      const isLt5M = file.size / 1024 / 1024 < 5
      if (!isLt5M) {
        this.$message.error('图片大小不能超过 5MB!')
      }
      return isLt5M
    },
    async handleCoverSuccess(res, identity) {
      if (res.code === 200) {
        try {
          await editCoverApi({ identity, pictureUrl: res.data.url })
          this.$message.success('修改成功')
          // 刷新对应的图片
          if (identity === 0) {
            this.photoCover = res.data.url
          } else {
            this.readCover = res.data.url
          }
        } catch (error) {
          console.error('封面修改失败', error)
        }
      } else {
        this.$message.error(res.msg || '上传失败')
      }
    }
  }
}
</script>

<style scoped>
.cover-page {
  padding: 20px;
}
.cover-section {
  display: flex;
  flex-direction: column;
  gap: 20px;
}
.upload-btn {
  align-self: flex-start;
}
.img-box {
  width: 100%;
  height: 400px;
  border: 1px solid #ebeef5;
  border-radius: 4px;
  overflow: hidden;
  background-color: #fafafa;
  display: flex;
  justify-content: center;
  align-items: center;
}
.cover-img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}
.no-img {
  color: #909399;
  font-size: 14px;
}
</style>
