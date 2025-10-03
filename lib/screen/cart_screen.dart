import 'package:flutter/material.dart';
import '../../models/cart_item.dart';

class CartScreen extends StatefulWidget {
  final List<CartItem> cart;

  const CartScreen({super.key, required this.cart});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void updateQuantity(int index, int change) {
    setState(() {
      widget.cart[index].quantity += change;
      if (widget.cart[index].quantity <= 0) {
        widget.cart.removeAt(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    int total = widget.cart.fold(
      0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );

    return Scaffold(
      appBar: AppBar(title: const Text("Keranjang Belanja"), centerTitle: true),
      body: widget.cart.isEmpty
          ? const Center(child: Text("Keranjang masih kosong"))
          : ListView.builder(
              itemCount: widget.cart.length,
              itemBuilder: (context, index) {
                final cartItem = widget.cart[index];
                return ListTile(
                  leading: Image.asset(
                    cartItem.product.image,
                    width: 50,
                    height: 50,
                  ),
                  title: Text(cartItem.product.name),
                  subtitle: Text("Rp ${cartItem.product.price}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: () => updateQuantity(index, -1),
                      ),
                      Text("${cartItem.quantity}"),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline),
                        onPressed: () => updateQuantity(index, 1),
                      ),
                    ],
                  ),
                );
              },
            ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.black12,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total: Rp $total",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Checkout berhasil!")),
                );
              },
              child: const Text("Checkout"),
            ),
          ],
        ),
      ),
    );
  }
}
