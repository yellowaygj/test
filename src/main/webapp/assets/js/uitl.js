 	


<script language="javascript">
 	//删除数组指定元素arr:数组   val:要删除的元素
	function removeByValue(arr, val) {
		  for(var i=0; i<arr.length; i++) {
		    if(arr[i] == val) {
		      arr.splice(i, 1);
		      break;
		    }
		  }
		}
		
 	
	//判断JSON数组长度
	function JSONLength(obj) {
		var size = 0, key;
		for (key in obj) {
			if (obj.hasOwnProperty(key))size++;
		}
		return size;
	};
	
 	
 	</script>