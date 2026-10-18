<template>
  <div class="app-container">

    <!-- 添加按钮 -->
    <div class="add-btn">
      <el-button type="primary" icon="el-icon-plus" @click="handleAdd">添加</el-button>
    </div>

    <!-- 轮播图列表（一行四个网格布局） -->
    <div class="pic-list" v-loading="loading">
      <div class="pic-item" v-for="(item, index) in pictureList" :key="index">
        <!-- 图片区域 -->
        <div class="img-box">
          <el-image :src="item.pictureUrl" fit="cover" style="width: 100%; height: 100%;">
            <div slot="error" class="image-slot">
              <i class="el-icon-picture-outline"></i>
            </div>
          </el-image>
        </div>

        <!-- 底部操作栏（启用开关 + 删除） -->
        <div class="item-footer">
          <!-- 【修改点】把"启用"和开关包在一起，让它们紧挨着 -->
          <div class="switch-group">
            <span class="label">启用</span>
            <el-switch
              v-model="item.status"
              :active-value="1"
              :inactive-value="0"
              active-color="#13ce66"
              @change="handleStatusChange(item)"
            >
            </el-switch>
          </div>
          <span class="delete-text" @click="handleDelete(item.id)">删除</span>
        </div>
      </div>
    </div>

    <!-- 新增/编辑弹窗 -->
    <el-dialog :title="dialogTitle" :visible.sync="dialogVisible" width="500px">
      <el-form :model="form" ref="form" label-width="80px">
        <el-form-item label="轮播图" prop="pictureUrl">
          <el-upload
            class="avatar-uploader"
            :action="uploadFileApi"
            :headers="uploadFileHeaders"
            :show-file-list="false"
            :on-success="handleUploadSuccess"
          >
            <img v-if="form.pictureUrl" :src="form.pictureUrl" class="avatar" />
            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
          </el-upload>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="submitForm">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { getView, addPicApi, deleteViewApi, uploadFileApi, uploadFileHeaders } from '@/api/view'

export default {
  name: 'StartPage',
  data() {
    return {
      loading: false,
      pictureList: [],
      dialogVisible: false,
      dialogTitle: '添加轮播图',
      form: {
        id: '',
        pictureUrl: '',
        status: 1
      },
      uploadFileApi,
      uploadFileHeaders
    }
  },
  created() {
    this.getList()
  },
  methods: {
    async getList() {
      this.loading = true
      try {
        const res = await getView()
        let rows = res.rows || []

        // 字符串对比排序，解决 bigint 精度丢失问题
        rows.sort((a, b) => String(a.id).localeCompare(String(b.id)));

        this.pictureList = rows;
      } catch (error) {
        console.error(error)
      } finally {
        this.loading = false
      }
    },
    handleAdd() {
      this.dialogTitle = '添加轮播图'
      this.form = { id: '', pictureUrl: '', status: 1 }
      this.dialogVisible = true
    },
    handleUploadSuccess(res) {
      if (res.code === 200) {
        this.form.pictureUrl = res.data.url
      } else {
        this.$message.error('上传失败')
      }
    },
    async submitForm() {
      if (!this.form.pictureUrl) {
        return this.$message.warning('请上传图片')
      }
      try {
        await addPicApi(this.form)
        this.$message.success('操作成功')
        this.dialogVisible = false
        this.getList()
      } catch (error) {
        console.error(error)
      }
    },
    async handleStatusChange(item) {
      try {
        await addPicApi({ id: item.id, status: item.status, pictureUrl: item.pictureUrl })
        this.$message.success('状态更新成功')
      } catch (error) {
        item.status = item.status === 1 ? 0 : 1 // 如果失败，回滚状态
      }
    },
    async handleDelete(id) {
      try {
        await this.$confirm('确认删除该轮播图吗?', '提示', { type: 'warning' })
        await deleteViewApi(id)
        this.$message.success('删除成功')
        this.getList()
      } catch (error) {
        if (error !== 'cancel') console.error(error)
      }
    }
  }
}
</script>

<style scoped>
/* 页面整体背景 */
.app-container {
  padding: 20px;
  background-color: #f0f2f5;
  min-height: calc(100vh - 84px);
}
.breadcrumb {
  margin-bottom: 20px;
  font-size: 14px;
}
.add-btn {
  margin-bottom: 20px;
}

/* 🎯 核心布局：一行四个网格布局 */
.pic-list {
  display: grid;
  grid-template-columns: repeat(4, 1fr); /* 一行四个 */
  gap: 20px; /* 中间间隔 20px */
}

/* 每个卡片样式：加边框、阴影、圆角 */
.pic-item {
  background: #ffffff;
  border: 1px solid #ebeef5;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.05);
  transition: all 0.3s;
}

/* 鼠标悬浮时的轻微浮起效果 */
.pic-item:hover {
  box-shadow: 0 4px 16px 0 rgba(0, 0, 0, 0.1);
  transform: translateY(-2px);
}

/* 图片区域容器：固定高度，防止图片变形 */
.img-box {
  width: 100%;
  height: 220px;
  background-color: #f5f7fa;
  border-bottom: 1px solid #ebeef5;
}

/* 图片加载失败时的占位图标 */
.image-slot {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
  height: 100%;
  color: #909399;
  font-size: 30px;
}

/* 底部操作栏：左边一组（启用+开关），右边删除 */
.item-footer {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 12px 15px;
}

/* 【新增】启用 + 开关 组合：让它们贴在一起 */
.switch-group {
  display: flex;
  align-items: center;
  gap: 8px;          /* "启用"文字和开关之间的间距，8px 刚刚好 */
}

.switch-group .label {
  font-size: 14px;
  color: #606266;
  line-height: 1;    /* 防止 label 撑高 */
}

.delete-text {
  font-size: 14px;
  color: #606266;
  cursor: pointer;
  transition: color 0.3s;
}
.delete-text:hover {
  color: #f56c6c; /* 鼠标悬浮变红 */
}

/* 弹窗里的上传图片样式 */
.avatar-uploader .el-upload {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}
.avatar-uploader .el-upload:hover {
  border-color: #409eff;
}
.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 178px;
  height: 178px;
  line-height: 178px;
  text-align: center;
}
.avatar {
  width: 178px;
  height: 178px;
  display: block;
  object-fit: cover;
}
</style>
