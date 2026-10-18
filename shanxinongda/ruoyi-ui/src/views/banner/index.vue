<template>
  <div class="app-container">
    <!-- 顶部新增按钮 -->
    <div class="toolbar">
      <el-button type="primary" @click="handleAdd">新增</el-button>
    </div>

    <!-- Banner 卡片列表 -->
    <div class="banner-list" v-loading="loading">
      <div class="banner-item" v-for="item in list" :key="item.id">
        <!-- 封面图 -->
        <div class="img-box">
          <el-image :src="item.background" fit="cover" style="width:100%;height:100%;">
            <div slot="error" class="image-slot">
              <i class="el-icon-picture-outline"></i>
            </div>
          </el-image>
        </div>
        <!-- 操作按钮 -->
        <div class="item-footer">
          <el-button type="primary" size="small" @click="handleEdit(item)">修改</el-button>
          <el-button size="small" @click="handleDelete(item.id)">删除</el-button>
        </div>
      </div>
    </div>

    <!-- 新增/修改弹窗 -->
    <el-dialog :title="dialogTitle" :visible.sync="dialogVisible" width="480px" @close="resetForm">
      <el-form ref="formRef" :model="form" :rules="rules" label-width="100px">
        <!-- 封面 -->
        <el-form-item label="banner封面" prop="background">
          <el-upload
            class="avatar-uploader"
            :action="uploadFileApi"
            :headers="uploadFileHeaders"
            :show-file-list="false"
            :on-success="handleUploadSuccess"
            :before-upload="beforeUpload"
          >
            <img v-if="form.background" :src="form.background" class="avatar" />
            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
          </el-upload>
          <div class="upload-tip">照片数量限制为1个</div>
        </el-form-item>

        <!-- 跳转类型 -->
        <el-form-item label="跳转类型" prop="type">
          <el-radio-group v-model="form.type">
            <el-radio :label="1">小程序页面</el-radio>
            <el-radio :label="2">外部链接</el-radio>
          </el-radio-group>
        </el-form-item>

        <!-- banner 地址 -->
        <el-form-item label="banner地址" prop="url">
          <el-input
            v-model="form.url"
            :placeholder="form.type === 2 ? '请输入网页链接，如 https://...' : '请输入小程序页面路径，如 /pages/building/building'"
          ></el-input>
          <div class="upload-tip">{{ form.type === 2 ? '点击轮播图将用 web-view 打开该网页' : '点击轮播图将跳转到该小程序页面' }}</div>
        </el-form-item>

        <!-- 是否启用 -->
        <el-form-item label="是否启用">
          <el-radio-group v-model="form.status">
            <el-radio :label="1">是</el-radio>
            <el-radio :label="0">否</el-radio>
          </el-radio-group>
        </el-form-item>
      </el-form>

      <div slot="footer">
        <el-button type="primary" @click="submitForm">立即修改</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { activityList, activityAdd, activityUpdate, activityDelete } from '@/api/banner'
import { uploadFileApi, uploadFileHeaders } from '@/api/view'

export default {
  name: 'BannerIndex',
  data() {
    return {
      loading: false,
      list: [],
      dialogVisible: false,
      dialogTitle: '修改banner',
      form: {
        id: '',
        background: '',
        name: '',
        type: 1,
        url: '',
        status: 1
      },
      uploadFileApi,
      uploadFileHeaders,
      rules: {
        background: [{ required: true, message: '请上传banner封面', trigger: 'change' }],
        url: [{ required: true, message: '请输入banner地址', trigger: 'blur' }]
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    async getList() {
      this.loading = true
      try {
        const res = await activityList()
        this.list = res.data || res.rows || []
      } catch (e) {
        console.error(e)
      } finally {
        this.loading = false
      }
    },

    handleAdd() {
      this.dialogTitle = '新增banner'
      this.form = { id: '', background: '', name: '', type: 1, url: '', status: 1 }
      this.dialogVisible = true
    },

    handleEdit(item) {
      this.dialogTitle = '修改banner'
      this.form = { ...item }
      this.dialogVisible = true
    },

    handleUploadSuccess(res) {
      if (res.code === 200) {
        this.form.background = res.data.url
        this.$refs.formRef.validateField('background')
      } else {
        this.$message.error(res.msg || '上传失败')
      }
    },

    beforeUpload(file) {
      const isLt5M = file.size / 1024 / 1024 < 5
      if (!isLt5M) this.$message.error('图片大小不能超过 5MB!')
      return isLt5M
    },

    async submitForm() {
      this.$refs.formRef.validate(async (valid) => {
        if (!valid) return
        // name 未填时用 url 兜底
        if (!this.form.name) this.form.name = this.form.url
        try {
          if (this.form.id) {
            await activityUpdate(this.form)
            this.$message.success('修改成功')
          } else {
            await activityAdd(this.form)
            this.$message.success('新增成功')
          }
          this.dialogVisible = false
          this.getList()
        } catch (e) {
          console.error(e)
        }
      })
    },

    handleDelete(id) {
      this.$confirm('确认删除该banner吗?', '提示', { type: 'warning' })
        .then(async () => {
          await activityDelete(id)
          this.$message.success('删除成功')
          this.getList()
        })
        .catch(() => {})
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
.toolbar {
  margin-bottom: 20px;
}
.banner-list {
  display: grid;
  grid-template-columns: repeat(3, 1fr);   /* 一行三个，和你图2一致 */
  gap: 24px;
}
.banner-item {
  background: #fff;
  border-radius: 4px;
  overflow: hidden;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
}
.img-box {
  width: 100%;
  height: 200px;
  background-color: #f5f7fa;
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
.item-footer {
  display: flex;
  gap: 10px;
  padding: 10px 12px;
}
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
.upload-tip {
  font-size: 12px;
  color: #999;
  margin-top: 5px;
}
</style>
