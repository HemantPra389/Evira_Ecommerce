class ProductEntity {
  String type;
  String title;
  String price;
  List<String> url;
  String category;
  ProductEntity({
    required this.type,
    required this.title,
    required this.price,
    required this.url,
    required this.category
  });
}
