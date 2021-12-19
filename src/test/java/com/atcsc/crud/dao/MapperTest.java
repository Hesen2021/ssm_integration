package com.atcsc.crud.dao;


import com.atcsc.crud.bean.Department;
import com.atcsc.crud.bean.Employee;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    SqlSession sqlSession;

    @Test
    public void testCrud() {
        System.out.println(departmentMapper);
//        departmentMapper.insertSelective(new Department(null, "开发部"));
//        departmentMapper.insertSelective(new Department(null, "测试部"));
        employeeMapper.insertSelective(new Employee(null, "jojo", "M", "jojo@csc.com", 1));
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for(int i = 0; i < 1000; i++) {
            String s = UUID.randomUUID().toString().substring(0, 4) + i;
            mapper.insertSelective(new Employee(null, s, "M", s + "@csc.com", 1));
        }
        System.out.println("批量完成");
    }
}
