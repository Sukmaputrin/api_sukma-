import 'dart:convert';

class Product {
  int id;
  String title;
  String category;
  dynamic price;
  String description;
  String image;

  Product({this.id = 0, this.title,this.category, this.price, this.description, this.image});

  factory Product.fromJson(Map<String, dynamic> map) {
    return Product(
        id: map["id"], title: map["title"],category: map["category"], price: map["price"] , description: map["description"],image: map["image"]);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "title": title,"category": category, "price": price, "description": description, "image": image};
  }

  @override
  String toString() {
    return 'Product{id: $id, title: $title, price: $price, description: $description}';
  }

}

List<Product> productFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Product>.from(data.map((item) => Product.fromJson(item)));
}

String productToJson(Product data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}