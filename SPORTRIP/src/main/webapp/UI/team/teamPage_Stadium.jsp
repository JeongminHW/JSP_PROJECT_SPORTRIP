<%@page import="stadium.StadiumBean"%>
<%@page import="stadium.StadiumMgr"%>
<%@page import="team.TeamBean"%>
<%@page import="team.TeamMgr"%>
<%@page import="java.util.Vector"%>
<%@page import="DB.MUtil"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:useBean id="teammgr" class="team.TeamMgr"/>
<jsp:useBean id="teamBean" class="team.TeamBean"/>
<jsp:setProperty property="*" name = "teamBean"/>
<%
    int teamNum = MUtil.parseInt(request, "teamNum");
    
    // 받은 값에 따라 팀 정보 가져오기
    TeamMgr teamMgr = new TeamMgr();
    StadiumMgr stadium = new StadiumMgr();
    
    // 팀, 경기장 정보 가져오기
    TeamBean teamInfo = teamMgr.getTeam(teamNum);  // teamNum을 사용하여 팀 정보 조회    
    StadiumBean StadiumInfo = stadium.getStadium(teamNum);    
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><%=teamInfo.getTEAM_NAME() %></title>
<link rel="stylesheet" href=".././assets/css/style.css">
<script>
    function goMain(){
        document.location.href="mainPage.jsp";
    }
</script>
</head>
<body>
<header class="header header_logo">
		<a style="cursor: pointer" onclick="goMain()"><img src=".././assets/images/sportrip_logo.png" alt="sportrip 로고" id="logo_img"></a>
	    <a href="#" onclick="sendSportNum(<%=teamInfo.getSPORT_NUM()%>, '.././sport/sport_main')" style="margin-left: 20px; margin-right: 20px;">
	    <img src=".././assets/images/sport_logo<%=teamInfo.getSPORT_NUM()%>.svg" alt="리그" id="league_logo_img"></a>
	    <div style="position: absolute; left: 50%; transform: translateX(-50%);" class="img-box">
        <img src="<%=teamInfo.getLOGO() %>" alt="로고" class="team_logo_img">
    </div>
</header>
    <div class="t_top">
        <div class="item" style="background-color: #236FB5;">
            <a href="#" onclick="sendTeamNum(<%=teamInfo.getTEAM_NUM()%>, 'teamPage_Player')">선수 명단</a>
        </div>
        <div class="item" style="background-color: #083660;">
            <a href="#" onclick="sendTeamNum(<%=teamInfo.getTEAM_NUM()%>, 'teamPage_Stadium')">경기장 소개</a>
        </div>
        <div class="item" style="background-color: #236FB5;">
            <a href="#" onclick="sendTeamNum(<%=teamInfo.getTEAM_NUM()%>, 'teamPage_Teamintro')">구단 소개</a>
        </div>
        <div class="item" style="background-color: #236FB5;">
            <a href="teamPage_teamHighlight.html">하이라이트 경기</a>
        </div>
        <div class="item" style="background-color: #236FB5;">
            <a href="teamPage_Store.html">굿즈샵</a>
        </div>
        <div class="item" style="background-color: #236FB5;">
            <a href="teamPage_Board.html">게시판</a>
        </div>
    </div>
    
    <div class="stadium-intro">
    	<div class="stadium-img">
    		<img alt=<%=StadiumInfo.getSTADIUM_NAME() %> src="<%=StadiumInfo.getSEATS() %>">
    	</div>
    	
    	<div class="stadium-info">
    		<div class="stadium-text">
    			<span>명칭 : <%=StadiumInfo.getSTADIUM_NAME() %></span><br>
    			<span>위치 : <%=StadiumInfo.getSTADIUM_ADDRESS() %></span><br>
    			<span>수용 인원 : <%=StadiumInfo.getSEAT_CAPACITY_S() %>명</span><br>
    		</div>
    		<div class="climate-info">
    			<button class="climate-button">날씨 정보 보기</button>
    		</div>
    	</div>
    </div>
	<script>
		// 스포츠 넘버 전송
	  	function sendSportNum(sportNum, page) {
		    // 폼을 생성
		    var form = document.createElement("form");
		    form.setAttribute("method", "POST");
		    form.setAttribute("action",  `${ "${page}" }.jsp`);// 데이터를 보낼 경로
		    
		    // hidden input 생성하여 sportNum 값 전달
		    var hiddenField = document.createElement("input");
		    hiddenField.setAttribute("type", "hidden");
		    hiddenField.setAttribute("name", "sportNum");
		    hiddenField.setAttribute("value", sportNum);
		    
		    form.appendChild(hiddenField);
		
		    // 생성한 폼을 document에 추가한 후 제출
		    document.body.appendChild(form);
		    form.submit();
	  	}
		
	 	// 팀 넘버 전송
	  	function sendTeamNum(teamNum, page) {
		    // 폼을 생성
		    var form = document.createElement("form");
		    form.setAttribute("method", "POST");
		    form.setAttribute("action",  `${ "${page}" }.jsp`);// 데이터를 보낼 경로
		    
		    // hidden input 생성하여 sportNum 값 전달
		    var hiddenField = document.createElement("input");
		    hiddenField.setAttribute("type", "hidden");
		    hiddenField.setAttribute("name", "teamNum");
		    hiddenField.setAttribute("value", teamNum);
		    
		    form.appendChild(hiddenField);
		
		    // 생성한 폼을 document에 추가한 후 제출
		    document.body.appendChild(form);
		    form.submit();
		  }
	  </script>
</body>
</html>
