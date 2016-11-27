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
    <title> - 角色管理</title>
    <meta name="keywords" content="">
    <meta name="description" content="">  

     
     
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/assets/css/plugins/treeview/bootstrap-treeview.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script> 

	<script src="${pageContext.request.contextPath}/assets/js/plugins/treeview/bootstrap-treeview.js"></script>  
	
<style type="text/css">
#tip_message {  
    z-index: 9999;  
    position: fixed;  
    left: 0;  
    top: 40%;  
    text-align: center;  
    width: 100%;  
}  
  
#tip_message span {  
    background-color: #03C440;  
    opacity: .8;  
    padding: 20px 50px;  
    border-radius: 5px;  
    text-align: center;  
    color: #fff;  
    font-size: 20px;  
}  
  
#tip_message span.error {  
    background-color: #EAA000;  
} 
</style>	



	

	
 	
</head>
 <script type="text/javascript">
 
 
 		
	                
 //获取数组最大值
	Array.max = function( array ){ 
		return Math.max.apply( Math, array 
		);
	};
	
	
	function removeByValue(arr, val) {
		  for(var i=0; i<arr.length; i++) {
		    if(arr[i] == val) {
		      arr.splice(i, 1);
		      break;
		    }
		  }
		}

	
var childTrigger = false; 

