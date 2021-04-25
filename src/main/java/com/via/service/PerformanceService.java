package com.via.service;

import com.via.domain.Performance;

import java.util.List;

public interface PerformanceService {
    List<Performance> selectList(Performance performance);
}
