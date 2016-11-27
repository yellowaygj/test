package ssm.controller;

import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

import ssm.model.Permission;
import ssm.model.Role;
import ssm.model.RolePer;


import ssm.service.IRoleService;

@Controller
@RequestMapping("/roleController")
public class RoleController {
	
	@Resource
	private IRoleService roleService;
	
	HttpSession session ; 
	
	@RequestMapping("role")
	public String role() {
		return "role";
	}
	
	@RequestMapping("list")
	@ResponseBody
	public String list(String search,Integer offset,Integer limit,String sort,String order,String filter) throws IOException {
		JSONObject jsonObject = new JSONObject(true);
		List<Role> role = roleService.getAll(search,offset,limit,sort,order,filter);
		Integer count = roleService.getCount(search,filter);			
		jsonObject.put("total", count);
		jsonObject.put("rows", role);
		return JSON.toJSONString(jsonObject);
	}
	
	
	
	@RequestMapping("rolepermissionlist")
	@ResponseBody
	public List<RolePer> rolepermissionlist(String userid) throws IOException {
		System.out.println("aaaaaaaaaaaaaaaaaazzzzzzzzzzzzzzzzzz:" + userid);
		List<RolePer> rolePers = roleService.getrolePers(userid);
		return rolePers;
	}
	
	@RequestMapping("addrolePer")
	@ResponseBody
	public int addrolePer(String uid, String rid) throws IOException {
		System.out.println("aaaaaaaaaaaaaaaaaazzzzzzzzzzzzzzzzzz:" + uid + rid);
		int res = roleService.addrolePer(uid, rid);
		return res;
	}
	
	@RequestMapping("delrolePer")
	@ResponseBody
	public int delrolePer(String uid, String rid) throws IOException {
		System.out.println("aaaaaaaaaaaaaaaaaazzzzzzzzzzzzzzzzzz:" + uid + rid);
		int res = roleService.delrolePer(uid, rid);
		return res;
	}
	
	@RequestMapping(value = "add", method = RequestMethod.POST)
	@ResponseBody
	public String add(@ModelAttribute("role") Role role)  throws IOException {
		JSONObject jsonObject = new JSONObject();
		int res =  roleService.add(role);
		try{
			if(res != 0){
				jsonObject.put("message", "success");
				jsonObject.put("status", "success");
			}else{
				jsonObject.put("message", "error");
				jsonObject.put("status", "error");
			}
        }catch(Exception ex){
        	jsonObject.put("message", ex.getMessage());
            jsonObject.put("status", "error");
        }		
		return jsonObject.toString();
	}	
	
	
	
	

	@RequestMapping(value = "del", method=RequestMethod.POST)
	@ResponseBody
	public String del(@RequestParam(value="ids") List<String> ids) throws IOException {	
		JSONObject jsonObject = new JSONObject();
		int res = roleService.delete(ids);
		try{
			if(res != 0){
				jsonObject.put("message", "success");
				jsonObject.put("status", "success");
			}else{
				jsonObject.put("message", "error");
				jsonObject.put("status", "error");
			}
        }catch(Exception ex){
        	jsonObject.put("message", ex.getMessage());
            jsonObject.put("status", "error");
        }		
		return jsonObject.toString();
	}
	
	@RequestMapping(value = "edit", method = RequestMethod.POST)
	@ResponseBody
	public String edit(@ModelAttribute("role") Role role)  throws IOException {
		JSONObject jsonObject = new JSONObject();
		int res =  roleService.updateByPrimaryKeySelective(role);
		try{
			if(res != 0){
				jsonObject.put("message", "success");
				jsonObject.put("status", "success");
			}else{
				jsonObject.put("message", "error");
				jsonObject.put("status", "error");
			}
        }catch(Exception ex){
        	jsonObject.put("message", ex.getMessage());
            jsonObject.put("status", "error");
        }		
		return jsonObject.toString();
	}	

	@RequestMapping(value = "addPer", method = RequestMethod.POST)
	@ResponseBody
	public int addPer(@ModelAttribute("Permission") Permission Per)  throws IOException {
		if(Per.getFlevel() != 0){
			roleService.setPerState(Per.getFlevel(), 1);	
			}
		int res =  roleService.addPer(Per);
		
		return res;
	}	
	
	
	@RequestMapping(value = "EditPer", method = RequestMethod.POST)
	@ResponseBody
	public int EditPer(@ModelAttribute("Permission") Permission Per)  throws IOException {
		
		int res =  roleService.EditPer(Per);
		
		return res;
	}	
	
	@RequestMapping(value = "DelPer", method = RequestMethod.POST)
	@ResponseBody
	public int DelPer(String rid, String flevel)  throws IOException {
		int getpers = roleService.getperstate(flevel);
		System.out.println("aaaaaaaaaaaaaaaaaazzzzzzzzzzzzzzzzzzgetpers:" + getpers);
		if (getpers==1) {
			roleService.setPerState(Integer.parseInt(flevel), 0);
		}

		int res =  roleService.DelPer(rid);
		
		return res;
	}	
	
}
