package com.dao;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import org.hibernate.Session;

import com.entity.User;

public interface CommonDao<T> {
	/**
	 * 存储对象
	 * @date	2018-6-19 下午5:06:07
	 * @author	live
	 * @param t
	 */
	public void save(T t);
	
	/**
	 * 删除对象
	 * @date	2018-6-28 上午11:42:53
	 * @author	live
	 * @param t
	 */
	public void delete(T t);
	
	/**
	 * 查询对象(根据类和主键id查询)
	 * @date	2018-6-28 上午11:48:22
	 * @author	live
	 * @param t
	 */
	public void query(T t, Integer id);
	
	/**
	 * 更新对象(根据对象的主键进行更新)
	 * @date	2018-6-28 上午11:51:53
	 * @author	live
	 * @param t
	 */
	public void update(T t);
	
	/**
	 * 执行SQL语句
	 * @date	2018-6-28 上午11:54:07
	 * @author	live
	 * @return
	 */
	public int executeBySql(String sql);
	
	/**
	 * 执行hql语句
	 * @date	2018-6-28 上午11:59:46
	 * @author	live
	 * @param hql
	 * @return
	 */
	public List executeByHql(String hql);
	
	
	/*********************************************************************************************分割线*********************************************************************************************/
	
	/**
	 * 存储或更新(根据主键判定)
	 * @date	2018-6-28 下午2:13:17
	 * @author	live
	 */
	public void saveOrUpdate(T t);
	
	public List<User> findUserByName(String userName);
	
	public List<User> getAllUsers(String where_str);
	
	public User getUserById(Integer id);
}
