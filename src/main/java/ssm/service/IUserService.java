package ssm.service;

import java.security.acl.Permission;
import java.util.List;

import ssm.model.Role;
import ssm.model.User;

public interface IUserService {
	
	public User getUserById(Integer id);
	
	public List<User> getAll(String search,Integer offset,Integer limit,String sort,String order,String filter);
	
    int getCount(String search,String filter);
    
    int getRoleCount();
    
	public int add(User user);
	
	public int delete(List<String> ids);
	
	public int delurole(String userid, String roleid);
	
	public int addurole(String userid, String username);
	
    int updateByPrimaryKeySelective(User user);
	
	public User Login(User user);
    
    List<Role> getRoleById();
    List<User> getRoleUser(String userid);
    List<Permission> getAllPerm();
    List<Role>  isrole(String uid);
    
}
