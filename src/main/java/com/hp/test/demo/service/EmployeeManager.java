package com.hp.test.demo.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hp.test.demo.dao.EmployeeDao;
import com.hp.test.demo.entity.Employee;




@Transactional(readOnly = true)
@Service
public class EmployeeManager {
	
	private EmployeeDao employDao;
		
	@Transactional(readOnly = false)
	public void save(Employee entity) {
		employDao.save(entity);
	}	
	
	
	@Transactional(readOnly = false)
	public void delete(Integer id) {
		employDao.delete(id);
	}	
	
	@Autowired
	public void setEmployDao(EmployeeDao employDao) {
		this.employDao = employDao;
	}
	
	
	
	public List getAll(){		
		return (List) employDao.findAll();
		//return null;
		
	}
	
	public Page<Employee> getPage(int pageNo, int pageSize){		
		PageRequest pageable = new PageRequest(pageNo-1, pageSize);
		return employDao.findAll(pageable);
	}
	
	
	
	public Employee getById(int id){
		
		return employDao.findOne(id);
		
	}
	

	public void flush(){
		
		employDao.flush();
	}

	@Transactional(readOnly = false)
	public Employee getbyName(String lastName){
		return  employDao.getByLastName(lastName);
	}
	
	

}
