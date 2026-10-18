<template>
  <div class="scenic-container">
    <!-- 顶部标签页 -->
    <el-tabs v-model="activeTab" @tab-click="handleTabChange">
      <el-tab-pane label="景点" name="0"></el-tab-pane>
      <el-tab-pane label="活动" name="1"></el-tab-pane>
    </el-tabs>

    <!-- ==================== 1. 景点搜索栏 ==================== -->
    <div class="search-bar" v-if="activeTab === '0'">
      <el-form :inline="true" :model="queryParams" size="small">
        <el-form-item>
          <el-select v-model="queryParams.subClafficationId" placeholder="请选择分类" clearable style="width: 160px;">
            <el-option
              v-for="item in classificationList"
              :key="item.id"
              :label="item.name"
              :value="String(item.id)"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-input v-model="queryParams.name" placeholder="请输入景点名称" clearable style="width: 160px;"></el-input>
        </el-form-item>
        <el-form-item>
          <el-input v-model="queryParams.remarks" placeholder="请输入景点地址" clearable style="width: 160px;"></el-input>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" icon="el-icon-search" @click="handleSearch">搜索</el-button>
        </el-form-item>
      </el-form>
    </div>

    <!-- ==================== 2. 活动搜索栏 ==================== -->
    <div class="search-bar" v-if="activeTab === '1'">
      <el-form :inline="true" :model="queryParams" size="small">
        <el-form-item>
          <el-input v-model="queryParams.name" placeholder="请输入活动" clearable style="width: 220px;"></el-input>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" icon="el-icon-search" @click="handleSearch">搜索</el-button>
        </el-form-item>
      </el-form>
    </div>

    <!-- 操作按钮 -->
    <div class="action-buttons">
      <el-button type="primary" icon="el-icon-plus" @click="openAddDialog">新增</el-button>
      <el-button type="primary" icon="el-icon-menu" @click="openClassDialog">分类管理</el-button>
    </div>

    <!-- 列表卡片区域 -->
    <el-row :gutter="20" class="card-list">
      <el-col :span="4" v-for="item in list" :key="item.id" style="margin-bottom: 20px;">
        <el-card :body-style="{ padding: '0px' }" shadow="hover">
          <div class="card-img-box">
            <img :src="item.pictureUrl ? item.pictureUrl.split(',')[0] : ''" class="card-img" alt="封面" />
          </div>
          <div class="card-content">
            <div class="card-title">{{ item.name }}</div>
            <div class="card-views">
              <i class="el-icon-view"></i> {{ item.pageviews || 0 }}
            </div>
            <div class="card-actions">
              <span class="action-btn" @click="handleDelete(item.id)"><i class="el-icon-delete"></i> 删除</span>
              <span class="action-btn" @click="openEditDialog(item)"><i class="el-icon-edit"></i> 编辑</span>
              <i class="el-icon-folder-opened folder-icon"></i>
            </div>
          </div>
        </el-card>
      </el-col>

      <!-- 空数据提示 -->
      <el-col :span="24" v-if="list.length === 0">
        <div style="text-align: center; color: #909399; padding: 50px 0;">
          <i class="el-icon-folder-opened" style="font-size: 40px; margin-bottom: 10px;"></i>
          <p>暂无数据</p>
        </div>
      </el-col>
    </el-row>

    <!-- 分页 -->
    <div class="pagination-container">
      <el-pagination
        background
        layout="prev, pager, next"
        :total="total"
        :page-size="queryParams.pageSize"
        :current-page.sync="queryParams.pageNum"
        @current-change="getList"
      >
      </el-pagination>
    </div>

    <!-- 新增/编辑弹窗 -->
    <el-dialog
      :title="dialogTitle"
      :visible.sync="dialogVisible"
      width="65%"
      :close-on-click-modal="false"
      @close="resetForm"
      class="custom-dialog"
    >
      <el-form ref="formRef" :model="form" :rules="currentRules" label-width="125px" size="small">

        <!-- ==================== 1. 景点表单 ==================== -->
        <template v-if="activeTab === '0'">
          <el-row :gutter="30">
            <el-col :span="12">
              <el-form-item label="中文名称" prop="name">
                <el-input v-model="form.name" placeholder="请输入景点名称"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item label="英文名称" prop="englishName">
                <el-input v-model="form.englishName" placeholder="Enter name"></el-input>
              </el-form-item>
            </el-col>
          </el-row>

          <el-row :gutter="30">
            <el-col :span="12">
              <el-form-item label="经纬度" prop="longitude">
                <el-input v-model="form.longitude" placeholder="格式如：纬度,经度 （逗号为英文逗号）"></el-input>
              </el-form-item>
            </el-col>
          </el-row>

          <!-- 【关键修复】分类改用 name 匹配 -->
          <el-row :gutter="30">
            <el-col :span="12">
              <el-form-item label="分类" prop="subClafficationName">
                <el-select v-model="form.subClafficationName" placeholder="请选择景点分类" style="width: 100%;" clearable :popper-append-to-body="false">
                  <el-option
                    v-for="item in classificationList"
                    :key="item.id"
                    :label="item.name"
                    :value="item.name"
                  ></el-option>
                </el-select>
              </el-form-item>
            </el-col>
          </el-row>

          <el-row :gutter="30">
            <el-col :span="24">
              <el-form-item label="景点信息"></el-form-item>
            </el-col>
          </el-row>

          <el-row :gutter="30">
            <el-col :span="12">
              <el-form-item label="建筑级别" prop="level">
                <el-input type="textarea" :rows="1" resize="both" v-model="form.level" placeholder="请输入建筑级别"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item label="Honors" prop="englishLevel">
                <el-input type="textarea" :rows="1" resize="both" v-model="form.englishLevel" placeholder="Enter Honors"></el-input>
              </el-form-item>
            </el-col>
          </el-row>

          <el-row :gutter="30">
            <el-col :span="12">
              <el-form-item label="建筑地址" prop="remarks">
                <el-input type="textarea" :rows="1" resize="both" v-model="form.remarks" placeholder="请输入建筑地址"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item label="Location" prop="address">
                <el-input type="textarea" :rows="1" resize="both" v-model="form.address" placeholder="Enter Location"></el-input>
              </el-form-item>
            </el-col>
          </el-row>

          <el-row :gutter="30">
            <el-col :span="12">
              <el-form-item label="中文开放时间" prop="chineseOpenTime">
                <el-input type="textarea" :rows="1" resize="both" v-model="form.chineseOpenTime" placeholder="请输入中文开放时间"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item label="Opening hours" prop="englishOpenTime">
                <el-input type="textarea" :rows="1" resize="both" v-model="form.englishOpenTime" placeholder="Enter Opening hours"></el-input>
              </el-form-item>
            </el-col>
          </el-row>

          <el-row :gutter="30">
            <el-col :span="12">
              <el-form-item label="门票信息" prop="ticket">
                <el-input v-model="form.ticket" placeholder="请输入门票信息"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item label="Ticket" prop="englishTicket">
                <el-input v-model="form.englishTicket" placeholder="Enter Ticket"></el-input>
              </el-form-item>
            </el-col>
          </el-row>

          <el-row :gutter="30">
            <el-col :span="12">
              <el-form-item label="联系电话" prop="phoneNumber">
                <el-input v-model="form.phoneNumber" placeholder="请输入联系电话"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item label="Telephone" prop="englishPhoneNumber">
                <el-input v-model="form.englishPhoneNumber" placeholder="Enter Telephone"></el-input>
              </el-form-item>
            </el-col>
          </el-row>

          <el-row :gutter="30">
            <el-col :span="12">
              <el-form-item label="景点封面" prop="pictureUrl">
                <el-upload
                  class="avatar-uploader"
                  :action="uploadFileApi"
                  :headers="uploadFileHeaders"
                  :show-file-list="false"
                  :on-success="(res) => handleUploadSuccess(res, 'pictureUrl')"
                  :before-upload="beforeUpload"
                >
                  <img v-if="form.pictureUrl" :src="form.pictureUrl" class="avatar" />
                  <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                </el-upload>
                <div class="upload-tip">照片数量限制为1个</div>
              </el-form-item>
            </el-col>
          </el-row>

          <el-row :gutter="30">
            <el-col :span="12">
              <el-form-item label="景点背景" prop="backgroundCover">
                <el-upload
                  class="avatar-uploader"
                  :action="uploadFileApi"
                  :headers="uploadFileHeaders"
                  :show-file-list="false"
                  :on-success="(res) => handleUploadSuccess(res, 'backgroundCover')"
                  :before-upload="beforeUpload"
                >
                  <img v-if="form.backgroundCover" :src="form.backgroundCover" class="avatar" />
                  <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                </el-upload>
                <div class="upload-tip">照片数量限制为3个</div>
              </el-form-item>
            </el-col>
          </el-row>

          <el-row :gutter="30">
            <el-col :span="24">
              <el-form-item label="音频">
                <el-upload
                  :action="uploadFileApi"
                  :headers="uploadFileHeaders"
                  :show-file-list="false"
                  accept="audio/*"
                  :on-success="(res) => handleUploadSuccess(res, 'audioUrl')"
                  :on-error="handleAudioUploadError"
                  :before-upload="beforeAudioUpload"
                >
                  <el-button type="primary" icon="el-icon-upload2" size="small">点击上传</el-button>
                </el-upload>
                <div v-if="form.audioUrl" class="audio-preview">
                  <audio :src="form.audioUrl" controls style="height: 36px; max-width: 360px;"></audio>
                  <el-button type="text" icon="el-icon-delete" @click="form.audioUrl = ''">删除</el-button>
                </div>
                <div class="upload-tip">支持 mp3/wav/m4a，大小不超过 50MB</div>
              </el-form-item>
            </el-col>
          </el-row>

          <el-row :gutter="30">
            <el-col :span="12">
              <el-form-item label="关联VR" prop="vrId">
                <el-select v-model="form.vrId" placeholder="请选择VR库" style="width: 100%;" clearable :popper-append-to-body="false">
                  <el-option
                    v-for="item in vrList"
                    :key="item.id"
                    :label="item.name"
                    :value="item.id"
                  ></el-option>
                </el-select>
              </el-form-item>
            </el-col>
          </el-row>

          <el-row :gutter="30">
            <el-col :span="12">
              <el-form-item label="vr简介" prop="introduction">
                <el-input type="textarea" :rows="3" resize="both" v-model="form.introduction" placeholder="请输入vr简介"></el-input>
              </el-form-item>
            </el-col>
          </el-row>

          <el-row :gutter="30">
            <el-col :span="12">
              <el-form-item label="排序" prop="inx">
                <el-input v-model.number="form.inx" placeholder="请输入数字"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item label="红色印记">
                <el-switch
                  v-model="form.blockId"
                  active-value="1"
                  inactive-value=""
                  active-text="是"
                  inactive-text="否"
                />
              </el-form-item>
            </el-col>
          </el-row>

          <el-row :gutter="30">
            <el-col :span="24">
              <el-form-item label="用户识别" prop="isUser">
                <el-radio-group v-model="form.isUser">
                  <el-radio :label="1">开</el-radio>
                  <el-radio :label="0">关</el-radio>
                </el-radio-group>
              </el-form-item>
            </el-col>
          </el-row>

          <el-row :gutter="30">
            <el-col :span="24">
              <el-form-item label="内容" prop="content">
                <div class="wps-editor-container">
                  <div class="wps-toolbar">
                    <div class="toolbar-row">
                      <span class="toolbar-btn" @mousedown.prevent="execCmd('formatBlock', '<h3>', 'chinese')" title="标题">H</span>
                      <span class="toolbar-btn" @mousedown.prevent="execCmd('bold', null, 'chinese')" title="加粗"><b>B</b></span>
                      <span class="toolbar-btn" @mousedown.prevent="execCmd('fontSize', '3', 'chinese')" title="字号">Tt</span>
                      <span class="toolbar-btn" @mousedown.prevent="execCmd('italic', null, 'chinese')" title="斜体"><i>I</i></span>
                      <span class="toolbar-btn" @mousedown.prevent="execCmd('underline', null, 'chinese')" title="下划线"><u>U</u></span>
                      <span class="toolbar-btn" @mousedown.prevent="execCmd('strikeThrough', null, 'chinese')" title="删除线"><s>S</s></span>
                      <span class="toolbar-btn" @mousedown.prevent="execCmd('justifyLeft', null, 'chinese')" title="左对齐"><i class="el-icon-s-fold"></i></span>
                      <span class="toolbar-btn" @mousedown.prevent="execCmd('justifyCenter', null, 'chinese')" title="居中"><i class="el-icon-s-unfold"></i></span>
                      <span class="toolbar-btn" @mousedown.prevent="execCmd('justifyRight', null, 'chinese')" title="右对齐"><i class="el-icon-s-grid"></i></span>
                      <span class="toolbar-btn" @mousedown.prevent="execCmd('formatBlock', '<blockquote>', 'chinese')" title="引用">“ ”</span>
                      <span class="toolbar-btn" @mousedown.prevent="execCmd('createLink', null, 'chinese')" title="插入链接"><i class="el-icon-link"></i></span>
                      <span class="toolbar-btn" @mousedown.prevent="execCmd('insertUnorderedList', null, 'chinese')" title="无序列表"><i class="el-icon-s-operation"></i></span>
                      <span class="toolbar-btn" @mousedown.prevent="execCmd('insertImage', null, 'chinese')" title="插入图片"><i class="el-icon-picture-outline"></i></span>
                    </div>
                    <div class="toolbar-row">
                      <span class="toolbar-btn" title="表情"><i class="el-icon-sunny"></i></span>
                      <span class="toolbar-btn" title="视频"><i class="el-icon-video-camera"></i></span>
                      <span class="toolbar-btn" title="表格"><i class="el-icon-s-grid"></i></span>
                      <span class="toolbar-btn" @mousedown.prevent="execCmd('formatBlock', '<pre>', 'chinese')" title="代码块">&gt;_</span>
                      <span class="toolbar-btn" @mousedown.prevent="execCmd('insertHorizontalRule', null, 'chinese')" title="分割线">—</span>
                      <span class="toolbar-btn" @mousedown.prevent="execCmd('undo', null, 'chinese')" title="撤销"><i class="el-icon-refresh-left"></i></span>
                      <span class="toolbar-btn" @mousedown.prevent="execCmd('redo', null, 'chinese')" title="重做"><i class="el-icon-refresh-right"></i></span>
                    </div>
                  </div>
                  <div ref="chineseEditor" class="wps-editor-content" contenteditable="true" placeholder="请输入正文" @input="syncContent('content', $event)"></div>
                </div>
              </el-form-item>
            </el-col>
          </el-row>

          <el-row :gutter="30">
            <el-col :span="24">
              <el-form-item label="English" prop="englishIntroduction">
                <div class="wps-editor-container">
                  <div class="wps-toolbar">
                    <div class="toolbar-row">
                      <span class="toolbar-btn" @mousedown.prevent="execCmd('formatBlock', '<h3>', 'english')" title="Title">H</span>
                      <span class="toolbar-btn" @mousedown.prevent="execCmd('bold', null, 'english')" title="Bold"><b>B</b></span>
                      <span class="toolbar-btn" @mousedown.prevent="execCmd('fontSize', '3', 'english')" title="Font Size">Tt</span>
                      <span class="toolbar-btn" @mousedown.prevent="execCmd('italic', null, 'english')" title="Italic"><i>I</i></span>
                      <span class="toolbar-btn" @mousedown.prevent="execCmd('underline', null, 'english')" title="Underline"><u>U</u></span>
                      <span class="toolbar-btn" @mousedown.prevent="execCmd('strikeThrough', null, 'english')" title="Strikethrough"><s>S</s></span>
                      <span class="toolbar-btn" @mousedown.prevent="execCmd('justifyLeft', null, 'english')" title="Align Left"><i class="el-icon-s-fold"></i></span>
                      <span class="toolbar-btn" @mousedown.prevent="execCmd('justifyCenter', null, 'english')" title="Align Center"><i class="el-icon-s-unfold"></i></span>
                      <span class="toolbar-btn" @mousedown.prevent="execCmd('justifyRight', null, 'english')" title="Align Right"><i class="el-icon-s-grid"></i></span>
                      <span class="toolbar-btn" @mousedown.prevent="execCmd('formatBlock', '<blockquote>', 'english')" title="Quote">“ ”</span>
                      <span class="toolbar-btn" @mousedown.prevent="execCmd('createLink', null, 'english')" title="Link"><i class="el-icon-link"></i></span>
                      <span class="toolbar-btn" @mousedown.prevent="execCmd('insertUnorderedList', null, 'english')" title="Bullet List"><i class="el-icon-s-operation"></i></span>
                      <span class="toolbar-btn" @mousedown.prevent="execCmd('insertImage', null, 'english')" title="Image"><i class="el-icon-picture-outline"></i></span>
                    </div>
                    <div class="toolbar-row">
                      <span class="toolbar-btn" title="Emoji"><i class="el-icon-sunny"></i></span>
                      <span class="toolbar-btn" title="Video"><i class="el-icon-video-camera"></i></span>
                      <span class="toolbar-btn" title="Table"><i class="el-icon-s-grid"></i></span>
                      <span class="toolbar-btn" @mousedown.prevent="execCmd('formatBlock', '<pre>', 'english')" title="Code">&gt;_</span>
                      <span class="toolbar-btn" @mousedown.prevent="execCmd('insertHorizontalRule', null, 'english')" title="Divider">—</span>
                      <span class="toolbar-btn" @mousedown.prevent="execCmd('undo', null, 'english')" title="Undo"><i class="el-icon-refresh-left"></i></span>
                      <span class="toolbar-btn" @mousedown.prevent="execCmd('redo', null, 'english')" title="Redo"><i class="el-icon-refresh-right"></i></span>
                    </div>
                  </div>
                  <div ref="englishEditor" class="wps-editor-content" contenteditable="true" placeholder="请输入正文" @input="syncContent('englishIntroduction', $event)"></div>
                </div>
              </el-form-item>
            </el-col>
          </el-row>

          <el-row :gutter="30">
            <el-col :span="12">
              <el-form-item label="历史人物" prop="human">
                <el-select v-model="form.human" placeholder="请选择历史人物" style="width: 100%;" clearable>
                  <el-option
                    v-for="item in personList"
                    :key="item.id"
                    :label="item.name"
                    :value="item.name"
                  ></el-option>
                </el-select>
              </el-form-item>
            </el-col>
          </el-row>
        </template>

        <!-- ==================== 2. 活动表单 ==================== -->
        <template v-if="activeTab === '1'">
          <el-row :gutter="30">
            <el-col :span="12">
              <el-form-item label="中文名称" prop="name">
                <el-input v-model="form.name" placeholder="请输入活动名称"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item label="英文名称" prop="englishName">
                <el-input v-model="form.englishName" placeholder="Enter name"></el-input>
              </el-form-item>
            </el-col>
          </el-row>

          <el-row :gutter="30">
            <el-col :span="24">
              <el-form-item label="活动地址" prop="remarks">
                <el-input type="textarea" :rows="1" resize="both" v-model="form.remarks" placeholder="请输入活动地址"></el-input>
              </el-form-item>
            </el-col>
          </el-row>

          <el-row :gutter="30">
            <el-col :span="12">
              <el-form-item label="景点封面" prop="pictureUrl">
                <el-upload
                  class="avatar-uploader"
                  :action="uploadFileApi"
                  :headers="uploadFileHeaders"
                  :show-file-list="false"
                  :on-success="(res) => handleUploadSuccess(res, 'pictureUrl')"
                  :before-upload="beforeUpload"
                >
                  <img v-if="form.pictureUrl" :src="form.pictureUrl" class="avatar" />
                  <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                </el-upload>
                <div class="upload-tip">照片数量限制为1个</div>
              </el-form-item>
            </el-col>
          </el-row>

          <el-row :gutter="30">
            <el-col :span="12">
              <el-form-item label="景点背景" prop="backgroundCover">
                <el-upload
                  class="avatar-uploader"
                  :action="uploadFileApi"
                  :headers="uploadFileHeaders"
                  :show-file-list="false"
                  :on-success="(res) => handleUploadSuccess(res, 'backgroundCover')"
                  :before-upload="beforeUpload"
                >
                  <img v-if="form.backgroundCover" :src="form.backgroundCover" class="avatar" />
                  <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                </el-upload>
                <div class="upload-tip">照片数量限制为3个</div>
              </el-form-item>
            </el-col>
          </el-row>

          <el-row :gutter="30">
            <el-col :span="24">
              <el-form-item label="内容" prop="content">
                <div class="wps-editor-container">
                  <div class="wps-toolbar">
                    <div class="toolbar-row">
                      <span class="toolbar-btn" @mousedown.prevent="execCmd('formatBlock', '<h3>', 'chinese')" title="标题">H</span>
                      <span class="toolbar-btn" @mousedown.prevent="execCmd('bold', null, 'chinese')" title="加粗"><b>B</b></span>
                      <span class="toolbar-btn" @mousedown.prevent="execCmd('fontSize', '3', 'chinese')" title="字号">Tt</span>
                      <span class="toolbar-btn" @mousedown.prevent="execCmd('italic', null, 'chinese')" title="斜体"><i>I</i></span>
                      <span class="toolbar-btn" @mousedown.prevent="execCmd('underline', null, 'chinese')" title="下划线"><u>U</u></span>
                      <span class="toolbar-btn" @mousedown.prevent="execCmd('strikeThrough', null, 'chinese')" title="删除线"><s>S</s></span>
                      <span class="toolbar-btn" @mousedown.prevent="execCmd('justifyLeft', null, 'chinese')" title="左对齐"><i class="el-icon-s-fold"></i></span>
                      <span class="toolbar-btn" @mousedown.prevent="execCmd('justifyCenter', null, 'chinese')" title="居中"><i class="el-icon-s-unfold"></i></span>
                      <span class="toolbar-btn" @mousedown.prevent="execCmd('justifyRight', null, 'chinese')" title="右对齐"><i class="el-icon-s-grid"></i></span>
                      <span class="toolbar-btn" @mousedown.prevent="execCmd('formatBlock', '<blockquote>', 'chinese')" title="引用">“ ”</span>
                      <span class="toolbar-btn" @mousedown.prevent="execCmd('createLink', null, 'chinese')" title="插入链接"><i class="el-icon-link"></i></span>
                      <span class="toolbar-btn" @mousedown.prevent="execCmd('insertUnorderedList', null, 'chinese')" title="无序列表"><i class="el-icon-s-operation"></i></span>
                      <span class="toolbar-btn" @mousedown.prevent="execCmd('insertImage', null, 'chinese')" title="插入图片"><i class="el-icon-picture-outline"></i></span>
                    </div>
                    <div class="toolbar-row">
                      <span class="toolbar-btn" title="表情"><i class="el-icon-sunny"></i></span>
                      <span class="toolbar-btn" title="视频"><i class="el-icon-video-camera"></i></span>
                      <span class="toolbar-btn" title="表格"><i class="el-icon-s-grid"></i></span>
                      <span class="toolbar-btn" @mousedown.prevent="execCmd('formatBlock', '<pre>', 'chinese')" title="代码块">&gt;_</span>
                      <span class="toolbar-btn" @mousedown.prevent="execCmd('insertHorizontalRule', null, 'chinese')" title="分割线">—</span>
                      <span class="toolbar-btn" @mousedown.prevent="execCmd('undo', null, 'chinese')" title="撤销"><i class="el-icon-refresh-left"></i></span>
                      <span class="toolbar-btn" @mousedown.prevent="execCmd('redo', null, 'chinese')" title="重做"><i class="el-icon-refresh-right"></i></span>
                    </div>
                  </div>
                  <div ref="chineseEditor" class="wps-editor-content" contenteditable="true" placeholder="请输入正文" @input="syncContent('content', $event)"></div>
                </div>
              </el-form-item>
            </el-col>
          </el-row>
        </template>

      </el-form>

      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">保存</el-button>
        <el-button @click="dialogVisible = false">取消</el-button>
      </div>
    </el-dialog>

    <!-- 分类管理弹窗 -->
    <el-dialog title="分类管理" :visible.sync="classDialogVisible" width="50%">
      <div style="margin-bottom: 20px;">
        <el-button type="primary" size="small" @click="handleAddClass">新增分类</el-button>
      </div>
      <el-table :data="classificationList" border size="small">
        <el-table-column prop="name" label="分类名称"></el-table-column>
        <el-table-column label="操作" width="150">
          <template slot-scope="scope">
            <el-button type="text" size="small" @click="handleEditClass(scope.row)">编辑</el-button>
            <el-button type="text" size="small" style="color: #F56C6C;" @click="handleDeleteClass(scope.row.id)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-dialog>
  </div>
