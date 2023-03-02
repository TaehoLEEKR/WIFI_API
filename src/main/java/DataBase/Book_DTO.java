package DataBase;

import java.awt.print.Book;
import java.util.Date;

public class Book_DTO {
    private String lg_id;
    private String book_name;
    private String ordercnt;
    private String add_date;
    private String edit_date;
    private String like_id;
    Book_DTO(String lg_id, String book_name, String ordercnt, String add_date , String edit_date ,String like_id){
         this.lg_id =lg_id;
         this.book_name = book_name;
         this.ordercnt = ordercnt;
         this.add_date = add_date;
         this.edit_date = edit_date;
         this.like_id = like_id;
    }
    Book_DTO(String book_name,String ordercnt){
        this.book_name = book_name;
        this.ordercnt = ordercnt;
    }
    Book_DTO(String book_name){
        this.book_name = book_name;
    }

    public String getLg_id() {
        return lg_id;
    }

    public String getBook_name() {
        return book_name;
    }
    public String getOrdercnt() {
        return ordercnt;
    }

    public String getAdd_date() {
        return add_date;
    }

    public String getEdit_date() {
        return edit_date;
    }
    public String getLike_id(){
        return like_id;
    }
    public void setLg_id(String lg_id) {
        this.lg_id = lg_id;
    }

    public void setOrdercnt(String ordercnt) {
        this.ordercnt = ordercnt;
    }

    public void setBook_name(String book_name) {
        this.book_name = book_name;
    }

    public void setAdd_date(String add_date) {
        this.add_date = add_date;
    }

    public void setEdit_date(String edit_date) {
        this.edit_date = edit_date;
    }
    public void setLike_id(String like_id) {
        this.like_id = like_id;
    }
}
