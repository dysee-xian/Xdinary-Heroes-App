import 'merchandise.dart';

class CartItem {
  final Merchandise product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}
