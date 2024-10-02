<%@page import="DB.MUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="login" class="user.UserBean" scope="session"/>

<%
    String url = request.getParameter("url");
    int teamNum = MUtil.parseInt(request, "teamNum", 0); // teamNum이 폼에 없을 경우 기본값 0
%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>SPORTRIP</title>
    <link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&display=swap" rel="stylesheet"/>
    <link href=".././assets/css/login.css" rel="stylesheet" type="text/css"/>
  </head>
  <body>
	<div id="secondScreen">
		<div id="background" class="c_main">
			<div class="b_wrap">
				<img alt="" src=".././assets/images/newpage_img.png">
			</div>
		</div>
		<div id="campaign" class="index" style="margin-top: -120px">
			<section class="c_hero area01">
				<div class="c_marquee value02">
					<div class="cm_wrap t1">
						<div class="marquee">
							<span>LET’S KFA</span> <span>LET’S KBO</span> <span>LET’S KOVO</span>
						</div>
						<div class="marquee t1">
							<span>LET’S KFA</span> <span>LET’S KBO</span> <span>LET’S KOVO</span>
						</div>
					</div>
					<div class="cm_wrap t2">
						<div class="marqueereverse">
							<span>LET’S SPORTRIP</span> <span>LET’S SPORTRIP</span> <span>LET’S SPORTRIP</span>
						</div>
						<div class="marqueereverse t1">
							<span>LET’S SPORTRIP</span> <span>LET’S SPORTRIP</span> <span>LET’S SPORTRIP</span>
						</div>
					</div>
					<div class="cm_wrap t3">
						<div class="marquee">
							<span>LET’S KFA</span> <span>LET’S KBO</span> <span>LET’S KOVO</span>
						</div>
						<div class="marquee t1">
							<span>LET’S KFA</span> <span>LET’S KBO</span> <span>LET’S KOVO</span>
						</div>
					</div>
				</div>
			</section>
		</div>
		<div class="popup-background">
			<div class="popup" id="popup">
				<div class="popup-content">
					<div class="login_img">
						<img src=".././assets/images/logo_img/2_울산HD.png" alt="울산HD" id="team_img">
					</div>
					<div class="login_form">
						<form action="loginCheck.jsp" method="POST">
							<div class="input_box">
								<input type="text" name="id" placeholder="아이디">
							</div>
							<div class="input_box">
								<input type="password" name="pw" placeholder="비밀번호">
							</div>
							<div class="login_button">
								<input type="hidden" name="url" value="<%=url%>"> 
								<input type="hidden" name="teamNum" value="<%=teamNum%>">
								<button type="submit">로그인</button>
							</div>
						</form>
					</div>
				</div>
			</div>
			<div class="u-popup" id="u-popup">
				<span class="u-popup-text">스포트립이 처음이신가요? </span><a class="sign-up" onclick="location.href='signup.jsp'">회원가입</a>
			</div>
		</div>
	</div>

	<script>
      	window.onload = function () {
        setTimeout(() => {
          document.getElementById("secondScreen").classList.add("show");
          document.getElementById("background").classList.add("show");
          document.getElementById("popup").classList.add("show");          
          document.getElementById("u-popup").classList.add("show");          
        }, 200);
      };

    </script>
	<script>
  	function sendSportNum(sportNum) {
	    // 세션에 값을 설정
	    var form = document.createElement("form");
	    form.setAttribute("method", "POST");
	    form.setAttribute("action", "sport_main.jsp"); // 데이터를 보낼 경로
		
        var hiddenField = document.createElement("input");
        hiddenField.setAttribute("type", "hidden");
        hiddenField.setAttribute("name", "sportNum");
        hiddenField.setAttribute("value", sportNum);
	    form.appendChild(hiddenField);
	
	    document.body.appendChild(form);
	    form.submit();
	}
    </script>
  </body>
</html>
