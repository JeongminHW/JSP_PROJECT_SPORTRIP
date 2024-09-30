<%@page import="team.TeamBean"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="md.MDBean"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="login" scope="session" class="user.UserBean" />
<jsp:useBean id="teamMgr" class="team.TeamMgr" />
<jsp:useBean id="teamBean" class="team.TeamBean" />
<jsp:useBean id="mdMgr" class="md.MDMgr" />
<%
	//(int)session.getAttribute("teamNum")
	Vector<MDBean> vlist = mdMgr.listMD(10);
	TeamBean bean = teamMgr.getTeam(10);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><%=bean.getTEAM_NAME() %></title>
<link rel="stylesheet" href=".././assets/css/style.css">
<script>
	function goMain() {
		document.location.href = "mainPage.jsp";
	}
</script>
</head>
<body>
	<header class="header header_logo">
		<a style="cursor: pointer" onclick="goMain()"> 
			<img src=".././assets/images/sportrip_logo.png" alt="sportrip 로고" id="logo_img">
		</a> 
		<a href="soccer_main.html" style="margin-left: 50px;"> 
			<img src=".././assets/images/k-league_logo.svg" alt="리그" id="league_logo_img">
		</a>
		<div style="position: absolute; left: 50%; transform: translateX(-50%);" class="img-box">
			<img src="<%=bean.getLOGO() %>" alt="울산" class="team_logo_img ulsan">
		</div>
		<a href="shopping_cart.html">
			<img src=".././assets/images/cart_icon.png" alt="장바구니" class="cart">
		</a>
		<div class="login-signup-box">
			<ul>
				<li><a href="login.html"
					style="font-family: BMJUA; color: black;">로그인</a></li>
				<li><a href="signup.html"
					style="font-family: BMJUA; color: black;">회원가입</a></li>
			</ul>
		</div>
	</header>
	<div class="t_top">
		<div class="item" style="background-color: #236FB5;">
			<a href="teamPage_Player.html">선수 명단</a>
		</div>
		<div class="item" style="background-color: #236FB5;">
			<a href="teamPage_Stadium.html">경기장 소개</a>
		</div>
		<div class="item" style="background-color: #236FB5;">
			<a href="teamPage_teamIntro.html">구단 소개</a>
		</div>
		<div class="item" style="background-color: #236FB5;">
			<a href="teamPage_teamHighlight.html">하이라이트 경기</a>
		</div>
		<div class="item" style="background-color: #083660;">
			<a href="teamPage_Store.html">굿즈샵</a>
		</div>
		<div class="item" style="background-color: #236FB5;">
			<a href="teamPage_Board.html">게시판</a>
		</div>
	</div>

	<div class="goods-section">
		<div class="selectBox2">
			<button class="label">카테고리를 선택하세요</button>
			<ul class="optionList">
				<li class="optionItem">유니폼</li>
				<li class="optionItem">머플러</li>
				<li class="optionItem">기타</li>
			</ul>
		</div>

		<!-- goods-list를 selectBox2 아래로 이동 -->
		<div class="goods-list">
			<%
				for (MDBean MDList : vlist){
			%>
					<div class="goods-card"> 
					    <img src="<%= MDList.getMD_IMG() %>" alt="굿즈 사진" class="goods-photo" id="uniform">
					    <div class="goods-info">
					        <div class="goods-name"><%= MDList.getMD_NAME() %></div>
					        <div class="price-and-cart">
					            <span class="goods-price">₩<%=MDList.getMD_PRICE() %></span>
					            <button class="add-to-cart" onclick="addToCart('<%= MDList.getMD_NAME() %>', <%=MDList.getMD_PRICE() %>">
					                <img src=".././assets/images/cart_icon.png" alt="카트 아이콘">
					            </button>
					        </div>
					    </div>
					</div>
			<% } %>
		</div>
	</div>

<script>
    const label = document.querySelector('.label');
    const options = document.querySelectorAll('.optionItem');
    const goodsCards = document.querySelectorAll('.goods-card');
    const cart = []; // 장바구니 배열

 // 선택한 옵션에 따라 상품을 필터링하는 함수
    const filterGoods = (category) => {
        goodsCards.forEach(card => {
            const cardId = card.querySelector('.goods-photo').id; // 상품의 ID 가져오기
            if (category === '유니폼' && cardId === 'uniform') {
                card.style.display = 'block'; // '유니폼' 카테고리이고 ID가 'uniform'인 경우 표시
            } else if (category === '머플러' && cardId === 'muffler') {
                card.style.display = 'block'; // '머플러' 카테고리이고 ID가 'muffler'인 경우 표시
            } else if (category === '기타' && cardId === 'etc') {
                card.style.display = 'block'; // '기타' 카테고리이고 ID가 'etc'인 경우 표시
            } else {
                card.style.display = 'none'; // 해당하지 않는 경우 숨김
            }
        });
    }

 	// 클릭한 옵션의 텍스트를 라벨 안에 넣고 필터링 실행
    const handleSelect = (item) => {
        label.parentNode.classList.remove('active');
        label.innerHTML = item.textContent;
        filterGoods(item.textContent);// 필터링 함수 호출
    }

 	// 옵션 클릭 시 클릭한 옵션을 넘김
    options.forEach(option => {
        option.addEventListener('click', () => handleSelect(option))
    });

 	// 라벨을 클릭 시 옵션 목록이 열림/닫힘
	label.addEventListener('click', () => {
	    if(label.parentNode.classList.contains('active')) {
	        label.parentNode.classList.remove('active');
	    } else {
	        label.parentNode.classList.add('active');
	    }
	});

    // 상품을 장바구니에 추가하는 함수
    function addToCart(productName, price) {
        cart.push({ name: productName, price: price });
        alert(`${productName}이(가) 장바구니에 추가되었습니다.`);
        console.log(cart); // 장바구니 내용을 콘솔에 출력
    }
</script>


</body>
</html>
