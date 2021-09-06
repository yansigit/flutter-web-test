class MyMenu {
  String storeThumbnail;
  String storeName;
  String orderDetail;
  String menuThumbnail;
  String menuName;
 

  MyMenu(
      [this.storeThumbnail = "images/store/위치icon.svg",
      this.storeName = "킬티",
      this.orderDetail = '''시원한 / 중간 사이즈 
                            얼음 적게
                            1샷 추가
                            물 적게 넣어주세요~''',
      this.menuThumbnail = "images/store/위치icon.svg",
      this.menuName = "아메리카노"]);
}

class Order {
  String storeThumbnail;
  String storeName;
  String orderDetail;
  String menuThumbnail;

  Order(
      [this.storeThumbnail = "images/store/위치icon.svg",
      this.storeName = "킬티",
      this.orderDetail = "아메리카노 2잔",
      this.menuThumbnail = "images/store/위치icon.svg"]);
}
