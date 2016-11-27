<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<!DOCTYPE html>  
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<html lang="zh-cn">
<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> - 用户管理</title>
    <meta name="keywords" content="">
    <meta name="description" content="">  
    
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/favicon.ico"> 
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/assets/css/font-awesome.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/plugins/bootstrap-table/bootstrap-table.css" rel="stylesheet" type="text/css"> 
    <link href="${pageContext.request.contextPath}/assets/css/animate.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script> 
    <script src="${pageContext.request.contextPath}/assets/js/plugins/bootstrap-table/bootstrap-table.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/plugins/bootstrap-table/extensions/toolbar/bootstrap-table-toolbar.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/plugins/bootstrap-table/extensions/flat-json/bootstrap-table-flat-json.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/plugins/bootstrap-table/extensions/multiple-sort/bootstrap-table-multiple-sort.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.js"></script>
	
 	<script language="javascript">

		function addValidate() {
			var name = add_Form['addname'].value;
			var pwd = add_Form['addpwd'].value;
			var nickname = add_Form['addnickname'].value;
			if (name == "") {
				alert("用户名不能为空");
				return false;
			} else if (pwd == "") {
				alert("密码不能为空");
				return false;
			} else if (nickname == "") {
				alert("昵称不能为空");
				return false;
			} else {
				add(name, pwd, nickname);
			}
		}
		
		function add(name, pwd, nickname) {
			var data = {
				name : name,
				pwd : pwd,
				nickname : nickname
			};
			$.ajax({
				type : 'post',
				url : '${pageContext.request.contextPath}/userController/add',
				data : data,
				dataType : 'json',
				success : function(result) {
					if (result.status == "success") {
						$('#addModal').modal('hide');
						$('#table').bootstrapTable('refresh');
						add_Form['addname'].value = "";
						add_Form['addpwd'].value = "";
						add_Form['addnickname'].value = "";
					} else {
						return false;
					}
				}
			});
		}

		function editValidate() {
			var id = edit_Form['editid'].value;
			var name = edit_Form['editname'].value;
			var pwd = edit_Form['editpwd'].value;
			var nickname = edit_Form['editnickname'].value;
			if (name == "") {
				alert("用户名不能为空");
				return false;
			} else if (pwd == "") {
				alert("密码不能为空");
				return false;
			} else if (nickname == "") {
				alert("昵称不能为空");
				return false;
			} else {
				edit(id, name, pwd, nickname);
			}
		}
		
		function edit(id, name, pwd, nickname) {
			var data = {
				id : id,
				name : name,
				pwd : pwd,
				nickname : nickname
			};
			$.ajax({
				type : 'post',
				url : '${pageContext.request.contextPath}/userController/edit',
				data : data,
				dataType : 'json',
				success : function(result) {
					if (result.status == "success") {
						$('#editModal').modal('hide');
						$('#table').bootstrapTable('refresh');
						edit_Form['editid'].value = "";
						edit_Form['editname'].value = "";
						edit_Form['editpwd'].value = "";
						edit_Form['editnickname'].value = "";
					} else {
						return false;
					}
				}
			});
		}

		function paginationParam(params) {
			return {
				filter : params.filter,
				order : params.order,
				sort : params.sort,
				search : params.search,
				limit : params.limit,
				offset : params.offset,
			};
		}
		

	    
	</script>
</head>

<body class="gray-bg">
	<!-- 角色模态框 begin -->
	<div class="modal fade" id="roleModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">取消</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">所属角色</h4>
				</div>
				<div class="modal-body">
					<div id="roleToolbar" class="btn-group">
			            <button id="btn_add" type="button" class="btn btn-default" onclick="edituserrole()" >
			                <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>保存
			            </button>

   					</div>
   						
					<table id="roleTable" class="table table-bordered table-striped" style="font-size: 12px;"  >
            			
        			</table>
