class WishlistModel {
  WishlistData? data;
  String? message;
  int? status;

  WishlistModel({this.data, this.message, this.status});

  WishlistModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? WishlistData.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
  }
}

class WishlistData {
  int? currentPage;
  List<WishlistItem>? items;
  int? total;

  WishlistData({this.currentPage, this.items, this.total});

  WishlistData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    total = json['total'];
    if (json['data'] != null) {
      items = <WishlistItem>[];
      json['data'].forEach((v) {
        items!.add(WishlistItem.fromJson(v));
      });
    }
  }
}

class WishlistItem {
  int? id;
  String? name;
  String? price;
  String? category;
  String? image;
  int? discount;
  int? stock;
  String? description;
  int? bestSeller;

  WishlistItem({
    this.id,
    this.name,
    this.price,
    this.category,
    this.image,
    this.discount,
    this.stock,
    this.description,
    this.bestSeller,
  });

  WishlistItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    category = json['category'];
    image = json['image'];
    discount = json['discount'];
    stock = json['stock'];
    description = json['description'];
    bestSeller = json['best_seller'];
  }
}
