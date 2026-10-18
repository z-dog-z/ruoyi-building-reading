<template>
  <div class="vr-container">
    <!-- 顶部搜索与操作栏 -->
    <div class="header-box">
      <el-input
        v-model="queryParams.name"
        placeholder="请输入资源库名称"
        clearable
        style="width: 200px; margin-right: 10px;"
        @keyup.enter.native="handleSearch"
      />
      <el-button type="primary" icon="el-icon-search" @click="handleSearch">搜索</el-button>
      <el-button type="primary" icon="el-icon-plus" @click="handleAdd">新增</el-button>
    </div>

    <!-- 表格：去掉了 border 属性（无竖边框），名称和VR标识缩小，VR链接宽度放大 -->
    <el-table :data="tableData" v-loading="loading" style="width: 100%; margin-top: 15px;">
      <el-table-column type="index" label="序号" width="60" align="center" />

      <el-table-column prop="name" label="名称" width="120" align="center" show-overflow-tooltip />
      <el-table-column prop="identify" label="VR标识" width="120" align="center" show-overflow-tooltip />

      <!-- VR链接：完整显示，允许换行 -->
      <el-table-column prop="travelVrUrl" label="VR链接" min-width="400" align="center">
        <template slot-scope="scope">
          <a :href="scope.row.travelVrUrl" target="_blank" class="vr-link">{{ scope.row.travelVrUrl }}</a>
        </template>
      </el-table-column>

      <el-table-column prop="status" label="是否启用" align="center" width="100">
        <template slot-scope="scope">
          <el-switch
            v-model="scope.row.status"
            :active-value="1"
            :inactive-value="0"
            @change="handleStatusChange(scope.row)"
          />
        </template>
      </el-table-column>

      <!-- 时间字段。若依通常返回 createTime，如果字段不同请自行修改 prop -->
      <el-table-column prop="createTime" label="时间" align="center" width="160" />

      <el-table-column label="操作" align="center" width="160">
        <template slot-scope="scope">
          <el-button type="text" @click="handleEdit(scope.row)">修改</el-button>
          <el-button type="text" @click="handleDelete(scope.row)">删除</el-button>
          <a :href="scope.row.travelVrUrl" target="_blank" class="view-btn">查看</a>
        </template>
      </el-table-column>
    </el-table>

    <!-- 分页 -->
    <div class="pagination-box" style="margin-top: 20px; text-align: right;">
      <el-pagination
        background
        :current-page="queryParams.pageNum"
        :page-size="queryParams.pageSize"
        :page-sizes="[10, 20, 50]"
        layout="total, sizes, prev, pager, next, jumper"
        :total="total"
        @size-change="handleSizeChange"
        @current-change="handleCurrentChange"
      />
    </div>

    <!-- 新增/修改 弹窗（细节1：@close 清空并清除校验） -->
    <el-dialog
      :title="dialogTitle"
      :visible.sync="dialogFormVisible"
      width="500px"
      @close="resetForm"
    >
      <!-- 表单字段：名称 / VR标识 / 是否启用，完全参照你的截图代码 -->
      <el-form :model="form" :rules="rules" ref="form" label-width="100px">
        <el-form-item label="名称" prop="name">
          <el-input v-model="form.name" placeholder="请输入名称" />
        </el-form-item>
        <el-form-item label="VR标识" prop="identify">
          <el-input v-model="form.identify" placeholder="请输入VR标识" />
        </el-form-item>
        <el-form-item label="是否启用" prop="status">
          <el-switch v-model="form.status" :active-value="1" :inactive-value="0" />
        </el-form-item>
      </el-form>
      <template slot="footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="submitForm">确 定</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script>
// 注意路径：请确保你在 src/api 目录下放了 vr.js 文件
import { getVrList, addVr, delVr, editVrList, useVrBtn } from '@/api/vr'