</template>

<script>
import {
  getTravelList,
  deleteTravelScenery,
  saveTravelScenery,
  updateTravelScenery,
  getClassApi,
  addClassApi,
  editClassApi,
  deleteClassApi,
  uploadFileApi,
  uploadFileHeaders
} from '@/api/scenery'

import { getScenicVrList, getPersonList } from '@/api/vr'

export default {
  name: 'ScenicIndex',
  data() {
    return {
      activeTab: '0',
      queryParams: {
        pageNum: 1,
        pageSize: 12,
        subClafficationId: '',
        name: '',
        remarks: '',
      },
      list: [],
      total: 0,
      classificationList: [],

      personList: [],
      vrList: [],

      dialogVisible: false,
      dialogTitle: '新增',
      form: {},

      scenicRules: {
        name: [{ required: true, message: '景点名称不能为空', trigger: 'blur' }],
        englishName: [{ required: true, message: '英文名称不能为空', trigger: 'blur' }],
        longitude: [{ required: true, message: '经纬度不能为空', trigger: 'blur' }],
        inx: [{ required: true, message: '排序不能为空', trigger: 'blur' }],
        pictureUrl: [{ required: true, message: '请上传景点封面', trigger: 'change' }]
      },

      activityRules: {
        name: [{ required: true, message: '活动名称不能为空', trigger: 'blur' }],
        englishName: [{ required: true, message: '英文名称不能为空', trigger: 'blur' }],
        remarks: [{ required: true, message: '活动地址不能为空', trigger: 'blur' }],
        pictureUrl: [{ required: true, message: '请上传景点封面', trigger: 'change' }],
        backgroundCover: [{ required: true, message: '请上传景点背景', trigger: 'change' }]
      },

      classDialogVisible: false,

      // 暴露给模板使用的上传配置（el-upload 的 action / headers）
      uploadFileApi,
      uploadFileHeaders
    }
  },
  computed: {
    currentRules() {
      return this.activeTab === '0' ? this.scenicRules : this.activityRules;
    }
  },
  created() {
    this.getList()
    this.getClassificationList()
    this.getPersonList()
    this.getVrList()
  },
  methods: {
    async getList() {
      try {
        const targetModuleId = this.activeTab === '0' ? 847162 : 923342;

        const params = {
          pageNum: this.queryParams.pageNum,
          pageSize: this.queryParams.pageSize,
          moduleId: targetModuleId,
          activity: Number(this.activeTab)
        };

        if (this.queryParams.name) params.name = this.queryParams.name;
        if (this.activeTab === '0') {
          if (this.queryParams.subClafficationId) params.subClafficationId = this.queryParams.subClafficationId;
          if (this.queryParams.remarks) params.remarks = this.queryParams.remarks;
        }

        const res = await getTravelList(params);
        const allRows = res.rows || [];

        // 过滤 + 按 inx 排序，保证编辑后位置不变
        this.list = allRows
          .filter(item => Number(item.moduleId) === targetModuleId)
          .sort((a, b) => (a.inx || 0) - (b.inx || 0));

        this.total = this.list.length > 0 ? (res.total || this.list.length) : 0;

      } catch (error) {
        console.error('获取列表失败', error);
      }
    },

    async getPersonList() {
      try {
        const res = await getPersonList({ pageNum: 1, pageSize: 1000 });
        this.personList = res.rows || res.data || [];
      } catch (error) {
        console.error('获取历史人物列表失败', error);
      }
    },

    async getVrList() {
      try {
        const res = await getScenicVrList({ pageNum: 1, pageSize: 1000 });
        this.vrList = res.rows || res.data || [];
      } catch (error) {
        console.error('获取VR列表失败', error);
      }
    },

    async getClassificationList() {
      try {
        const res = await getClassApi()
        this.classificationList = res.data || []
      } catch (error) {
        console.error('获取分类失败', error)
      }
    },

    handleTabChange(tab) {
      this.activeTab = tab.name;
      this.queryParams.pageNum = 1;
      this.queryParams.subClafficationId = '';
      this.queryParams.name = '';
      this.queryParams.remarks = '';
      this.form = {};

      this.getList();
    },

    handleSearch() {
      this.queryParams.pageNum = 1
      this.getList()
    },

    handleDelete(id) {
      this.$confirm('确认删除吗？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(async () => {
        await deleteTravelScenery(id)
        this.$message.success('删除成功')
        this.getList()
      }).catch(() => {})
    },

    openAddDialog() {
      this.dialogTitle = '新增'
      const targetModuleId = this.activeTab === '0' ? 847162 : 923342;
      this.form = {
        moduleId: targetModuleId,
        isUser: 0,
        isVr: 0,
        inx: 0,
        blockId: '',
        content: '',
        englishIntroduction: '',
        subClafficationName: ''
      }
      this.dialogVisible = true
      this.$nextTick(() => {
        if (this.$refs.chineseEditor) this.$refs.chineseEditor.innerHTML = ''
        if (this.$refs.englishEditor) this.$refs.englishEditor.innerHTML = ''
      })
    },

    // 【关键修复】编辑时优先从 travelJointList 取分类，没有则用 subClassificationId 兜底
    openEditDialog(row) {
      this.dialogTitle = '编辑'
      this.form = JSON.parse(JSON.stringify(row))

      let classId = null
      if (row.travelJointList && row.travelJointList.length > 0) {
        classId = String(row.travelJointList[0].classificationId)
      } else if (row.subClassificationId) {
        classId = String(row.subClassificationId)
      }
      if (classId) {
        const target = this.classificationList.find(c => String(c.id) === classId)
        this.form.subClafficationName = target ? target.name : ''
      } else {
        this.form.subClafficationName = ''
      }

      if (!this.form.blockId) this.form.blockId = ''
      if (!this.form.isVr) this.form.isVr = 0

      this.dialogVisible = true
      this.$nextTick(() => {
        if (this.$refs.chineseEditor) this.$refs.chineseEditor.innerHTML = this.form.content || ''
        if (this.$refs.englishEditor) this.$refs.englishEditor.innerHTML = this.form.englishIntroduction || ''
      })
    },

    handleUploadSuccess(res, field) {
      if (res.code === 200) {
        this.form[field] = res.data.url
        this.$message.success('上传成功')
      } else {
        this.$message.error(res.msg || '上传失败')
      }
    },

    beforeUpload(file) {
      const isLt5M = file.size / 1024 / 1024 < 5
      if (!isLt5M) {
        this.$message.error('上传文件大小不能超过 5MB!')
      }
      return isLt5M
    },

    // 音频上传前校验
    beforeAudioUpload(file) {
      const isAudio = file.type.indexOf('audio/') === 0
      if (!isAudio) {
        this.$message.error('只能上传音频文件!')
        return false
      }
      const isLt50M = file.size / 1024 / 1024 < 50
      if (!isLt50M) {
        this.$message.error('音频大小不能超过 50MB!')
        return false
      }
      return true
    },

    // 音频上传失败（网络错误/服务器报错）时给出明确提示
    handleAudioUploadError(err) {
      let msg = '音频上传失败，请重试'
      try {
        const obj = typeof err === 'string' ? JSON.parse(err) : err
        if (obj && obj.msg) msg = obj.msg
      } catch (e) { /* 忽略解析失败 */ }
      this.$message.error(msg)
    },

    execCmd(command, value = null, lang = 'chinese') {
      if (command === 'createLink') {
        const url = prompt('请输入链接地址：');
        if (!url) return;
        document.execCommand(command, false, url);
      } else if (command === 'insertImage') {
        const url = prompt('请输入图片地址：');
        if (!url) return;
        document.execCommand(command, false, url);
      } else {
        document.execCommand(command, false, value);
      }

      this.syncContent(lang === 'chinese' ? 'content' : 'englishIntroduction', {
        target: lang === 'chinese' ? this.$refs.chineseEditor : this.$refs.englishEditor
      });
    },

    syncContent(field, event) {
      if (event.target) {
        this.form[field] = event.target.innerHTML;
      }
    },

    // 【关键修复】提交时通过分类名反查 ID
    submitForm() {
      this.$refs.formRef.validate(async (valid) => {
        if (valid) {
          try {
            const payload = { ...this.form }
            payload.moduleId = this.activeTab === '0' ? 847162 : 923342;

            if (this.activeTab === '0') {
              if (payload.subClafficationName) {
                const target = this.classificationList.find(c => c.name === payload.subClafficationName)
                if (target) {
                  payload.travelJointList = [{ classificationId: target.id }]
                }
              } else {
                payload.travelJointList = []
              }
            }

            if (payload.id) {
              await updateTravelScenery(payload)
              this.$message.success('修改成功')
            } else {
              await saveTravelScenery(payload)
              this.$message.success('新增成功')
            }
            this.dialogVisible = false
            this.getList()
          } catch (error) {
            console.error('保存失败', error)
          }
        } else {
          return false
        }
      })
    },

    resetForm() {
      if (this.$refs.formRef) {
        this.$refs.formRef.resetFields()
      }
      this.form = {}
    },

    openClassDialog() {
      this.classDialogVisible = true
    },

    handleAddClass() {
      this.$prompt('请输入分类名称', '新增分类', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
      }).then(async ({ value }) => {
        await addClassApi({ name: value, moduleId: this.activeTab })
        this.$message.success('新增成功')
        this.getClassificationList()
      }).catch(() => {})
    },

    handleEditClass(row) {
      this.$prompt('请输入分类名称', '编辑分类', {
        inputValue: row.name,
        confirmButtonText: '确定',
        cancelButtonText: '取消',
      }).then(async ({ value }) => {
        await editClassApi({ id: row.id, name: value, moduleId: this.activeTab })
        this.$message.success('修改成功')
        this.getClassificationList()
      }).catch(() => {})
    },

    handleDeleteClass(id) {
      this.$confirm('确认删除该分类吗？', '提示', {
        type: 'warning'
      }).then(async () => {
        await deleteClassApi(id)
        this.$message.success('删除成功')
        this.getClassificationList()
      }).catch(() => {})
    }
  }
}
</script>

