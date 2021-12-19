<%--
  Created by IntelliJ IDEA.
  User: Caisc
  Date: 2021/12/9
  Time: 16:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<%--web路径，
不以/开始的相对路径，找资源，以当前资源的路径为基准，经常出问题。
以/开始的相对路径，找资源，以服务器的路径为标准（http://localhost:3306）:需要加上项目名
http://localhost:3306/crud
--%>
<head>
    <title>员工列表</title>
    <script type="text/javascript"
            src="${APP_PATH}/static/js/jquery-1.12.4.min.js"></script>
    <link
            href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
            rel="stylesheet">
    <script
            src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>

<%--员工更新模态框--%>
<!-- Modal -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="ModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="ModalLabel">员工更新</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <div>
                                <p class="form-control-static" id="emp_update_empName"></p>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="emp_update_email" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <div>
                                <input type="text" name="email" class="form-control" id="emp_update_email" placeholder="1234@csc.com">
                                <span class="help-block"></span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="update_gender_m" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="update_gender_f" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>



<%--员工添加模态框--%>
<!-- Modal -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="emp_add_empName" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <div>
                            <input type="text" name="empName" class="form-control" id="emp_add_empName" placeholder="empName">
                            <span class="help-block"></span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="emp_add_email" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <div>
                            <input type="text" name="email" class="form-control" id="emp_add_email" placeholder="1234@csc.com">
                            <span class="help-block"></span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender_m" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender_f" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>


<%--    搭建显示页面--%>
<div class="container">
    <%--    标题--%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <%--    按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_model_btn">新增</button>
            <button class="btn btn-danger" id="emp_del_all_btn">删除</button>
        </div>
    </div>
    <%--    表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="check_all">
                        </th>
                        <th>#</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th>操作</th>
                    </tr>
                </thead>
            <tbody>
            </tbody>
            </table>
        </div>
    </div>
    <%--    显示分页信息--%>
    <div class="row">
        <%--        分页信息--%>
        <div class="col-md-6" id="page_info_area">
        </div>
        <%--        分页条--%>
        <div class="col-md-6" id="page_info_nav">
    </div>
</div>

