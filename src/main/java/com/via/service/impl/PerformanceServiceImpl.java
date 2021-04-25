package com.via.service.impl;

import com.via.dao.PerformanceMapper;
import com.via.domain.Performance;
import com.via.service.PerformanceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
@Transactional
public class PerformanceServiceImpl implements PerformanceService {

    @Autowired
    private PerformanceMapper performanceMapper;

    @Override
    public List<Performance> selectList(Performance performance) {
        return performanceMapper.selectList(performance);
    }
}
