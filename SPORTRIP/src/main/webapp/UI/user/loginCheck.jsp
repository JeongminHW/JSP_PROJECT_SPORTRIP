<%@ page import="DB.MUtil" %>
<%@ page import="user.UserBean" %>
<%@ page import="team.TeamBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:useBean id="userMgr" class="user.UserMgr" />
<jsp:useBean id="login" scope="session" class="user.UserBean" />
<jsp:useBean id="team" scope="session" class="team.TeamBean" />
<jsp:setProperty property="*" name="login" />
<jsp:setProperty property="*" name="team" />

<%
    // Get the previous URL or default to sport main page
    String defaultUrl = ".././sport/sport_main.jsp";
    String previousUrl = request.getParameter("url");
    if (previousUrl == null || previousUrl.isEmpty()) {
        previousUrl = (String) session.getAttribute("previousPage");
    }
    String redirectUrl = previousUrl != null ? previousUrl : defaultUrl;

    // Check login credentials
    boolean result = userMgr.checkLogin(login.getId(), login.getPw());
    String msg = "로그인에 실패하였습니다.";

    if (result) {
        msg = "로그인에 성공하였습니다.";
        login = userMgr.getJoin(login.getId());
        session.setAttribute("idKey", login.getId());
        session.setAttribute("login", login);
        session.removeAttribute("previousPage");  // Clear previous page after login
    }
%>

<script>
    alert("<%=msg%>");
    location.href = "<%= redirectUrl %>"; 
</script>
