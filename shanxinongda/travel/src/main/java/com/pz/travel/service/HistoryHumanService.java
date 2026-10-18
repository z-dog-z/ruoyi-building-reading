package com.pz.travel.service;

import com.ruoyi.common.utils.IdWorker;
import com.pz.travel.domain.HistoryHuman;
import com.pz.travel.mapper.HistoryHumanMapper;
import com.ruoyi.common.utils.uuid.IdUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class HistoryHumanService {


    @Autowired
    HistoryHumanMapper historyHumanMapper;
    @Autowired
    private IdWorker idWorker;


  public List<HistoryHuman>  list (HistoryHuman historyHuman){

      return historyHumanMapper.select(historyHuman);


  }

  public HistoryHuman save(HistoryHuman historyHuman){

      historyHuman.setId(idWorker.nextId());

      historyHumanMapper.insert(historyHuman);
      return historyHuman;
  }

    public HistoryHuman update(HistoryHuman historyHuman){


        historyHumanMapper.updateByPrimaryKey(historyHuman);
        return historyHuman;
    }


    public int delete(List<Long> id){


        for ( Long id1: id
             ) {
            HistoryHuman historyHuman = new HistoryHuman();
            historyHuman.setId(id1);
            historyHumanMapper.delete(historyHuman);

        }

        return 1;
    }
}
