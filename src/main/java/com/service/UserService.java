package com.service;

import java.util.List;

import com.entity.User;

public interface UserService {
	/**
	 * 新增用户
	 * @date	2018-6-19 下午5:13:45
	 * @author	live
	 * @param user
	 */
	public void saveUser(User user);
	
	/**
	 * 更新用户
	 * @param user
	 */
	public void updateUser(User user);
	
	/**
	 * 删除用户
	 * @date	2018-6-28 上午11:44:14
	 * @author	live
	 * @param user
	 */
	public void delUser(User user);
	
	/**
	 * 执行hql
	 * @date	2018-6-28 下午12:03:54
	 * @author	live
	 * @param hql
	 * @return
	 */
	public List<User> executeByHql(String hql);
	
	/**
	 * 通过用户名查询用户信息
	 * @param userName
	 * @return
	 */
	public List<User> findUserByName(String userName);
	
	/**
	 * 获取所有会员列表
	 * @return
	 */
	public List<User> getAllUsers(String where_str);
	
	/**
	 * 通过id查询用户
	 * @param user
	 * @param id
	 * @return
	 */
	public User getUserById(Integer id);
}
