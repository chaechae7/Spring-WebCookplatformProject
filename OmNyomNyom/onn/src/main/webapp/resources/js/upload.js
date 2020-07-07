//온로드 함수
$(function() {
	// 이미지 불러오기 후 처리
	function readURL(input) {
		if (input.files && input.files[0]) {
			var imgFile = $(input).val();
			var fileForm = /(.*?)\.(mp4|mov|mpeg4|avi|wmv)$/i;
			var maxSize = 64 * 1000 * 1000 * 1000;
			var fileSize;

			if (imgFile != "" && imgFile != null) {
				fileSize = input.files[0].size;
				if (!imgFile.match(fileForm)) {
					alert("비디오 파일(mp4,mov,mpeg4,avi,wmv)만 업로드 가능");
					$(input).val(null);
					return;
				} else if (fileSize > maxSize) {
					alert("파일 사이즈는 64GB까지 가능");
					$(input).val(null);
					return;
				}
			}

			var reader = new FileReader();

			reader.onload = function(e) {
				// $('#image_section').show();
				// $('.image_section_src').attr('src', e.target.result).show();
				$('#video_section').attr('src', e.target.result).show();
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
			$('#video_section').hide();
		}
	}

	// 이미지 불러오기
	$("#videoInput").change(function() {

		readURL(this);
	});

	// 시작시 이미지
	$("#video_section").hide();

	// CK에디터 불러오기
//	CKEDITOR.replace('editor1');

});

// 이미지 불러오기 버튼 처리
function upload(ref) {
	$("#videoInput").click();
};



var tag = document.createElement('script');// 이거 뭔지 모름
tag.src = "https://www.youtube.com/iframe_api";// api 주소
var firstScriptTag = document.getElementsByTagName('script')[0];// 이거 뭔지 모름
firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);// 이거 뭔지 모름
var player;// 유튜브 api 전역변수
var setVideoId = "t4Es8mwdYlE";// 유튜브영상 ID
function onYouTubeIframeAPIReady() {
  player = new YT.Player('testPTag',{
              videoId: setVideoId,
  });
}


// 유튜브 영상 redirect
function hreflink(s){
  player.loadVideoById(setVideoId, s);
}



// 해시태그부분

	// if IE, add IE tagify's polyfills
	!function( d ) {
		if( !d.currentScript ){
			var s = d.createElement( 'script' );
			s.src = 'dist/tagify.polyfills.min.js';
			d.head.appendChild( s );
		}
	}(document)



	var isIE = !document.currentScript;

	function renderPRE(currentScript, codeScriptName){
		if( isIE ) return;

		function removeLast(s, r){
		  s = s.split(r)
		  return s.slice(0,-1).join(r) + s.pop()
		}

		setTimeout(function(){
			var jsCode = document.querySelector("[data-name='"+ codeScriptName +"']").innerHTML;

			// cleanup closure wraper
			jsCode = jsCode.replace("(function(){", "").trim();
			jsCode = removeLast(jsCode, "})()")

			// escape angled brackets between two _ESCAPE_START_ and _ESCAPE_END_ comments
			let textsToEscape = jsCode.match(new RegExp("// _ESCAPE_START_([^]*?)// _ESCAPE_END_", 'mg'));
			if (textsToEscape) {
				textsToEscape.forEach(function(textToEscape){
					jsCode = jsCode.replace(textToEscape, textToEscape.replace(/</g, "&lt" )
																	  .replace(/>/g, "&gt" )
																	  .replace("// _ESCAPE_START_", "")
																	  .replace("// _ESCAPE_END_", "")
																	  .trim());
				});
			}
			currentScript.insertAdjacentHTML('afterend', "<pre class='language-js'><code>" + jsCode + "</code></pre>");
		}, 500);
	}

	// detect modern browser and enhance console logs with colors
	if( typeof(Intl) )
		try{
		   // console.log = ((_c) => (...args) => args.length > 1 ? _c("%c "+ args[0], 'background:indianred; color:white; border-radius:3px; padding:1px;', ...args.slice(1)) : _c(...args))(console.log);
		}
		catch(err){}

