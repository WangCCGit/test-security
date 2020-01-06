package com.my.test.mapper;

import com.my.test.model.SysDepartment;
import com.my.test.model.SysDepartmentExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SysDepartmentMapper {
    long countByExample(SysDepartmentExample example);

    int deleteByExample(SysDepartmentExample example);

    int deleteByPrimaryKey(Long id);

    int insert(SysDepartment record);

    int insertSelective(SysDepartment record);

    List<SysDepartment> selectByExample(SysDepartmentExample example);

    SysDepartment selectByPrimaryKey(Long id);

    int updateByExampleSelective(@Param("record") SysDepartment record, @Param("example") SysDepartmentExample example);

    int updateByExample(@Param("record") SysDepartment record, @Param("example") SysDepartmentExample example);

    int updateByPrimaryKeySelective(SysDepartment record);

    int updateByPrimaryKey(SysDepartment record);
}