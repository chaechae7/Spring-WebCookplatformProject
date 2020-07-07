<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"> 
<jsp:param value="안녕 옴뇸뇸!" name="pageTitle"/>
</jsp:include>


 <section class="page-top-section page-sp set-bg" data-setbg="">
        <div class="container">
            <div class="row">
                <div class="col-lg-7 m-auto text-white">

                    <h2>CHEF CHANNAL</h2>
					<p>공지사항</p>
                </div>
            </div>
        </div>
    </section>
    
	 <section class="classes-details-section spad overflow-hidden">
	        <div class="container">
				<div id="board-container">
					<div class="col-lg-6 m-auto">
						<form name="boardFrm" 
							  action="${pageContext.request.contextPath }/chef/noticeUpdateDone"
							  method="POST" 
							  id="noticeFrm"
							  enctype="multipart/form-data">
							<input type="number" value="${notice.noticeNo }" name="noticeNo" hidden/>
							<input type="text" value="${memberLoggedIn.memberNick }" name="memberNickName" hidden/>
							 <div class="row"> 
								<input type="submit" class="btn btn-outline-success" id="update" style="float:right;"value="수정완료 "  >
							</div>
							<input type="text" class="form-control" placeholder="제목 " name="noticeTitle" id="noticeTitle" value ="${notice.noticeTitle}"required  >
							<input type="text" class="form-control" name="noticeWriter" value="${notice.noticeWriter }" readonly required >
							<input type="text" class="form-control" placeholder="카테고리(ex.원데이클래스)" name="noticeCategory" value="${notice.noticeCategory }" id="notice_class" required >
						    <textarea class="form-control" name="noticeContent" placeholder="내용"   required  >${notice.noticeContent }</textarea>
							<br />
							
						</form>
					</div>
				</div>
			</div>
	</section>
	
	

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