//해시태그 스크립트

		/*(function(){
	var input = document.querySelector('input[name=input]'),
		whitelist = ["A# .NET", "A# (Axiom)", "A-0 System", "A+", "A++", "ABAP", "ABC", "ABC ALGOL", "ABSET", "ABSYS", "ACC", "Accent", "Ace DASL", "ACL2", "Avicsoft", "ACT-III", "Action!", "ActionScript", "Ada", "Adenine", "Agda", "Agilent VEE", "Agora", "AIMMS", "Alef", "ALF", "ALGOL 58", "ALGOL 60", "ALGOL 68", "ALGOL W", "Alice", "Alma-0", "AmbientTalk", "Amiga E", "AMOS", "AMPL", "Apex (Salesforce.com)", "APL", "AppleScript", "Arc", "ARexx", "Argus", "AspectJ", "Assembly language", "ATS", "Ateji PX", "AutoHotkey", "Autocoder", "AutoIt", "AutoLISP / Visual LISP", "Averest", "AWK", "Axum", "Active Server Pages", "ASP.NET", "B", "Babbage", "Bash", "BASIC", "bc", "BCPL", "BeanShell", "Batch (Windows/Dos)", "Bertrand", "BETA", "Bigwig", "Bistro", "BitC", "BLISS", "Blockly", "BlooP", "Blue", "Boo", "Boomerang", "Bourne shell (including bash and ksh)", "BREW", "BPEL", "B", "C--", "C++ – ISO/IEC 14882", "C# – ISO/IEC 23270", "C/AL", "Caché ObjectScript", "C Shell", "Caml", "Cayenne", "CDuce", "Cecil", "Cesil", "Céu", "Ceylon", "CFEngine", "CFML", "Cg", "Ch", "Chapel", "Charity", "Charm", "Chef", "CHILL", "CHIP-8", "chomski", "ChucK", "CICS", "Cilk", "Citrine (programming language)", "CL (IBM)", "Claire", "Clarion", "Clean", "Clipper", "CLIPS", "CLIST", "Clojure", "CLU", "CMS-2", "COBOL – ISO/IEC 1989", "CobolScript – COBOL Scripting language", "Cobra", "CODE", "CoffeeScript", "ColdFusion", "COMAL", "Combined Programming Language (CPL)", "COMIT", "Common Intermediate Language (CIL)", "Common Lisp (also known as CL)", "COMPASS", "Component Pascal", "Constraint Handling Rules (CHR)", "COMTRAN", "Converge", "Cool", "Coq", "Coral 66", "Corn", "CorVision", "COWSEL", "CPL", "CPL", "Cryptol", "csh", "Csound", "CSP", "CUDA", "Curl", "Curry", "Cybil", "Cyclone", "Cython", "Java", "Javascript", "M2001", "M4", "M#", "Machine code", "MAD (Michigan Algorithm Decoder)", "MAD/I", "Magik", "Magma", "make", "Maple", "MAPPER now part of BIS", "MARK-IV now VISION:BUILDER", "Mary", "MASM Microsoft Assembly x86", "MATH-MATIC", "Mathematica", "MATLAB", "Maxima (see also Macsyma)", "Max (Max Msp – Graphical Programming Environment)", "Maya (MEL)", "MDL", "Mercury", "Mesa", "Metafont", "Microcode", "MicroScript", "MIIS", "Milk (programming language)", "MIMIC", "Mirah", "Miranda", "MIVA Script", "ML", "Model 204", "Modelica", "Modula", "Modula-2", "Modula-3", "Mohol", "MOO", "Mortran", "Mouse", "MPD", "Mathcad", "MSIL – deprecated name for CIL", "MSL", "MUMPS", "Mystic Programming L"],
	
		// init Tagify script on the above inputs
		tagify = new Tagify(input, {
			// after 2 characters typed, all matching values from this list will be suggested in a dropdown
			 //whitelist: [].concat(whitelist)
		})
	
	
	// "remove all tags" button event listener
	document.querySelector('.tags--removeAllBtn')
		.addEventListener('click', tagify.removeAllTags.bind(tagify))
	
	// Chainable event listeners
	tagify.on('add', onAddTag)
		  .on('remove', onRemoveTag)
		  .on('input', onInput)
		  .on('edit', onTagEdit)
		  .on('invalid', onInvalidTag)
		  .on('click', onTagClick)
		  .on('focus', onTagifyFocusBlur)
		  .on('blur', onTagifyFocusBlur)
		  .on('dropdown:hide dropdown:show', e => console.log(e.type))
		  .on('dropdown:select', onDropdownSelect)
	
	var mockAjax = (function mockAjax(){
		var timeout;
		return function(duration){
			clearTimeout(timeout); // abort last request
			return new Promise(function(resolve, reject){
				timeout = setTimeout(resolve, duration || 1000, whitelist)
			});
		}
	})()
	
	// tag added callback
	function onAddTag(e){
		console.log("onAddTag: ", e.detail);
		console.log("original input value: ", input.value)
		tagify.off('add', onAddTag) // exmaple of removing a custom Tagify event
	}
	
	// tag remvoed callback
	function onRemoveTag(e){
		console.log("onRemoveTag:", e.detail, "tagify instance value:", tagify.value)
	}
	
	// on character(s) added/removed (user is typing/deleting)
	function onInput(e){
		console.log("onInput: ", e.detail);
		tagify.settings.whitelist.length = 0; // reset current whitelist
		tagify.loading(true).dropdown.hide.call(tagify) // show the loader animation
	
		// get new whitelist from a delayed mocked request (Promise)
		mockAjax()
			.then(function(result){
				// https://stackoverflow.com/q/30640771/104380
				// replace tagify "whitelist" array values with new values (result)
				tagify.settings.whitelist.splice(0, result.length, ...result)
				// render the suggestions dropdown. "newValue" is when "input" event is called while editing a tag
				tagify.loading(false).dropdown.show.call(tagify, e.detail.value);
			})
	}
	
	function onTagEdit(e){
		console.log("onTagEdit: ", e.detail);
	}
	
	// invalid tag added callback
	function onInvalidTag(e){
		console.log("onInvalidTag: ", e.detail);
	}
	
	// invalid tag added callback
	function onTagClick(e){
		console.log(e.detail);
		console.log("onTagClick: ", e.detail);
	}
	
	function onTagifyFocusBlur(e){
		console.log(e.type, "event fired")
	}
	
	function onDropdownSelect(e){
		console.log("onDropdownSelect: ", e.detail)
	}
	})()*/

	
	

