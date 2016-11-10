package com.hp.test.demo.actions;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hp.test.demo.dao.DepartmentDao;
import com.hp.test.demo.entity.Department;
import com.hp.test.demo.entity.Employee;
import com.hp.test.demo.service.EmployeeManager;

@RequestMapping("/springmvc")
@Controller
public class EmployeeAction{
	
	
	@Autowired
	protected EmployeeManager employeeManager;
	
	@Autowired
	protected  DepartmentDao departmentDao;
	
	
	@RequestMapping(value = "/list")
	public ModelAndView list() {
		
		List list = (List) employeeManager.getAll();		
        ModelAndView mav = new ModelAndView("emp-list");
        mav.addObject("list", list);
        return mav;
	}
	
	//分页效果
	@RequestMapping(value = "/pagelist")
	public ModelAndView pageList(@RequestParam(value="pageNo", required=false, defaultValue="1")String pageNoStr) {
		int pageNo = 1;
		try {
			
			pageNo = Integer.valueOf(pageNoStr);
			if(pageNo < 1 ){
				pageNo = 1;
			}
		}catch (Exception e) {}
	
		Page page = employeeManager.getPage(pageNo,5);		
        ModelAndView mav = new ModelAndView("emp-list");
        mav.addObject("page", page);
        return mav;
	}
	
	
	
	@RequestMapping(value = "/emp-input")
	public String empinput(Map<String, Object> map){
		Employee ee = new Employee();
		List<Department> listDempartMent =   (List<Department>) departmentDao.getAll();
		map.put("departments",listDempartMent);
		map.put("employee", ee);
		return "emp-input";
	}
		
	@RequestMapping(value = "/emp/{id}" )
	public String  edit(@PathVariable(value = "id") Integer id, Map<String, Object> map){		
		map.put("employee", employeeManager.getById(id));
		map.put("departments", departmentDao.getAll());		
		return "emp-input";		
	}
	

	@RequestMapping(value = "/save",method=RequestMethod.POST)
	public String  saveOrUpdate(Employee entity, HttpServletRequest request, HttpSession session){
		if(entity.getId() == null){
			entity.setCreateTime(new Date());
		}
		employeeManager.save(entity);
		return "redirect:/springmvc/pagelist";	
	}

	
	
	@ModelAttribute()
	public void getEmployee(@RequestParam(value="id",required=false) Integer id,
			Map<String, Object> map){
		if(id != null){
			Employee em = employeeManager.getById(id);
			//此处设置为null的目的是 防止通过页面编辑员工修改department时候 department id会改变 会发生id被修改的hibernate异常
			em.setDepartment(null);
			map.put("employee", em);
		}
	}
	
	
	@RequestMapping(value= "/emp/delete")
	public String delete(@RequestParam(value="id",required=false) Integer id,
			Map<String, Object> map){
		if(id != null){
			employeeManager.delete(id);
		}
		return "redirect:/springmvc/pagelist";
	}
	@ResponseBody
	@RequestMapping(value= "/ajaxValidateLastName")
	public String validateName(@RequestParam(value="lastName") String lastName){
		
		Employee ee = employeeManager.getbyName(lastName);
		if(ee == null){
			return "0";
		}else{
			return "1";
		}
	}
}