var userid;
var messageState = true;
    $(function () {
    //getPermission();
	
    
    
    
            $.ajax({  
                 	type : 'post',
					url : '${pageContext.request.contextPath}/userController/roleList',
					success : function(result) {						
						var treeData ="{text: '角色用户',nodes: [";
						for(var i = 1; i<result.length; i++){	
							treeData = treeData + "{ nodeid: '" + result[i].id + "',text:'" + result[i].name + "'},";	
						}    
						treeData = treeData + "]}";
						var temp=eval('('+treeData+')');
						inittree([temp]);             
                  }  
               });  

        	function inittree(tree){
    		 var $checkableTree = $('#roletree').treeview({
	    		  data: tree,  
	    		  //levels: 5,
	              //multiSelect: false,
	             // icon: "glyphicon glyphicon-stop",
				  //selectedIcon: "glyphicon glyphicon-stop",
				  color: "#000000",
				  backColor: "#FFFFFF",
				  
				  //selectable: true,
				  //showCheckbox: true,	 
				   onNodeUnselected: function(event, node) {
				  $('#Permtree').treeview('uncheckAll', { silent: true });
				  	//console.log("取消选中:" + data.text);
				  	userid = "";
				  },
				  onNodeSelected: function(event, data) {
				  	userid = data.nodeid;
  					console.log("data:" + data.text);
  					$('#Permtree').treeview('uncheckAll', { silent: true });
		
  					setRoleNode();
  					setUserRole();
  					 //$('#Permtree').treeview('checkNode', [ 5, { silent: true } ]); 选中check
  
				  }
				 
	    		 });
    		 }
    	

    
 		$.ajax({  
        	type : 'post',
			url : '${pageContext.request.contextPath}/userController/permissionlist',
			success : function(data) {
				permissionlistlength = data.length;
				result = data;
				treeData ="{ nodeid: '" + result[0].id + "',text:'" + result[0].name + "', tag:'" +  result[0].describe + "', url:'" + result[0].url + "', level:'" +  result[0].state + "', flevel:'" + result[0].flevel + "', nodes: [";
				treeData = treeData + allnode(0);
				treeData=eval('['+treeData+']');       
				initPermtree(treeData);
				}
                    
       		}); 
       		//递归出来的值 我复制放这个 
       		
 			  function allnode(index){
					var tempValue = new Array();
					for(var row = 1; row<result.length; row++){
						if(result[row].flevel == index && result[row].state == 0){
							tempValue = tempValue + "{ nodeid: '" + result[row].id + "',text:'" + result[row].name + "', tag:'" +  result[row].describe + "', url:'" + result[row].url + "', level:'" +  result[row].state + "', flevel:'" + result[row].flevel + "'}," ;
						}else if(result[row].flevel == index && result[row].state == 1){
							tempValue = tempValue + "{ nodeid: '" + result[row].id + "',text:'" + result[row].name + "', tag:'" +  result[row].describe + "', url:'" + result[row].url + "', level:'" +  result[row].state + "', flevel:'" + result[row].flevel + "', nodes: [";
							tempValue = tempValue + allnode(result[row].id);
						}
			
					}
					return tempValue + "]},";
				}

			var selectPet;
        	function initPermtree(tree){
    		 var $PermtreeTree = $('#Permtree').treeview({

	    		  data: tree,  
	    		  levels:4,
	    		  //showTags: true,

	              //multiSelect: true,
	              showCheckbox : true,
	              onNodeSelected: function(event, data) {
					console.log("单击的值" + data.nodeid);
					
						},
						
	              onNodeChecked: function(e, node) {
	              	console.log(node);
					messageState = false;
	              	//添加权限
	              	var nodenum = $('#roletree').treeview('getSelected');
					if(nodenum == 0){
					//ShowErrorMessage("请先选择用户", 2000);
					
			 			$('#Permtree').treeview('uncheckAll', { silent: true });
			 			alert("请选择角色");
					 return;
					}
					//添加角色 靠这个id
	             	addrolePer(node.nodeid);
				  	var that = $(this);
					var children = node.nodes;
					if (children != undefined) {
					$.each(node.nodes, function(i, child) {
						that.treeview('checkNode', [child.nodeId]);
					  });
				    }

					var siblings = that.treeview('getSiblings', node);
					console.log("siblings:" + siblings);
					var boolCheckAll = true;
					if (siblings != undefined) {
							$.each(siblings, function(i, child) {
						if (!child.state.checked) {
							boolCheckAll = false;
							}
						  });
						}
						var parentId = node.parentId;
						if (boolCheckAll && parentId != undefined) {
						console.log("选全部");
						messageState = true;
							that.treeview('checkNode', [parentId]);
						  }
					},
				
				//取消勾选事件
					onNodeUnchecked: function(e, node) {
						var that = $(this);
						var nodenum = $('#roletree').treeview('getSelected');
						if(nodenum == 0) return;
						delrolePer(node.nodeid);
						//作为父节点：取消勾选时，同时取消勾选所有子节点
						var children = node.nodes;
						if (children != undefined && !childTrigger) {
						console.log("选全部123: " + childTrigger);
						$.each(children, function (i, child) {
						that.treeview('uncheckNode', [child.nodeId]);
						});
						}
						
						//作为子节点：取消勾选时，同时取消勾选父节点
						var parentId = node.parentId;
						if (parentId != undefined) {
						console.log("选yige: " + childTrigger);
						childTrigger = true;
						that.treeview('uncheckNode', [parentId]);
						childTrigger = false;
						}
						}
					
					
				  
					 
	    		 });
    		 }




	 });	
	 

		function setRoleNode(){
		var name =Number(userid);
		console.log("name:" + name);
			  $.ajax({  
                 	type : 'post',
                 	data : {userid},
					url : '${pageContext.request.contextPath}/roleController/rolepermissionlist',
					success : function(result) {
       					if(result.length == 0) return;
       					var roledata = new Array();
       					//用户新的添加or删除的只能数组
       					addperrole = new Array();
       					for(var i = 0; i<result.length; i++){
       							roledata.push(result[i].pid);
       					}
       					addperrole = roledata;
  						for(var i = 1; i<=permissionlistlength; i++){
  							var ta = $('#Permtree').treeview('getNode', i);
  							if(roledata.indexOf(Number(ta.nodeid)) != -1){
  	
  								$('#Permtree').treeview('checkNode', [ i, { silent: true} ]);
  								
  								};
  							
  						};
       					 
                  }
               });  
		} 

  


     

	//添加
	function addrolePer(rid){
		
		var datalist = {
			uid:userid,
			rid:rid,
			};
			
		$.ajax({  
          type : 'post',
          data : datalist,
		  url : '${pageContext.request.contextPath}/roleController/addrolePer',
		  success : function(result) {

			}
		});
	
	}
 
	function delrolePer(rid){
		var datalist = {
			uid:userid,
			rid:rid,
			};
			
		$.ajax({  
          type : 'post',
          data : datalist,
		  url : '${pageContext.request.contextPath}/roleController/delrolePer',
		  success : function(result) {

					
			}
		});
	
	}

	function setUserRole(){
			
		$.ajax({  
          type : 'post',
          data : {userid},
		  url : '${pageContext.request.contextPath}/userController/getRoleUser',
		  success : function(result) {
		 	 var text = "拥有该角色用户信息:\r\n";	
				if(result.length == 0){
					document.getElementById("userrole").value = text;
					return;
					}

				var rolejson = eval('('+result+')');
	
				for(var i = 0; i<rolejson.userinfo.length; i++){
					text = text + "用户名:" + rolejson.userinfo[i].name + "\r\n";
					console.log("rolejson.userinfo[i].name" + text);
					}
					document.getElementById("userrole").value = text;
					
			}
		});
	}

	function addPerinfo(){
		var nodenum = $('#Permtree').treeview('getSelected');
		if(nodenum == 0) return;
		add_Form['addname'].value = "";
		add_Form['adddesc'].value = "";
		add_Form['addnurl'].value = "";
		$('#addModal').modal('show');
		document.getElementById("myModalLabel").innerHTML = "新增职能";
		
		//console.log("nodenum111111111111" + document.getElementById("myModalLabel").innerHTML);
		//console.log("nodenum" + nodenum[0].nodeid);
	}


	function addValidate(){
		var name = add_Form['addname'].value;
		var describe = add_Form['adddesc'].value;
		var url = add_Form['addnurl'].value;
		var nodenum = $('#Permtree').treeview('getSelected');
		if (name == "") {
			alert("用户名不能为空");
			return false;
		} else if (describe == "") {
			alert("描述不能为空");
			return false;
		} else if (url == "") {
			alert("地址不能为空");
			return false;
		} else if(document.getElementById("myModalLabel").innerHTML == "新增职能"){
			addPer(name, describe, url, nodenum[0].nodeid);
		}else{
			EditPerClick(name, describe, url, nodenum[0].nodeid);
		};
		
}

	
	function addPer(name, describe, url, flevel) {
			var data = {
				name : name,
				describe : describe,
				url : url,
				flevel : flevel
			};
			$.ajax({
				type : 'post',
				url : '${pageContext.request.contextPath}/roleController/addPer',
				data : data,
				dataType : 'json',
				success : function(result) {
					$('#addModal').modal('hide');
					add_Form['addname'].value = "";
					add_Form['adddesc'].value = "";
					add_Form['addnurl'].value = "";
					location.reload();
				}
			});
		}
	
	
	
	function EditPerClick(name, describe, url, id) {
			var data = {
				name : name,
				describe : describe,
				url : url,
				id : id
			};
			$.ajax({
				type : 'post',
				url : '${pageContext.request.contextPath}/roleController/EditPer',
				data : data,
				dataType : 'json',
				success : function(result) {
					$('#addModal').modal('hide');
					add_Form['addname'].value = "";
					add_Form['adddesc'].value = "";
					add_Form['addnurl'].value = "";
					location.reload();
					

				}
			});
		}
	
	
	function EditPer(){
		var nodenum = $('#Permtree').treeview('getSelected');
		if(nodenum == 0) return;
		add_Form['addname'].value = nodenum[0].text;
		add_Form['adddesc'].value = nodenum[0].tag;
		add_Form['addnurl'].value = nodenum[0].url;
		document.getElementById("myModalLabel").innerHTML = "修改职能";
		$('#addModal').modal('show');
	}
 
 	//删除职能
 	function DelPer(){
 		var nodenum = $('#Permtree').treeview('getSelected');
		if(nodenum == 0) return;
		 
		var data = {rid : Number(nodenum[0].nodeid),flevel:Number(nodenum[0].flevel),};
		console.log("nodenum[0].flevel" + nodenum[0].flevel);
		//var tax = $('#Permtree').treeview('getParent', Number(nodenum[0].nodeid));
		 	$.ajax({
				type : 'post',
				url : '${pageContext.request.contextPath}/roleController/DelPer',
				data : data,
				success : function(result) {
					location.reload();
					console.log("aaa");
					

				}
			});   
 	}
 	
 	
 	ShowSuccessMessage = function(message, life) {
 		if(messageState == false)return;
 		console.log("进来了");
 		//messageState = false;
        var time = 5000;  
        if (!life) {  
            time = life;  
        }  
          
        if ($("#tip_message").text().length > 0) {  
            var msg = "<span>" + message + "</span>";  
            $("#tip_message").empty().append(msg);  
        } else {  
            var msg = "<div id='tip_message'><span>" + message + "</span></div>";  
            $("body").append(msg);  
        }  
          
        $("#tip_message").fadeIn(time);  
    
        setTimeout($("#tip_message").fadeOut(2500, setmessage()), 2000);  
      
  
    };  
      
      function setmessage(){
      	messageState = true;
      }
    //提示错误信息  
    ShowErrorMessage = function(message, life) {  
        ShowSuccessMessage(message, life);  
        $("#tip_message span").addClass("error");  
    };  
 	