//	$(function(){
//	var input = document.querySelector('input[name="input-custom-dropdown"]'),
//		// init Tagify script on the above inputs
//		tagify = new Tagify(input, {
//		  whitelist: ["한식/찜", "중식/찜", "일식/찜", "A+", "A++", "ABAP", "ABC", "ABC ALGOL", "ABSET", "ABSYS", "ACC", "Accent", "Ace DASL", "ACL2", "Avicsoft", "ACT-III", "Action!", "ActionScript", "Ada", "Adenine", "Agda", "Agilent VEE", "Agora", "AIMMS", "Alef", "ALF", "ALGOL 58", "ALGOL 60", "ALGOL 68", "ALGOL W", "Alice", "Alma-0", "AmbientTalk", "Amiga E", "AMOS", "AMPL", "Apex (Salesforce.com)", "APL", "AppleScript", "Arc", "ARexx", "Argus", "AspectJ", "Assembly language", "ATS", "Ateji PX", "AutoHotkey", "Autocoder", "AutoIt", "AutoLISP / Visual LISP", "Averest", "AWK", "Axum", "Active Server Pages", "ASP.NET", "B", "Babbage", "Bash", "BASIC", "bc", "BCPL", "BeanShell", "Batch (Windows/Dos)", "Bertrand", "BETA", "Bigwig", "Bistro", "BitC", "BLISS", "Blockly", "BlooP", "Blue", "Boo", "Boomerang", "Bourne shell (including bash and ksh)", "BREW", "BPEL", "B", "C--", "C++ – ISO/IEC 14882", "C# – ISO/IEC 23270", "C/AL", "Caché ObjectScript", "C Shell", "Caml", "Cayenne", "CDuce", "Cecil", "Cesil", "Céu", "Ceylon", "CFEngine", "CFML", "Cg", "Ch", "Chapel", "Charity", "Charm", "Chef", "CHILL", "CHIP-8", "chomski", "ChucK", "CICS", "Cilk", "Citrine (programming language)", "CL (IBM)", "Claire", "Clarion", "Clean", "Clipper", "CLIPS", "CLIST", "Clojure", "CLU", "CMS-2", "COBOL – ISO/IEC 1989", "CobolScript – COBOL Scripting language", "Cobra", "CODE", "CoffeeScript", "ColdFusion", "COMAL", "Combined Programming Language (CPL)", "COMIT", "Common Intermediate Language (CIL)", "Common Lisp (also known as CL)", "COMPASS", "Component Pascal", "Constraint Handling Rules (CHR)", "COMTRAN", "Converge", "Cool", "Coq", "Coral 66", "Corn", "CorVision", "COWSEL", "CPL", "CPL", "Cryptol", "csh", "Csound", "CSP", "CUDA", "Curl", "Curry", "Cybil", "Cyclone", "Cython", "Java", "Javascript", "M2001", "M4", "M#", "Machine code", "MAD (Michigan Algorithm Decoder)", "MAD/I", "Magik", "Magma", "make", "Maple", "MAPPER now part of BIS", "MARK-IV now VISION:BUILDER", "Mary", "MASM Microsoft Assembly x86", "MATH-MATIC", "Mathematica", "MATLAB", "Maxima (see also Macsyma)", "Max (Max Msp – Graphical Programming Environment)", "Maya (MEL)", "MDL", "Mercury", "Mesa", "Metafont", "Microcode", "MicroScript", "MIIS", "Milk (programming language)", "MIMIC", "Mirah", "Miranda", "MIVA Script", "ML", "Model 204", "Modelica", "Modula", "Modula-2", "Modula-3", "Mohol", "MOO", "Mortran", "Mouse", "MPD", "Mathcad", "MSIL – deprecated name for CIL", "MSL", "MUMPS", "Mystic Programming L"],
//		  maxTags: 1,
//		  dropdown: {
//			maxItems: 20,           // <- mixumum allowed rendered suggestions
//			classname: "tags-look", // <- custom classname for this dropdown, so it could be targeted
//			enabled: 0,             // <- show suggestions on focus
//			closeOnSelect: false    // <- do not hide the suggestions dropdown once an item has been selected
//		  }
//		});
//	});

