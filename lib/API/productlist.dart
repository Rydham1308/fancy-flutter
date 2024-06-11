import 'dart:convert';

List<Products> productsFromJson(String str) => List<Products>.from(
      json.decode(str).map(
            (x) => Products.fromJson(x),
          ),
    );

String productsToJson(List<Products> data) => json.encode(
      List<dynamic>.from(
        data.map((x) => x.toJson()),
      ),
    );

class Products {
  Products({
    required this.brandname,
    required this.detail,
    required this.type,
    required this.size,
    required this.color,
    required this.price,
    required this.gender,
    required this.image1,
    required this.image2,
    required this.image3,
    required this.favorite,
    required this.id,
  });

  String brandname;
  String detail;
  String type;
  int size;
  String color;
  int price;
  String gender;
  String image1;
  String image2;
  String image3;
  bool favorite;
  String id;

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        brandname: json["brandname"],
        detail: json["detail"],
        type: json["type"],
        size: json["size"],
        color: json["color"],
        price: json["price"],
        gender: json["gender"],
        image1: json["image1"],
        image2: json["image2"],
        image3: json["image3"],
        favorite: json["favorite"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "brandname": brandname,
        "detail": detail,
        "type": type,
        "size": size,
        "color": color,
        "price": price,
        "gender": gender,
        "image1": image1,
        "image2": image2,
        "image3": image3,
        "favorite": favorite,
        "id": id,
      };
}
