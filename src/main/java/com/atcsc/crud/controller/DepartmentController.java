package com.atcsc.crud.controller;


import com.atcsc.crud.bean.Department;
import com.atcsc.crud.bean.Msg;
import com.atcsc.crud.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;

    @RequestMapping(value="/depts", method= RequestMethod.GET)
    @ResponseBody
    public Msg getAllDepartment() {
        List<Department> depts = departmentService.getDepts();
        return Msg.success().add("depts", depts);
    }
}
