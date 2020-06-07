<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- 위 3개의 메타 태그는 *반드시* head 태그의 처음에 와야합니다; 어떤 다른 콘텐츠들은 반드시 이 태그들 *다음에* 와야 합니다 -->
    <title>로그인 화면</title>

    <!-- 부트스트랩 -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
 
    <!-- IE8 에서 HTML5 요소와 미디어 쿼리를 위한 HTML5 shim 와 Respond.js -->
    <!-- WARNING: Respond.js 는 당신이 file:// 을 통해 페이지를 볼 때는 동작하지 않습니다. -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
		<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
 
  		<script src="js/jquery.min.js"></script>
		<script src="js/jquery.dropotron.min.js"></script>
		<script src="js/skel.min.js"></script>
		<script src="js/skel-layers.min.js"></script>
		<script src="js/init.js"></script>
			<link rel="stylesheet" href="css/skel.css" />
			<link rel="stylesheet" href="css/style.css" />
			<link rel="stylesheet" href="css/style-wide.css" />
		<!--[if lte IE 8]><link rel="stylesheet" href="css/ie/v8.css" /><![endif]-->
<style>
#join span{
	color: white;
	font-size: 12px;

}


</style>	
		
<script>	
$(document).ready(function() {
	
	var getName= RegExp(/^[A-Za-z가-힣]{2}/);
	var re = RegExp(/[a-zA-Z0-9]{4,12}$/);
	var getPass = RegExp(/[a-zA-Z]{1}[0-9]{1}/);
	var re2 = RegExp(/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i);
	var getPhone = RegExp(/^(010|011)[-\s]?\d{3,4}[-\s]?\d{4}$/);
	var getEmail = RegExp(/^[\w\.-]{1,64}@[\w\.-]{1,252}\.\w{2,4}$/);	
	var getBirth = RegExp(/^[0-9]{2}[0,1]{1}[0-9]{1}[0-3]{1}[0-9]{1}$/);
	
	
	$("#id_sp2").hide()
	$("#pass_sp1").hide()
	$("#pass_sp2").hide()
	$("#pass_sp3").hide()
	$("#name_sp").hide()
	$("#ph_sp").hide()
	$("#email_sp").hide()
	$("#birth_sp").hide()
	
	
	$("#id").blur(function() {
				 
		 if(!re.test($("#id").val())){
			 $("#id_sp2").show('fast');
			 $("#id").val("");
			/* alert("id는 4자이상 입력해야 합니다."); */
		 }else{$("#id_sp2").hide('fast');}
	
	});//id
	
	$("#pass").blur(function() {
		 if(!re.test($("#pass").val())){
			 $("#pass_sp1").show('fast');
			 $("#pass").val("");
		 }else{$("#pass_sp1").hide('fast');}
	 
		 if(!getPass.test($("#pass").val())){
			 $("#pass_sp2").show('fast');
			 $("#pass").val("");
		 }else{$("#pass_sp2").hide('fast');}
	
	});//pass
	
	$("#pass-repeat").blur(function() {
		var pass1 = $("#pass").val();
		var pass2 = $("#pass-repeat").val();
		 if(pass1!=pass2){
			 $("#pass_sp3").show('fast');
			 $("#pass-repeat").val("");
		 }else{$("#pass_sp3").hide('fast');}
	
	});//pass

	
	$("#name").blur(function() {		
		 if(!getName.test($("#name").val())){
			 $("#name_sp").show('fast');
			 $("#name").val("");
		 }else{$("#name_sp").hide('fast');} 
	});//name

	$("#phone").blur(function() {	
		 if(!getPhone.test($("#phone").val())){
			 $("#ph_sp").show('fast');
			 $("#phone").val("");
		 }else{$("#ph_sp").hide('fast');} 	 
	});//phone
	
	$("#email").blur(function() {	
		 if(!getEmail.test($("#email").val())){
			 $("#email_sp").show('fast');
			 $("#email").val("");
		 }else{$("#email_sp").hide('fast');} 	 
	});//email
	
	$("#birth").blur(function() {	
		 if(!getBirth.test($("#birth").val())){
			 $("#birth_sp").show('fast');
			 $("#birth").val("");
		 }else{$("#birth_sp").hide('fast');} 	 
	});//birth

});
	  
	//아이디 중복 체크 버튼 클릭시 호출 되는 함수 
 	function winopen() {
 		 
		//id입력란이 공백일경우  아이디를 입력하세요 !! 메세지를 띄우고  아이디입력란에 포커스가 깜박이게 
		if(document.fr.id.value == ""){
			window.alert("아이디를 입력해주세요");
			document.fr.id.focus();
			return;
		}
 		
		//창열기 
		var chkid = document.fr.id.value; //아이디입력란에 작성한 값 얻기 
		window.open("IDcheck.jsp?chkid="+ chkid, "", "width=400, height=200");
		
		
	}

 	function openmail(){
 		
 		if(document.fr.email.value == ""){
 			alert("이메일을 입력하세요.");
 			//아이디 입력 <input>태그에 포커스깜빡
 			document.fr.email.focus();
 			return;
 		}
 		
 		var femail = document.fr.email.value;
 		var check = -1;
 		
 		
 		window.open("join_IDCheck2.jsp?email="+femail+"&check="+check,"","width=400,height=200");
 		
 	
 	}
	
	
	
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;

                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('sample6_address').value = fullAddr;

                // 커서를 상세주소 필드로 이동한다.
                document.getElementById('sample6_address2').focus();
            }
        }).open();
    }
	
    function inputIdChk(){
        document.fr.idDuplication.value ="idUncheck";
    }

    function checkVlaue() {
    	
    	if(!fr.pass.value){
    		alert("비밀번호를 입력해주세요");
    		return false;
    	}
    	
    	if(!fr.name.value){
    		alert("이름을 입력해주세요");
    		return false;
    	}
    	
    	if(!fr.phone.value){
    		alert("전화번호를 입력해주세요");
    		return false;
    	}
    	
    	if(!fr.email.value){
    		alert("이메일을 입력해주세요");
    		return false;
    	}
    	
    	
		if(fr.idDuplication.value != "idcheck"){
			alert("아이디 중복체크를 해주세요");
			return false;
		}
		
		else{
			document.fr.submit();
		}
	}
