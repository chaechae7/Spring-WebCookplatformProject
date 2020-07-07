    //회원가입 javascript
$(function(){
		console.log("signup.js");
	    //로그인%회원가입 기능
	    var signUpButton = document.getElementById('signUp');
	    var signInButton = document.getElementById('signIn');
	    var container = document.getElementById('login_container');
	    console.log('signUpButton='+signUpButton);
	    signUpButton.addEventListener('click', function(event) {
	        login_container.classList.add("right-panel-active");
	    });

	    signInButton.addEventListener('click', function(event) {
	        login_container.classList.remove("right-panel-active");
	    });
	    
	   

	    console.log($("#memberId"));
		
		    $("#enrollBtn").click(()=>{
		    	console.log("확인 찎히니");
		    	
		    	var regExp6 = /^.*(?=^.{6,20}$)(?=.*\d)(?=.*[a-zA-Z]).*$/g;
		    	
		    	var memberId = $("#memberId");
				if(memberId.val().trim().length != regExp6){
					alert("아이디는 6~20자리 숫자/문자를 포함해야합니다.");
					memberId.focus();
					return false;
				}
				
				/*if(!regExpTest(regExp6, pwd, "아이디는 6~20자리 숫자/문자를 포함해야합니다.")){
		            return false;
				}*/
				
				$("#memberenrollFrm").submit();
		    });









		//유효성 검사
		function validate(){
		    var pwd = document.getElementById("password_");
		    var email = document.getElementById("email");
		    
		    console.log("함수 실행!");
		    console.log(pwd.value);
		    console.log(email.value);
	
	
		    //2.비밀번호 확인 검사
		    //숫자/문자 포함 형태의 8~15자리 이내의 암호 정규식 
		    var regExp6 = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z]).*$/g;
	
		    if(!regExpTest(regExp6, pwd, "비밀번호는 8~15자리 숫자/문자를 포함해야합니다.")){
	            return false;
		    }
		    
	
		    //5.이메일 검사
		    // 4글자 이상(\w = [a-zA-Z0-9_], [\w-\.]) @가 나오고
		    // 1글자 이상(주소). 글자 가 1~3번 반복됨
		    if(!regExpTest(/^[\w]{4,}@[\w]+(\.[\w]+){1,3}$/, email, "이메일 형식에 어긋납니다.")){
	            return false;        	
		    }
		    console.log("통과!");
		    return true;
		};

		function regExpTest(regExp, el, msg){
		    if(regExp.test(el.value))
		        return true;
		    //적합한 문자열이 아닌 경우
		    alert(msg);
		    el.value="";
		    el.focus();
		    return false;
		}

		
		//패스워드 유효성
		function isEqualPwd() {
			//패스워드 값 저장
			let password = document.getElementById("password_").value;
			let passwordChk = document.getElementById("password_2").value;
			//패스워드, 패스워드 확인 비교
			if (password != passwordChk) {
			    document.getElementById("errorPwChk").innerHTML = "<font color=red>*입력한 비밀번호가 다릅니다.</font>";
			    document.getElementById("password_").focus();
			}
			else {
			    document.getElementById("errorPwChk").innerHTML = "";
			}
		};

		
		//이메일 유효성 (입력하지 않은 경우)
		function emailValidate() {
		    let userEmailVal = email.value.trim();
		    console.log(userEmailVal);
		    if (userEmailVal.length == 0) {
		        document.getElementById("errorEmail").innerHTML = "<font color=red>*이메일를 입력하지 않았습니다.</font>";
		        email.focus();
		    }
		    else {
		        document.getElementById("errorEmail").innerHTML = "";
		    }
		};

		
		//패스워드 유효성 (입력하지 않은 경우)
		function pwValidate() {
		    let userPwVal = password.value.trim();
		    if (userPwVal.length == 0) {
		        document.getElementById("errorPw").innerHTML = "<font color=red>*비밀번호를 입력하지 않았습니다.</font>";
		        password.focus();
		    } else {
		        document.getElementById("errorPw").innerHTML = "";
		    }
		};


});