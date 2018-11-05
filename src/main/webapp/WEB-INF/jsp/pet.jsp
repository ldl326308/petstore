<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>所有宠物</title>
    <style>
        table {
            width: 700px;
            text-align: center;
            margin: auto;
        }

        input[type='text'] {
            width: 120px;
            height: 24px;
        }

        select {
            width: 120px;
            height: 24px;
        }

        th, td {
            height: 30px;
        }

        img {
            width: 25px;
            height: 25px;
        }

    </style>
</head>
<body>


<%--
    nteger petId Integer categoryId
    String petName String petPhotoUrls;
    Integer tagId String petStatus
    Tag tag Category category;
--%>
<%--<a target="_blank" href="/addPet" >添加宠物</a>--%>

    <%-- 添加宠物 --%>
    <table style="width:800px;">
        <thead>
        <tr>
            <th>宠物编号</th>
            <th>宠物名称</th>
            <th>宠物类别</th>
            <th rowspan="2">图片上传</th>
            <th>宠物标签</th>
            <th>宠物状态</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>
                <input type="text" id="petId" autocomplete="off"/>
            </td>
            <td>
                <input type="text" id="petName" autocomplete="off"/>
            </td>
            <td>
                <select id="selCategoryId">
                </select>
            </td>
            <td rowspan="2">
                <input type="hidden" value="" id="petPhotoUrls"/>
                <img style="width:50px;height:50px;" id="imgShow"/>
                <form id="frm_upload" action="#">
                    <input type="file" style="width:70px;" name="multipartFile"/>
                    <input type="button" id="btnUpload" value="上传"/>
                </form>
            </td>
            <td>
                <select id="selTagId">
                </select>
            </td>
            <td>
                <select id="petStatus">
                    <option value="可用">可用</option>
                    <option value="待售">待售</option>
                    <option value="出售">出售</option>
                </select>
            </td>
            <td>
                <input type="button" id="btnAddPet" value="添加宠物"/>
            </td>
        </tbody>
        </tr>
    </table>

<%-- 渲染所有宠物数据 --%>
<table cellpadding="0" cellspacing="0" border="1">
    <thead>
    <tr>
        <th>名称</th>
        <th>图片</th>
        <th>标签</th>
        <th>类型</th>
        <th>状态</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody id="petTbody"></tbody>
</table>

<script type="text/javascript" src="../../js/jquery-1.11.3.js"></script>
<script>

    $(function () {
        start();

        //添加宠物点击事件
        $("#btnAddPet").click(function () {
            if($("#petId").val()==""){
                alert("请输入编号！");
                return false;
            }
            if($("#petName").val()==""){
                alert("请输入名称");
                return false;
            }
            if($("#petPhotoUrls").val()==""){
                if(!window.confirm("还未上传图片，确认添加吗？")){
                    return false;
                }
            }

           $.ajax({
              type:"post",
              url:"/pet",
              data:{
                  "petId":$("#petId").val(),
                  "petName":$("#petName").val(),
                  "categoryId":$("#selCategoryId option:selected").val(),
                  "petPhotoUrls":$("#petPhotoUrls").val(),
                  "tagId":$("#selTagId option:selected").val(),
                  "petStatus":$("#petStatus option:selected").val()
              },
              success:function (data) {
                  alert(data.msg);
                  start();
                  window.location.href="/petStart";
              },error:function (err) {
                   alert("error : "+err.responseText);
               }
           });
        });

        //图片上传点击事件
        $("#btnUpload").click(function () {
            var formData = new FormData($("#frm_upload")[0]);
            $.ajax({
                type: "post",
                url: "/uploadImg",
                data: formData,
                async: false,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {
                    if (data.false == undefined) {
                        $("#petPhotoUrls").attr("value", data.true);
                        $("#imgShow").attr("src", data.true);
                    } else {
                        alert(data.false);
                    }
                },
                error: function (data) {
                    alert("error:" + data.responseText);
                }
            });
            return false;
        });

        //删除点击事件
        $("#petTbody").on("click", ".petDel", function (index, obj) {
            if(!window.confirm("确认删除吗？")){
                return false;
            }

            var delId = $(this).attr("delId");
            $.ajax({
                type: "delete",
                url: "/pet/" + delId,
                success: function (data) {
                    alert(data.msg);
                    window.location.href="/petStart";
                },
                error: function (err) {
                    console.log(err);
                }
            });
        });

    });


    function start() {

        //标签
        $.ajax({
            type: "get",
            url: "/tag",
            success: function (data) {
                $("#selTagId option").remove();  //清空
                $.each(data, function (index, obj) {
                    $("#selTagId").append($("<option/>").attr("value", obj.tagId).text(obj.tagName));
                });
            },
            error: function (err) {
                console.log(err);
            }
        });

        //类别
        $.ajax({
            type: "get",
            url: "category",
            success: function (data) {
                $("#selCategoryId option").remove();  //清空
                $.each(data, function (index, obj) {
                    $("#selCategoryId").append($("<option/>").attr("value", obj.categoryId).text(obj.categoryName));
                });
            },
            error: function (err) {
                console.log(err);
            }
        });

        //所有宠物数据的渲染
        $.ajax({
            type: "get",
            url: "/pet",
            success: function (data) {
                $("#petTbody tr").remove(); //清空
                $.each(data, function (index, obj) {
                    var newTr = $("<tr/>");
                    newTr.append($("<td/>").text(obj.petName));
                    var newImg = $("<img/>").attr("src", obj.petPhotoUrls);
                    newTr.append($("<td/>").append(newImg));
                    newTr.append($("<td/>").text(obj.tag.tagName));
                    newTr.append($("<td/>").text(obj.category.categoryName));
                    newTr.append($("<td/>").text(obj.petStatus));
                    var newDelBtn = $("<input type='button' class='petDel' value='删除' delId='" + obj.petId + "' />");
                    newTr.append($("<td/>").append(newDelBtn));
                    $("#petTbody").append(newTr);
                });
            },
            error: function (err) {
                console.log(err);
            }
        });
    }

</script>

</body>
</html>
