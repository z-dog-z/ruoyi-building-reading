package com.pz.travel.mapper;

import com.pz.travel.domain.TravelModule;

import java.util.List;

public interface TravelModuleMapper {
    public List<TravelModule> selectTravelModule(TravelModule travelModule);

    public int insertTravelModule(TravelModule travelModule);

    public int deleteTravelModule(Long id);
}
