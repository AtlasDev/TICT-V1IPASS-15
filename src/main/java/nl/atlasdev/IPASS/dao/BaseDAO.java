package nl.atlasdev.IPASS.dao;

import java.sql.Connection;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BaseDAO {
	private static Connection conn;

	protected final Connection getConnection() {
		if(BaseDAO.conn != null) return BaseDAO.conn;
		try {
			DataSource ds = (DataSource) new InitialContext().lookup("java:comp/env/jdbc/PostgresDS");
			BaseDAO.conn = ds.getConnection();
		} catch (Exception ex) {
			throw new RuntimeException(ex);
		}
		return BaseDAO.conn;
	}
}