</script>	

	</head>
	<body>
	
		<!-- Wrapper -->

				<!-- Header -->
										<jsp:include page="header.jsp"/>

				


 
    
 <div id="footer" class="wrapper style2">
			<div class="container">
				<section>
					<header class="major">
						<h2>회원가입</h2>
					</header>
					<form method="post" action="joinPro.jsp" id="join" method="post" name ="fr">
						<div class="row half">
							<div class="12u">
							<label for="id"><b>ID</b>
							<span id="id_sp2"> *아이디는 4~12자의 영문 대소문자와 숫자만 가능합니다</span></label>
							<input type="text"  placeholder="Enter Id"  onkeydown="inputIdChk()" name="id" id="id" required>
							<button type="button" class="button alt" id="BTN_USERID_CHECK" onclick="winopen();">ID 중복체크</button>
							<input type="hidden" name="idDuplication" value="idUncheck"> 
							</div>
							
							
						</div>
						<div class="row half">
							<div class="12u">
								<label for="psw"><b>Password</b>  <span id="pass_sp1"> *비밀번호는 4~12자의 영문 대소문자와 숫자만 가능합니다 <br/></span>
							    <span id="pass_sp2"> *비밀번호에는 하나이상의 문자와 숫자가 포함되어야 합니다.</span> </label>
							    <input type="password" placeholder="Enter Password" name="passwd" id="pass"required>
							</div>
						</div>
						<div class="row half">
							<div class="12u">
							 <label for="psw-repeat"><b>Repeat Password</b>
						    <span id="pass_sp3"> *비밀번호가 다릅니다.</span></label>
						    <input type="password" placeholder="Repeat Password" name="pass-repeat" id="pass-repeat"required>
							</div>
						</div> 
						
						<div class="row half">
							<div class="12u">
								<label for="name"><b>Name</b>
  								<span id="name_sp"> *이름은 2자 이상의 문자만 입력할 수 있습니다.</span></label>
    							<input type="text" placeholder="Enter Name" name="name" id="name" required>
							</div>
						</div>
						
						<div class="row half">
							<div class="12u">
							 <label for="email"><b>Email</b>
							 <span id="email_sp"> *이메일 형식이 잘못되었습니다.</span></label>
							 <input type="email" name="email"  placeholder="Email" required />
							 <input type="button" value="이메일인증" class="button alt" onclick="openmail()"><br>	
							</div>
						</div>
						<div class="row half">
							<div class="12u">
								<label for="addr"><b>Address</b></label>	<br>
								<input type="button" class="button alt" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" id="postcode_btn"><br>
								
								<input type="text" id="sample6_postcode" name="address1" placeholder="우편번호" >
								<br>
								<input type="text" id="sample6_address" name="address2" placeholder="주소">
								<br>
								<input type="text" id="sample6_address2" name="address3" placeholder="상세주소">
								<br>
							</div>
						</div>
						
						
						
	
						
						<div class="row half">
							<div class="12u">
								<ul class="actions">
									<li>
										<input type="submit" value="Register" class="button alt" />
										<input type="reset" value="Reset" class="button alt" />
										
									</li>
								</ul>
							</div>
						</div>
					</form>
				</section>
			</div>
		</div>

    	<!-- Copyright -->
				<jsp:include page="bottom.jsp"/>

    
    
  </body>
</html>