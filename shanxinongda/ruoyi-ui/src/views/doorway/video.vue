<template>
  <div class="app-container">
    
    <!-- 搜索区 -->
    <div class="filter-container">
      <el-input
        v-model="queryParams.name"
        placeholder="请输入视频名称"
        style="width: 200px; margin-right: 10px;"
        clearable
        @keyup.enter.native="handleQuery"
      ></el-input>
      <el-button type="primary" @click="handleQuery">查询</el-button>
    </div>

    <!-- 新增按钮 -->
    <div class="add-btn">
      <el-button type="primary" @click="handleAdd">新增视频</el-button>
    </div>

    <!-- 表格 -->
    <el-table
      :data="tableData"
      style="width: 100%"
      v-loading="loading"
      border
      :header-cell-style="{ background: '#f5f7fa', color: '#606266', fontWeight: 'bold' }"
    >
      <el-table-column type="index" label="序号" width="80" align="center"></el-table-column>
      <el-table-column prop="name" label="视频名称" min-width="250" show-overflow-tooltip></el-table-column>
      <el-table-column label="排序" width="200" align="center">
        <template slot-scope="scope">
          <el-input-number
            v-model="scope.row.inx"
            :min="0"
            controls-position="right"
            style="width: 100%;"
            @change="handleSortChange(scope.row)"
          ></el-input-number>
        </template>
      </el-table-column>
      <el-table-column prop="createTime" label="创建时间" width="200" align="center"></el-table-column>
      <el-table-column label="操作" width="200" align="center">
        <template slot-scope="scope">
          <el-button type="primary" size="small" @click="handleDetail(scope.row)">详情</el-button>
          <el-button type="danger" size="small" @click="handleDelete(scope.row)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 分页 -->
    <div class="pagination-container">
      <el-pagination
        background
        layout="total, sizes, prev, pager, next"
        :total="total"
        :page.sync="queryParams.pageNum"
        :limit.sync="queryParams.pageSize"
        @pagination="getList"
      ></el-pagination>
    </div>

    <!-- 新增/编辑弹窗 -->
    <el-dialog :title="dialogTitle" :visible.sync="dialogVisible" width="600px" @close="resetForm">
      <el-form :model="form" ref="form" :rules="rules" label-width="80px">
        <el-form-item label="封面" prop="cover">
          <el-upload
            class="avatar-uploader"
            :action="uploadFileApi"
            :headers="uploadFileHeaders"
            :show-file-list="false"
            :on-success="(res) => handleUploadSuccess(res, 'cover')"
            accept="image/*"
          >
            <img v-if="form.cover" :src="form.cover" class="avatar" />
            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
          </el-upload>
        </el-form-item>
        <el-form-item label="视频名称" prop="name">
          <el-input v-model="form.name" placeholder="请输入视频名称"></el-input>
        </el-form-item>
        <el-form-item label="视频" prop="video">
          <el-upload
            class="video-uploader"
            :action="uploadFileApi"
            :headers="uploadFileHeaders"
            :show-file-list="false"
            :on-success="(res) => handleUploadSuccess(res, 'video')"
            accept="video/*"
          >
            <el-button type="primary" icon="el-icon-upload2">点击上传</el-button>
            <span v-if="form.video" style="margin-left: 10px; color: #67c23a;">已上传</span>
          </el-upload>
        </el-form-item>
        <el-form-item label="排序" prop="inx">
          <el-input-number v-model="form.inx" :min="0" controls-position="right" style="width: 100%;"></el-input-number>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="submitForm">提交</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { getTravelList, deleteTravelScenery, saveTravelScenery, updateTravelScenery } from '@/api/index'
import { uploadFileApi, uploadFileHeaders } from '@/api/view'

