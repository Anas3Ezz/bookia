class CartModel {
  CartData? data;
  String? message;
  int? status;

  CartModel({this.data, this.message, this.status});

  CartModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? CartData.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
  }
}

class CartData {
  int? id;
  CartUser? user;
  String? total;
  List<CartItem>? cartItems;

  CartData({this.id, this.user, this.total, this.cartItems});

  CartData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? CartUser.fromJson(json['user']) : null;
    total = json['total'];
    if (json['cart_items'] != null) {
      cartItems = <CartItem>[];
      json['cart_items'].forEach((v) {
        cartItems!.add(CartItem.fromJson(v));
      });
    }
  }
}

class CartUser {
  int? userId;
  String? userName;

  CartUser({this.userId, this.userName});

  CartUser.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
  }
}

class CartItem {
  int? itemId;
  int? itemProductId;
  String? itemProductName;
  String? itemProductImage;
  String? itemProductPrice;
  int? itemProductDiscount;
  double? itemProductPriceAfterDiscount;
  int? itemProductStock;
  int? itemQuantity;
  double? itemTotal;

  CartItem({
    this.itemId,
    this.itemProductId,
    this.itemProductName,
    this.itemProductImage,
    this.itemProductPrice,
    this.itemProductDiscount,
    this.itemProductPriceAfterDiscount,
    this.itemProductStock,
    this.itemQuantity,
    this.itemTotal,
  });

  CartItem.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    itemProductId = json['item_product_id'];
    itemProductName = json['item_product_name'];
    itemProductImage = json['item_product_image'];
    itemProductPrice = json['item_product_price'];
    itemProductDiscount = json['item_product_discount'];
    itemProductPriceAfterDiscount =
        (json['item_product_price_after_discount'] as num?)?.toDouble();
    itemProductStock = json['item_product_stock'];
    itemQuantity = json['item_quantity'];
    itemTotal = (json['item_total'] as num?)?.toDouble();
  }
}
