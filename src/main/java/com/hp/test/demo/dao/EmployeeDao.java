/**
 * 
 */
package com.hp.test.demo.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import com.hp.test.demo.entity.Employee;
@Repository
public interface EmployeeDao extends JpaRepository<Employee, Integer> {
	Employee getByLastName(String lastName);
}
