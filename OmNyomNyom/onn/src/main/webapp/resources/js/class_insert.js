	//온로드 함수
	window.onload = function() {
		
		$("#input-date").datepicker({
			
			minDate : new Date()
			
		});
		
		
		$("#input-date").datepicker({
			onSelect: function onSelect(dattte){
				console.log("찍힌 시간"+dattte);
			}
		});
		//이미지 불러오기 후 처리
		function readURL(input) {
			if (input.files && input.files[0]) {
				var imgFile = $(input).val();
				var fileForm = /(.*?)\.(jpg|jpeg|png)$/i;
				var maxSize = 5 * 1024 * 1024;
				var fileSize;

				if (imgFile != "" && imgFile != null) {
					fileSize = input.files[0].size;
					if (!imgFile.match(fileForm)) {
						alert("이미지 파일만 업로드 가능");
						$(input).val(null);
						return;
					} else if (fileSize > maxSize) {
						alert("파일 사이즈는 5MB까지 가능");
						$(input).val(null);
						return;
					}
				}

				var reader = new FileReader();

				reader.onload = function(e) {
					$('#image_section').attr('src', e.target.result).show();
					let $uploadbtn = $("#uploadbtn");
					$uploadbtn.html("");
					$uploadbtn.addClass("uploading");
					setTimeout(function() {
						$uploadbtn.removeClass('uploading');
						$uploadbtn.html("Upload Files");
					}, 1200);
				};

				reader.readAsDataURL(input.files[0]);
			} else {
				$('#image_section').hide();
			}
			
			
		}

		//이미지 불러오기
		$("#imgInput").change(function() {

			readURL(this);
		});

		//시작시 이미지
		$("#image_section").hide();

		//CK에디터 불러오기
		CKEDITOR.replace('onedayContent',{filebrowserUploadUrl:'/mine/imageUpload.do'});
		

		if (!String.prototype.trim) {
			(function() {
				// Make sure we trim BOM and NBSP
				var rtrim = /^[\s\uFEFF\xA0]+|[\s\uFEFF\xA0]+$/g;
				String.prototype.trim = function() {
					return this.replace(rtrim, '');
				};
			})();
		}
		[].slice.call( document.querySelectorAll( 'input.input__field' ) ).forEach( function( inputEl ) {
			// in case the input is already filled..
			if( inputEl.value.trim() !== '' ) {
				classie.add( inputEl.parentNode, 'input--filled' );
			}
			// events:
			inputEl.addEventListener( 'focus', onInputFocus );
			inputEl.addEventListener( 'blur', onInputBlur );
		} );
		function onInputFocus( ev ) {
			classie.add( ev.target.parentNode, 'input--filled' );
		}
		function onInputBlur( ev ) {
			if( ev.target.value.trim() === '' ) {
				classie.remove( ev.target.parentNode, 'input--filled' );
			}
		}

	};

	//이미지 불러오기 버튼 처리
	function upload(ref) {
		$("#imgInput").click();
	};

	// 클래스 날짜 추가
	function addClassTime() {
		let $inputDate = $("#input-date");
		if ($inputDate.val() == "" || $inputDate.val() == null)
			return;
		let $inputDimeList = $("#input-date-list")
		$inputDimeList
				.append("<div class='row m-auto'>"
						+ "<input class='col-9' id='input-class-date' name='classdate' type='text' value='"
						+ substring_($inputDate.val())
						+ "' readonly/>"
						+ "<button class='col site-btn sb-gradient px-3 ml-3' style='min-width: 0;' type='button' onclick='removeClassTime(this);'>제거</button>"
						+ "</div>");

	}
	// 클래스 날짜 제거
	function removeClassTime(bt) {
		let $bt = $(bt);
		$bt.parent().remove();
	}
	
	function substring_(something){
		var substred = something.substr();
		return substred;
	}