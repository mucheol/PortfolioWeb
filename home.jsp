<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<%@ page session="false" %>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.13.0/css/all.css">
<link href="//fonts.googleapis.com/earlyaccess/nanumpenscript.css" rel="stylesheet" type="text/css">
<link href="//fonts.googleapis.com/earlyaccess/nanumgothic.css" rel="stylesheet" type="text/css">
<link href="//fonts.googleapis.com/earlyaccess/nanummyeongjo.css" rel="stylesheet" type="text/css">
<link href="/resources/css/home.css?after" rel="stylesheet" type="text/css">
	<title>Home</title>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
$(window).ready(function(){
	//https://gahyun-web-diary.tistory.com/2 참고
	String.prototype.toKorChars = function() { 
        var cCho = [ 'ㄱ', 'ㄲ', 'ㄴ', 'ㄷ', 'ㄸ', 'ㄹ', 'ㅁ', 'ㅂ', 'ㅃ', 'ㅅ', 'ㅆ', 'ㅇ', 'ㅈ', 'ㅉ', 'ㅊ', 'ㅋ', 'ㅌ', 'ㅍ', 'ㅎ' ], 
        	cJung = [ 'ㅏ', 'ㅐ', 'ㅑ', 'ㅒ', 'ㅓ', 'ㅔ', 'ㅕ', 'ㅖ', 'ㅗ', 'ㅘ', 'ㅙ', 'ㅚ', 'ㅛ', 'ㅜ', 'ㅝ', 'ㅞ', 'ㅟ', 'ㅠ', 'ㅡ', 'ㅢ', 'ㅣ' ], 
        	cJong = [ '', 'ㄱ', 'ㄲ', 'ㄳ', 'ㄴ', 'ㄵ', 'ㄶ', 'ㄷ', 'ㄹ', 'ㄺ', 'ㄻ', 'ㄼ', 'ㄽ', 'ㄾ', 'ㄿ', 'ㅀ', 'ㅁ', 'ㅂ', 'ㅄ', 'ㅅ', 'ㅆ', 'ㅇ', 'ㅈ', 'ㅊ', 'ㅋ', 'ㅌ', 'ㅍ', 'ㅎ' ], cho, jung, jong; 
        var str = this, 
        cnt = str.length, 
        chars = [], 
        cCode; 
        for (var i = 0; i < cnt; i++) { 
            cCode = str.charCodeAt(i); 
            if (cCode == 32) { 
              chars.push(" ");
              continue;
            } // 한글이 아닌 경우 
            if (cCode < 0xAC00 || cCode > 0xD7A3) { 
                chars.push(str.charAt(i)); 
                continue; 
            } 
            cCode = str.charCodeAt(i) - 0xAC00; 

            jong = cCode % 28;   // 종성 
            jung = ((cCode - jong) / 28 ) % 21;   // 중성 
            cho = (((cCode - jong) / 28 ) - jung ) / 21;      // 초성 

            //기본 코드 테스트가 ㅌㅔㅅ-ㅌ- 형식으로 저장됨 
            // chars.push(cCho[cho], cJung[jung]); 
            // if (cJong[jong] !== '') { 
            //     chars.push(cJong[jong]); 
            //     } 

            //  테스트라는 문장이 있으면 ㅌ테ㅅ스ㅌ트 형식으로 저장되도록함 (타이핑을 위해서)
            chars.push(cCho[cho]);
            chars.push(String.fromCharCode( 44032 + (cho * 588) + (jung  * 28)));
            if (cJong[jong] !== '') { 
                chars.push(String.fromCharCode( 44032 + (cho * 588) + (jung  * 28) + jong ));
            }
        } 
        return chars; 
    }


//타이핑할 문장
    var result1  = "A rolling stone";
    var result2  = "SW개발자 김무철";
    var typing1=[], typing2=[];;
    result1 = result1.split(''); // 한글자씩자름
    result2 = result2.split(''); // 한글자씩자름

    //각글자 초성,중성,종성으로 나눔
    for(var i =0; i<result1.length; i++){
        typing1[i]=result1[i].toKorChars();
    }
   for(var i =0; i<result2.length; i++){
        typing2[i]=result2[i].toKorChars();
    }

    //출력할 엘리먼트요소 가져옴 
    var resultDiv1 = document.getElementsByClassName("result1")[0];
    var resultDiv2 = document.getElementsByClassName("result2")[0];

    //
    var text = "";
    var i=0; 
    var j=0; 

    //총글자수
    var imax1 = typing1.length;
    var imax2 = typing2.length;

    //setInterval을 이용해 반복적으로 출력 
    var inter = setInterval(typi,70);
    var inter2;


    function typi(){
        //글자수만큼 반복후 종료 
      resultDiv1.classList.add("cursor");
        if(i<=imax1-1){
            //각 글자가 초성 중성 종성 순서대로 추가되도록 
            var jmax1 = typing1[i].length;
            resultDiv1.innerHTML = text + typing1[i][j];
            j++;
            if(j==jmax1){
                text+=  typing1[i][j-1];//초성중성종성 순서대로 출력된 글자는 저장 ( 다음 글자와 이어붙이기 위해서 )
                i++;
                j=0;
            }
        } else{
            clearInterval(inter);
             text ="";
            i=0;
            j=0; 
       setTimeout(function(){    
          resultDiv1.classList.remove("cursor");
          setTimeout(function(){             
             resultDiv2.classList.add("cursor");
             setTimeout(function(){
                inter2 = setInterval(typi2,70);
             },400);
           },300);
         },400);
        }
    }

 	function typi2(){
        //글자수만큼 반복후 종료 

        if(i<=imax2-1){
            //각 글자가 초성 중성 종성 순서대로 추가되도록 
            var jmax2 = typing2[i].length;
            resultDiv2.innerHTML = text + typing2[i][j];
            j++;
            if(j==jmax2){
                text+=  typing2[i][j-1];//초성중성종성 순서대로 출력된 글자는 저장 ( 다음 글자와 이어붙이기 위해서 )
                i++;
                j=0;
            }
        } else{
            clearInterval(inter);
        }
    }
});/* 여기까지 배너 */ 

	$(function(){
		
		$("#text_box1_1").hide();
		$("#text_box2_1").hide();
		$("#text_box3_1").hide();
		$("#text_box4_1").hide();
		$("#text_box4_2").hide();
		$("#text_box4_3").hide();
		$("#text_box4_4").hide();

		$("#text_box1").click(function(){
			$("#text_box1_1").toggle(500);
		});
		$("#text_box1").hover(function(){
			$(this).css({background:"#E0EAF8",border:"1px solid blue"});
			$(this).css("font-weight", "900");
		},function(){
			$(this).css({background:"none",border:"1px solid black"});
			$(this).css("font-weight","400");
		});
		
		$("#text_box2").click(function(){
			$("#text_box2_1").toggle(500);
		});
		$("#text_box2").hover(function(){
			$(this).css({background:"#E0EAF8",border:"1px solid blue"});
			$(this).css("font-weight", "900");
		},function(){
			$(this).css({background:"none",border:"1px solid black"});
			$(this).css("font-weight","400");
		});
		
		$("#text_box3").click(function(){
			$("#text_box3_1").toggle(500);
		});
		$("#text_box3").hover(function(){
			$(this).css({background:"#E0EAF8",border:"1px solid blue"});
			$(this).css("font-weight", "900");
		},function(){
			$(this).css({background:"none",border:"1px solid black"});
			$(this).css("font-weight","400");
		});
		
		$("#text_box4").click(function(){
			$("#text_box4_1").toggle(200);
			$("#text_box4_2").toggle(300);
			$("#text_box4_3").toggle(400);
			$("#text_box4_4").toggle(500);
		});
		$("#text_box4").hover(function(){
			$(this).css({background:"#E0EAF8",border:"1px solid blue"});
			$(this).css("font-weight", "900");
		},function(){
			$(this).css({background:"none",border:"1px solid black"});
			$(this).css("font-weight","400");
		});
		
		$(window).scroll(function() {
            if ($(this).scrollTop() > 500) {
                $('#move_top_btn').fadeIn();
            } else {
                $('#move_top_btn').fadeOut();
            }
        });
        
        $("#move_top_btn").click(function() {
            $('html, body').animate({
                scrollTop : 0
            }, 400);
            return false;
        });
	});
