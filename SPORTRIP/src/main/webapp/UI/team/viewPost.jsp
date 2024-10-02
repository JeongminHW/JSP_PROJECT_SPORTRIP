<%@page import="team.TeamBean"%>
<%@page import="team.TeamMgr"%>
<%@page import="java.util.Vector"%>
<%@page import="DB.MUtil"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="login" scope="session" class="user.UserBean" />
<jsp:useBean id="teamMgr" class="team.TeamMgr" />
<jsp:useBean id="teamBean" class="team.TeamBean" />

<%
	// POST로 전달된 teamNum을 세션에 저장 (세션에 없을 경우에만 저장)
	int teamNum = MUtil.parseInt(request, "teamNum", 0); // 폼에서 받은 값이 없으면 0
	if (teamNum == 0) {
		teamNum = (Integer) session.getAttribute("teamNum"); // 세션에서 팀 번호 가져오기
	} else {
		session.setAttribute("teamNum", teamNum); // 세션에 팀 번호 저장
	}
	// 팀 정보와 선수 명단 가져오기
	TeamBean teamInfo = teamMgr.getTeam(teamNum);
	
	String teamName = teamInfo.getTEAM_NAME();
	int sportNum = (int)session.getAttribute("sportNum");
%>

<jsp:include page="team_header.jsp"/>
	<div class="list-btn-top">
        <button type="button" onclick="goList()">목록</button>
    </div>

    <div class="post-content-box">
        <div class="post-header">
            <div class="post-title">
                <span style="font-weight: bold; font-size: 22px;">오늘 축구 몇시</span>
				<div class="update-btn">
					<button type="button" onclick="">수정</button>
					<button type="button" onclick="">삭제</button>
				</div>
            </div>
            <div class="user-box">
                <div class="userInfo">
                    <span style="font-weight: bold;">ID</span>
                    <span>2024.09.24 00:00:00</span>
                    <span>127.0.0.0</span>
                </div>
                <div class="userView">
                    <span>조회 3</span>
                    <span>추천 0</span>
                </div>
            </div>
        </div>
		<div class="post-content">
			<p>오늘 축구 몇시에 하나요?</p>
			<p><img src=".././assets/images/stadium_img.png"></p>
		</div>
		<div class="rec-btn">
			<button type="button" id="rec" onclick="">
				<span><img src=".././assets/images/recommend_img.png" alt=""> 0</span><br>
				<span>추천</span>
			</button>
			<button type="button" id="nrec" onclick="">
				<span><img src=".././assets/images/notRecommend_img.png" alt=""> 1</span><br>
				<span>비추천</span>
			</button>
		</div>
    </div>

	<div class="box">
		<div class="comment-box">
			<div class="user-box">
				<div class="userInfo">
					<span style="font-weight: bold;">ID</span>
					<span>2024.09.24 00:00:00</span>
					<span>127.0.0.1</span>
				</div>
				<div class="update-btn">
					<button type="button" onclick="">수정</button>
					<button type="button" onclick="">삭제</button>
				</div>
			</div>
			<div class="comment">
				<p>몰라요</p>
			</div>
			<div class="comment-reple">
				<button onclick="repleComment()">답글</button>
			</div>
			<div class="reple-box" style="display: none;">
				<textarea name="comment" class="comment-text" placeholder="댓글을 입력해주세요."></textarea>
				<button type="button" class="comment-btn">등록</button>
			</div>
		</div>
		<div class="comment-box">
			<div class="user-box">
				<div class="userInfo">
					<span style="font-weight: bold;">ID</span>
					<span>2024.09.24 00:00:00</span>
					<span>127.0.0.1</span>
				</div>
				<div class="update-btn">
					<button type="button" onclick="">수정</button>
					<button type="button" onclick="">삭제</button>
				</div>
			</div>
			<div class="comment">
				<p>몰라요</p>
			</div>
			<div class="comment-reple">
				<button onclick="repleComment()">답글</button>
			</div>
			<div class="reple-box " style="display: none;">
				<textarea name="comment" class="comment-text" placeholder="댓글을 입력해주세요."></textarea>
				<button type="button" class="comment-btn">등록</button>
			</div>
		</div>
	</div>

	<div class="comment-text-box">
		<textarea name="comment" class="comment-text" placeholder="댓글을 입력해주세요."></textarea>
		<button type="button" class="comment-btn">등록</button>
	</div>

    <div class="list-btn">
        <button type="button" onclick="goList()">목록</button>
    </div>
    <script>
		function goMain() {
			document.location.href = "mainPage.jsp";
		}
	
	    function postMessage(){
	        document.location.href = "Board_post.html";
	    }
	    
	 	// 팀 번호 전달
		function sendTeamNum(teamNum, page) {
		    // 세션에 값을 설정
		    var form = document.createElement("form");
		    form.setAttribute("method", "POST");
		    form.setAttribute("action", page + ".jsp");
		
		    var teamField = document.createElement("input");
		    teamField.setAttribute("type", "hidden");
		    teamField.setAttribute("name", "teamNum");
		    teamField.setAttribute("value", teamNum);
		    form.appendChild(teamField);
		
		    document.body.appendChild(form);
		    form.submit();
		}
	
		function repleComment(){
			var repleBox = document.querySelector('.reple-box');
			if(repleBox.style.display == 'none'){
				repleBox.style.display = 'flex';
			}else{
				repleBox.style.display = 'none';
			}
		}
		
		// 페이지 로드 시 체크박스 해제
		window.addEventListener('load', function() {
        const toggle = document.getElementById('toggle');
        toggle.checked = false; // 체크박스 해제
    	});
        
        // 햄버거 메뉴
        document.getElementById('toggle').addEventListener('change', function() {
            const menu = document.querySelector('.menu');
            const overlay = document.getElementById('overlay');
            
            menu.classList.toggle('open');
            overlay.classList.toggle('open');
        });

        // 클릭 시 메뉴 닫기
        overlay.addEventListener('click', function() {
            document.getElementById('toggle').checked = false; // 체크박스 해제
            const menu = document.querySelector('.menu');
            menu.classList.remove('open'); // 메뉴 숨김
            overlay.classList.remove('open'); // 배경 숨김
        });
	</script>
</body>
</html>