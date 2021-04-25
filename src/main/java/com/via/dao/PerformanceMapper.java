package com.via.dao;

import com.via.domain.Performance;

import java.util.List;

public interface PerformanceMapper {
    List<Performance> selectList(Performance performance);
}
