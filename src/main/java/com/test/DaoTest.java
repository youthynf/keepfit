package com.test;

import org.springframework.beans.factory.annotation.Autowired;

import com.dao.CommonDao;
import com.dao.impl.CommonDaoImpl;
import com.entity.User;

public class DaoTest {
	public static void main(String[] args) {
		CommonDao<User> commonDao;
		
		User user = new User();
		user.setUserName("张三");
		user.setPassword("123456");
		
		
	}

}
