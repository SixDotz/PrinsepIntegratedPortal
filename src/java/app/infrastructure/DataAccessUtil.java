package app.infrastructure;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import org.apache.commons.lang3.StringUtils;

public class DataAccessUtil {

    private static final String dbDriver = "com.mysql.jdbc.Driver";
    private static Connection dbConnection = null;
    private static String dbURL = null;
    private static String dbUser = null;
    private static String dbPassword = null;

    private static void establishConnection() throws SQLException, NamingException {
        //Read JDBC parameters from web.xml
        Context env = (Context) new InitialContext().lookup("java:comp/env");
        dbURL = (String) env.lookup("dbURL");
        dbUser = (String) env.lookup("dbUser");
        dbPassword = (String) env.lookup("dbPassword");

        //Create Connection
        if (dbConnection == null || dbConnection.isClosed()) {
            try {
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                dbConnection = DriverManager.getConnection(dbURL, dbUser, dbPassword);
            } catch (ClassNotFoundException e) {
            } catch (InstantiationException e) {
            } catch (IllegalAccessException e) {
            }
        }
    }

    private static void closeConnection() throws SQLException {
        if (dbConnection != null && !dbConnection.isClosed()) {
            dbConnection.close();
        }
    }

    public ResultSet mySQLExecuteResultSet(String storedProceedureName, Object... paramaterValues) {
        ResultSet rs = null;

        //ArrayList<ResultSet> rss = new ArrayList<ResultSet>();

        try {
            //Create Connection
            establishConnection();

            //Create Stored Proceedure Call and add Parameters
            String parameters = "()";
            if(paramaterValues.length > 0){
                String temp = StringUtils.repeat("?, ", paramaterValues.length);
                parameters = "(" + temp.substring(0, temp.length() - 3) + ")";
            }           

            //CallableStatement dbStatement = dbConnection.prepareCall(storedProceedureName);
            CallableStatement dbStatement = dbConnection.prepareCall("{ call " + storedProceedureName + parameters + "}");
            for (int i = 0; i < paramaterValues.length; i++) {
                dbStatement.setObject(i, paramaterValues[i]);
            }

            //Execute Stored Proceedure & Retrieve ResultSet
            //rs = dbStatement.executeQuery();
            dbStatement.execute();

            //Retrieve all the ResultSets from the executed stored proceedure
            //do {
            //    rss.add(dbStatement.getResultSet());
            //} while (dbStatement.getMoreResults());
            
            rs = dbStatement.getResultSet();

        } catch (SQLException e) {
            //Write exeption to log file
            writeSQLExceptionLog(e);
        } catch (NamingException e) {
            //Write exception to log file
            writeNamingExceptionLog(e);
        }

        //Return ResultSet
        //return rss;
        return rs;
    }

    public ResultSet mySQLExecuteResultSet_Str(String SQL_Str, Object... paramaterValues) {
        ResultSet rs = null;

        try {
            //Create Connection
            establishConnection();

            //Create SQL Statement and add Parameters
            PreparedStatement dbStatement = dbConnection.prepareStatement(SQL_Str);
            for (int i = 0; i < paramaterValues.length; i++) {
                dbStatement.setObject(i, paramaterValues[i]);
            }

            //Execute SQL 
            dbStatement.execute(SQL_Str);

            //Retrieve ResultSet
            rs = dbStatement.getResultSet();
        } catch (SQLException e) {
            //Write exeption to log file
            writeSQLExceptionLog(e);
        } catch (NamingException e) {
            //Write exception to log file
            writeNamingExceptionLog(e);
        }

        //Return ResultSet
        return rs;
    }

    public static int mySQLExecuteNonQuery(String storedProceedureName, Object... paramaterValues) {
        int returnCount = 0;

        try {
            //Create Connection
            establishConnection();

            //Create Stored Proceedure Call and add Parameters
            CallableStatement dbStatement = dbConnection.prepareCall(storedProceedureName);
            for (int i = 0; i < paramaterValues.length; i++) {
                dbStatement.setObject(i, paramaterValues[i]);
            }

            //Execute Stored Proceedure
            returnCount = dbStatement.executeUpdate();

        } catch (SQLException e) {
            //Write exeption to log file
            writeSQLExceptionLog(e);

        } catch (NamingException e) {
            //Write exception to log file
            writeNamingExceptionLog(e);

        }

        //Return number of rows affected
        return returnCount;
    }

    public static int mySQLExecuteNonQuery_Str(String SQL_Str, Object... paramaterValues) {
        int returnCount = 0;

        try {
            //Create Connection
            establishConnection();

            //Create SQL Statement and add Parameters
            PreparedStatement dbStatement = dbConnection.prepareStatement(SQL_Str);
            for (int i = 0; i < paramaterValues.length; i++) {
                dbStatement.setObject(i, paramaterValues[i]);
            }

            //Execute Stored Proceedure
            returnCount = dbStatement.executeUpdate(SQL_Str);
        } catch (SQLException e) {
            //Write exeption to log file
            writeSQLExceptionLog(e);
        } catch (NamingException e) {
            //Write exception to log file
            writeNamingExceptionLog(e);
        }

        //Return number of rows affected
        return returnCount;
    }

    public static void writeSQLExceptionLog(SQLException e) {
    }

    private static void writeNamingExceptionLog(NamingException e) {
    }
}
