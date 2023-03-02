package DataBase;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import java.sql.*;
import java.util.ArrayList;

public class DataController {

    public static ResultSet rs = null;
    public static Connection conn = null;
    public static Statement state = null;


    public static void Connection(){
        String url = "jdbc:mariadb://localhost:3306/mission1";
        String username = "LDH";
        String password = "0000";

        try {
            Class.forName("org.mariadb.jdbc.Driver");
            //Class.forName("C:\\Dev\\mariadb-java-client-3.1.2.jar\\org.mariadb.jdbc\\Driver");

        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        try {
             conn = DriverManager.getConnection(url,username,password);
             state = conn.createStatement();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }


    public static ArrayList SELECT_Key(String key) throws SQLException {
        try {
            JsonParser jsonParser = new JsonParser();
            Connection();
            key = key.trim();
            String sql = String.format("SELECT * FROM Json_API where json_value(jdata,'$.X_SWIFI_MGR_NO') = '%s';", key);
            rs = state.executeQuery(sql);
            ArrayList<JsonElement> myList = new ArrayList<>();
            while (rs.next()) {
                String jdata = rs.getString("Jdata");
                Object obj = jsonParser.parse(jdata);
                JsonObject jobj = (JsonObject) obj;
                myList.add(jobj);
            }
            for (int i = 0; i <myList.size() ; i++) {
                System.out.println(myList.get(i));
            }
            return myList;

        } catch (Exception e) {


        } finally {
            conn.close();
            state.close();
            rs.close();
        }
        return null;
    }

    public static ArrayList SELECT_ALL() throws SQLException {
        try{
            JsonParser jsonParser = new JsonParser();
            Connection();
            String sql = "SELECT * FROM Json_API";
            rs = state.executeQuery(sql);
            ArrayList <JsonElement> myList = new ArrayList<>();
            while(rs.next()){
                String jdata = rs.getString("Jdata");
                Object obj = jsonParser.parse(jdata);
                JsonObject jobj = (JsonObject) obj;
                myList.add(jobj);
            }
            return myList;
        }catch (SQLException e){}
        finally {
            conn.close();
            state.close();
            rs.close();
        }
        return null;
    }



    public static void InsertAPI(String jdata,String data) throws SQLException {

        try{
            Connection();
            String sql = String.format("INSERT INTO Json_API VALUES ('%s','%s') ON DUPLICATE KEY UPDATE pk_id = '%s'",jdata,data,jdata);
            // pk_id 가 중복인지 체크
//            String sql =String.format("INSERT IGNORE INTO DATA_API VALUES" +
//                    " ('','%s','%s','%s','%s','%s','','%s','%s','%s','%s','%s','%s','','%s','%s','%s')"
//            ,jdata.getAsJsonObject().get("X_SWIFI_MGR_NO")
//            ,jdata.getAsJsonObject().get("X_SWIFI_WRDOFC")
//            ,jdata.getAsJsonObject().get("X_SWIFI_MAIN_NM")
//            ,jdata.getAsJsonObject().get("X_SWIFI_ADRES1")
//            ,jdata.getAsJsonObject().get("X_SWIFI_ADRES2")
//            ,jdata.getAsJsonObject().get("X_SWIFI_INSTL_FLOOR")
//            ,jdata.getAsJsonObject().get("X_SWIFI_INSTL_TY")
//            ,jdata.getAsJsonObject().get("X_SWIFI_INSTL_MBY")
//            ,jdata.getAsJsonObject().get("X_SWIFI_SVC_SE")
//            ,jdata.getAsJsonObject().get("X_SWIFI_CMCWR")
//            ,jdata.getAsJsonObject().get("X_SWIFI_CNSTC_YEAR")
//            ,jdata.getAsJsonObject().get("X_SWIFI_INOUT_DOOR")
//            ,jdata.getAsJsonObject().get("LAT")
//            ,jdata.getAsJsonObject().get("LNT")
//            ,jdata.getAsJsonObject().get("WORK_DTTM")
//                    );
            // 만약 기본 데이터가 존재한다면 추가하지않는다.
            rs = state.executeQuery(sql);
        }catch (SQLException e){

        }finally {
            conn.close();
            state.close();
            rs.close();
        }
    }

    public static void Insert_Book(String BookName, String BookNum) throws SQLException{
        try{
            Connection();
            String sql = String.format("INSERT INTO LIKE_GROUP (book_name, ordercnt, add_date, edit_date, like_id) VALUES ('%s',%s,now(),'','%s');",
                    BookName, BookNum,BookName);
            rs = state.executeQuery(sql);

        }catch (SQLException e){

        }finally {
            conn.close();
            state.close();
            rs.close();
        }
    }
    public static ArrayList SELECT_KEY_Book(String key) throws  SQLException{
        try{
            ArrayList <Book_DTO> lst = new ArrayList<Book_DTO>();
            Connection();
            String sql = String.format("SELECT book_name,ordercnt FROM LIKE_GROUP where lg_id = %s;",key);
            System.out.println(sql);
            rs = state.executeQuery(sql);
            while(rs.next()){
                //String lg_id = rs.getString("lg_id");
                String book_name = rs.getString("book_name");
                String ordercnt = rs.getString("ordercnt");
                lst.add(new Book_DTO(book_name,ordercnt));
            }
            return lst;
        }catch (SQLException e){

        }finally {
            conn.close();
            state.close();
            rs.close();
        }
        return null;
    }
    public static ArrayList SELECT_Book() throws SQLException{
        try{
            ArrayList <Book_DTO> lst = new ArrayList<Book_DTO>();
            Connection();
            String sql = String.format("SELECT * FROM LIKE_GROUP;");
            rs = state.executeQuery(sql);
            while(rs.next()){
                String lg_id = rs.getString("lg_id");
                String book_name = rs.getString("book_name");
                String ordercnt = rs.getString("ordercnt");
                String add_date = rs.getString("add_date");
                String edit_date = rs.getString("edit_date");
                String like_id = rs.getString("like_id");
                lst.add(new Book_DTO(lg_id,book_name,ordercnt,add_date,edit_date,like_id));
            }
            return lst;
        }catch (SQLException e){

        }finally {
            conn.close();
            state.close();
            rs.close();
        }
        return null;
    }
    public static void Update_book(String key,String book_name , String ordercnt) throws SQLException{
        try {
            Connection();
            String sql = String.format("UPDATE LIKE_GROUP SET book_name = '%s', ordercnt = %s, edit_date = now() where lg_id = %s;", book_name, ordercnt, key);
            System.out.println(sql);
            rs = state.executeQuery(sql);
        }
        catch (SQLException e){

        }finally {
            conn.close();
            state.close();
            rs.close();
        }

    }
    public static void Delete_book(String key) throws  SQLException{
        try {
            Connection();
            String sql = String.format("DELETE FROM LIKE_GROUP where lg_id = %s;",key);
            System.out.println(sql);
            rs = state.executeQuery(sql);
        }
        catch (SQLException e){

        }finally {
            conn.close();
            state.close();
            rs.close();
        }
    }
    public static void Delete_like(String key) throws  SQLException{
        try {
            Connection();
            String sql = String.format("DELETE FROM LIKE_TABLE_USER where like_id = %s;",key);
            System.out.println(sql);
            rs = state.executeQuery(sql);
        }
        catch (SQLException e){

        }finally {
            conn.close();
            state.close();
            rs.close();
        }
    }
    public static ArrayList SELECT_BOOK_NAME () throws SQLException{
        try{
            ArrayList <Book_DTO> lst = new ArrayList<Book_DTO>();
            Connection();
            String sql = String.format("SELECT book_name FROM LIKE_GROUP;");
            System.out.println(sql);
            rs = state.executeQuery(sql);
            while(rs.next()){
                String book_name = rs.getString("book_name");
                lst.add(new Book_DTO(book_name));
            }
            return lst;
        }catch (SQLException e){

        }finally {
            conn.close();
            state.close();
            rs.close();
        }
        return null;
    }
    public static void InsertLike(String key,String name) throws SQLException{
        try{
            Connection();
            String sql =String.format("INSERT INTO like_table_user SELECT lg_id,book_name,'%s',add_date FROM LIKE_GROUP where book_name = '%s';",key,name);
            System.out.println(sql);
            rs = state.executeQuery(sql);

        }catch (SQLException e){

        }finally {
            conn.close();
            state.close();
            rs.close();
        }
    }
    public static ArrayList SELECT_LIKE() throws SQLException{
        try{
            ArrayList <Like_DTO> lst = new ArrayList<Like_DTO>();
            Connection();
            String sql = String.format("SELECT * FROM like_table_user;");
            rs = state.executeQuery(sql);
            while(rs.next()){
                String like_id = rs.getString("like_id");
                String book_name = rs.getString("book_name");
                String wifiName = rs.getString("wifiName");
                String add_date = rs.getString("add_date");
                lst.add(new Like_DTO(like_id,book_name,wifiName,add_date));
            }
            return lst;
        }catch (SQLException e){

        }finally {
            conn.close();
            state.close();
            rs.close();
        }
        return null;
    }
    public static ArrayList SELECT_KEY_Like(String key) throws  SQLException{
        try{
            ArrayList <Like_DTO> lst = new ArrayList<Like_DTO>();
            Connection();
            String sql = String.format("SELECT book_name,wifiName,add_Date FROM LIKE_TABLE_USER where like_id = %s;",key);
            System.out.println(sql);
            rs = state.executeQuery(sql);
            while(rs.next()){
                String book_name = rs.getString("book_name");
                String wifiName = rs.getString("wifiName");
                String add_Date = rs.getString("add_Date");
                lst.add(new Like_DTO(book_name,wifiName,add_Date));
            }
            return lst;
        }catch (SQLException e){

        }finally {
            conn.close();
            state.close();
            rs.close();
        }
        return null;
    }

    public static void main(String[] args) throws SQLException {
        //SELECT_KEY_Book("2");
        //SELECT_Book();
        //SELECT_ALL();
    }
}