export default {
  name: 'VideoList',
  data() {
    return {
      loading: false,
      tableData: [],
      total: 0,
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        name: '',
        //orderByColumn: 'inx',
        //isAsc: 'asc'
      },
      dialogVisible: false,
      dialogTitle: '新增视频',
      form: {
        id: '',
        name: '',
        cover: '',
        video: '',
        inx: 0
      },
      rules: {
        name: [{ required: true, message: '请输入视频名称', trigger: 'blur' }],
        cover: [{ required: true, message: '请上传封面', trigger: 'change' }],
        video: [{ required: true, message: '请上传视频', trigger: 'change' }]
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
        // ============ 核心修改：如果 name 为空，就不传给后端 ============
        if (!this.queryParams.name || this.queryParams.name.trim() === '') {
          delete this.queryParams.name; // 删掉空参数
        }

        const res = await getTravelList(this.queryParams)
        console.log('接口返回数据：', res) // F12 控制台看这里

        this.tableData = res.rows || []
        this.total = res.total || 0
      } catch (error) {
        console.error('获取列表失败', error)
        this.tableData = []
        this.total = 0
      } finally {
        this.loading = false
      }
    },
    handleQuery() {
      this.queryParams.pageNum = 1
      this.getList()
    },
    handleAdd() {
      this.dialogTitle = '新增视频'
      this.form = { id: '', name: '', cover: '', video: '', inx: 0 }
      this.dialogVisible = true
    },
    handleDetail(row) {
      this.dialogTitle = '修改视频'
      this.form = { ...row }
      this.dialogVisible = true
    },
    handleUploadSuccess(res, field) {
      if (res.code === 200) {
        this.form[field] = res.data.url
        this.$refs.form.validateField(field)
      } else {
        this.$message.error('上传失败')
      }
    },
    async handleSortChange(row) {
      try {
        await updateTravelScenery({ id: row.id, inx: row.inx })
        this.$message.success('排序修改成功')
      } catch (error) {
        this.getList()
      }
    },
    async submitForm() {
      this.$refs.form.validate(async valid => {
        if (valid) {
          try {
            if (this.form.id) {
              await updateTravelScenery(this.form)
              this.$message.success('修改成功')
            } else {
              await saveTravelScenery(this.form)
              this.$message.success('新增成功')
            }
            this.dialogVisible = false
            this.getList()
          } catch (error) {
            console.error(error)
          }
        }
      })
    },
    async handleDelete(row) {
      try {
        await this.$confirm('确认删除该视频吗?', '提示', { type: 'warning' })
        await deleteTravelScenery(row.id)
        this.$message.success('删除成功')
        this.getList()
      } catch (error) {
        if (error !== 'cancel') console.error(error)
      }
    },
    resetForm() {
      this.$refs.form.resetFields()
      this.form = { id: '', name: '', cover: '', video: '', inx: 0 }
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
.breadcrumb {
  margin-bottom: 20px;
  font-size: 14px;
}
.filter-container {
  margin-bottom: 20px;
  display: flex;
  align-items: center;
}
.add-btn {
  margin-bottom: 20px;
}
/* 分页容器 */
.pagination-container {
  margin-top: 20px;
  display: flex;
  justify-content: flex-end;
  background: transparent;
}

/* ====== 分页样式核心修复 ====== */

/* 1. 给“10条/页”下拉框加白底和圆角 */
::v-deep .el-pagination.is-background .el-select .el-input .el-input__inner {
  background-color: #ffffff !important;
  border: none;
  border-radius: 4px;
}

/* 2. 把 < 1 > 合并成一整块连续的白底 */
::v-deep .el-pagination.is-background .btn-prev,
::v-deep .el-pagination.is-background .btn-next,
::v-deep .el-pagination.is-background .el-pager {
  background-color: #ffffff !important;
  margin: 0 !important; /* 去除间隙，让它们连在一起 */
  border-radius: 0 !important; /* 去除内部圆角 */
  box-shadow: none !important;
}

/* 3. 清除页码数字单独的底色，让其融入大白块 */
::v-deep .el-pagination.is-background .el-pager li {
  background-color: transparent !important;
  margin: 0 5px !important;
}

/* 4. 当前页码高亮 */
::v-deep .el-pagination.is-background .el-pager li.active {
  color: #409EFF !important;
  font-weight: bold;
}

/* 5. 给大白块两端加上圆角 */
::v-deep .el-pagination.is-background .btn-prev {
  border-top-left-radius: 4px !important;
  border-bottom-left-radius: 4px !important;
  padding-left: 10px;
}
::v-deep .el-pagination.is-background .btn-next {
  border-top-right-radius: 4px !important;
  border-bottom-right-radius: 4px !important;
  padding-right: 10px;
}

/* 弹窗图片上传样式 */
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
  width: 120px;
  height: 120px;
  line-height: 120px;
  text-align: center;
}
.avatar {
  width: 120px;
  height: 120px;
  display: block;
  object-fit: cover;
}
</style>
