import 'package:cloud_firestore/cloud_firestore.dart';

class Merchandise {
  final String name;
  final int price;
  final String image;
  final String category;
  final String description;
  final String? id; 
  
  Merchandise({
    required this.name,
    required this.price,
    required this.image,
    required this.category,
    required this.description,
    this.id,
  });


  // Factory untuk convert dari document firestore ke object Merchandise
  factory Merchandise.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Merchandise(
      id: doc.id,
      name: data['name'] ?? '',
      price: data['price'] ?? 0,
      image: data['image'] ?? '',
      category: data['category'] ?? '',
      description: data['description'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'image': image,
      'category': category,
      'description': description,
    };
  }
}

/// Service class untuk ambil data dari firestore
class MerchandiseService {
  final CollectionReference merchRef = FirebaseFirestore.instance.collection(
    'merchandise',
  );

  Future<List<Merchandise>> getMerchandise() async {
    final querySnapshot = await merchRef.get();
    return querySnapshot.docs
        .map((doc) => Merchandise.fromDocument(doc))
        .toList();
  }

  // Tambahan kalau mau nambahin data ke Firestore
  Future<void> addMerchandise(Merchandise item) async {
    await merchRef.add(item.toMap());
  }
}
