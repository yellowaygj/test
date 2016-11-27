package ssm.dao;

import java.security.acl.Permission;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import ssm.model.Role;
import ssm.model.User;

@Repository
public interface UserMapper extends BaseMapper<User>{
//    int deleteByPrimaryKey(Integer id);
//
//    int insert(User record);
//
//    int insertSelective(User record);
//
//    User selectByPrimaryKey(Integer id);
//
//    int updateByPrimaryKeySelective(User record);
//
//    int updateByPrimaryKey(User record);
    
    List<Role> getRoleById();
    
    List<Permission> getAllPerm();
    
   List<User> getRoleUser(@Param("userid")String userid);
    
    User Login(User user);

    
    List<Role> isrole(@Param("userid")String uid);
    
    int getRoleCount();
    
}