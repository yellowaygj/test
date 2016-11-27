package ssm.service.impl;

import java.security.acl.Permission;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

import ssm.dao.UserMapper;
import ssm.model.Role;
import ssm.model.User;
import ssm.service.IUserService;

@Service("userService")
public class UserServiceImpl implements IUserService {
	
	@Resource
	private UserMapper userMapper;

	public User getUserById(Integer id) {
		return (User) userMapper.selectByPrimaryKey(id);
	}

	public List<User> getAll(String search,Integer offset,Integer limit,String sort,String order,String filter) {
		JSONObject obj = JSON.parseObject(filter);	
		Map<String,Object> params = new HashMap<String, Object>();
		if(obj != null){
			params.put("searchId", obj.get("id") != null ? obj.get("id").toString() : "" );
			params.put("searchName", obj.get("name") != null ? obj.get("name").toString() : "");
			params.put("searchNcikName", obj.get("nickname") != null ? obj.get("nickname").toString() : "");
			params.put("searchCreatetime", obj.get("createtime") != null ? obj.get("createtime").toString() : "");
		}
		return userMapper.getAll(search,offset,limit,sort,order,params);
	}

	public User Login(User user) {
		// TODO Auto-generated method stub
		return userMapper.Login(user);
	}

	public int add(User user) {
		// TODO Auto-generated method stub
		return userMapper.insertSelective(user);
	}

	public int delete(List<String> ids) {
		// TODO Auto-generated method stub
		return userMapper.delete(ids);
	}
	public int delurole(String userid, String roleid){
		return userMapper.delurole(userid, roleid);
		
	}
	
	public int addurole(String userid, String username){
		return userMapper.addurole(userid, username);
	}
	
	@Override
	public int updateByPrimaryKeySelective(User user) {
		// TODO Auto-generated method stub
		return userMapper.updateByPrimaryKeySelective(user);
	}

	@Override
	public int getCount(String search,String filter) {
		JSONObject obj = JSON.parseObject(filter);	
		Map<String,Object> params = new HashMap<String, Object>();
		if(obj != null){
			params.put("searchId", obj.get("id") != null ? obj.get("id").toString() : "" );
			params.put("searchName", obj.get("name") != null ? obj.get("name").toString() : "");
			params.put("searchNcikName", obj.get("nickname") != null ? obj.get("nickname").toString() : "");
			params.put("searchCreatetime", obj.get("createtime") != null ? obj.get("createtime").toString() : "");
		}
		return userMapper.getCount(search, params);
	}

	@Override
	public int getRoleCount() {
		return userMapper.getRoleCount();
	}

	
	@Override
	public List<Role> getRoleById() {
		return userMapper.getRoleById();
	}
	
	@Override
	public List<User> getRoleUser(String userid){
		return userMapper.getRoleUser(userid);
	}
	
	@Override
	public List<Permission> getAllPerm() {
		return userMapper.getAllPerm();
	}
	
	@Override
	public List<Role>  isrole(String uid){
		return userMapper.isrole(uid);
	}
	
}
