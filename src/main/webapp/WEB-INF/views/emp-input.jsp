<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Insert title here</title>
<script type="text/javascript" src="${pageContext.request.contextPath }/scripts/jquery-1.9.1.min.js"></script>
<script type="text/javascript">
 $(function(){
	 $("#lastName").change(function(){
		 var val = $(this).val();
		 val = $.trim(val);
		 $(this).val(val);
		 
		 //edit时候不能把原来的lastName判定为重复
		 var _oldLastName =  $("#_oldLastName").val();
		 //alert(_oldLastName);
		 if(_oldLastName != null && _oldLastName != "" && _oldLastName == val){
			alert("lastName可用");
			return; 
		 }		 
		 var url = "${pageContext.request.contextPath }/springmvc/ajaxValidateLastName";
		 var args = {"lastName":val,"date":new Date()}
		 $.post(url,args,function(data){
			 if(data == "0"){
				 alert("lastName可用");
			 }else if(data == "1"){
				 alert("lastName重复！");
			 }else{
				 alert("程序异常请检查");
			 }
		 })
	 })
 })
 
</script>



</head>
<body>

<%-- 	<form action="testConversionServiceConverer" method="POST">
		<!-- lastname-email-gender-department.id 例如: GG-gg@atguigu.com-0-105 -->
		Employee: <input type="text" name="employee"/>
		<input type="submit" value="Submit"/>
	</form>
	<br><br> --%>
	
	<!--  
		1. WHY 使用 form 标签呢 ?
		可以更快速的开发出表单页面, 而且可以更方便的进行表单值的回显
		2. 注意:
		可以通过 modelAttribute 属性指定绑定的模型属性,
		若没有指定该属性，则默认从 request 域对象中读取 command 的表单 bean
		如果该属性值也不存在，则会发生错误。
	-->
	<%-- <form:form action="${pageContext.request.contextPath }/springmvc/save" method="POST">  --%>
	
	<input type="hidden" value= "${employee.lastName }">
	<form:form action="${pageContext.request.contextPath }/springmvc/save" method="POST"
		modelAttribute="employee">
			
		<c:if test="${employee.id == null }">
			<!-- path 属性对应 html 表单标签的 name 属性值 -->

		</c:if>
		<c:if test="${employee.id != null }">
			<!-- path 属性对应 html 表单标签的 name 属性值 -->
			<input type="hidden" id="_oldLastName" value="${employee.lastName }"/>
		</c:if>
		LastName: <form:input id="lastName" path="lastName"/>
		<form:errors path="lastName"></form:errors>
		<br>
		<c:if test="${employee.id != null }">
			<form:hidden path="id"/>
		</c:if>
		Email: <form:input path="email"/>
		<form:errors path="email"></form:errors>
		<br>
		Department: <form:select path="department.id" 
			items="${departments }" itemLabel="departmentName" itemValue="id"></form:select>
		<br>
		Birth: <form:input path="birth"/>
		<%-- <form:errors path="birth"></form:errors>  --%>
		<br>
		<input type="submit" value="Submit"/>
	</form:form>
	
</body>
</html>