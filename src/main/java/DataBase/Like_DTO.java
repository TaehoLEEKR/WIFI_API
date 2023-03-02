package DataBase;

public class Like_DTO {
    private String like_id;
    private String book_name;
    private String wifiName;
    private String add_date;

    Like_DTO(String like_id ,String book_name , String wifiName ,String add_date){
        this.like_id = like_id;
        this.book_name = book_name;
        this.wifiName = wifiName;
        this.add_date = add_date;
    }
    Like_DTO(String book_name , String wifiName ,String add_date){
        this.book_name = book_name;
        this.wifiName = wifiName;
        this.add_date = add_date;
    }
    public String getLike_id(){
        return like_id;
    };
    public String getWifiName() {
        return wifiName;
    }

    public String getAdd_date() {
        return add_date;
    }
    public String getBook_name() {
        return book_name;
    }

    public void setAdd_date(String add_date) {
        this.add_date = add_date;
    }

    public void setBook_name(String book_name) {
        this.book_name = book_name;
    }

    public void setLike_id(String like_id) {
        this.like_id = like_id;
    }

    public void setWifiName(String wifiName) {
        this.wifiName = wifiName;
    }
}