<script type="text/javascript">
        				            	
            
        			function initRoleTable() {
	        			$('#roleTable').bootstrapTable({				
							cache: false,
							
							method : 'post',
							dataType : 'json',
							striped : true,
							pagination : true, //在表格底部显示分页工具栏
							pageSize :5,
							pageList : [ 5, 10 ],
							uniqueId: "roles.id",
							paginationFirstText : "首页",
			            	paginationPreText : "上一页",
			           	 	paginationNextText : "下一页",
							paginationLastText : "尾页",
							sortable: true,
							sortorder: 'asc',
							showRefresh : true, //显示刷新按钮
							search : false,//是否显示右上角的搜索框
							clickToSelect : true,//点击行即可选中单选/复选框
							maintainselected : true,
							//sidePagination : "server",//表格分页的位置
							//queryParams : getPatientId, //参数
							
							toolbar : "#roleToolbar", //设置工具栏的Id或者class
							//advancedSearch : true,
							//idTable : "advancedTable",
							
							columns: [{
						    	checkbox: true,
						    	formatter:stateFormatter
						    }, {
						   		field: 'roles.id',
						    	title: '编号',
						    	sortable : true
						    },{
						   		field: 'roles.name',
						    	title: '名称',
						    	sortable : true
						    }]
						    
		             	});		
		             	//$('#roleTable').bootstrapTable('hideColumn', 'roles.userid');
						userroleid = $table.bootstrapTable('getAllSelections')[0].id;
						isrolestaic(userroleid);
							
		             	
					}	
					
					
				
					//返回用户拥有角色 
					function isrolestaic(row){
						$.ajax({
									type : 'post',
									url : '${pageContext.request.contextPath}/userController/userole',
									data : {userid:row},
									success : function(result) {
										var rolejson = eval('('+result+')');
										//从后台获取用户有的角色
										rolearray = new Array();
										//复选框选中的角色
										selectrolearray = new Array();
										for(i = 0; i<rolejson.rows; i++){
											rolearray.push(rolejson.total[i].id);
											selectrolearray.push(rolejson.total[i].id);
											}
								
									}
							});
					}
					
					//判断是否是用户已有角色
					function isuserrole(num){
					//console.log(rolearray.length);
						for(i = 0; i<rolearray.length; i++){
						//rolejson.total[i].id == num || 
							if(selectrolearray.indexOf(num) != -1){
								return true;
								}
							}
						return false;
					}
					
					//check框状态捕获
					function stateFormatter(value, row, index) {
						//console.log(row.id);
						
						//console.log(rowindex);
						if(isuserrole(row.id)){
						return	{checked: true};	
						}
						else{
						return	{checked: false};		
						}
							
    				}
    				
    				//删除数组指定元素 
					function removeByValue(arr, val) {
					  for(var i=0; i<arr.length; i++) {
					    if(arr[i] == val) {
					      arr.splice(i, 1);
					      break;
					    }
					  }
					}
    				
    				
    				//删除角色
    				function deluserrole(num){
    					var data = {userid: userroleid,
									roleid: num};
    					$.ajax({
							type : 'post',
							url : '${pageContext.request.contextPath}/userController/deluserrole',
							data : data,
							success : function(result) {
								removeByValue(rolearray, num);
							}
						});
						
						console.log("删除" + num);
    				
    				}
    				//增加角色
    				function addusersole(num){
    					var data = {userid:userroleid,
									roleid: num};
						
    					$.ajax({
							type : 'post',
							url : '${pageContext.request.contextPath}/userController/addusersole',
							data : data,
							success : function(result) {
								rolearray.push(num);
							}
						});
						
						console.log("添加" + num);
    				}
    				
    				//修改用户角色
    				function edituserrole(){
	    				//遍历添加
						for(i = 0; i < selectrolearray.length; i++) {
						console.log("遍历开始selectrolearray" + selectrolearray);
							if(rolearray.length == 0){
								addusersole(selectrolearray[i]);
							}else if(rolearray.indexOf(selectrolearray[i]) == -1){
							console.log("else if 过程 selectrolearray[i]" + selectrolearray[i]);
		         				addusersole(selectrolearray[i]);
	         				}
	         				console.log("什么都不做，没变更:"); 	
						}
						
						//遍历删除
						for(i=0; i<rolearray.length; i++) {
							if(selectrolearray.indexOf(rolearray[i]) == -1 ){
								console.log("删除的时候selectrolearray:" + selectrolearray[i]);
	         				 	deluserrole(rolearray[i]);	
							}
						}
						$('#roleTable').bootstrapTable('refresh');
						console.log("刷新后selectrolearray:" + selectrolearray);
						
    				}
    				
    				
    				//单击事件
    				$('#roleTable').on('check.bs.table', function(e, row) {
    					 selectrolearray.push(row.id);
    					console.log("row.id:" + row.id);
    				});
    				
    				$('#roleTable').on('uncheck.bs.table', function(e, row) {
    					removeByValue(selectrolearray, row.id);
    					
    				});
    				
    				$('#roleTable').on('check-all.bs.table', function(e, rows) {
			             for(var i=0;i<rows.length;i++){
			             	selectrolearray.push(rows[i].id);
			                }         
			            
			         });
			         $('#roleTable').on('uncheck-all.bs.table', function(e, rows) {
			               for(var i=0;i<rows.length;i++){
			                   removeByValue(selectrolearray, rows[i].id);
			                   }
			            
			          });
    				
					
	</script>
        			
