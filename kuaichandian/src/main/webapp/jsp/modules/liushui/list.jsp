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
                    <h3 class="block-title">流水表管理</h3>
                </div>
                <div class="col-md-6">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">
                            <a href="${pageContext.request.contextPath}/index.jsp">
                                <span class="ti-home"></span>
                            </a>
                        </li>
                        <li class="breadcrumb-item">流水表管理</li>
                        <li class="breadcrumb-item active">流水表列表</li>
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
                        <h3 class="widget-title">流水表列表</h3>
                        <div class="table-responsive mb-3">
                            <div class="col-sm-12">
                                                                                                                                                                 
                                            <label>
                                                是否支付
                                                <select name="sfTypesSelectSearch" id="sfTypesSelectSearch" class="form-control form-control-sm"
                                                        aria-controls="tableId">
                                                </select>
                                            </label>
                                                                 
                                        <label>
                                            支付时间
                                            <input type="date" id="createTimeStart" class="form-control form-control-sm"
                                                    placeholder="开始支付时间">
                                        </label>
                                        <label>
                                            -
                                        </label>
                                        <label>
                                            <input type="date" id="createTimeEnd" class="form-control form-control-sm"
                                                    placeholder="结束支付时间">
                                        </label>

                                <button onclick="search()" type="button" class="btn btn-primary">查询</button>
                                </br>
                                <button onclick="add()" type="button" class="btn btn-success 新增">添加</button>
                                <button onclick="deleteMore()" type="button" class="btn btn-danger 删除">批量删除</button>
                                <button onclick="graph()" type="button" class="btn btn-danger 报表">报表</button>
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
                                    <th onclick="sort('odd')">订单号</th>
                                    <th onclick="sort('czTypes')">餐桌名称</th>
                                    <th onclick="sort('yhTypes')">预定用户</th>
                                    <th onclick="sort('sfTypes')">是否支付</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                            <div class="col-md-6 col-sm-3">
                                <div class="dataTables_length" id="tableId_length">

                                    <select name="tableId_length" aria-controls="tableId" id="selectPageSize"
                                            onchange="changePageSize()">
                                        <option value="10">10</option>
                                        <option value="25">25</option>
                                        <option value="50">50</option>
                                        <option value="100">100</option>
                                    </select>
                                    条 每页

                                </div>
                            </div>
                            <nav aria-label="Page navigation example">
                                <ul class="pagination justify-content-end">
                                    <li class="page-item" id="tableId_previous" onclick="pageNumChange('pre')">
                                        <a class="page-link" href="#" tabindex="-1">上一页</a>
                                    </li>

                                    <li class="page-item" id="tableId_next" onclick="pageNumChange('next')">
                                        <a class="page-link" href="#">下一页</a>
                                    </li>
                                </ul>
                            </nav>
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
    var tableName = "liushui";
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

            var czTypesOptions = [];
            var yhTypesOptions = [];
            var sfTypesOptions = [];

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
                     
        var sfTypesIndex = document.getElementById("sfTypesSelectSearch").selectedIndex;
        var sfTypesValue;
        if( sfTypesIndex  == 0){
                sfTypesValue='';
        }else{
                sfTypesValue= document.getElementById("sfTypesSelectSearch").options[sfTypesIndex].value;
        }

        searchForm.sfTypes = sfTypesValue;

         
            if ($('#createTimeStart').val() != null && $('createTimeStart').val() != '') {
                searchForm.createTimeStart = $('#createTimeStart').val();
            }
            if ($('#createTimeEnd').val() != null && $('createTimeEnd').val() != '') {
                searchForm.createTimeStart = $('#createTimeEnd').val();
            }
        getDataList();
    }

    // 获取数据列表
    function getDataList() {
        http("liushui/page", "GET", {
            page: pageIndex,
            limit: pageSize,
            sort: sortColumn,
            order: sortOrder,
                    sfTypes: searchForm.sfTypes,
                    createTime: searchForm.createTime,
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

        var oddCell = document.createElement('td');
        oddCell.innerHTML = item.odd;
        row.appendChild(oddCell);

        var czTypesCell = document.createElement('td');
        for (var i = 0; i < czTypesOptions.length; i++) {
            if(czTypesOptions[i].id == item.czTypes){//下拉框value对比,如果一致就赋值汉字
                    czTypesCell.innerHTML = czTypesOptions[i].name;
            }
        }
        row.appendChild(czTypesCell);

        var yhTypesCell = document.createElement('td');
        for (var i = 0; i < yhTypesOptions.length; i++) {
            if(yhTypesOptions[i].id == item.yhTypes){//下拉框value对比,如果一致就赋值汉字
                    yhTypesCell.innerHTML = yhTypesOptions[i].name;
            }
        }
        row.appendChild(yhTypesCell);

        var sfTypesCell = document.createElement('td');
        for (var i = 0; i < sfTypesOptions.length; i++) {
            if(sfTypesOptions[i].codeIndex == item.sfTypes){//下拉框value对比,如果一致就赋值汉字
                    sfTypesCell.innerHTML = sfTypesOptions[i].indexName;
            }
        }
        row.appendChild(sfTypesCell);


        //每行按钮
        var btnGroup = document.createElement('td');

        //详情按钮
        var detailBtn = document.createElement('button');
        var detailAttr = "detail(" + item.odd + ')';
        detailBtn.setAttribute("type", "button");
        detailBtn.setAttribute("class", "btn btn-info btn-sm 查看");
        detailBtn.setAttribute("onclick", detailAttr);
        detailBtn.innerHTML = "查看订单详情"
        btnGroup.appendChild(detailBtn)
        //修改按钮
       if(item.sfTypes == 2){
           var editBtn = document.createElement('button');
           var editAttr = 'gaiwei(' + item.id + ')';
           editBtn.setAttribute("type", "button");
           editBtn.setAttribute("class", "btn btn-warning btn-sm 修改");
           editBtn.setAttribute("onclick", editAttr);
           editBtn.innerHTML = "确定支付"
           btnGroup.appendChild(editBtn)
        }
        //删除按钮
        var deleteBtn = document.createElement('button');
        var deleteAttr = 'remove(' + item.id + ')';
        deleteBtn.setAttribute("type", "button");
        deleteBtn.setAttribute("class", "btn btn-danger btn-sm 删除");
        deleteBtn.setAttribute("onclick", deleteAttr);
        deleteBtn.innerHTML = "删除"
        btnGroup.appendChild(deleteBtn)

        row.appendChild(btnGroup)
        return row;
    }

    //搜素输入检查

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
    function deleteMore() {
        ids = []
        var boxs = document.getElementsByName("chk");
        for (var i = 0; i < boxs.length; i++) {
            if (boxs[i].checked) {
                ids.push(boxs[i].value)
            }
        }
        if (ids.length == 0) {
            alert('请勾选要删除的记录');
        } else {
            remove(ids);
        }
    }

    // 删除
    function remove(id) {
        var mymessage = confirm("真的要删除吗？");
        if (mymessage == true) {
            var paramArray = [];
            if (id == ids) {
                paramArray = id;
            } else {
                paramArray.push(id);
            }
            httpJson("liushui/delete", "POST", paramArray, (res) => {
                if(res.code == 0
        )
            {
                getDataList();
                alert('删除成功');
            }
        })
            ;
        }
        else {
            alert("已取消操作");
        }
    }
    // 支付
    function gaiwei(id) {
        var mymessage = confirm("真的要确认支付吗？");
        if (mymessage == true) {
            http("liushui/gaiwei?ids="+id, "get", {}, (res) => {
                if(res.code == 0
        )
            {
                getDataList();
                alert('确认成功');
            }
        })
            ;
        }
        else {
            alert("已取消操作");
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
        http("liushui" + colName, "GET", {
            tableName: "liushui",
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
    function detail(odd) {
        window.sessionStorage.setItem("odd", odd);
        //window.sessionStorage.setItem("ifView", true);
        window.location.href = "../dingdanxiangqing/list.jsp";
    }

    //填充搜索下拉框
                     
            function sfTypesSelectSearch() {
                var sfTypesSelectSearch = document.getElementById('sfTypesSelectSearch');
                    sfTypesSelectSearch.add(new Option('请选择',''));
                for (var i = 0; i < sfTypesOptions.length; i++) {
                        sfTypesSelectSearch.add(new Option(sfTypesOptions[i].indexName,sfTypesOptions[i].codeIndex));
                }
            }
         


    //查询当前页面下所有列表
        function czTypesSelect() {
            //填充下拉框选项
            http("canzhuo/page?page=1&limit=100&sort=&order=&dicCode=cz_types", "GET", {}, (res) => {
                if(res.code == 0){
                    czTypesOptions = res.data.list;
            }
        });
        }
        function yhTypesSelect() {
            //填充下拉框选项
            http("yonghu/page?page=1&limit=100&sort=&order=&dicCode=yh_types", "GET", {}, (res) => {
                if(res.code == 0){
                    yhTypesOptions = res.data.list;
            }
        });
        }
        function sfTypesSelect() {
            //填充下拉框选项
            http("dictionary/page?page=1&limit=100&sort=&order=&dicCode=sf_types", "GET", {}, (res) => {
                if(res.code == 0){
                    sfTypesOptions = res.data.list;
            }
        });
        }
    //跨表
    function crossTable(id, crossTableName) {
        window.sessionStorage.setItem('crossTableId', id);
        window.sessionStorage.setItem('crossTableName', "liushui");
        var url = "../" + crossTableName + "/add-or-update.jsp";
        window.location.href = url;
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
        czTypesSelect();
        yhTypesSelect();
        sfTypesSelect();
        getDataList();


        //下拉框赋值
                                                             
            sfTypesSelectSearch();
                         

    <%@ include file="../../static/myInfo.js"%>
    });
</script>
</body>

</html>