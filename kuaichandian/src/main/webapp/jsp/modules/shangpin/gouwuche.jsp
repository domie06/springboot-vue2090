<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-cn">

<head>
    <%@ include file="../../static/head.jsp" %>
    <!-- font-awesome -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/font-awesome.min.css">
</head>
<style>

</style>
<body>
<!-- Pre Loader -->
<div class="loading">
    <div class="spinner">
        <div class="double-bounce1"></div>
        <div class="double-bounce2"></div>
    </div>
</div>
<!--/Pre Loader -->
<div class="wrapper">
    <!-- Page Content -->
    <div id="content">
        <!-- Top Navigation -->
        <%@ include file="../../static/topNav.jsp" %>
        <!-- Menu -->
        <div class="container menu-nav">
            <nav class="navbar navbar-expand-lg lochana-bg text-white">
                <button class="navbar-toggler" type="button" data-toggle="collapse"
                        data-target="#navbarSupportedContent"
                        aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="ti-menu text-white"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul id="navUl" class="navbar-nav mr-auto">
                    </ul>
                </div>
            </nav>
        </div>
        <!-- /Menu -->
        <!-- Breadcrumb -->
        <!-- Page Title -->
        <div class="container mt-0">
            <div class="row breadcrumb-bar">
                <div class="col-md-6">
                    <h3 class="block-title">菜品表管理</h3>
                </div>
                <div class="col-md-6">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">
                            <a href="${pageContext.request.contextPath}/index.jsp">
                                <span class="ti-home"></span>
                            </a>
                        </li>
                        <li class="breadcrumb-item">菜品表管理</li>
                        <li class="breadcrumb-item active">菜品表列表</li>
                    </ol>
                </div>
            </div>
        </div>
        <!-- /Page Title -->

        <!-- /Breadcrumb -->
        <!-- Main Content -->
        <div class="container">

            <div class="row">
                <!-- Widget Item -->
                <div class="col-md-12">
                    <div class="widget-area-2 lochana-box-shadow">
                        <h3 class="widget-title">菜品表列表</h3>
                        <div class="table-responsive mb-3">
                            <div class="col-sm-12">
                                <button onclick="deleteHandler()" type="button" class="btn btn-success 点餐">提交订单</button>
                            </div>
                            <table id="tableId" class="table table-bordered table-striped">
                                <thead>
                                <tr>
                                    <th class="no-sort" style="min-width: 35px;">
                                        <div class="custom-control custom-checkbox">
                                            <input class="custom-control-input" type="checkbox" id="select-all"
                                                   onclick="chooseAll()">
                                            <label class="custom-control-label" for="select-all"></label>
                                        </div>
                                    </th>
                                    <th onclick="sort('hxTypes')">菜品名称</th>
                                    <th onclick="sort('money')">菜品单价</th>
                                    <th>菜品图片</th>
                                    <th>菜品数量</th>
                                </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <!-- /Widget Item -->
            </div>
        </div>
        <!-- /Main Content -->

    </div>
    <!-- /Page Content -->
</div>
<!-- Back to Top -->
<a id="back-to-top" href="#" class="back-to-top">
    <span class="ti-angle-up"></span>
</a>
<!-- /Back to Top -->
<%@ include file="../../static/foot.jsp" %>
<script language="javascript" type="text/javascript"
        src="${pageContext.request.contextPath}/resources/My97DatePicker/WdatePicker.js"></script>

