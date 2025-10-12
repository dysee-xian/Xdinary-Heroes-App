import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../data/event_data.dart'; // Import data event
import '../models/event.dart'; // Import model event
import 'merchandise_screen.dart';
import 'ProfileScreen.dart';
import 'artist_list_screen.dart';

class XdhFansScreen extends StatelessWidget {
  final String userid;
  const XdhFansScreen({super.key, required this.userid});

  final List<String> imageList = const [
    'assets/image/TroubleShooting.jpg',
    'assets/image/beauifulmind.jpg',
    'assets/image/ode.jpg',
    'assets/image/gunil.jpg',
    'assets/image/Jungsu.jpg',
    'assets/image/gaon.jpg',
    'assets/image/JOOYEON.jpg',
    'assets/image/Junhan.jpg',
    'assets/image/depan.png',
  ];

  Future<String> fetchUserName() async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userid)
          .get();

      if (userDoc.exists && userDoc.data() != null) {
        final data = userDoc.data() as Map<String, dynamic>;
        return data['name'] ?? 'Villain';
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
    return DefaultTabController(
      length: 3,
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
                                    "Hello, $greetingName 👋",
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
          body: TabBarView(
            children: [
              const ArtistListScreen(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MasonryGridView.builder(
                  itemCount: imageList.length,
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(imageList[index], fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),
              // ## MODIFIKASI: Tampilkan daftar event di sini ##
              ListView.builder(
                itemCount: dummyEvents.length,
                itemBuilder: (context, index) {
                  final event = dummyEvents[index];
                  return Card(
                    color: Colors.grey[900],
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              event.imageUrl,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  event.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  event.date,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  event.location,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          selectedItemColor: Colors.deepPurple,
          unselectedItemColor: const Color.fromARGB(179, 56, 53, 53),
          onTap: (index) {
            if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MerchandiseScreen(),
                ),
              );
            } else if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(userid: userid),
                ),
              );
            }
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag),
              label: "Merchandise",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
    );
  }
}
