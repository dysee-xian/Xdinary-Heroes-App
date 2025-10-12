import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'merchandise_screen.dart';
import 'ProfileScreen.dart';
import 'artist_list_screen.dart';

class XdhFansScreen extends StatelessWidget {
  final String userid;
  const XdhFansScreen({super.key, required this.userid});

  // Fungsi baru: Mengambil nama pengguna dari Firestore menggunakan UID
  Future<String> fetchUserName() async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userid) // Menggunakan UID untuk mencari dokumen
          .get();

      if (userDoc.exists && userDoc.data() != null) {
        // Mengambil field 'name' yang disimpan saat registrasi
        final data = userDoc.data() as Map<String, dynamic>;
        return data['name'] ??
            'Villain'; // Mengembalikan nama, atau 'Villain' sebagai default
      } else {
        return 'Villain (Not Found)';
      }
    } catch (e) {
      print("Error fetching user name: $e");
      return 'Error Loading Name';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Length TabController tetap 5 sesuai TabBar di SliverAppBar (ARTIST, FAN, MEDIA, NOTICES, EVENTS)
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: Colors.black,
                expandedHeight: 550,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset("assets/image/depan.png", fit: BoxFit.cover),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(0.6),
                              Colors.transparent,
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 40),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                "Xdinary Heroes",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 6),

                              // Menampilkan Nama Pengguna dari Firestore
                              FutureBuilder<String>(
                                future: fetchUserName(),
                                builder: (context, snapshot) {
                                  String greetingName = 'Loading...';

                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    greetingName = 'Loading...';
                                  } else if (snapshot.hasError) {
                                    greetingName = 'Error';
                                  } else if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    greetingName = snapshot.data ?? 'Villain';
                                  }

                                  return Text(
                                    "Hello, $greetingName 👋", // Menampilkan nama asli
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white70,
                                    ),
                                  );
                                },
                              ),

                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.music_note, color: Colors.white),
                                  SizedBox(width: 16),
                                  Icon(Icons.tiktok, color: Colors.white),
                                  SizedBox(width: 16),
                                  Icon(Icons.facebook, color: Colors.white),
                                  SizedBox(width: 16),
                                  Icon(Icons.more_horiz, color: Colors.white),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                bottom: const TabBar(
                  indicatorColor: Colors.deepPurple,
                  labelColor: Colors.deepPurple,
                  unselectedLabelColor: Colors.white70,
                  tabs: [
                    Tab(text: "ARTIST"),
                    Tab(text: "MEDIA"),
                    Tab(text: "EVENTS"),
                  ],
                ),
              ),
            ];
          },
          body: const TabBarView(
            children: [
              ArtistListScreen(),
              Center(
                child: Text(
                  "Media Page",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Center(
                child: Text(
                  "Events Page",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),

        // Bottom Navigation
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          selectedItemColor: Colors.deepPurple,
          unselectedItemColor: const Color.fromARGB(179, 56, 53, 53),
          onTap: (index) {
            // Index: 0 = Home, 1 = Merchandise, 2 = Profile
            if (index == 1) {
              // Merchandise (Index 1)
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MerchandiseScreen(),
                ),
              );
            } else if (index == 2) {
              // PERBAIKAN: Profile sekarang di Index 2
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(userid: userid),
                ),
              );
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ), // Index 0
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag),
              label: "Merchandise",
            ), // Index 1
            // Item 'Notices' dihapus dari sini
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ), // Index 2
          ],
        ),
      ),
    );
  }
}
