package com.soda.onn.common.util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class ChefRequestUtils {

	public static String getRenamedFileName(String originalFileName, String renamedFileName) {
		
		//파일명 생성코드
		//기존파일의 확장자를 가져옴
		String ext = "";
		int dotIndex = originalFileName.lastIndexOf(".");
		if(dotIndex > -1)
			ext = originalFileName.substring(dotIndex); // .txt
		
		//새파일명 : yyyyNNdd_HHmmssSSSS_rnd.txt
		 renamedFileName += ext;
		//새 파일객체 생성
		//이름 뿐만 아니라, 디렉토리 경로도 가지고 있어야함.
		
		return renamedFileName;
	}

}