export default {
  name: 'VrIndex',
  data() {
    return {
      loading: false,
      tableData: [],
      total: 0,
      dialogFormVisible: false,
      dialogTitle: '新增VR',
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        name: ''
      },
      // 表单字段
      form: {
        id: null,
        name: '',
        identify: '',
        status: 1 // 默认开启
      },
      // 校验规则
      rules: {
        name: [{ required: true, message: '请输入名称', trigger: 'blur' }],
        identify: [{ required: true, message: '请输入VR标识', trigger: 'blur' }]
      }
    }
  },
  mounted() {
    this.getList()
  },
  methods: {
    // 查询列表
    async getList() {
      this.loading = true
      try {
        const res = await getVrList(this.queryParams)
        // 注意：若依拦截器通常直接返回 data，若你的项目返回 res.code 请加上 res.code === 200 判断
        this.tableData = res.rows
        this.total = res.total
      } catch (error) {
        console.error(error)
      } finally {
        this.loading = false
      }
    },

    // 细节2：搜索按钮里必须把 pageNum 重置成 1，防止搜出空页
    handleSearch() {
      this.queryParams.pageNum = 1
      this.getList()
    },

    // 分页处理
    handleSizeChange(val) {
      this.queryParams.pageSize = val
      this.getList()
    },
    handleCurrentChange(val) {
      this.queryParams.pageNum = val
      this.getList()
    },

    // 新增：清空 form，状态默认开启
    handleAdd() {
      this.resetForm() // 确保打开前没有旧数据和校验红字
      this.form = { status: 1 } // 默认开启状态
      this.dialogTitle = "新增VR"
      this.dialogFormVisible = true
    },

    // 修改：把行数据填进 form
    handleEdit(val) {
      this.resetForm()
      // 注意：这里直接赋值，开关组件绑定了 :active-value="1" 和 :inactive-value="0"，因此不需要转布尔值
      this.form = {
        id: val.id,
        name: val.name,
        identify: val.identify,
        status: val.status
      }
      this.dialogTitle = "修改VR"
      this.dialogFormVisible = true
    },

    // 提交：根据 form.id 分流调用 addVr / editVrList
    submitForm() {
      this.$refs.form.validate(valid => {
        if (!valid) return

        // 确保提交时状态是数字 1 或 0
        const payload = { ...this.form, status: this.form.status ? 1 : 0 }

        // 修复了原截图逻辑：有 id 才是修改（edit），无 id 是新增（add）
        const isEdit = !!this.form.id
        const req = isEdit ? editVrList(payload) : addVr(payload)

        req.then(res => {
          // 如果你的 axios 拦截器直接返回了 data 且没有 code 字段，则无需判断 res.code
          // 若依默认 axios 返回的是包含 code 的对象
          if (res.code == 200 || res.code === undefined) {
            this.dialogFormVisible = false
            this.getList()
            this.$message.success(isEdit ? "修改成功" : "新增成功")
          }
        })
      })
    },

    // 状态切换
    async handleStatusChange(row) {
      try {
        await useVrBtn(row.status, row.id)
        this.$message.success('状态修改成功')
      } catch (error) {
        // 失败时回退状态
        row.status = row.status === 1 ? 0 : 1
      }
    },

    // 删除（细节4 & 5b）
    handleDelete(row) {
      this.$confirm('确定删除该VR资源吗？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning',
        confirmButtonClass: 'el-button--danger' // 细节5b：确认删除按钮变红
      })
        .then(async () => {
          await delVr(row.id)
          this.$message.success('删除成功')
          // 如果当前页只有一条数据，删除后页码减一，防止停留在空页
          if (this.tableData.length === 1 && this.queryParams.pageNum > 1) {
            this.queryParams.pageNum--
          }
          this.getList()
        })
        // 细节4/5a：给 .catch(() => {}) 兜底，防止用户点击取消时报未处理异常
        .catch(() => {})
    },

    // 细节1：清空 form 并清除校验
    resetForm() {
      if (this.$refs.form) {
        this.$refs.form.resetFields()
        this.$refs.form.clearValidate()
      }
      this.form = {
        id: null,
        name: '',
        identify: '',
        status: 1
      }
    }
  }
}
</script>

<style scoped>
.vr-container {
  padding: 20px;
  background-color: #fff;
}
.header-box {
  display: flex;
  justify-content: flex-start;
  align-items: center;
}
/* 细节3：让 VR 链接可以完整显示并自动换行 */
.vr-link {
  color: #409eff;
  text-decoration: none;
  word-break: break-all;
  white-space: normal;
  display: inline-block;
  line-height: 1.4;
}
.vr-link:hover {
  text-decoration: underline;
}
.view-btn {
  color: #409eff;
  text-decoration: none;
  margin-left: 10px;
  font-size: 14px;
  cursor: pointer;
}
.view-btn:hover {
  text-decoration: underline;
}
/* 表头背景色微调（可选，视觉上更舒服） */
::v-deep .el-table th {
  background-color: #f8f8f9;
}
</style>