</div>
				
        								
        
				
				
		</div>				
			</div>	
			</div>
				
				
				
				
				
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>取消</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 角色模态框 end -->		
	
	<!-- 添加模态框 begin -->
	<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">取消</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">新增用户</h4>
				</div>
				<div class="modal-body">
				
				<form id="add_Form" role="form" class="form-horizontal m-t">
				
					<div class="form-group">
						<label class="col-sm-3 control-label">用户名：</label>
						<div class="col-sm-8">
							<input id="addname" name="name" class="form-control"
								type="text" aria-required="true" aria-invalid="true">
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label">密码：</label>
						<div class="col-sm-8">
							<input id="addpwd" name="pwd" class="form-control"
								type="text">
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label">昵称：</label>
						<div class="col-sm-8">
							<input id="addnickname" name="nickname" class="form-control"
								type="text" aria-required="true" aria-invalid="true">
						</div>
					</div>
				</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>取消</button>
					<button type="button" class="btn btn-primary" onclick="addValidate()"><span class="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span>保存</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 添加模态框end -->
	
	<!-- 编辑模态框 begin -->
	<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">取消</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">修改用户</h4>
				</div>
				<div class="modal-body">
				
				<form id="edit_Form" role="form" class="form-horizontal m-t">
				<input id="editid" name="id" type="hidden">
					<div class="form-group">
						<label class="col-sm-3 control-label">用户名：</label>
						<div class="col-sm-8">
							<input id="editname" name="name" class="form-control"
								type="text" aria-required="true" aria-invalid="true">
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label">密码：</label>
						<div class="col-sm-8">
							<input id="editpwd" name="pwd" class="form-control"
								type="text">
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label">昵称：</label>
						<div class="col-sm-8">
							<input id="editnickname" name="nickname" class="form-control"
								type="text" aria-required="true" aria-invalid="true">
						</div>
					</div>
				</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>取消</button>
					<button type="button" class="btn btn-primary" onclick="editValidate()"><span class="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span>修改</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 编辑模态框 end -->
	
	<!-- 用户信息 begin -->
	<div class="container">
	
        <h1></h1>
		
        <div id="toolbar" class="btn-group">
            <button id="btn_role" type="button" class="btn btn-default">
                <span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>查看所属角色
            </button>
            <button id="btn_add" type="button" class="btn btn-default" data-toggle="modal" data-target="#addModal">
                <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
            </button>
            <button id="btn_edit" type="button" class="btn btn-default" data-toggle="modal">
                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改
            </button>
            <button id="btn_delete" type="button" class="btn btn-default" onclick="getIdSelections()">
                <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>删除
            </button>
        </div>
       
        <table id="table" class="table table-bordered table-striped" style="font-size: 12px;">
            
        </table>
        
        <script type="text/javascript">
        
       		$(document).ready(function () { 
       			initTable(); 
       		});
       		
			function initTable() {
				$('#table').bootstrapTable({				
					cache: false,
					method : 'get',
					url : '${pageContext.request.contextPath}/userController/list',
					dataType : 'json',
					striped : true,
					uniqueId: "id",
					pagination : true, //在表格底部显示分页工具栏
					pageSize : 20,
					pageNumber : 1,
					pageList : [ 10, 20, 'ALL' ],
					paginationFirstText : "首页",
	            	paginationPreText : "上一页",
	           	 	paginationNextText : "下一页",
					paginationLastText : "尾页",
					sortable: true,
					showColumns : true, //显示隐藏列 
					showRefresh : true, //显示刷新按钮
					search : true,//是否显示右上角的搜索框
					clickToSelect : true,//点击行即可选中单选/复选框
					sidePagination : "server",//表格分页的位置
					queryParams : paginationParam, //参数
					toolbar : "#toolbar", //设置工具栏的Id或者class
					advancedSearch : true,
					idTable : "advancedTable",
					
					columns: [{
				    	checkbox: true
				    }, {
				    	field: 'id',
				    	title: '编号',
				    	sortable : true
				    }, {
				   		field: 'name',
				    	title: '账号',
				    	sortable : true
				    }, {
				    	field: 'nickname',
				    	title: '昵称',
				    	sortable : true
				    }, {
				    	field: 'createtime',
				    	title: '创建时间',
				    	sortable : true
				    }/* ,{
                    	title: '操作',
                      	align: 'center',
                      	formatter:function(value,row,index){  
                   			var e = '<a href="#" mce_href="#" onclick="edit(\''+ row.id + '\')" title="编辑"><i class="glyphicon glyphicon-edit" aria-hidden="true"></i></a> ';  
                   			var d = '<a href="#" mce_href="#" onclick="getIdSelections()" title="删除"><i class="glyphicon glyphicon-trash" aria-hidden="true"></i></a> ';  
                        	return e+d;  
                    	} 
                  	} */]
				});			
			}
		</script>     
    </div>
	<!-- 用户信息 end -->

	
	<script>
	/* 点击删除获取ids */
	var $table = $('#table');
	function getIdSelections() {
		var strIds = [];
        $.map($table.bootstrapTable('getSelections'), function(row) {
			strIds.push(row.id);
        });
        var ids = strIds.join(",");
        if(ids==""){
        	alert("您还未选中值，请选择！");
        }else{
	    	$.ajax({
				type : 'post',
				url : '${pageContext.request.contextPath}/userController/del',
				data : {ids : ids},
				dataType : 'json',
				success : function(result) {
					if (result.status == "success") {		
						$('#table').bootstrapTable('refresh',{url:"${pageContext.request.contextPath}/userController/list"});
					} else {          
						return false;
					}
				}
			});
		}
    } 

	/* 点击编辑按钮触发事件 */

	var $btn_edit = $('#btn_edit');
    $(function () {
        $btn_edit.click(function () {
        	var size = JSONLength($table.bootstrapTable('getAllSelections'));
            if(size == 0){
           		alert("您还未选中值，请选择！");
            }else if(size > 1){
            	alert("请选择一条数据！");
            }else{
            	$('#editModal').modal('show');
            	edit_Form['editid'].value = $table.bootstrapTable('getAllSelections')[0].id;
            	edit_Form['editname'].value = $table.bootstrapTable('getAllSelections')[0].name;
            	edit_Form['editpwd'].value = $table.bootstrapTable('getAllSelections')[0].pwd;
            	edit_Form['editnickname'].value = $table.bootstrapTable('getAllSelections')[0].nickname;
            }
        });
    });
    
    
    var $btn_role = $('#btn_role');
    $(function () {
        $btn_role.click(function () {
			var size = JSONLength($table.bootstrapTable('getAllSelections'));
            if(size == 0){
           		alert("您还未选中值，请选择！");
            }else if(size > 1){
            	alert("请选择一条数据！");
            }else{	
            	$('#roleModal').modal('show');
            	initRoleTable(); 
				$('#roleTable').bootstrapTable('refresh',{url:"${pageContext.request.contextPath}/userController/roleList"});
            }//${pageContext.request.contextPath}/userController/roleList    ${pageContext.request.contextPath}/assets/json/data6.json
        });
    });

	function JSONLength(obj) {
		var size = 0, key;
		for (key in obj) {
			if (obj.hasOwnProperty(key))size++;
		}
		return size;
	};
	
	
	
	</script>
</body>

</html>
