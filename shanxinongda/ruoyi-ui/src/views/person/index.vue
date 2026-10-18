<template>
  <div class="person-container">
    <!-- 顶部操作栏：仅包含按钮 -->
    <div class="toolbar">
      <div class="toolbar-btns">
        <el-button type="primary" @click="handleAdd">新增</el-button>

        <!-- 普通模式 -->
        <el-button v-if="deletePic" type="primary" @click="enterDeleteMode">删除</el-button>

        <!-- 删除模式 -->
        <template v-else>
          <el-button @click="cancelDeleteMode">取消</el-button>
          <el-button type="danger" @click="confirmDelete">确定删除</el-button>
        </template>
      </div>
    </div>

    <!-- 内容区 -->
    <div class="content-area">
      <!-- 普通图墙 -->
      <div v-if="deletePic" class="pic-wall">
        <div class="pic-item" v-for="item in tableData" :key="item.id" @click="updatePersonInfo(item)">
          <img :src="item.photo" alt="照片" class="pic-img" />
          <div class="pic-name">{{ item.name }}</div>
        </div>
      </div>

      <!-- 删除模式图墙：左侧全选，右侧照片带复选框 -->
      <div v-else class="delete-mode-container">
        <!-- 左侧：全选复选框 -->
        <div class="select-all-col">
          <el-checkbox
            v-model="checkAll"
            :indeterminate="isIndeterminate"
            @change="handleCheckAllChange"
          >全选</el-checkbox>
        </div>

        <!-- 右侧：照片墙 -->
        <div class="pic-wall">
          <el-checkbox-group v-model="checkedPictures" @change="handleCheckedPictureChange" class="checkbox-group">
            <div class="pic-item" v-for="item in tableData" :key="item.id">

              <!-- 使用 Flex 布局实现复选框在左，照片在右，底部对齐 -->
              <div class="pic-content">
                <el-checkbox :label="item.id" class="side-checkbox"></el-checkbox>
                <img :src="item.photo" alt="照片" class="pic-img" />
              </div>
              <div class="pic-name">{{ item.name }}</div>

            </div>
          </el-checkbox-group>
        </div>
      </div>
    </div>

    <!-- 分页组件 -->
    <div class="pagination-box">
      <el-pagination
        background
        layout="total, prev, pager, next"
        :total="total"
        :current-page="queryForm.pageNum"
        :page-size="queryForm.pageSize"
        @current-change="handlePageChange"
      >
      </el-pagination>
    </div>

    <!-- 新增/编辑弹窗 -->
    <el-dialog :title="form.id ? '编辑人物' : '新增人物'" :visible.sync="open" width="600px" @close="resetForm">
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="姓名" prop="name">
          <el-input v-model="form.name" placeholder="请输入内容"></el-input>
        </el-form-item>

        <el-form-item label="生辰" prop="date">
          <el-input v-model="form.date" placeholder="请输入内容"></el-input>
        </el-form-item>

        <el-form-item label="照片" prop="photo">
          <el-upload
            :action="uploadFileApi"
            :headers="uploadFileHeaders"
            :limit="1"
            :on-success="handBackgroundSuccess"
            :file-list="picList"
            accept=".gif,.jpg,.jpeg,.png,.GIF,.JPG,.PNG"
            list-type="picture-card"
          >
            <i slot="default" class="el-icon-plus"></i>
            <div slot="file" slot-scope="{ file }">
              <img class="el-upload-list__item-thumbnail" :src="file.url" alt="" />
              <span class="el-upload-list__item-actions">
                <span class="el-upload-list__item-preview" @click="handlePictureCardPreview(file)">
                  <i class="el-icon-zoom-in"></i>
                </span>
                <span class="el-upload-list__item-delete" @click="handleBackgroundRemove(file)">
                  <i class="el-icon-delete"></i>
                </span>
              </span>
            </div>
          </el-upload>
        </el-form-item>

        <el-form-item label="简介" prop="content">
          <el-input type="textarea" v-model="form.content" placeholder="请输入内容" :rows="4"></el-input>
        </el-form-item>
      </el-form>

      <div slot="footer" class="dialog-footer">
        <el-button @click="open = false">取 消</el-button>
        <el-button type="primary" @click="submit">确 定</el-button>
      </div>
    </el-dialog>

    <!-- 图片预览弹窗 -->
    <el-dialog :visible.sync="dialogVisible" width="600px" append-to-body>
      <img width="100%" :src="dialogImageUrl" alt="" />
    </el-dialog>
  </div>
</template>

<script>
import { getPersonList, savePerson, updatePerson, deletePerson } from '@/api/vr';
import { getToken } from '@/utils/auth';