<script type="text/javascript">

    var totalRecord;
    var currentNum;

    //1、 页面加载完成以后，直接去发送ajax请求，要到分页数据
    $(function() {
        to_page(1);
    });

    //员工信息列表显示函数
    function build_emps_table(result) {
        //清空列表
        $("#emps_table tbody").empty();
        var emps = result.extend.pageInfo.list;
        $.each(emps, function(index, item) {
            var checkBodTd = $("<td><input type='checkbox' class='check_item'/></td>");
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var gender = $("<td></td>").append(item.gender=='M'?"男":"女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit-btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
                .append("编辑").attr("edit-id", item.empId);
            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm del-btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                .append("删除").attr("del-id", item.empId);
            var dtnTn = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            $("<tr></tr>")
                .append(checkBodTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(gender)
                .append(emailTd)
                .append(deptNameTd)
                .append(dtnTn)
                .appendTo("#emps_table tbody");
        }); 
    }

    //解析显示分页信息
    function build_page_info(result) {
        $("#page_info_area").empty();
        $("#page_info_area").append("当前" +result.extend.pageInfo.pageNum+
            "页，总 " + result.extend.pageInfo.pages +
            "页，总" + result.extend.pageInfo.total + "条记录")
        totalRecord =  result.extend.pageInfo.total;
        currentNum = result.extend.pageInfo.pageNum;
    }

    //分页导航
    function build_page_nav(result) {
        $("#page_info_nav").empty();
        var ul = $("<ul></ul>").addClass("pagination");

        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("前一页").append("&laquo;"));

        if(result.extend.pageInfo.hasPreviousPage == false){
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }

        var nextPageLi = $("<li></li>").append($("<a></a>").append("下一页").append("&raquo;"));
        var LastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));
        if(result.extend.pageInfo.hasNextPage == false) {
            nextPageLi.addClass("disabled");
            LastPageLi.addClass("disabled");
        }

        firstPageLi.click(function () {
            to_page(1);
        });
        prePageLi.click(function () {
            to_page(result.extend.pageInfo.pageNum - 1);
        });

        LastPageLi.click(function () {
            to_page(result.extend.pageInfo.pages);
        });
        nextPageLi.click(function () {
            to_page(result.extend.pageInfo.pageNum + 1);
        });

        ul.append(firstPageLi).append(prePageLi);

        $.each(result.extend.pageInfo.navigatepageNums, function(index, item){
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if(result.extend.pageInfo.pageNum == item){
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_page(item);
            });
            ul.append(numLi);
        });

        ul.append(nextPageLi).append(LastPageLi);

        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_info_nav")
    }

    //清理
    function modal_reset(ele) {
        $(ele)[0].reset();
        //清空表单样式
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");
    }

    //新增按钮模态框点击弹出绑定
    $("#emp_add_model_btn").click(function() {
        modal_reset("#empAddModal form");
        //发送ajax请求，获取部门信息，进行显示
        getDepts("#empAddModal select");
        // 显示模态框
        $("#empAddModal").modal({
            backdrop:"static"
        })
    });

    //保存按钮点击保存绑定
    $("#emp_save_btn").click(function() {
        //1. 模态框中填写的表单数据

        //2. 前端数据校验
        // emp_msg_validate();

        //3. 重复校验
        if($(this).attr("ajax_val")=="error"){
            validate_msg("#emp_add_empName","error","用户名不合法，请重新输入");
            return false;
        }

        //2. 发送ajax请求进行保存
        $.ajax({
            url:"${APP_PATH}/emp",
            type:"POST",
            data:$("#empAddModal form").serialize(),
            success:function (result) {
                if(result.code == 200) {
                    if(undefined != result.extend.errors.empName){
                        alert(result.extend.errors.empName);
                        validate_msg("#emp_add_empName", "error", result.extend.errors.empName);
                    }

                    if(undefined != result.extend.errors.email){
                        alert(result.extend.errors.email);
                        validate_msg("#emp_add_email", "error", result.extend.errors.email);
                    }

                } else {
                    //关闭模态框
                    $("#empAddModal").modal('hide');
                    //2. 来到最后一页
                    to_page(totalRecord);
                }

            }
        })
    });

    //用户名输入重复用户名更改绑定
    $("#emp_add_empName").change(function () {
       var empName = this.value;
       $.ajax({
           url:"${APP_PATH}/checkuser",
           data:"empName="+empName,
           type:"POST",
           success:function (result) {
               if(result.code == 200) {
                   validate_msg("#emp_add_empName","error",result.extend.val_msg);
                   $("#emp_save_btn").attr("ajax_val", "error");
               } else {
                   validate_msg("#emp_add_empName","success","用户名可用");
                   $("#emp_save_btn").attr("ajax_val", "success");
               }
           }
       })
    });

    //更新模态框绑定
    //在数据更新后发生的绑定事件
    $(document).on("click", ".edit-btn", function(){
        //01. 查出员工
        //02. 显示员工
        modal_reset("#empUpdateModal form");
        getDepts("#empUpdateModal select");
        //获取员工的id
        getEmp($(this).attr("edit-id"));
        //将员工id传入到更新按钮中
        $("#emp_update_btn").attr("edit-id", $(this).attr("edit-id"));
        $("#empUpdateModal").modal({
            backdrop:"static"
        });
    });

    //绑定单个删除按钮
    $(document).on("click", ".del-btn", function(){
        //1. 是否确认删除对话框
        var name = $(this).parents("tr").find("td:eq(2)").text();
        if(confirm("确认删除【" + name +"】吗？")) {
            //确认，发送ajax请求即可
            $.ajax({
                url:"${APP_PATH}/emp/" + $(this).attr("del-id"),
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    to_page(currentNum);
                }
            })
        }
    });


    //绑定模态框更新按钮
    $("#emp_update_btn").click(function() {
        //1. 验证邮箱
        var empEmail = $("#emp_update_email").val();
        var emailRule = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(emailRule.test(empEmail)){
            validate_msg("#emp_update_email","success","邮箱验证成功");
        } else {
            validate_msg("#emp_update_email","error","邮箱格式错误，请重新输入！");
            return false;
        };
        //2. 发送请求
        $.ajax({
            url:"${APP_PATH}/emp/" + $(this).attr("edit-id"),
            type:"PUT",
            data:$("#empUpdateModal form").serialize(),
            success:function (result) {
                // alert(result.msg);
                //1. 关闭对话框
                $("#empUpdateModal").modal("hide");
                //2 回到本页面
                to_page(currentNum);

            }
        })
    });

    //绑定全选全不选的单击事件 prop获取dom原生的值，attr获取标签的值
    $("#check_all").click(function () {
        // alert($(this).prop("checked"));
        $(".check_item").prop("checked", $(this).prop("checked"))
    });

    //check_item
    $(document).on("click", ".check_item", function () {
        //判断当前选中的元素是不是5个
        var flag = $(".check_item:checked").length == $(".check_item").length;
        $("#check_all").prop("checked", flag);
    });

    //全部删除
    $("#emp_del_all_btn").click(function () {
        var empNames = "";
        var ids = "";
       $.each($(".check_item:checked"), function () {
           var name = $(this).parents("tr").find("td:eq(2)").text() + ",";
           var id = $(this).parents("tr").find("td:eq(1)").text() + "-";
           empNames += name;
           ids += id;
       });
       //去除多余的逗号
        empNames = empNames.substring(0 , empNames.length-1);
        ids = ids.substring(0 , ids.length-1);
       if(confirm("确认删除【"+ empNames +"】吗")) {
           //发送ajax请求
            $.ajax({
                url:"${APP_PATH}/emp/" + ids,
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    to_page(currentNum);
                }
            })
       }
    });

    function getEmp(id) {
        $.ajax({
            url:"${APP_PATH}/emp/" + id,
            type:"GET",
            success:function (result) {
                var emp = result.extend.emp;
                //1. 设置姓名
                $("#emp_update_empName").text(emp.empName);
                //2. 设置邮箱
                $("#emp_update_email").val(emp.email);
                //3. 设置性别
                $("#empUpdateModal input[name=gender]").val([emp.gender]);
                //4. 设置部门
                $("#empUpdateModal select").val([emp.dId]);
            }
        })
    }

    //信息校验
    function emp_msg_validate() {
        if(!empName_validate()) {
            validate_msg("#emp_add_empName","error","用户名格式错误，请重新输入！");
            return false;
        }
        validate_msg("#emp_add_empName","success","");

        if(!email_validate()) {
           validate_msg("#emp_add_email","error","邮箱格式错误，请重新输入！");
           return false;
        }
        validate_msg("#emp_add_email","success","");
    }

    function empName_validate() {
        var empName = $("#emp_add_empName").val();
        var nameRule = /(^[a-z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if(nameRule.test(empName)) {
            return true;
        } else {
            return false;
        }
    }

    function validate_msg(ele, status, msg) {
        $(ele).parent().removeClass("has-error has-success");
        $(ele).next("span").text("");
        if("error" == status) {
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        } else {
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }
    }

    function email_validate() {
        var empEmail = $("#emp_add_email").val();
        var emailRule = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(emailRule.test(empEmail)){
            return true;
        } else {
            return false;
        }
    }

    //获取部门信息
    function getDepts(ele){
        $.ajax({
            url:"${APP_PATH}/depts",
            type:"GET",
            success:function (result) {
                $(ele).empty();
                $.each(result.extend.depts, function () {
                    var optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                    optionEle.appendTo(ele);
                })
            }
        })
    }

    //转到对应的页面
    function to_page(pn) {
        $.ajax({
            url:"${APP_PATH}/emps",
            data:"pn=" + pn,
            type:"GET",
            success:function(result) {
                // console.log(result);
                //1. 解析并显示 员工数据
                build_emps_table(result);
                //2. 解析并显示分页信息
                build_page_info(result);
                //3. 导航栏信息显示
                build_page_nav(result);
            }
        })
    }



</script>
</body>
</html>
