package ssm.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import ssm.model.Permission;
import ssm.model.RolePer;

public interface BaseMapper<T> {
	
    int deleteByPrimaryKey(Integer id);

    int insert(T record);

    int insertSelective(T record);

    T selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(T record);

    int updateByPrimaryKey(T record);
    
    List<T> getAll(
       	@Param("search")String search,
       	@Param("offset")Integer offset,
       	@Param("limit")Integer limit,
       	@Param("sort")String sort,
       	@Param("order")String order,
       	@Param("params")Map<String, Object> params
    );
    
	List<RolePer> getrolePers(@Param("roleperid")String roleperid);
	
	int addrolePer(@Param("rid")String rid, @Param("pid")String pid);
	
	int delrolePer(@Param("rid")String rid, @Param("pid")String pid);
    
    int getCount(@Param("search")String search,@Param("params")Map<String, Object> params);
    
    int delete(List<String> ids);
    
    int addPer(Permission per);
    
    int EditPer(Permission per);
    
    
    int DelPer(@Param("id")String id);
    
	int setPerState(@Param("state")Integer state, @Param("val")Integer val);
	
	int getperstate(@Param("fid")String fid);
	
	int setPerstate(@Param("fid")String fid);
	
    int delurole(@Param("uid")String userid, @Param("uname")String roleid);
    
    int addurole(@Param("uid")String userid, @Param("uname")String username);
}
