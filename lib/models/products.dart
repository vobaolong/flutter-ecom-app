class Product {
  final int id;
  final String name;
  final String category;
  final double price;
  final double? oldPrice;
  final String image;
  final String description;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    this.oldPrice,
    required this.image,
    required this.description,
  });

  // Helper method to check if product is in wishlist
  bool isInWishlist(List<int> wishlist) {
    return wishlist.contains(id);
  }
}

final List<Product> products = [
  Product(
    id: 1,
    name: 'Shoes',
    category: 'Footwear',
    price: 69,
    oldPrice: 189,
    image: 'assets/images/shoe.jpg',
    description: 'This is a description of the product 1',
  ),
  Product(
    id: 2,
    name: 'Shoes',
    category: 'Footwear',
    price: 69,
    oldPrice: 189,
    image: 'assets/images/shoe2.jpg',
    description: 'This is a description of the product 2',
  ),
  Product(
    id: 3,
    name: 'Shoes',
    category: 'Footwear',
    price: 69,
    oldPrice: 189,
    image: 'assets/images/shoes2.jpg',
    description: 'This is a description of the product 3',
  ),
  Product(
    id: 4,
    name: 'Laptop',
    category: 'Electronics',
    price: 69,
    oldPrice: 189,
    image: 'assets/images/laptop.jpg',
    description: 'A high quality laptop',
  ),
];
