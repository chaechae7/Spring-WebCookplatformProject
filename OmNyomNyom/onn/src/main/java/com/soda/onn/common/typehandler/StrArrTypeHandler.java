package com.soda.onn.common.typehandler;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.TypeHandler;

//제네릭에는 자바쪽 타입을 적어줍니다. 
/**
 * 
 * 하나의 setter (java ->db)
 * - PreparedSatement에 값 대입 
 * 
 * 세개의 getter (db -> java)
 * - Resultset 컬럼
 * - Resultset 컬럼인덱
 * - CallableStatement 호출시 컬럼인덱스 
 * 
 *
 */
public class StrArrTypeHandler implements TypeHandler<String[]> {

	@Override
	public void setParameter(PreparedStatement ps, int i, String[] parameter, JdbcType jdbcType) throws SQLException {
		//  ["c" , "java", "javascript"] = > "c" , "java", "javascprit"
//		문자열 배열을 문자열로 변환 
		if(parameter !=null) {
		ps.setString(i, String.join(",", parameter));
		}else {
			ps.setString(i, "");
		}
	}

	@Override
	public String[] getResult(ResultSet rs, String columnName) throws SQLException {
		String str = rs.getString(columnName);
		String[] strArr = null;
		
		if(str != null)
				strArr  = str.split(",");
		return strArr;
	}

	@Override
	public String[] getResult(ResultSet rs, int columnIndex) throws SQLException {
		String str = rs.getString(columnIndex);
		String[] strArr = null;
		
		if(str != null)
				strArr  = str.split(",");
		return strArr;
	}

	@Override
	public String[] getResult(CallableStatement cs, int columnIndex) throws SQLException {
		String str = cs.getString(columnIndex);
		String[] strArr = null;
		
		if(str != null)
				strArr  = str.split(",");
		return strArr;
	}
	

}
