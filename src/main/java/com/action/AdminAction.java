package com.action;

import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.service.UserService;
import com.entity.User;
import com.opensymphony.xwork2.ActionSupport;

@Controller
public class AdminAction extends ActionSupport {
	
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
	 * 管理员登录
	 * @return
	 */
	public String login(){
		System.out.println("login_action......");
		Boolean isLogin = this.isLogin();
		if(isLogin) {
			state = 1;
			return SUCCESS;
		} else {			
			state = 0;
			return INPUT;
		}
	}
	
	/**
	 * 校验管理员登录
	 * @return
	 */
	public String checkLogin() {
		List<User> userList = this.userService.findUserByName(userName);
		if(userList.size() >= 1) {
			User user = userList.get(0);
			System.out.println("getpassword:" + user.getPassword() + ", password:" + password);
			if(!password.equals(user.getPassword())) {
				state = 0;
			} else {
				HttpServletRequest request=(HttpServletRequest) ServletActionContext.getRequest();
				HttpSession session=request.getSession();
				session.setAttribute("user", user);
				state = 1;
			}
//			Iterator it = userList.iterator();
//			while (it.hasNext()) {
//				User user = (User)it.next();
//				System.out.println(user.getUserName());
//			}
		} else {
			state = 400;
		}
		return SUCCESS;
	}
	
	/**
	 * 后台首页
	 * @return
	 */
	public String index() {
		Boolean isLogin = this.isLogin();
		if(isLogin) {
			state = 1;
			return SUCCESS;
		} else {			
			state = 0;
			return INPUT;
		}
	}
	
	/**
	 * 后台首页数据页
	 * @return
	 */
	public String statistic() {
		Boolean isLogin = this.isLogin();
		if(isLogin) {
			state = 1;
			return SUCCESS;
		} else {
			state = 0;
			return INPUT;
		}
	}
	
	private Boolean isLogin() {
		HttpServletRequest request=(HttpServletRequest) ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		User user = (User)session.getAttribute("user");
		if(user != null) {
			return true;
		} else {			
			return false;
		}
	}
}
