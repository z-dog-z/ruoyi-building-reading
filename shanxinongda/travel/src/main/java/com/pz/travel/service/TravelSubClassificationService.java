package com.pz.travel.service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.ruoyi.common.utils.IdWorker;
import com.pz.travel.domain.TravelSubClassification;
import com.pz.travel.mapper.TravelSubClassificationMapper;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.file.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.net.URL;
import java.util.List;

@Service
public class TravelSubClassificationService {
    @Autowired
    private TravelSubClassificationMapper travelSubClassificationMapper;
    @Autowired
    private IdWorker idWorker;
    /**
     * 二级分类展示
     * @param travelSubClassification
     * @return
     */
    public List<TravelSubClassification> selectTravelSubclassfication(TravelSubClassification travelSubClassification){
        return travelSubClassificationMapper.selectTravelSubclassfication(travelSubClassification);
    }

    /**
     * 新增分类
     * @param travelSubClassification
     * @return
     */
    public int insertTravelSubClassfication(TravelSubClassification travelSubClassification){
        travelSubClassification.setId(idWorker.nextId());
        travelSubClassification.setCreateTime(DateUtils.getNowDate());//获取系统时间
        travelSubClassification.setCreateBy(SecurityUtils.getLoginUser().getUser().getUserId().toString());//获取修改人id
        return travelSubClassificationMapper.insertTravelSubClassification(travelSubClassification);
    }

    /**
     * 修改二级分类
     * @param travelSubClassification
     * @return
     */
    public int updateTravelSubClassfication(TravelSubClassification travelSubClassification){
        return travelSubClassificationMapper.updateTravelSubClassfication(travelSubClassification);
    }
    /**
     * 删除分类
     * @param id
     * @return
     */
    public int deleteTravelSubClassification(Long id){
        return travelSubClassificationMapper.deleteTravelSubClassficationById(id);
    }






    public  void   get () {


        File file = new File("D:\\徐汇旅游\\xuhui_travel\\travel\\file.txt");
        String result = "";
        try {
            BufferedReader br = new BufferedReader(new FileReader(file));
            String s = null;//构造一个BufferedReader类来读取文件
            while((s = br.readLine())!=null){//使用readLine方法，一次读一行
                result = result + "\n" +s;
            }
            br.close();
        }
        catch (Exception e){

        }

        JSONArray object  = JSONObject.parseArray(result);

        JSONArray object1 =   object.getJSONObject(2).getJSONArray("subItem");
        int  i = 0;
        for (Object  ob: object1) {
            i++;
            JSONObject object2 = (JSONObject)ob;
            downloadHttpUrl(object2.getJSONArray("audioStorageInfo").getJSONObject(0).getString("url"),"D:\\Music\\中国共产党章程\\","zgzcdzc-"+i+".mp3");
        }



    }

    /**
     * 下载文件---返回下载后的文件存储路径
     *
     * @param url 文件地址
     * @param dir 存储目录
     * @param fileName 存储文件名
     * @return
     */
    public static void downloadHttpUrl(String url, String dir, String fileName) {
        try {
            URL httpurl = new URL(url);
            File dirfile = new File(dir);
            if (!dirfile.exists()) {
                dirfile.mkdirs();
            }
            FileUtils.copyURLToFile(httpurl, new File(dir+fileName));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


}
