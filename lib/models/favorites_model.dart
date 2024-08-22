class FavoritesModel{
  late bool? status;
  late String? message;
  late Data? data;
  FavoritesModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
    data=json['data'] !=null?Data.fromJson(json['data']):null;

  }}
  class Data{
  late int? currentPage;
   List<FavoritesData>data=[];
  late  String? firstPageUrl ;
  late int?from;
  late int? lastPageUrl;
   late int?  nextPageUrl;
  late  String? path ;
  late int? perPage;
  Data.fromJson(Map<String,dynamic>json){
    currentPage=json['current_page'];
    json['data'].forEach((element) {
      data.add(FavoritesData.fromJson(element));
    });
    firstPageUrl=json['first_page_url'];
    from=json['from'];
    lastPageUrl=json['lastPage'];
    nextPageUrl=json['next_page_url'];
    path=json['path'];
    perPage=json['per_page'];
  }


  }
  class FavoritesData{
  late int? id;
  late Product? product;
  FavoritesData.fromJson(Map<String,dynamic>json){
    id=json['id'];
    product=json['product'];
  }

  }
  class Product{
    int? id;
    dynamic price;
    dynamic oldPrice;
    dynamic discount;
    String? image;
    String? name;
    bool? inFavorite;
    bool? inCart;

    Product.fromJson(Map<String, dynamic> json) {
      id = json['id'];
      price = json['price'];
      oldPrice = json['old_price'];
      discount = json['discount'];
      image = json['image'];
      name = json['name'];
      inFavorite = json['in_favorites'];
      inCart = json['in_cart'];
    }
  }

