import 'package:flutter/material.dart';
import '../../models/merchandise.dart';
import 'info_screen.dart';

class MerchandiseScreen extends StatefulWidget {
  const MerchandiseScreen({super.key});

  @override
  State<MerchandiseScreen> createState() => _MerchandiseScreenState();
}

class _MerchandiseScreenState extends State<MerchandiseScreen> {
  String selectedCategory = "All";

  @override
  Widget build(BuildContext context) {
    final filteredItems = selectedCategory == "All"
        ? allItems
        : allItems.where((item) => item.category == selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Merchandise Store"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
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

              // 🔹 Grid produk
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: filteredItems.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) {
                    final item = filteredItems[index];
                    return _buildMerchCard(item);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMerchCard(Merchandise item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MerchandiseDetailScreen(item: item),
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
              Expanded(child: Image.asset(item.image, fit: BoxFit.contain)),
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
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
