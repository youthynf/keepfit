package com.dao.impl;

import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.dao.CommonDao;
import com.entity.User;

@Repository
@Transactional
public class CommonDaoImpl<T> implements CommonDao<T> {
	
	@Resource
	private SessionFactory sessionFactory;

	public SessionFactory getSessionFactory() {
		return sessionFactory;
	}

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	
	public Session getSession(){
		
		return sessionFactory.getCurrentSession();
	}

	@Override
	public void save(T t) {
		getSession().save(t);
	}

	@Override
	public void delete(T t) {
		getSession().delete(t);
	}

	@Override
	public void query(T t, Integer id) {
		getSession().get(t.getClass(), id);
	}

	@Override
	public void update(T t) {
		getSession().update(t);
	}

	@Override
	public int executeBySql(String sql) {
		SQLQuery sqlQuery = getSession().createSQLQuery(sql);
		int result = sqlQuery.executeUpdate();
		
		return result;
	}

	@Override
	public List executeByHql(String hql) {
		Query query = getSession().createQuery(hql);
		List list = query.list();
		
		return list;
	}

	@Override
	public void saveOrUpdate(T t) {
		getSession().saveOrUpdate(t);
	}
	
	@Override
	public List<User> findUserByName(String userName) {
		String sql = "from User where username = '" + userName + "'";
		Query query = getSession().createQuery(sql);
		List list = query.list();
		return list;
	}
	
	@Override
	public List<User> getAllUsers(String where_str) {
		String sql = "from User " + where_str;
		Query query = getSession().createQuery(sql);
		List list = query.list();
		return list;
	}
	
	@Override
	public User getUserById(Integer id) {
		String sql = "from User where id = " + id;
		Query query = getSession().createQuery(sql);
		List list = query.list();
		User user = (User)list.get(0);
		return user;
	}
}
