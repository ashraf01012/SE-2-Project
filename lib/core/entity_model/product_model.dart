class ProductModel {
  String? pName,pDescription,pCategory,image,id;
  int? quantity;
  double? price;

  ProductModel({
    this.quantity,
    this.price,
     this.image,
     this.pCategory,
     this.pDescription,
     this.id,
     this.pName,
  });
  factory ProductModel.fromMap(Map<String, dynamic> data, String documentId) {
    return ProductModel(
      id: documentId,
      pName: data['name'],
      pDescription: data['description'],
      pCategory: data['category'],
      price: data['price'],
      image: data['imageLocation'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'name': pName,
      'description': pDescription,
      'category': pCategory,
      'price': price,
      'imageLocation': image,
    };
  }

}