export default {
  name: 'PersonIndex',
  data() {
    return {
      tableData: [],
      total: 0,
      queryForm: {
        pageNum: 1,
        pageSize: 10
      },

      // 删除模式控制
      deletePic: true,
      checkAll: false,
      isIndeterminate: false,
      checkedPictures: [],

      // 弹窗与表单
      open: false,
      form: {},
      picList: [],
      uploadFileApi: process.env.VUE_APP_BASE_API + "/travel/oss/upload",

      // 预览相关
      dialogVisible: false,
      dialogImageUrl: '',

      // 表单校验规则
      rules: {
        name: [{ required: true, message: '名称不能为空', trigger: 'blur' }],
        date: [{ required: true, message: '生辰不能为空', trigger: 'blur' }],
        photo: [{ required: true, message: '照片不能为空', trigger: 'change' }],
        content: [{ required: true, message: '简介不能为空', trigger: 'blur' }]
      }
    };
  },
  computed: {
    uploadFileHeaders() {
      return {
        Authorization: "Bearer " + getToken()
      };
    }
  },
  created() {
    this.getList();
  },
  methods: {
    getList() {
      getPersonList(this.queryForm).then(response => {
        this.tableData = response.rows || response.data || [];
        this.total = response.total || 0;
      });
    },

    handlePageChange(page) {
      this.queryForm.pageNum = page;
      this.getList();
    },

    // ================= 删除模式逻辑 =================
    enterDeleteMode() {
      this.deletePic = false;
      this.checkedPictures = [];
      this.checkAll = false;
      this.isIndeterminate = false;
    },

    cancelDeleteMode() {
      this.deletePic = true;
      this.checkedPictures = [];
    },

    handleCheckAllChange(val) {
      if (val) {
        this.checkedPictures = this.tableData.map(item => item.id);
      } else {
        this.checkedPictures = [];
      }
      this.isIndeterminate = false;
    },

    handleCheckedPictureChange(value) {
      const checkedCount = value.length;
      this.checkAll = checkedCount === this.tableData.length;
      this.isIndeterminate = checkedCount > 0 && checkedCount < this.tableData.length;
    },

    confirmDelete() {
      if (this.checkedPictures.length === 0) {
        this.$message.warning('请至少选择一项');
        return;
      }

      this.$confirm('确认删除选中的历史人物吗？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        return deletePerson(this.checkedPictures);
      }).then(() => {
        this.$message.success('删除成功');
        this.deletePic = true;
        this.getList();
      }).catch(() => {});
    },

    // ================= 表单及图片上传逻辑 =================
    updatePersonInfo(val) {
      this.open = true;
      this.form = { ...val };
      this.picList = val.photo ? [{ name: val.photo, url: val.photo }] : [];
    },

    handleAdd() {
      this.resetForm();
      this.open = true;
    },

    resetForm() {
      this.form = {
        id: null,
        name: '',
        date: '',
        photo: '',
        content: ''
      };
      this.picList = [];
      if (this.$refs.form) {
        this.$refs.form.resetFields();
      }
    },

    handBackgroundSuccess(res, file, fileList) {
      this.picList = fileList;
      this.form.photo = res.data.url;
      this.$refs.form.validateField('photo');
    },

    handleBackgroundRemove(file) {
      this.picList = [];
      this.form.photo = "";
      this.$refs.form.validateField('photo');
    },

    handlePictureCardPreview(file) {
      this.dialogImageUrl = file.url;
      this.dialogVisible = true;
    },

    submit() {
      this.$refs["form"].validate((valid) => {
        if (!valid) return;

        if (this.form.id) {
          updatePerson(this.form).then(() => {
            this.$message.success('修改成功');
            this.open = false;
            this.getList();
          });
        } else {
          savePerson(this.form).then(() => {
            this.$message.success('新增成功');
            this.open = false;
            this.getList();
          });
        }
      });
    }
  }
};
</script>

<style scoped>
.person-container {
  padding: 20px;
}

.toolbar {
  display: flex;
  margin-bottom: 20px;
}

.toolbar-btns {
  display: flex;
  align-items: center;
  gap: 10px;
}

.content-area {
  min-height: 400px;
}

/* 图墙网格布局 */
.pic-wall {
  display: flex;
  flex-wrap: wrap;
  gap: 20px;
  flex: 1;
}

/* 删除模式的左右布局容器 */
.delete-mode-container {
  display: flex;
  align-items: flex-start; /* 顶部对齐，让全选与照片顶部平齐 */
  gap: 30px; /* 全选与照片墙之间的间距 */
}

.select-all-col {
  flex-shrink: 0;
  margin-top: 5px; /* 微调全选的位置，使其与照片视觉平齐 */
}

.pic-item {
  width: 220px; /* 稍微加宽以容纳左侧的复选框 */
  cursor: pointer;
  text-align: center;
}

/* 新增：照片与复选框的 Flex 容器 */
.pic-content {
  display: flex;
  align-items: flex-end; /* 底部对齐 */
  gap: 10px; /* 复选框与照片之间的距离 */
  justify-content: center; /* 整体居中 */
}

/* 侧边复选框的样式 */
::v-deep .side-checkbox {
  margin-bottom: 0;
  height: 20px;
}

/* 隐藏复选框自带的文字标签（如果有的话） */
::v-deep .side-checkbox .el-checkbox__label {
  display: none;
}

.pic-img {
  width: 200px;
  height: 200px;
  object-fit: cover;
  border-radius: 8px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
}

.pic-name {
  margin-top: 10px;
  font-size: 16px;
  color: #333;
}

/* 删除模式下复选框组样式 */
.checkbox-group {
  display: flex;
  flex-wrap: wrap;
  gap: 20px;
}

.pagination-box {
  margin-top: 20px;
  text-align: right;
}
</style>