//요리방법 타임스탬프

	$(function() {
		$('#participants').multiInput({
			json: true,
			input: $('<div class="row inputElement">\n' +
				'<div class="multiinput-title col-xs-12">요리방법<span class="number">1</span></div>\n' +
				'<div class="form-group col-xs-6">\n' +
				'<input class="form-control" name="tn_firstname" placeholder="ex)60 = 1분" type="number">\n' +
				'</div>\n' +
				'<div class="form-group col-xs-6">\n' +
				'<input class="form-control" name="tn_lastname" placeholder="조리방법입력" type="text">\n' +
				'</div>\n' +
				'</div><hr>\n'),
				
			limit: 20,
			onElementAdd: function (el, plugin) {
				console.log(plugin.elementCount);
			},
			onElementRemove: function (el, plugin) {
				console.log(plugin.elementCount);
			}
		});
	});




// 클래스 날짜 추가
function addIngredient(){
    let $inputIngredient = $("#input-ingredient");
	let $inputIngMass = $("#input-ing-mass");
	let $inputIngNumber = $("#input-ing-number");
    if($inputIngredient.val() == "" || $inputIngredient.val() == null){
    	alert("재료명을 입력하세요.");
        return;
    }
    else if($inputIngMass.val() == "" || $inputIngMass.val() == null){
    	alert("계량을 입력하세요.");
    	return;
    }
    let $inputDimeList = $("#input-date-list")
    console.log("로그");
    $inputDimeList.append("<div class='row m-auto'>"
                            +'<span class="input col-4 p-0">'
                            +'<input name="ingr_name" class="form-control" type="text" autocomplete="off" value="'+ $inputIngredient.val() +'" readonly/>'
							+'</span>'
							+'<span class="input col-4 p-0">'
                            +'<input name="ingr_mass" class="form-control" type="text" autocomplete="off" value="'+ $inputIngMass.val() +'" readonly/>'
							+'</span>'
							+'<input name="ingr_number" type="number" hidden value="'+$inputIngNumber.val()+'">'
                            +'<div class="col py-1 pr-0 input">'
							+'<i class="fa fa-lg fa-minus-circle" style="min-width: 100%;" onclick="removeClassTime(this);" type="button"></i>'
                        	// +'<button class="site-btn sb-gradient px-3" style="min-width: 100%;" type="button" onclick="removeClassTime(this);">제거</button>'
							
							
                        	+'</div>'
							// +"<button class='col site-btn sb-gradient px-3 ml-3' style='min-width: 0;' type='button' onclick='removeClassTime(this);'>제거</button>"
                         +'</div>');
    $inputIngredient.val("");
    $inputIngMass.val("");
    $inputIngNumber.val(0);

}
// 클래스 날짜 제거
function removeClassTime(bt){
    let $bt = $(bt);
    $bt.parent().parent().remove();
}
