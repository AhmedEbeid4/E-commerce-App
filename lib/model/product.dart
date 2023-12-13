class Product {
  int id;
  String name;
  String imageUrl;
  String gender;
  String desc;
  double price;
  int minWeight;
  int? maxWeight;
  bool isBeingLiked = false;

  Product(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.gender,
      required this.desc,
      required this.price,
      required this.minWeight,
      required this.maxWeight});

  factory Product.fromJson(Map<dynamic, dynamic> item) {
    int minWeight;
    int? maxWeight;

    // Extracting weights
    if ((item['weight'] as String).contains('o')) {
      minWeight = 90;
    } else {
      final weights = (item['weight'] as String).split('-');
      minWeight = int.parse(weights[0]);
      maxWeight = int.parse(weights[1]);
    }

    // Extracting price
    double price = item['price'] is int
        ? (item['price'] as int).toDouble()
        : item['price'];

    return Product(
      id: item['id'],
      name: item['name'],
      imageUrl: item['image_url'],
      gender: item['gender'],
      desc: item['description'],
      price: price,
      minWeight: minWeight,
      maxWeight: maxWeight,
    );
  }


  String get weightText {
    return maxWeight == null ? 'Over 90' : '$minWeight-$maxWeight';
  }


  Map<String, dynamic> toJson(){
    return {
      "id": id,
      "name": name,
      "price" : price,
      "image_url":imageUrl,
      'weight': maxWeight == null ? 'over 90' : '$minWeight-$maxWeight',
      'gender': gender,
      'description': desc
    };
  }


/*
  final response = await http.get(Uri.parse(
      'https://e-commerce-db933-default-rtdb.firebaseio.com/products.json'));
  final res = jsonDecode(response.body) as List<dynamic>;
  List<Map<String, dynamic>> newList = [];
  for (var element in res) {
    final ele = element as Map<String, dynamic>;
    final product = Product.fromJson(ele);
    ele['description'] = '''Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.''';
    newList.add(ele);
  }
  print('NEW_LIST $newList');
  await http.put(
      Uri.parse(
          'https://e-commerce-db933-default-rtdb.firebaseio.com/products.json'),
      body: jsonEncode(newList));

   */
}
