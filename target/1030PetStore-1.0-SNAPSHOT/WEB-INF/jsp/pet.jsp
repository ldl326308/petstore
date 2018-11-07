<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>所有宠物</title>
    <style>
        .petDel {
            margin-right: 10px;
        }

        #divMain {
            width: 500px;
            margin-left: 300px;
            margin-top: 30px;
        }

        #divMain div {
            float: left;
            margin-left: 15px;
        }

        table {
            width: 800px;
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

        #selSearchStatus {
            display: none;
        }

        .tabSearch {
            text-align: center;
        }

        .tabSearch td {
            width: 150px;
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

<table class="tabSearch">
    <tr>
        <td>通过状态查询：<input type="checkbox" id="cboStatus"/> &emsp;</td>
        <td><select id="selSearchStatus">
            <option value="请选择">请选择</option>
            <option value="可用">可用</option>
            <option value="待售">待售</option>
            <option value="出售">出售</option>
        </select>
            <input style="width:150px;height:24px;" type="text" id="txtSearch" placeholder="通过id查询"/></td>
        <td><input type="button" id="btnSearch" value="ID查询"/></td>
    </tr>
</table>
<%-- 渲染所有宠物数据 --%>
<table>
    <thead>
    <tr>
        <th>ID</th>
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

<!-- 更新数据 -->
<div id="divMain">
    <div>
        <input type="hidden" id="petId_upd"/>
        <p>宠物名称：<input type="text" id="petName_upd"/></p>
        <p>
            宠物标签：<select id="selTagId_upd"></select>
        </p>
        <p>
            宠物类别：<select id="selCategoryId_upd"></select>
        </p>
        <p>宠物状态：
            <select id="petStatus_upd">
                <option value="可用">可用</option>
                <option value="待售">待售</option>
                <option value="出售">出售</option>
            </select>
        </p>
        <p>
            <input type="button" id="btnPetUpd" value="更新"/>
        </p>
    </div>
    <div>
        <p>图片上传：
            <input type="hidden" id="petPhotoUrls_upd"/>
            <img style="width:50px;height:50px;" id="imgShow_upd"/>
        <form id="frm_upload_upd" action="#">
            <input type="file" style="width:70px;" name="multipartFile"/>
            <input type="button" id="btnUpload_upd" value="上传"/>
        </form>
        </p>
    </div>
</div>

<script type="text/javascript" src="../../js/jquery-1.11.3.js"></script>
<script>

    $(function () {
        start();


        //更新按钮点击事件
        $("#btnPetUpd").click(function () {
            if ($("#petName_upd").val() == "") {
                alert("请输入名称");
                return false;
            }
            if ($("#petPhotoUrls_upd").val() == "") {
                if (!window.confirm("还未上传图片，确认添加吗？")) {
                    return false;
                }
            }

            var updDataPet = new FormData();
            updDataPet.append("petId",$("#petId_upd").val());
            updDataPet.append("petName", $("#petName_upd").val());
            updDataPet.append("categoryId", $("#selCategoryId_upd option:selected").val());
            updDataPet.append("petPhotoUrls", $("#petPhotoUrls_upd").val());
            updDataPet.append("tagId", $("#selTagId_upd option:selected").val());
            updDataPet.append("petStatus", $("#petStatus_upd option:selected").val());

            $.ajax({
                type: "put",
                url: "/pet",
                data:updDataPet ,
                processData:false,
                contentType:false, //不进行转换操作，原数据
                success: function (data) {
                    alert(data.msg);
                    window.location.href = "/petStart";
                }, error: function (err) {
                    alert("error : " + err.responseText);
                }
            });
        });

        //修改点击事件
        $("#petTbody").on("click", ".petUpd", function () {
            var updId = $(this).attr("updId");

            $.ajax({
                type: "get",
                url: "/pet/" + updId,
                success: function (data) {
                    $("#petId_upd").val(data.petId);
                    $("#petName_upd").val(data.petName);

                    //类型
                    $.each($("#selTagId_upd option"), function (index, obj) {
                        if (data.tagId == $(obj).val()) {
                            $(obj).prop("selected", "true");
                        }
                    });

                    // //标签
                    $.each($("#selCategoryId_upd option"), function (index, obj) {
                        if (data.categoryId == $(obj).val()) {
                            $(obj).prop("selected", "true");
                        }
                    });
                    //状态
                    $.each($("#petStatus_upd option"), function (index, obj) {
                        if (data.petStatus == $(obj).val()) {
                            $(obj).prop("selected", "true");
                        }
                    });

                    //图片
                    $("#imgShow_upd").attr("src", data.petPhotoUrls);
                    $("#petPhotoUrls_upd").attr("value", data.petPhotoUrls);

                }, error: function (err) {
                    console.log(err.responseText);
                }
            });
        });

        //状态查询，下拉框点击事件
        $("#selSearchStatus").bind("change", function () {
            var petStatus = $(this).val();
            if (petStatus === "请选择") {
                return false;
            }
            $.ajax({
                type: "get",
                url: "/pet/finByStatus",
                data: {"pet_status": petStatus},
                success: function (data) {
                    rendering(data);
                },
                error: function (err) {
                    console.log(err.responseText);
                }
            });
        });

        //复选框点击事件
        $("#cboStatus").click(function () {
            if (this.checked) {  //显示下拉框，隐藏文本框及按钮
                $("#btnSearch").css("display", "none");
                $("#txtSearch").css("display", "none");
                $("#selSearchStatus").css("display", "block");
            } else {
                $("#btnSearch").css("display", "block");
                $("#txtSearch").css("display", "block");
                $("#selSearchStatus").css("display", "none");
            }
        });

        //点击按钮通过id查询
        $("#btnSearch").click(function () {
            var petId = $("#txtSearch").val();

            if (petId == "" || petId == null) {
                start();
                return false;
            }

            $.ajax({
                type: "get",
                url: "/pet/" + petId,
                success: function (obj) {
                    $("#petTbody tr").remove(); //清空
                    if (obj == undefined || obj == "") {
                        var newTr = $("<tr/>").text("没有找到！");
                        $("#petTbody").append(newTr);
                        $("#txtSearch").val("");
                    } else {
                        var newTr = $("<tr/>");
                        newTr.append($("<td/>").text(obj.petId));
                        newTr.append($("<td/>").text(obj.petName));
                        var newImg = $("<img/>").attr("src", obj.petPhotoUrls);
                        newTr.append($("<td/>").append(newImg));
                        newTr.append($("<td/>").text(obj.tag.tagName));
                        newTr.append($("<td/>").text(obj.category.categoryName));
                        newTr.append($("<td/>").text(obj.petStatus));
                        var newDelBtn = $("<input type='button' class='petDel' value='删除' delId='" + obj.petId + "' />");
                        var newUpdBtn = $("<input type='button' class='petUpd' value='修改' updId='" + obj.petId + "' />");
                        newTr.append($("<td/>").append(newDelBtn).append(newUpdBtn));
                        $("#petTbody").append(newTr);
                        $("#txtSearch").val("");
                    }
                }, error: function (err) {
                    console.error(err.responseText);
                }
            });
        });

        //添加宠物点击事件
        $("#btnAddPet").click(function () {
            if ($("#petId").val() == "") {
                alert("请输入编号！");
                return false;
            }
            if ($("#petName").val() == "") {
                alert("请输入名称");
                return false;
            }
            if ($("#petPhotoUrls").val() == "") {
                if (!window.confirm("还未上传图片，确认添加吗？")) {
                    return false;
                }
            }

            $.ajax({
                type: "post",
                url: "/pet",
                data: {
                    "petId": $("#petId").val(),
                    "petName": $("#petName").val(),
                    "categoryId": $("#selCategoryId option:selected").val(),
                    "petPhotoUrls": $("#petPhotoUrls").val(),
                    "tagId": $("#selTagId option:selected").val(),
                    "petStatus": $("#petStatus option:selected").val()
                },
                success: function (data) {
                    alert(data.msg);
                    start();
                    window.location.href = "/petStart";
                }, error: function (err) {
                    alert("error : " + err.responseText);
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

        //修改图片
        //图片上传点击事件
        $("#btnUpload_upd").click(function () {
            var formData = new FormData($("#frm_upload_upd")[0]);
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
                        $("#imgShow_upd").attr("src", data.true);
                        $("#petPhotoUrls_upd").val(data.true);
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
            if (!window.confirm("确认删除吗？")) {
                return false;
            }

            var delId = $(this).attr("delId");
            $.ajax({
                type: "delete",
                url: "/pet/" + delId,
                success: function (data) {
                    alert(data.msg);
                    window.location.href = "/petStart";
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
                $("#selTagId_upd option").remove();
                $.each(data, function (index, obj) {
                    $("#selTagId").append($("<option/>").attr("value", obj.tagId).text(obj.tagName));
                    $("#selTagId_upd").append($("<option/>").attr("value", obj.tagId).text(obj.tagName));
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
                $("#selCategoryId_upd option").remove();  //清空
                $.each(data, function (index, obj) {
                    $("#selCategoryId").append($("<option/>").attr("value", obj.categoryId).text(obj.categoryName));
                    $("#selCategoryId_upd").append($("<option/>").attr("value", obj.categoryId).text(obj.categoryName));
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
                //渲染
                rendering(data);
            },
            error: function (err) {
                console.log(err);
            }
        });
    }

    //数据渲染方法
    function rendering(data) {
        $("#petTbody tr").remove(); //清空
        $.each(data, function (index, obj) {
            var newTr = $("<tr/>");
            newTr.append($("<td/>").text(obj.petId));
            newTr.append($("<td/>").text(obj.petName));
            var newImg = $("<img/>").attr("src", obj.petPhotoUrls);
            newTr.append($("<td/>").append(newImg));
            newTr.append($("<td/>").text(obj.tag.tagName));
            newTr.append($("<td/>").text(obj.category.categoryName));
            newTr.append($("<td/>").text(obj.petStatus));
            var newDelBtn = $("<input type='button' class='petDel' value='删除' delId='" + obj.petId + "' />");
            var newUpdBtn = $("<input type='button' class='petUpd' value='修改' updId='" + obj.petId + "' />");
            newTr.append($("<td/>").append(newDelBtn).append(newUpdBtn));
            $("#petTbody").append(newTr);
        });
    }

</script>

</body>
</html>
