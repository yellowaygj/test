package ssm.controller;

import java.io.IOException;
import java.security.acl.Permission;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;



import ssm.model.Role;
import ssm.model.User;
import ssm.service.IUserService;

@Controller
@RequestMapping("/userController")
public class UserController {
	
	@Resource
	private IUserService userService;
	
	HttpSession session ; 
	
	@RequestMapping("index")
	public String index() {
		return "index";
	}
	
	@RequestMapping("index_v1")
	public String index_v1() {
		return "index_v1";
	}
	
	@RequestMapping("login")
	public String login() {
		return "login";
	}
	
	@RequestMapping("user")
	public String user() {
		return "user";
	}
	
	@RequestMapping("list")
	@ResponseBody
	public String list(String search,Integer offset,Integer limit,String sort,String order,String filter) throws IOException {
		JSONObject jsonObject = new JSONObject(true);
		List<User> user = userService.getAll(search,offset,limit,sort,order,filter);
		Integer count = userService.getCount(search,filter);			
		jsonObject.put("total", count);
		jsonObject.put("rows", user);
		return JSON.toJSONString(jsonObject);
	}
	
	@RequestMapping(value = "add", method = RequestMethod.POST)
	@ResponseBody
	public String add(@ModelAttribute("user") User user)  throws IOException {
		JSONObject jsonObject = new JSONObject();
		int res =  userService.add(user);
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
		int res = userService.delete(ids);
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
	
	
	@RequestMapping("deluserrole")
	@ResponseBody
	public String deluserrole(String userid, String roleid) throws IOException {	
		JSONObject jsonObject = new JSONObject();
		System.out.println("dddddddddddddddddddddddddddddddduserid:" + userid);
		System.out.println("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeusername:" + roleid);
		int res = userService.delurole(userid, roleid);
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
	

	
	@RequestMapping("addusersole")
	@ResponseBody
	public String addusersole(String userid, String roleid) throws IOException {	
		JSONObject jsonObject = new JSONObject();
		

		int res = userService.addurole(userid, roleid);
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
	public String edit(@ModelAttribute("user") User user)  throws IOException {
		JSONObject jsonObject = new JSONObject();
		int res =  userService.updateByPrimaryKeySelective(user);
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
	
	@RequestMapping("roleList")
	@ResponseBody
	public List<Role> roleList() throws IOException {
		//JSONObject jsonObject = new JSONObject(true);
		List<Role> userRole = userService.getRoleById();
		//Integer count = userService.getRoleCount();
		//jsonObject.put("total", userRole);
		//jsonObject.put("rows", count);
		System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" + userRole);
		//System.out.println("bbbbbbbbbbbbbbbbbbbbbbbbbbbb" + count);
		return userRole;
	}
	
	@RequestMapping("getRoleUser")
	@ResponseBody
	public String getRoleUser(String userid) throws IOException {
		JSONObject jsonObject = new JSONObject(true);

		List<User> userRole = userService.getRoleUser(userid);
		//Integer count = userService.getRoleCount();
		if(userRole.size() == 0)
			return "";
		jsonObject.put("userinfo", userRole);
		//jsonObject.put("rows", count);
		System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" + userRole);
		//System.out.println("bbbbbbbbbbbbbbbbbbbbbbbbbbbb" + count);
		return jsonObject.toString();
	}
	
	
	@RequestMapping("permissionlist")
	@ResponseBody
	public List<Permission> permissionlist() throws IOException {
		
		List<Permission> userRole = userService.getAllPerm();

		System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" + userRole);

		return userRole;
	}
	
//HttpServletRequest req,HttpServletResponse rep
	
	@RequestMapping("userole")
	@ResponseBody
	public String userole(String userid) throws IOException {
		JSONObject jsonObject = new JSONObject(true);
		List<Role> userRole  = userService.isrole(userid);
		//String userid =req.getParameter("uid");
		jsonObject.put("total", userRole);
		jsonObject.put("rows", userRole.size());
		return JSON.toJSONString(jsonObject);
	}
	
	
	
	@RequestMapping(value = "doLogin", method = RequestMethod.POST)
	@ResponseBody
	public String doLogin(@ModelAttribute("user") User user, HttpServletRequest req)  throws IOException {
		JSONObject jsonObject = new JSONObject();
		user = userService.Login(user);
		session = req.getSession();
		try{
			if(user!=null){
				session.setAttribute("user", user);
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

	
	@RequestMapping("signOut")
	public String signOut(HttpServletRequest req) {
		session = req.getSession();
		session.invalidate();
		return "login";
	}
	
//	@RequestMapping(value = "/showUser", method = RequestMethod.POST)
//	@ResponseBody
//	public void showUser(@RequestBody User user,HttpServletRequest req) {
//		System.out.println(user.getName());
//		System.out.println(user.getPwd());
//		User u = userService.getUserById(id);
//		req.setAttribute("user", u);
//		return "showUser";
//	}

	@RequestMapping(value = "/testRestful/{id}", method = { RequestMethod.GET })
	public String testRestfulGet(Integer id) {
		System.out.println("The value which the restful style url is GET :"
				+ id);
		return "success";
	}

	@RequestMapping(value = "/testRestful", method = { RequestMethod.POST })
	public String testRestfulPost(User user, HttpServletRequest req, HttpServletResponse resp) {
		System.out.println("The value which the restful style url is POST ");
		System.out.println(user.getName());
		return "success";
	}

	@RequestMapping(value = "/testRestful/{id}", method = { RequestMethod.DELETE })
	public String testRestfulDelete(Integer id) {
		System.out.println("The value which the restful style url is DELETE :"
				+ id);
		return "success";
	}

	@RequestMapping(value = "/testRestful/{id}", method = { RequestMethod.PUT })
	public String testRestfulPut(Integer id) {
		System.out.println("The value which the restful style url is PUT :"
				+ id);
		return "success";
	}

}
