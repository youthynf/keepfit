package com.action;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.service.UserService;
import com.entity.User;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

@Controller
public class UserAction extends ActionSupport {
	
	@Autowired
	private UserService userService;
	
	private Integer id;
	
	private String userName;
	
	private String password;
	
	private Integer state;
	
	private String hql;

	public UserService getUserService() {
		return userService;
	}

	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}
	
	public String getHql() {
		return hql;
	}

	public void setHql(String hql) {
		this.hql = hql;
	}

	/**
	 * 注册测试
	 * @date	2018-6-20 上午9:47:42
	 * @author	live
	 * @return
	 */
	public String saveUser(){
		System.out.println("action......");
		User user = new User();
		user.setUserName(userName);
		user.setPassword(password);
		
		this.userService.saveUser(user);
		state = 1;
		
		return SUCCESS;
	}
	
	/**
	 * 删除测试
	 * @date	2018-6-28 上午11:42:14
	 * @author	live
	 * @return
	 */
	public String delUserById(){
		System.out.println("delaction....");
		System.out.println("id:" + this.getId());
//		User user = new User();
//		user.setId(id);
//		this.userService.delUser(user);
		state = 1;
		
		return SUCCESS;
	}
	
	/**
	 * HQL查询测试
	 * @date	2018-6-28 下午12:12:16
	 * @author	live
	 * @return
	 */
	public String queryUserByHql(){
		hql = "from User where userName = '" + userName + "'";
		List<User> userList = this.userService.executeByHql(hql);
		if(userList.size() > 0)
			state = 1;
		else
			state = 0;
		
		return SUCCESS;
	}	
	
	public String test() {
		System.out.println("testAction....");
		state = 1;
		return SUCCESS;
	}
	
	public String userList() {
		List<User> userList = this.userService.getAllUsers();
		Map request = (Map) ActionContext.getContext().get("request");
		request.put("users_list", userList);
		return SUCCESS;
	}
}
