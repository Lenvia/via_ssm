package com.via.service.impl;

import com.via.dao.MajorMapper;
import com.via.domain.Major;
import com.via.service.MajorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class MajorServiceImpl implements MajorService {
    @Autowired
    private MajorMapper majorMapper;

    @Override
    public List<Major> selectAll() {
        return majorMapper.selectAll();
    }
}
