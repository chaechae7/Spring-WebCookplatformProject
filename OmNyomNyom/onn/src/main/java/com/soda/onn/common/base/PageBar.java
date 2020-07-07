package com.soda.onn.common.base;

public class PageBar {
	
	
	public static String Paging(String url, int cPage, int pageStart, int pageEnd, int totalPage)  {
		StringBuffer pageBar = new StringBuffer("<div class=site-pagination pt-3.5''>");	
		
		if(pageStart != 1 ){
			pageBar.append("<a href='"+url+"?cPage="+(pageStart-1)+"'>"
						+  "<i class='material-icons'>"
						+  "keyboard_arrow_left"
						+  "</i></a>");
		}
		
		while(!(pageStart>pageEnd || pageStart > totalPage)){
			
			if(cPage == pageStart ){
				pageBar.append("<a href="+url+"?cPage="+pageStart+" class='active'>"+pageStart+"</a>");
			} 
			else {
				pageBar.append("<a href="+url+"?cPage="+pageStart+">"+pageStart+"</a>");
			}
			pageStart++;
		}
		
		if(pageStart <= totalPage){
			pageBar.append("<a href='"+url+"?cPage="+pageStart+"'>"
					+	"<i class='material-icons'>"
					+ 	"keyboard_arrow_right"
					+	"</i></a>");
		}
		pageBar.append("</div>");
		return pageBar.toString();	}

}
