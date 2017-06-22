package nl.atlasdev.IPASS.dao;

import java.net.URI;
import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

public class BaseDAO {
	private static Connection conn;

	protected final Connection getConnection() {
		if(BaseDAO.conn != null) return BaseDAO.conn;
		try {
			final String DATABASE_URL_PROP = System.getenv("DATABASE_URL");
			if (DATABASE_URL_PROP != null) {
				URI dbUri = new URI(DATABASE_URL_PROP);
				String dbUrl = "jdbc:postgresql://" + dbUri.getHost() + dbUri.getPath();
				@SuppressWarnings("resource")
				BasicDataSource pool = new BasicDataSource();
				if (dbUri.getUserInfo() != null) {
					pool.setUsername(dbUri.getUserInfo().split(":")[0]);
					pool.setPassword(dbUri.getUserInfo().split(":")[1]);
				}
				pool.setDriverClassName("org.postgresql.Driver");
				pool.setUrl(dbUrl);
				pool.setInitialSize(1);
				BaseDAO.conn = pool.getConnection();
			} else {
				InitialContext ic = new InitialContext();
				BaseDAO.conn = ((DataSource) ic.lookup("java:comp/env/jdbc/PostgresDS")).getConnection();
				return BaseDAO.conn;
			}
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		try {
			DataSource ds = (DataSource) new InitialContext().lookup("java:comp/env/jdbc/PostgresDS");
			BaseDAO.conn = ds.getConnection();
		} catch (Exception ex) {
			throw new RuntimeException(ex);
		}
		return BaseDAO.conn;
	}
}