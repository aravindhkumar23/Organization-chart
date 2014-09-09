<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ page import ="java.sql.*" %>
<%

Connection connection = null; 
PreparedStatement p=null;
PreparedStatement p5=null;
PreparedStatement p6=null;
PreparedStatement p7=null;

Statement st=null;
String connectionURL = "jdbc:mysql://localhost:3306/travelspends"; 
Class.forName("com.mysql.jdbc.Driver").newInstance(); 
connection = DriverManager.getConnection(connectionURL, "root","aravindh");

%>