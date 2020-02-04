package com.action;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

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
	private String gender;
	private String phone;
	private String email;
	private String address;
	private String amdin;
	private String add_time;
	
	public String getAdd_time() {
		return add_time;
	}

	public void setAdd_time(String add_time) {
		this.add_time = add_time;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getAmdin() {
		return amdin;
	}

	public void setAmdin(String amdin) {
		this.amdin = amdin;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	private String status;
	private String note;	
	private Integer state;
	private String json;
	public String getJson() {
		return json;
	}

	public void setJson(String json) {
		this.json = json;
	}

	private String hql;
	private String dateMax;
	private String dateMin;
	private String admin;

	public String getAdmin() {
		return admin;
	}

	public void setAdmin(String admin) {
		this.admin = admin;
	}

	public String getDateMax() {
		return dateMax;
	}

	public void setDateMax(String dateMax) {
		this.dateMax = dateMax;
	}

	public String getDateMin() {
		return dateMin;
	}

	public void setDateMin(String dateMin) {
		this.dateMin = dateMin;
	}

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
		user.setGender(gender);
		user.setPhone(phone);
		user.setEmail(email);
		user.setAddress(address);
		user.setAdmin(admin);
		user.setStatus(status);
		user.setNote(note);
		Date date = new Date();
		String time = String.valueOf(date.getTime()/1000);
		user.setAdd_time(time);
		System.out.println("time:" + time);
		if(id != null && id > 0) {
			user.setId(id);
			this.userService.updateUser(user);
		} else {
			this.userService.saveUser(user);	
		}
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
	
	/* 
     * 将时间转换为时间戳
     */    
    private String dateToStamp(String s) throws ParseException {
        String res;
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date = simpleDateFormat.parse(s);
        long ts = date.getTime() / 1000;
        res = String.valueOf(ts);
        return res;
    }
	
	public String userList() throws ParseException {
		Map request = (Map) ActionContext.getContext().get("request");
		request.put("dateMin", dateMin);
		request.put("dateMax", dateMax);
		request.put("admin", admin);
		String where = "";
		if(admin == null) admin = "0"; 
		where += "where admin = " + admin;
		if(userName != null && userName.length() != 0) {
			where += " and userName = '" + userName + "'";
		}
		if(dateMin != null && dateMin.length() != 0) {
			dateMin = this.dateToStamp(dateMin + " 00:00:00");
			where += " and add_time >= " + dateMin;
		}
		if(dateMax != null && dateMax.length() != 0) {
			dateMax = this.dateToStamp(dateMax + " 23:59:59");
			where += " and add_time <= " + dateMax;
		}
		List<User> userList = this.userService.getAllUsers(where);
		request.put("users_list", userList);
		return SUCCESS;
	}
	
	public String adminList() throws ParseException {
		Map request = (Map) ActionContext.getContext().get("request");
		request.put("dateMin", dateMin);
		request.put("dateMax", dateMax);
		request.put("admin", admin);
		String where = "";
		if(admin == null) admin = "1"; 
		where += "where admin = " + admin;
		if(userName != null && userName.length() != 0) {
			where += " and userName = '" + userName + "'";
		}
		if(dateMin != null && dateMin.length() != 0) {
			dateMin = this.dateToStamp(dateMin + " 00:00:00");
			where += " and add_time >= " + dateMin;
		}
		if(dateMax != null && dateMax.length() != 0) {
			dateMax = this.dateToStamp(dateMax + " 23:59:59");
			where += " and add_time <= " + dateMax;
		}
		List<User> userList = this.userService.getAllUsers(where);
		request.put("users_list", userList);
		return SUCCESS;
	}
	
	public String stopUser() {
		User user = this.userService.getUserById(id);
		if(Integer.valueOf(status) == 0) status = "1";
		else status = "0";
		user.setStatus(status);
		System.out.println("id:" + id + ",status:" + status);
		this.userService.updateUser(user);
		state = 1;	
		return SUCCESS;
	}
	
	public String getUserById() {
		hql = "from User where id = " + String.valueOf(id);
		List<User> userList = this.userService.executeByHql(hql);
		if(userList.size() > 0) {
			User user = userList.get(0);
			JSONArray usr = JSONArray.fromObject(user);
			json = usr.toString();
			state = 1;
		} else {
			state = 0;	
		}
		
		return SUCCESS;
	}
}