</script>
</head>
<body>
<div id="banner">
	<img alt="배너" src="/resources/image/10.png">
	
	<div id="banner_title">
		<p class="result1"></p><br>
		<p class="result2"></p>
	</div>
</div>

<div id="sidebar">
	<p><a href="#project">Project</a></p>
	<p><a href="#tech">Technology</a></p>
	<p><a href="#aboutMe">About Me</a></p>
</div>

<div id="project">
	<div class="title">
		<p>Project</p>
	</div>
	<div class="pro_1">
		<div class="pro_box1">
			<div class="pro_img"><img alt="레스토랑 예약서비스" src="/resources/image/restaurant.png"></div>
			<div class="pro_des"><p>&nbsp;Restaurant Reservation Service(레스토랑 예약 서비스)<br><br>
						&nbsp;InteliJ로 개발하였으며 SpringBoot, H2DB를 사용해 개발하였고 최종적으론 MariaDB와 연결하였습니다.<br>
						 &nbsp;가게의 목록,상세,추가,수정,에러처리,메뉴관리,리뷰,필터링,회원가입,JWT 인증기능,예약 시스템 구축하였습니다.<br>
						&nbsp;node.js와 webpack, docker까지 이제까지 써보지 않았던 기술을 배워나가는데 중점을 두며 만든 프로젝트입니다.</p>
			</div>
			<div class="pro_ppt"><p><a href="#"/></a></p></div>
			<div class="pro_git"><a href="https://github.com/mucheol/RestaurantReservation"><p>Git</p></a></div>
		</div>
	</div>
	<div class="pro_2">
		<div class="pro_box2">
			<div class="pro_img"><img alt="다무비" src="/resources/image/damovie.png"></div>
			<div class="pro_des"><p>&nbsp;Project Damovie는 통합예매사이트로 예매는 물론 각 영화사에서 서브 관리자로 영화관, 좌석, 상영시간을 업데이트 및 관리하는 사이트입니다.<br><br>
								 &nbsp;6개월 교육 마지막 과정으로 3인이 협업한 프로젝트로 페이지별로 분담해 여러 경험을 쌓는 데에 목적을 두었으며
								 저는 Layout(tiles), 마이페이지(예매확인, 정보수정, 탈퇴), 고객센터, 관리자페이지, 서브관리자(메인, 영화 관리) 페이지 프로그래밍을 하였고 PPT 제작과 발표를 담당했습니다.</p>
			</div>
			<div class="pro_ppt"><p><a href="<c:url value="/resources/DamoviePPT.pptx"/>">PPT</a></p></div>
			<div class="pro_git"><a href="https://github.com/mucheol/DaMovie"><p>Git</p></a></div>
		</div>
	</div>
	<div class="pro_1">		
		<div class="pro_box1">
			<div class="pro_img"><img alt="Disney CINEMA" src="/resources/image/disney.png"></div>
			<div class="pro_des"><p>&nbsp;Project Disney CINEMA는 JavaFX Scene Builder를 이용해 개발한 영화관 사이트입니다.<br><br>
						2주간의 4인 프로젝트이며 Scene Builder를 이용해 화면구성을 하고 Java, DB를 이용해 기능구성 및 데이터관리를 하였습니다.<br>
						&nbsp;저는 상점페이지 프로그래밍을 하였으며 원하는 상품을 리스트에 추가, 삭제하는 기능과 총합계를 실시간으로 계산해 DB에 전송, 화면에 출력하는 기능 등을 구현하였고 PPT 제작을 담당했습니다.</p>
			</div>
			<div class="pro_ppt"><p><a href="<c:url value="/resources/DisneyPPT.pptx"/>">PPT</a></p></div>
			<div class="pro_git"><a href="https://github.com/mucheol/DisneyCinema"><p>Git</p></a></div>
		</div>
	</div>
	<div class="pro_2">		
		<div class="pro_box2">
			<div class="pro_img"><img alt="블로그" src="/resources/image/blog.png"></div>
			<div class="pro_des"><p>&nbsp;IT공부를 시작하며 언젠가 문득 뒤돌아 봤을 때 후회하지 않도록 '모든순간 최선을 다하자'라는 마음으로 배우는 모든 내용을 정리한 블로그입니다.<br><br>
									&nbsp;C언어, Python, Java 기본언어 부터 응용SW(윈도우, 리눅스, 네트워크, DB), JavaFX, HTML, CSS, JavaScript, jQuery, Vue, Spring까지 정리하며 복습하였습니다.</p>
			</div>
			<div class="pro_ppt"><p><a href="#"/></a></p></div>
			<div class="pro_git"><a href="https://blog.naver.com/ancjf0601"><p>블로그</p></a></div>
		</div>
	</div>
	<div class="mobile">
		<p>모바일에서는 PPT와 Git 주소를 지원하지 않습니다.</p>
	</div>
