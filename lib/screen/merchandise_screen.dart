import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/merchandise.dart';
import '../models/cart_item.dart';
import 'cart_screen.dart';
import 'info_screen.dart';
import 'package:badges/badges.dart' as badges;

class MerchandiseScreen extends StatefulWidget {
  const MerchandiseScreen({super.key});

  @override
  State<MerchandiseScreen> createState() => _MerchandiseScreenState();
}

class _MerchandiseScreenState extends State<MerchandiseScreen> {
  String selectedCategory = "All";
  final List<CartItem> cart = [];

  void addToCart(Merchandise product) {
    setState(() {
      final index = cart.indexWhere(
        (item) => item.product.name == product.name,
      );
      if (index >= 0) {
        cart[index].quantity++;
      } else {
        cart.add(CartItem(product: product));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Merchandise Store"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        actions: [
          badges.Badge(
            position: badges.BadgePosition.topEnd(top: 3, end: 5),
            showBadge: cart.isNotEmpty,
            badgeContent: Text(
              '${cart.length}',
              style: const TextStyle(color: Colors.white, fontSize: 10),
            ),
            badgeStyle: const badges.BadgeStyle(
              badgeColor: Colors.red,
              padding: EdgeInsets.all(5),
            ),
            badgeAnimation: badges.BadgeAnimation.slide(
              animationDuration: const Duration(seconds: 1),
              colorChangeAnimationDuration: const Duration(seconds: 3),
              loopAnimation: false,
              curve: Curves.fastOutSlowIn,
            ),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartScreen(cart: cart),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 59, 55, 59),
              Color.fromARGB(255, 70, 65, 71),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // 🔹 Pilih kategori
              SizedBox(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: ["All", "Album", "Baju", "Monster", "Aksesoris"]
                      .map(
                        (cat) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: ChoiceChip(
                            label: Text(cat),
                            selected: selectedCategory == cat,
                            onSelected: (value) {
                              setState(() {
                                selectedCategory = cat;
                              });
                            },
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),

              const SizedBox(height: 10),

              // 🔹 Ambil data dari Firestore
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('merchandise') // 🔸 nama collection kamu
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      );
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(
                        child: Text(
                          "Belum ada merchandise 😢",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }

                    final docs = snapshot.data!.docs;

                    // 🔸 convert dari firestore ke Merchandise model
                    final items = docs.map((doc) {
                      final data = doc.data() as Map<String, dynamic>;
                      return Merchandise(
                        name: data['name'] ?? '',
                        price: data['price'] ?? 0,
                        image: data['image'] ?? '',
                        image2: data['image2'] ?? '',
                        category: data['category'] ?? 'Uncategorized',
                        description: data['description'] ?? '',
                      );
                    }).toList();

                    // 🔸 filter berdasarkan kategori
                    final filteredItems = selectedCategory == "All"
                        ? items
                        : items
                              .where(
                                (item) => item.category == selectedCategory,
                              )
                              .toList();

                    return GridView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: filteredItems.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.75,
                          ),
                      itemBuilder: (context, index) {
                        final item = filteredItems[index];
                        return _buildMerchCard(context, item);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMerchCard(BuildContext context, Merchandise item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MerchandiseDetailScreen(
              item: item,
              onAddToCart: (merch) => addToCart(merch),
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 6,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 21, 20, 21),
                Color.fromARGB(255, 67, 64, 67),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: item.image.startsWith('http')
                    ? Image.network(
                        item.image,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.broken_image,
                            color: Colors.white,
                            size: 50,
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          );
                        },
                      )
                    : Image.asset(item.image, fit: BoxFit.contain),
              ),
              const SizedBox(height: 8),
              Text(
                item.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                "Rp ${item.price}",
                style: const TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 8),
              const Text(
                "Lihat Detail",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