<script>
    <%@ include file="../../utils/menu.jsp"%>
            <%@ include file="../../static/setMenu.js"%>
            <%@ include file="../../utils/baseUrl.jsp"%>
            <%@ include file="../../static/getRoleButtons.js"%>
            <%@ include file="../../static/crossBtnControl.js"%>
    var tableName = "shangpin";
    var pageType = "list";
    var searchForm = {key: ""};
    var pageIndex = 1;
    var pageSize = 10;
    var totalPage = 0;
    var dataList = [];
    var sortColumn = '';
    var sortOrder = '';
    var ids = [];
    var checkAll = false;

            var hxTypesOptions = [];

    function init() {
        // 满足条件渲染提醒接口
    }

    // 改变每页记录条数
    function changePageSize() {
        var selection = document.getElementById('selectPageSize');
        var index = selection.selectedIndex;
        pageSize = selection.options[index].value;
        getDataList();
    }



    // 查询
    function search() {
        searchForm = {key: ""};
             
        var moneyStartSearch = $('#moneyStartSearch').val();
        if( moneyStartSearch  == 0){
                moneyStartSearch ='';
        }
        searchForm.moneyStart = moneyStartSearch;
        var moneyEndSearch = $('#moneyEndSearch').val();
        if( moneyEndSearch  == 0){
                moneyEndSearch ='';
        }
        searchForm.moneyEnd = moneyEndSearch;

                getDataList();
    }

    // 获取数据列表
    function getDataList() {
        http("shangpin/page", "GET", {
            page: pageIndex,
            limit: pageSize,
            sort: sortColumn,
            order: sortOrder,
                    money: searchForm.money,
    }, (res) => {
            if(res.code == 0
            )
            {
                clear();
                dataList = res.data.list;
                totalPage = res.data.totalPage;
                //var tbody = document.getElementById('tbMain');
                for (var i = 0; i < dataList.length; i++) { //遍历一下表格数据  
                    var trow = setDataRow(dataList[i], i); //定义一个方法,返回tr数据 
                    $('tbody').append(trow);
                }
                pagination(); //渲染翻页组件
                getRoleButtons();// 权限按钮控制
            }
        })
        ;
    }

    // 渲染表格数据
    function setDataRow(item, number) {
        //创建行 
        var row = document.createElement('tr');
        row.setAttribute('class', 'useOnce');
        //创建勾选框
        var checkbox = document.createElement('td');
        var checkboxDiv = document.createElement('div');
        checkboxDiv.setAttribute("class", "custom-control custom-checkbox");
        var checkboxInput = document.createElement('input');
        checkboxInput.setAttribute("class", "custom-control-input");
        checkboxInput.setAttribute("type", "checkbox");
        checkboxInput.setAttribute('name', 'chk');
        checkboxInput.setAttribute('value', item.id);
        checkboxInput.setAttribute("id", number);
        checkboxDiv.appendChild(checkboxInput);
        var checkboxLabel = document.createElement('label');
        checkboxLabel.setAttribute("class", "custom-control-label");
        checkboxLabel.setAttribute("for", number);
        checkboxDiv.appendChild(checkboxLabel);
        checkbox.appendChild(checkboxDiv);
        row.appendChild(checkbox)

        var hxTypesCell = document.createElement('td');
        for (var i = 0; i < hxTypesOptions.length; i++) {
            if(hxTypesOptions[i].id == item.hxTypes){//下拉框value对比,如果一致就赋值汉字
                    hxTypesCell.innerHTML = hxTypesOptions[i].name;
            }
        }
        row.appendChild(hxTypesCell);

        var moneyCell = document.createElement('td');
        moneyCell.innerHTML = item.money;
        row.appendChild(moneyCell);

        var imgPhotoCell = document.createElement('td');

        var imgPhotoImg = document.createElement('img');
        imgPhotoImg.setAttribute('src', item.imgPhoto);
        imgPhotoImg.setAttribute('height', 100);
        imgPhotoImg.setAttribute('width', 100);
        imgPhotoCell.appendChild(imgPhotoImg);
        row.appendChild(imgPhotoCell);

        //每行按钮
        var btnGroup = document.createElement('td');

        //数量
        var detailBtn = document.createElement('input');
        detailBtn.setAttribute("type", "number");
        detailBtn.setAttribute("class", "form-control");
        detailBtn.setAttribute("style", "margin-top: 23px");
        detailBtn.setAttribute("placeholder", "请选择购买数量");
        detailBtn.setAttribute("id", "num"+item.id);
        btnGroup.appendChild(detailBtn)

        row.appendChild(btnGroup)
        return row;
    }

    //搜素输入检查
                function moneyStartSearchChickValue(e){
                    var this_val = e.value || 0;
                    var reg=/^[0-9]+.?[0-9]{1,2}$/;
                    if(!reg.test(this_val)){
                        e.value = "";
                        alert("输入不合法");
                        return false;
                    }
                }
                function moneyEndSearchChickValue(e){
                    var this_val = e.value || 0;
                    var reg=/^[0-9]+.?[0-9]{1,2}$/;
                    if(!reg.test(this_val)){
                        e.value = "";
                        alert("输入不合法");
                        return false;
                    }
                }

    // 翻页
    function pageNumChange(val) {
        if (val == 'pre') {
            pageIndex--;
        } else if (val == 'next') {
            pageIndex++;
        } else {
            pageIndex = val;
        }
        getDataList();
    }

    // 下载
    function download(url) {
        window.open(url);
    }

    // 打开新窗口播放媒体
    function mediaPlay(url) {
        window.open(url);
    }

    // 渲染翻页组件
    function pagination() {
        var beginIndex = pageIndex;
        var endIndex = pageIndex;
        var point = 4;
        //计算页码
        for (var i = 0; i < 3; i++) {
            if (endIndex == totalPage) {
                break;
            }
            endIndex++;
            point--;
        }
        for (var i = 0; i < 3; i++) {
            if (beginIndex == 1) {
                break;
            }
            beginIndex--;
            point--;
        }
        if (point > 0) {
            while (point > 0) {
                if (endIndex == totalPage) {
                    break;
                }
                endIndex++;
                point--;
            }
            while (point > 0) {
                if (beginIndex == 1) {
                    break;
                }
                beginIndex--;
                point--
            }
        }
        // 是否显示 前一页 按钮
        if (pageIndex > 1) {
            $('#tableId_previous').show();
        } else {
            $('#tableId_previous').hide();
        }
        // 渲染页码按钮
        for (var i = beginIndex; i <= endIndex; i++) {
            var pageNum = document.createElement('li');
            pageNum.setAttribute('onclick', "pageNumChange(" + i + ")");
            if (pageIndex == i) {
                pageNum.setAttribute('class', 'paginate_button page-item active useOnce');
            } else {
                pageNum.setAttribute('class', 'paginate_button page-item useOnce');
            }
            var pageHref = document.createElement('a');
            pageHref.setAttribute('class', 'page-link');
            pageHref.setAttribute('href', '#');
            pageHref.setAttribute('aria-controls', 'tableId');
            pageHref.setAttribute('data-dt-idx', i);
            pageHref.setAttribute('tabindex', 0);
            pageHref.innerHTML = i;
            pageNum.appendChild(pageHref);
            $('#tableId_next').before(pageNum);
        }
        // 是否显示 下一页 按钮
        if (pageIndex < totalPage) {
            $('#tableId_next').show();
            $('#tableId_next a').attr('data-dt-idx', endIndex + 1);
        } else {
            $('#tableId_next').hide();
        }
        var pageNumInfo = "当前第 " + pageIndex + " 页，共 " + totalPage + " 页";
        $('#tableId_info').html(pageNumInfo);
    }

    // 跳转到指定页
    function toThatPage() {
        //var index = document.getElementById('pageIndexInput').value;
        if (index < 0 || index > totalPage) {
            alert('请输入正确的页码');
        } else {
            pageNumChange(index);
        }
    }

    // 全选/全不选
    function chooseAll() {
        checkAll = !checkAll;
        var boxs = document.getElementsByName("chk");
        for (var i = 0; i < boxs.length; i++) {
            boxs[i].checked = checkAll;
        }
    }

    // 批量删除
    function deleteHandler() {
        var paramArray = {}
        var boxs = document.getElementsByName("chk");
        for (var i = 0; i < boxs.length; i++) {
            if (boxs[i].checked) {
                if($("#num"+boxs[i].value).val() != null && $("#num"+boxs[i].value).val() != ""){
                    paramArray[boxs[i].value] = $("#num"+boxs[i].value).val()
                }
            }
        }
        if (paramArray.length == 0) {
            alert('请勾选要购买的菜品');
        } else {
            var mymessage = confirm("您确定要提交订单吗？");
            if (mymessage == true) {
                httpJson("shangpin/diancai", "post", paramArray, (res) => {
                    if(res.code == 0 )
                {
                    getDataList();
                    alert('成功下单，请耐心等待哦');
                }
            }) ;
            }
            else {
                alert("已取消操作");
            }
        }
    }

    // 用户登出
    <%@ include file="../../static/logout.jsp"%>

            //修改
            function edit(id) {
                window.sessionStorage.setItem('updateId', id)
                window.location.href = "add-or-update.jsp"
            }

    //清除会重复渲染的节点
    function clear() {
        var elements = document.getElementsByClassName('useOnce');
        for (var i = elements.length - 1; i >= 0; i--) {
            elements[i].parentNode.removeChild(elements[i]);
        }
    }

    //添加
    function add() {
        window.location.href = "add-or-update.jsp"
    }

    //报表
    function graph() {
        window.location.href = "graph.jsp"
    }

    //单列求和
    function getSum(colName) {
        http("shangpin" + colName, "GET", {
            tableName: "shangpin",
            columnName: colName
        }, (res) => {
            if(res.code == 0
    )
        {
            return res.data.sum;
        }
    })
        ;
    }

    // 查看详情
    function detail(id) {
        window.sessionStorage.setItem("id", id);
        //window.sessionStorage.setItem("ifView", true);
        window.location.href = "info.jsp";
    }

    //填充搜索下拉框
             
        

    //查询当前页面下所有列表
        function hxTypesSelect() {
            //填充下拉框选项
            http("kuchuen/page?page=1&limit=100&sort=&order=&dicCode=hx_types", "GET", {}, (res) => {
                if(res.code == 0){
                    hxTypesOptions = res.data.list;
            }
        });
        }
    //跨表
    function crossTable(id, crossTableName) {
        window.sessionStorage.setItem('crossTableId', id);
        window.sessionStorage.setItem('crossTableName', "shangpin");
        var url = "../" + crossTableName + "/add-or-update.jsp";
        window.location.href = url;
    }

    function diancan() {
        
    }

    $(document).ready(function () {
        //激活翻页按钮
        $('#tableId_previous').attr('class', 'paginate_button page-item previous')
        $('#tableId_next').attr('class', 'paginate_button page-item next')
        //隐藏原生搜索框
        $('#tableId_filter').hide()
        //设置右上角用户名
        $('.dropdown-menu h5').html(window.sessionStorage.getItem('username'))
        //设置项目名
        $('.sidebar-header h3 a').html(projectName)
        setMenu();
        init();

        //查询当前页面所有下拉框
        hxTypesSelect();
        getDataList();


        //下拉框赋值
                                     
                        
    <%@ include file="../../static/myInfo.js"%>
    });
</script>
</body>

</html>