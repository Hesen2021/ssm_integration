package com.atcsc.crud.controller;


import com.atcsc.crud.bean.Employee;
import com.atcsc.crud.bean.Msg;
import com.atcsc.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;


import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;
    /**
     * 查询员工数据，分页查询
     * @return
     */
//    @RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn", defaultValue = "1")Integer pn, Model model) {
        //这不是一个页面
        PageHelper.startPage(pn, 5); //每页5条
        List<Employee> employees = employeeService.getAll();
        PageInfo page = new PageInfo(employees, 5);
        //封装了详细的分页信息
        model.addAttribute("pageInfo", page);
        return "list";
    }

    /**
     * 导入jason包
     * @param pn
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping("/emps")
    public Msg getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1")Integer pn, Model model) {
        //这不是一个页面
        PageHelper.startPage(pn, 5); //每页5条
        List<Employee> employees = employeeService.getAll();
        PageInfo page = new PageInfo(employees, 5);

        return Msg.success().add("pageInfo", page);
    }


    @RequestMapping(value = "/emp", method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmployee(@Validated Employee employee, BindingResult bindingResult) {

        if(bindingResult.hasErrors()) {
            Map<String, Object> map = new HashMap<>();
            List<FieldError> fieldErrors = bindingResult.getFieldErrors();
            for (FieldError fieldError : fieldErrors) {
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errors", map);
        }
        employeeService.saveEmp(employee);
        return Msg.success();
    }

    @RequestMapping(value = "/checkuser")
    @ResponseBody
    public Msg checkUser(@RequestParam("empName") String username){
        String regx = "(^[a-z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if(!username.matches(regx)){
            return Msg.fail().add("val_msg", "请输入格式为6-16位的英文或2-5的中文");
        };

        boolean flag = employeeService.checkUser(username);
        if(flag){
            return Msg.success();
        } else {
            return Msg.fail().add("val_msg", "用户名重复，请重新输入");
        }
    }

    @RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmpById(@PathVariable("id")Integer id){
        Employee emp = employeeService.getById(id);
        return Msg.success().add("emp", emp);
    }

    @RequestMapping(value="/emp/{empId}", method = RequestMethod.PUT)
    @ResponseBody
    public Msg saveEmp(Employee employee){
        System.out.println(employee);
        employeeService.updateEmp(employee);
        return Msg.success();
    }


    @ResponseBody
    @RequestMapping(value="/emp/{ids}", method = RequestMethod.DELETE)
    public Msg deleteEmpById( @PathVariable("ids") String ids) {
        if(ids.contains("-")){
            ArrayList<Integer> idStr = new ArrayList<>();
            String[] split = ids.split("-");
            for (String s : split) {
                idStr.add(Integer.parseInt(s));
            }
            System.out.println(idStr.toString());
            employeeService.deleteBatch(idStr);
        } else {
            Integer id = Integer.parseInt(ids);
            employeeService.deleteEmp(id);
        }
        return Msg.success();
    }
}