<style scoped>
.scenic-container { padding: 20px; background-color: #f5f7fa; min-height: 100vh; }
.search-bar { background-color: #fff; padding: 15px 20px 5px 20px; border-radius: 4px; margin-bottom: 15px; }
.action-buttons { margin-bottom: 15px; }
.card-list { min-height: 400px; }
.card-img-box { height: 150px; overflow: hidden; }
.card-img { width: 100%; height: 100%; object-fit: cover; transition: transform 0.3s; }
.card-img:hover { transform: scale(1.05); }
.card-content { padding: 10px; }
.card-title { font-size: 14px; font-weight: bold; color: #333; margin-bottom: 8px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
.card-views { font-size: 12px; color: #999; margin-bottom: 10px; }
.card-actions { display: flex; justify-content: space-between; align-items: center; font-size: 12px; color: #666; border-top: 1px solid #eee; padding-top: 8px; }
.action-btn { cursor: pointer; display: flex; align-items: center; }
.action-btn i { margin-right: 3px; }
.action-btn:hover { color: #409EFF; }
.folder-icon { font-size: 14px; cursor: pointer; }
.pagination-container { display: flex; justify-content: center; margin-top: 20px; }
.custom-dialog .el-dialog__body { padding: 20px 40px; overflow: visible !important; }
/* 防止 el-select 下拉被 dialog 裁剪 */
::v-deep .custom-dialog .el-select-dropdown { z-index: 9999 !important; }
::v-deep .custom-dialog .el-popper.is-light { z-index: 9999 !important; }
.avatar-uploader { border: 1px dashed #d9d9d9; border-radius: 6px; cursor: pointer; position: relative; overflow: hidden; width: 120px; height: 120px; display: flex; justify-content: center; align-items: center; background-color: #fafafa; }
.avatar-uploader:hover { border-color: #409EFF; }
.avatar-uploader-icon { font-size: 28px; color: #8c939d; width: 120px; height: 120px; line-height: 120px; text-align: center; }
.avatar { width: 120px; height: 120px; display: block; object-fit: cover; }
.upload-tip { font-size: 12px; color: #999; margin-top: 5px; line-height: 1; }
.audio-preview { display: flex; align-items: center; gap: 12px; margin-top: 8px; }
.wps-editor-container { border: 1px solid #dcdfe6; border-radius: 4px; overflow: hidden; width: 100%; background-color: #fff; }
.wps-toolbar { background-color: #f5f7fa; border-bottom: 1px solid #dcdfe6; padding: 5px 10px; }
.toolbar-row { display: flex; align-items: center; gap: 2px; height: 32px; }
.toolbar-btn { display: inline-flex; justify-content: center; align-items: center; min-width: 28px; height: 28px; cursor: pointer; border-radius: 4px; font-size: 14px; color: #606266; user-select: none; }
.toolbar-btn:hover { background-color: #e4e7ed; }
.wps-editor-content { min-height: 200px; max-height: 400px; overflow-y: auto; padding: 10px; outline: none; font-size: 14px; line-height: 1.5; color: #333; }
.wps-editor-content * { font-size: 14px !important; font-family: inherit !important; }
.wps-editor-content:empty::before { content: attr(placeholder); color: #c0c4cc; pointer-events: none; }
::v-deep .el-textarea__inner { font-family: inherit; font-size: 14px; line-height: 1.5; }
</style>
