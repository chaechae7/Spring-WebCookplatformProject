  $().ready(function(){
		console.log('jquery로드 완료');
		subCtgload();
			
	});
	
	function subCtgload(){
		/* 메인 카테고리 선택에 따른 변경 */
		console.log("카테고리 리스트 가져오기중");
		$(".main-ctg-menu p").on('click', function(){
			/* 이미 선택된 분류라면 아래의 코드 수행하지 않음 */
		 	if($(this).hasClass("active"))
		 	{	return; }
/*		 	
		 	let ctgList = ${categoryList};*/
		 	
		 	
			console.log(ctgList);
			console.log($(this));
			let mainMenuCtg = {'mainMenuCtg' : $(this).html()};
			
			$(".main-ctg-menu p").removeClass("active");
		 	$(this).addClass("active");
			
			
				/*	 서브 카테고리 교체작업 
					let subMenuCtg = ' '; 
					$.each(data,function(index, item){
						if(index == 0){
							subMenuCtg += '<li> <p class="active">'+item+'</p> </li>';
						}else{
							subMenuCtg += '<li> <p>'+item+'</p> </li>';
						}
						console.log(item);
					});
	
					$(".sub-ctg-menu").html(subMenuCtg);*/
		
			
		});
	}; //서브 카테고리 교체 끝
    