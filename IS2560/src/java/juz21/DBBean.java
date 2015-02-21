package juz21;

import static java.lang.System.out;
import java.sql.*;

/**
 *
 * @author zhaojun
 */
public class DBBean {

    private static Connection conn;
    private static Statement stmt;
    private static ResultSet rs = null;

    static {
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            String connectionURL = "jdbc:derby://localhost:1527/IS2560_Final";
            conn = DriverManager.getConnection(connectionURL, "IS2560", "IS2560");
            stmt = conn.createStatement();
        } catch (ClassNotFoundException | SQLException e) {
        }
    }

    public static String[][] findFriend(String fname,String uname) throws SQLException {
        String sql = "SELECT * FROM users WHERE email LIKE '%"+fname+"%' OR firstname LIKE '%"+fname+"%' OR lastname LIKE '%"+fname+"%' AND email != ALL(SELECT touser From addfriend WHERE fromuser='"+uname+"')";
        PreparedStatement findname = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
        rs = findname.executeQuery();
        rs.last();
        int size = rs.getRow();
        int i = 0;
        rs.beforeFirst();
        if (size>0) {
            String[][] user = new String[size][3];
            while (rs.next()) {
                user[i][0] = rs.getString(1);
                user[i][1] = rs.getString(2);
                user[i][2] = rs.getString(3);
                i++;
            }
            return user;
        }else {
            return null;
        } 
    }

    public static String[][] selectFriend(String fname, String uname) throws SQLException {
        String sql = "SELECT * FROM users WHERE email IN (SELECT fromuser FROM addfriend WHERE touser='" + uname + "') AND firstname LIKE '%" + fname + "%' OR lastname LIKE '%" + fname + "%'";
        PreparedStatement selectFriend = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
        rs = selectFriend.executeQuery();
        rs.last();
        int size = rs.getRow();
        int i = 0;
        rs.beforeFirst();
        String[][] user = new String[size][3];
        while (rs.next()) {
            user[i][0] = rs.getString(1);
            user[i][1] = rs.getString(2);
            user[i][2] = rs.getString(3);
            i++;
        }
        return user;
    }

    public static String[][] selectmessagefrom(String fname, String uname, String title) throws SQLException {
        String sql = "SELECT fromuser,title,content,senttime FROM receivedmessage WHERE fromuser='" + fname + "' AND touser='" + uname + "' AND title='" + title + "'";
        rs = stmt.executeQuery(sql);
        rs.next();
        String[][] mess = new String[1][4];
        mess[0][0] = rs.getString(1);
        mess[0][1] = rs.getString(2);
        mess[0][2] = rs.getString(3);
        mess[0][3] = rs.getString(4);
        String sql2 = "UPDATE receivedmessage SET hasread=true WHERE fromuser='" + fname + "' AND touser='" + uname + "' AND title='" + title + "'";
        stmt.executeUpdate(sql2);
        return mess;
    }

    public static String[][] showunreadmessage(String uname) throws SQLException {
        String sql = "SELECT * FROM receivedmessage WHERE touser='" + uname + "' AND hasread=false";
        PreparedStatement showunreadmessage = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
        rs = showunreadmessage.executeQuery();
        rs.last();
        int size = rs.getRow();
        int i = 0;
        rs.beforeFirst();
        String[][] mess = new String[size][4];
        while (rs.next()) {
            mess[i][0] = rs.getString("fromuser");
            mess[i][1] = rs.getString("title");
            mess[i][2] = rs.getString("content");
            mess[i][3] = rs.getString("senttime");
            i++;
        }
        return mess;
    }

    public static String[][] showreadmessage(String uname) throws SQLException {
        String sql = "SELECT * FROM receivedmessage WHERE touser='" + uname + "' AND hasread=true";
        PreparedStatement showunreadmessage = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
        rs = showunreadmessage.executeQuery();
        rs.last();
        int size = rs.getRow();
        int i = 0;
        rs.beforeFirst();
        String[][] mess = new String[size][4];
        while (rs.next()) {
            mess[i][0] = rs.getString("fromuser");
            mess[i][1] = rs.getString("title");
            mess[i][2] = rs.getString("content");
            mess[i][3] = rs.getString("senttime");
            i++;
        }
        return mess;
    }

    public static String[] showfriendrequest(String uname) throws SQLException {
        String sql = "select * from addfriend WHERE touser = '" + uname + "' AND requestsent=true AND isfriend=false";
        PreparedStatement showfriendrequest = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
        rs = showfriendrequest.executeQuery();
        rs.last();
        int size = rs.getRow();
        int i = 0;
        rs.beforeFirst();
        String[] frequest = new String[size];
        while (rs.next()) {
            frequest[i] = rs.getString("fromuser");
            i++;
        }
        return frequest;
    }
    public static String[][] recommendfriend(String uname) throws SQLException {
        String sql = "SELECT firstname, lastname, email FROM users WHERE email IN(SELECT email FROM event  WHERE city IN (SELECT city FROM event WHERE email = '"+uname+"') AND email <> '"+uname+"' GROUP BY email)";
        PreparedStatement recommendfriend = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
        rs = recommendfriend.executeQuery();
        rs.last();
        int size = rs.getRow();
        int i = 0;
        rs.beforeFirst();
        if(size>0){
        String[][] recommend = new String[size][3];
        while (rs.next()) {
            recommend[i][0] = rs.getString(1);
            recommend[i][1] = rs.getString(2);
            recommend[i][2] = rs.getString(3);
            i++;
        }
        return recommend;
        }else {
            return null;
        }
    }
    public static void addfriend(String from, String to) throws SQLException {
        String sql = "INSERT INTO addfriend VALUES ('" + from + "', '" + to + "',true,false)";
        stmt.executeUpdate(sql);

    }
    public static void agreeadd(String from, String to) throws SQLException {
        String sql = "UPDATE addfriend SET isfriend = true WHERE fromuser = '" + from + "' AND touser = '" + to + "'";
        stmt.executeUpdate(sql);

    }

    public static void disagreeadd(String from, String to) throws SQLException {
        String sql = "DELETE FROM addfriend WHERE fromuser = '" + from + "' AND touser = '" + to + "'";
        stmt.executeUpdate(sql);

    }

    public static void sendmessage(String from, String to, String title, String content) throws SQLException {
        String sql = "INSERT INTO receivedmessage VALUES ('" + from + "','" + to + "',DEFAULT,'" + title + "','" + content + "',DEFAULT)";
        stmt.executeUpdate(sql);

    }

    public static int countmessagefrom(String uname) throws SQLException {
        String sql = "select count(*) as c from RECEIVEDMESSAGE WHERE touser = '" + uname + "' AND hasread=false";
        rs = stmt.executeQuery(sql);
        rs.next();
        int c = rs.getInt(1);
        return c;
    }

    public static int countunreadmessage(String uname) throws SQLException {
        String sql = "select count(*) as c from RECEIVEDMESSAGE WHERE touser = '" + uname + "' AND hasread=false";
        rs = stmt.executeQuery(sql);
        rs.next();
        int c = rs.getInt(1);
        if (c > 0)
            return c;
        else
            return 0;
    }

    public static int countreadmessage(String uname) throws SQLException {
        String sql = "select count(*) as c from RECEIVEDMESSAGE WHERE touser = '" + uname + "' AND hasread=true";
        rs = stmt.executeQuery(sql);
        rs.next();
        int c = rs.getInt(1);
        if (c > 0)
            return c;
        else
            return 0;
    }

    public static int countfriendrequest(String uname) throws SQLException {
        String sql = "select count(*) as c from addfriend WHERE touser = '" + uname + "' AND requestsent=true AND isfriend=false";
        rs = stmt.executeQuery(sql);
        rs.next();
        int c = rs.getInt(1);
        return c;
    }
    
    public static void main(String[] args) throws SQLException {
        String[][] friend= DBBean.selectFriend("","juz21@pitt.edu");
        out.println(friend[0][1]);
    }

}