</script>

<body >
<div class="container" style="width:100%, text-align:center">



<!-- 添加模态框 begin -->
	<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">取消</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">新增职能</h4>
				</div>
				<div class="modal-body">
				
				<form id="add_Form" role="form" class="form-horizontal m-t">
				
					<div class="form-group">
						<label class="col-sm-3 control-label">名称：</label>
						<div class="col-sm-8">
							<input id="addname" name="name" class="form-control"
								type="text" aria-required="true" aria-invalid="true">
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label">描述：</label>
						<div class="col-sm-8">
							<input id="adddesc" name="desc" class="form-control"
								type="text">
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label">管理地址(url)：</label>
						<div class="col-sm-8">
							<input id="addnurl" name="url" class="form-control"
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
     
     <div id="divbox">  <center>   <h1 >    </h1>   </center> 
     		
            </div>
          <h1 >  </h1>  
<div >
	<div id="roletree"class="col-xs-3"></div>
	<div class="col-xs-4">
	
<center>
            <button id="btn_add" type="button" class="btn btn-default"   onclick="addPerinfo()">
                <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
            </button>
            <button id="btn_edit" type="button" class="btn btn-default" onclick="EditPer()" >
                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改
            </button> 
              <button id="btn_delete" type="button" class="btn btn-default" onclick="DelPer()">
                <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>删除
            </button>
            <h1 >      </h1>    
           
            </center>
         
                <div id="Permtree"  ></div>
              
              </div>
	
	 <div class="col-xs-3" ><textarea id="userrole" class="form-control"  readOnly = "true"  style= "resize: none;height: 300px;">属于该角色用户信息:</textarea>
	</div>
	</div>
</body>

</html>