</div>

<div id="tech">
	<div class="title">
		<p>Technology</p>
	</div>
	<div id="tech_box">
		<div id="tech_first">
			<div id="java" class="tech_list"><img alt="Java" src="/resources/image/java.png"><p>Java</p> </div>
			<div id="spring" class="tech_list"><img alt="Spring" src="/resources/image/spring.png"><p>Spring</p> </div>
			<div id="mybatis" class="tech_list"><img alt="Mybatis" src="/resources/image/mybatis.png"><p>Mybatis</p> </div>
			<div id="jQuery" class="tech_list"><img alt="jQuery" src="/resources/image/jQuery.png"><p>jQuery</p> </div>
		</div>
		<div id="tech_second">
			<div id="javascript" class="tech_list"><img alt="JavaScript" src="/resources/image/javascript.png"><p>JavaScript</p> </div>
			<div id="html" class="tech_list"><img alt="HTML" src="/resources/image/html.png"><p>HTML</p> </div>
			<div id="css" class="tech_list"><img alt="CSS" src="/resources/image/css.png"><p>CSS</p> </div>
			<div id="oracle" class="tech_list"><img alt="Oracle" src="/resources/image/oracle.png"><p>Oracle</p> </div>
		</div>
	</div>
</div>

<div id="aboutMe">
	<div class="title">
		<p>About Me</p>
	</div>
	<div id="about_out" class="about_border">
			<div id="text_box1" class="about_border"><p>Education</p></div>
			<div id="text_box1_1" class="about_border">
				ο <b>반응형 웹 개발 교육</b> : 응용SW 기초기술 활용, 프로그래밍 언어, 화면구현, UI구현, 서블릿 기반 프레임워크, 프로젝트<br>
				ο <b>JavaScript</b> : 타입, 연산자, 제어문, 배열, 함수, 객체, 이벤트, 예외처리, 정규표현식, jQuery<br>
				ο <b>Spring</b> : Annotation 기반 Controller 구현 가능, MVC패턴 이용 WebApp제작<br>
				ο <b>MyBatis</b> : MVC패턴 및 연동, XML이용한 SQL mapping<br>
				ο <b>Tomcat</b> : 서버 구축작업 및 사용<br>
				ο <b>JSP</b> : Java Bean활용, DB입출력, Model1/Model2 기반개발<br>
				ο <b>Oracle</b> : 기본 SQL문 작성, DB모델링 기법 및 정규화, 트랜잭션(개념, 처리방법)과 PL/SQL 작성<br>
				ο <b>HTML/CSS</b> : 시간표, 회원가입페이지 구현, 교육 후 미니프로젝트(상품Store 구현)<br>
				ο <b>Java</b> : 기본구조, 타입, 연산자, 제어문, 배열, 클래스와 객체, 메서드, 상속, 추상클래스, 인터페이스, jdbc이해 및 DB연동, GUI와 AWT활용, 이벤트처리, 계산기&달력 구현<br>
				ο <b>Python</b> : 기본구조, 연산자, 표준입출력, 반복문, 문자열, 라이브러리, 함수<br>
				ο <b>C언어</b> : 기본구조, 변수와 자료형, 기본입출력, 연산자, 제어문, 알고리즘, 함수, 배열, 포인터, 다중포인터, 동적메모리, 구조체
			</div>
			
   			<div id="text_box2" class="about_border"><p>Life Style</p></div>
			<div id="text_box2_1" class="about_border">
				<div class="box_gra"><p> </p></div>
				<div id="text_box2_1_1" class="box_m">
					<img alt="일상1" src="/resources/image/일상1.png">
					<img alt="일상2" src="/resources/image/일상2.png">
					<img alt="일상3" src="/resources/image/일상3.png"> 
					<p>여행과 게임, 액티비티 스포츠 등  친구들과 함께하는 시간을 소중하게 생각하며 좋아합니다.</p>
				</div>
				<div class="box_gra"><p> </p></div>
				<div id="text_box2_1_2" class="box_m">
					<img alt="취미1" src="/resources/image/취미생활1.png">
					<img alt="취미2" src="/resources/image/취미생활2.png">
					<p>운동과 스포츠를 즐기고 게임과 팬 활동을 해보기도 하며 낙서나 필기체 연습 등 다양한 분야에 관심을 두곤 합니다.</p>
				</div>
				<div class="box_gra"><p> </p></div>
				<div id="text_box2_1_3" class="box_m">
					<img alt="여행1" src="/resources/image/여행1.png">
					<img alt="여행2" src="/resources/image/여행2.png">
					<p>새로운 문화를 접하는 것을 좋아하며 필리핀, 일본(도쿄, 오사카, 교토), 코타키나발루 해외여행 경험이 있습니다. </p>
					<p>앞으로도 더 많은 곳을 가보고 싶고 세상을 바라보는 시야를 넓히며 저의 세상을 키워나가려 합니다.</p>
				</div>
				<div class="box_gra"><p> </p></div>
				<div id="text_box2_1_4" class="box_m">
					<img alt="대학1" src="/resources/image/대학생활1.png">
					<img alt="대학2" src="/resources/image/대학생활2.png">
					<p>컴퓨터 응용기계학과를 졸업하였으며 2년간 110학점  3.89/4.5의 학점으로 졸업하였습니다.</p>
				</div>
				<div class="box_gra"><p> </p></div>
				<div id="text_box2_1_5" class="box_m">
					<img alt="회사1" src="/resources/image/회사생활1.png">
					<img alt="회사2" src="/resources/image/회사생활2.png">
					<img alt="회사3" src="/resources/image/회사생활3.png">
					<p>1개월의 연수원 기간을 거쳐 2년 2개월 동안 에스원 TS 직군에 재직하였으며 삼성전자 화성사업장에 근무하였습니다.</p>
					<p>업무 숙지, 자기 개발, 어학 등 노력의 결실로 고과평가 최고등급 EX로 시작해 인정받는 회사생활을 하였고</p>
					<p>우연히 프로그래밍의 재미를 느끼고 배우다 본격적인 웹 개발자로서의 꿈을 펼치기 위해 퇴사를 결심하게 되었습니다.</p>
					<p>너무나 좋은 사람들과 즐겁게 근무하였고 퇴사 후에도 좋은 관계를 이어가고 있으며 행복한 기억으로 남아있습니다.</p>
				</div>
				<div class="box_gra"><p> </p></div>
			</div>

	
		
			<div id="text_box3" class="about_border"><p>꿈 & 목표</p></div>
			<div id="text_box3_1" class="about_border">&nbsp;개발자가 되어 회사에서는 누군가가 원하는 개발을 하겠지만, 저의 시간에는 저를 위한 개발을 하면서 누구나 될 수 있는 개발자가 아닌 아무나 될 수 없는 개발자가 되어 더 넓은 세상을 보고 느끼며 성장하고 싶습니다.<br><br>
					&nbsp;현재 보유 중인 기술은 더욱 깊이 있게 배우고 클라우드, AI, 블록체인 등도 기회가 되는 데로 IT의 발전에 맞춰 자격증 취득도 하고 지식을 쌓아 여러 분야를 접목해 더 좋은 세상을 프로그래밍할 수 있는 개발자가 되고 싶습니다.
			</div>
			
			<div id="text_box4" class="about_border"><p>현재 진행중</p></div>
			<div id="text_box4_1" class="about_border">1. 정보처리산업기사 필기 합격 후 실기 준비 중 입니다.</div>
			<div id="text_box4_2" class="about_border">2. 전문학사에서 나아가 학점은행제로 컴퓨터공학 학위취득을 위한 공부 중이며  정보처리 합격 시 졸업 가능한 상태입니다.</div>
			<div id="text_box4_3" class="about_border">3. 네트워크관리사와 컴퓨터 활용능력 공부 중입니다.</div>
			<div id="text_box4_4" class="about_border">4. intelliJ프로그램으로 스프링부트 프로젝트 진행 중입니다.</div>
	</div>
</div>
			<div class="mobile">
				<p>모바일에서는 Life Style 항목을 지원하지 않습니다.</p>
			</div>
<a id="move_top_btn" href="#"><i class="fas fa-arrow-alt-circle-up fa-2x" aria-hidden="true">&nbsp;</i></a>

<div id="footer">
	<div id="ps">
		<p><b>-A rolling stone gathers no moss-</b> 구르는 돌에는 이끼가 끼지 않는다. <br>
		제 좌우명으로 부지런하고 꾸준히 노력하는 사람은 침체되지 않고 발전한다는 뜻 입니다.<br>
		계속해서 구르며 끊임없이 노력하는 개발자가 되겠습니다!</p>
	</div>
	<p>문의 및 조언은 <b>ancjf0601@naver.com</b>으로 부탁드립니다!</p>
</div>
</body>
</html>
