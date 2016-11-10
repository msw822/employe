<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<!--  
	SpringMVC 处理静态资源:
	1. 为什么会有这样的问题:
	优雅的 REST 风格的资源URL 不希望带 .html 或 .do 等后缀
	若将 DispatcherServlet 请求映射配置为 /, 
	则 Spring MVC 将捕获 WEB 容器的所有请求, 包括静态资源的请求, SpringMVC 会将他们当成一个普通请求处理, 
	因找不到对应处理器将导致错误。
	2. 解决: 在 SpringMVC 的配置文件中配置 <mvc:default-servlet-handler/>
-->
<script type="text/javascript" src="${pageContext.request.contextPath }/scripts/jquery-1.9.1.min.js"></script>
<script type="text/javascript">
 	$(function(){
		$("#delete").click(function(){
			//alert("33");
			var label = $(this).next(":hidden").val();
			if(confirm('确定要删除 '+ label+ ' 吗?')==false)
		    return false;
		/* 	var href = $(this).attr("href");
			$("form").attr("action", href).submit();			
			return false; */
		});
	}) 
</script>
</head>
<body>
	
	<form action="" method="POST">
		<input type="hidden" name="_method" value="DELETE"/>
	</form>
	<h2>员工列表</h2>
	<c:if test="${empty requestScope.page }">
		没有任何员工信息.
	</c:if>
	<c:if test="${!empty requestScope.page }">
		<table border="1" cellpadding="10" cellspacing="0">
			<tr>
				<th>ID</th>
				<th>LastName</th>
				<th>Email</th>
				<th>Department</th>
				<th>Birth</th>
				<th>创建时间</th>
				<th>Edit</th>
				<th>Delete</th>
			</tr>
			
			<c:forEach items="${requestScope.page.content }" var="emp">
				<tr>
					<td>${emp.id }</td>
					<td>${emp.lastName }</td>
					<td>${emp.email }</td>
					<td>${emp.department.departmentName }</td>
					<td>${emp.birth }</td>
					<td>${emp.createTime }</td>
					<td><a href="emp/${emp.id}">Edit</a></td>
					<td>
						<a id="delete"  href="emp/delete?id=${emp.id}">Delete</a>
						<input type="hidden" value="${emp.lastName }"/>	
					</td>
					
				</tr>
			</c:forEach>
			<tr>
				<td colspan="8">
					共 ${page.totalElements } 条记录
					共 ${page.totalPages } 页
					当前 ${page.number + 1 } 页
					<a href="?pageNo=${page.number + 1 - 1 }">上一页</a>
					<a href="?pageNo=${page.number + 1 + 1 }">下一页</a>
				</td>
			</tr>
			
			
		</table>
	</c:if>
	
	<br><br>
	
	<a href="emp-input">Add New Employee</a>
	
</body>
</html>