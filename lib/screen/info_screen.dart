import 'package:flutter/material.dart';
import '../models/merchandise.dart';

class MerchandiseDetailScreen extends StatelessWidget {
  final Merchandise item;

  const MerchandiseDetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 2, 2, 2),
      appBar: AppBar(
        title: Text(item.name),
        backgroundColor: const Color.fromARGB(255, 145, 139, 139),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 35, 35, 34),
              Color.fromARGB(255, 228, 201, 233),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Gambar Produk
                Expanded(
                  child: Hero(
                    tag: item.image,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(item.image, fit: BoxFit.contain),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Nama Produk
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 10),

                // Harga
                Text(
                  "Rp ${item.price}",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),

                const SizedBox(height: 20),

                // Deskripsi unik dari model
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    item.description, // 👉 deskripsi panjang
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis, // kalau lebih kasih "..."
                  ),
                ),

                const SizedBox(height: 30),

                // Tombol Beli
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 228, 225, 232),
                      foregroundColor: Colors.black87,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 20,
                      ),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "${item.name} berhasil ditambahkan ke keranjang!",
                          ),
                          backgroundColor: Colors.black87,
                        ),
                      );
                    },
                    icon: const Icon(Icons.shopping_cart_outlined),
                    label: const Text(
                      "Beli Sekarang",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
