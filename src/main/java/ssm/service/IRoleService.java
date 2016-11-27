package ssm.service;

import java.util.List;

import ssm.model.Permission;
import ssm.model.Role;
import ssm.model.RolePer;

public interface IRoleService {
	
//	public Role getByRoleId(Integer id);
//	
//	public void Add(Role role);
	
	public List<Role> getAll(String search,Integer offset,Integer limit,String sort,String order,String filter);
	
	public List<RolePer> getrolePers(String roleperid);
	
	public int delrolePer(String rid, String pid);
	
	public int addrolePer(String rid, String pid);

    int getCount(String search,String filter);

	public int add(Role role);
	
	public int delete(List<String> ids);
	
    int updateByPrimaryKeySelective(Role role);

	public int addPer(Permission per);
	
	public int EditPer(Permission per);
	
	public int DelPer(String id);
	
	public int getperstate(String fid);
	
	
	public int setPerState(Integer state, Integer val);
}
