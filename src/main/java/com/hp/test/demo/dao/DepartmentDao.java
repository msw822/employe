/**
 * 
 */
package com.hp.test.demo.dao;

import java.util.List;

import javax.persistence.QueryHint;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.QueryHints;
import org.springframework.stereotype.Repository;

import com.hp.test.demo.entity.Department;
@Repository
public interface DepartmentDao extends JpaRepository<Department, Integer> {
	
	//@QueryHints({@QueryHint(name=org.hibernate.ejb.QueryHints.HINT_CACHEABLE,value="true")})
	@Query("FROM Department d")	
	List<Department> getAll();
}
