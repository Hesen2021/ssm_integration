package com.atcsc.crud.Controller;

import com.atcsc.crud.bean.Employee;
import com.github.pagehelper.PageInfo;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml","file:src/main/webapp/WEB-INF/dispatcherServlet-servlet.xml"})
@WebAppConfiguration
public class MvcTest {
    //传入Springmvc的ioc
    @Autowired
    WebApplicationContext context;
    //虚拟mvc请求，获取到处理结果
    MockMvc mockMvc;

    @Before
    public void initMockMvc() {
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void testPage() throws Exception {
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "1")).andReturn();

//        //请求成功以后，请求域中有pageInfo,取出
//        MockHttpServletRequest request = result.getRequest();
//        PageInfo pi = (PageInfo) request.getAttribute("pageInfo");
//        System.out.println("当前页码：" + pi.getPageNum());
//        System.out.println("总页码：" + pi.getPages());
//        System.out.println("总记录数" + pi.getTotal());
//        int[] nums = pi.getNavigatepageNums();
//        for (int i : nums) {
//            System.out.println(" " + i);
//        }
//
//        //获取员工数据
//        List<Employee> list = pi.getList();
//        for(Employee employee : list) {
//            System.out.println("Id:" + employee.getEmpId() + "== > Name:" + employee.getEmpName());
//            System.out.println("department" + employee.getDepartment());
//        }
    }
}
