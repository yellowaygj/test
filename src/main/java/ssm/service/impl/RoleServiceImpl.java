package ssm.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

import ssm.dao.RoleMapper;
import ssm.model.Permission;
import ssm.model.Role;
import ssm.model.RolePer;
import ssm.service.IRoleService;

@Service("Roleservice")
public class RoleServiceImpl implements IRoleService {

	@Resource
	RoleMapper roleMapper;

	@Override
	public List<Role> getAll(String search, Integer offset, Integer limit,String sort, String order, String filter) {
		JSONObject obj = JSON.parseObject(filter);	
		Map<String,Object> params = new HashMap<String, Object>();
		if(obj != null){
			params.put("searchId", obj.get("id") != null ? obj.get("id").toString() : "" );
			params.put("searchName", obj.get("name") != null ? obj.get("name").toString() : "");
			params.put("searchNcikName", obj.get("nickname") != null ? obj.get("nickname").toString() : "");
			params.put("searchCreatetime", obj.get("createtime") != null ? obj.get("createtime").toString() : "");
		}
		return roleMapper.getAll(search,offset,limit,sort,order,params);
	}

	
	@Override
	public List<RolePer> getrolePers(String roleperid){
		return roleMapper.getrolePers(roleperid);
	}
	
	@Override
	public int addrolePer(String rid, String pid){
		return roleMapper.addrolePer(rid, pid);
	}
	
	@Override
	public int delrolePer(String rid, String pid){
		return roleMapper.delrolePer(rid, pid);
	}
	@Override
	public int getCount(String search, String filter) {
		JSONObject obj = JSON.parseObject(filter);	
		Map<String,Object> params = new HashMap<String, Object>();
		if(obj != null){
			params.put("searchId", obj.get("id") != null ? obj.get("id").toString() : "" );
			params.put("searchName", obj.get("name") != null ? obj.get("name").toString() : "");
			params.put("searchNcikName", obj.get("nickname") != null ? obj.get("nickname").toString() : "");
			params.put("searchCreatetime", obj.get("createtime") != null ? obj.get("createtime").toString() : "");
		}
		return roleMapper.getCount(search, params);
	}

	@Override
	public int add(Role role) {
		// TODO Auto-generated method stub
		return roleMapper.insertSelective(role);
	}
	
	
	public int addPer(Permission per) {
		// TODO Auto-generated method stub
		return roleMapper.addPer(per);
	}
	
	

	public int EditPer(Permission per) {
		// TODO Auto-generated method stub
		return roleMapper.EditPer(per);
	}
	
	public int DelPer(String id){
		return roleMapper.DelPer(id);
	}
	
	
	public int setPerState(Integer state, Integer val){
		return roleMapper.setPerState(state, val);
	}
	
	public int getperstate(String fid){
		return roleMapper.getperstate(fid);
	}
	

	
	public int delete(List<String> ids) {
		// TODO Auto-generated method stub
		return roleMapper.delete(ids);
	}

	@Override
	public int updateByPrimaryKeySelective(Role role) {
		// TODO Auto-generated method stub
		return roleMapper.updateByPrimaryKeySelective(role);
	}
	
}
