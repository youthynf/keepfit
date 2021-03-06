package com.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.CommonDao;
import com.service.UserService;
import com.entity.User;

@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	private CommonDao<User> commonDao; 

	@Override
	public void saveUser(User user) {
		this.commonDao.save(user);
	}
	
	@Override
	public void updateUser(User user) {
		this.commonDao.update(user);
	}

	@Override
	public void delUser(User user) {
		this.commonDao.delete(user);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<User> executeByHql(String hql) {
		return this.commonDao.executeByHql(hql);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<User> findUserByName(String userName) {
		return this.commonDao.findUserByName(userName);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<User> getAllUsers(String where_str) {
		return this.commonDao.getAllUsers(where_str);
	}
	
	@SuppressWarnings("unckecked")
	@Override
	public User getUserById(Integer id) {
		return this.commonDao.getUserById(id);
	}
}
