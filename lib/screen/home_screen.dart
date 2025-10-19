import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/event_data.dart';
import '../models/event.dart';
import 'merchandise_screen.dart';
import 'ProfileScreen.dart';
import 'artist_list_screen.dart';

class XdhFansScreen extends StatelessWidget {
  final String userid;
  const XdhFansScreen({super.key, required this.userid});

  final List<String> imageList = const [
    'assets/image/ode.jpg',
    'assets/image/gunil.jpg',
    'assets/image/Jungsu.jpg',
    'assets/image/gaon.jpg',
    'assets/image/JOOYEON.jpg',
    'assets/image/Junhan.jpg',
    'assets/image/depan.png',
    'https://i.imgur.com/1Zhpdtd.jpeg',
    'https://i.imgur.com/ApSfRom.jpeg',
    'https://i.imgur.com/acD9lTb.jpeg',
    'https://i.imgur.com/EM7DO4b.jpeg',
    'https://i.imgur.com/mpJOW5x.jpeg',
    'https://i.imgur.com/aLAeK57.jpeg',
    'https://i.imgur.com/RhSkFUb.jpeg',
    'https://i.imgur.com/x5F3dpK.jpeg',
    'https://i.imgur.com/Nlq2fXm.jpeg',
    'https://i.imgur.com/OkPStek.jpeg',
  ];

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Tidak dapat membuka $url';
    }
  }

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

                              // 🌐 Ikon Sosial Media
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.play_circle_fill,
                                      color: Colors.white,
                                    ),
                                    iconSize: 25,
                                    onPressed: () {
                                      _launchURL(
                                        'https://youtu.be/_L7wVbtpgm8?si=0vrYsBAbsWO2Lqkg',
                                      );
                                    },
                                  ),
                                  const SizedBox(width: 16),
                                  IconButton(
                                    icon: const Icon(Icons.music_note),
                                    iconSize: 25,
                                    color: Colors.white,
                                    onPressed: () {
                                      _launchURL(
                                        'https://spotify.link/Pv3hPUbjtXb',
                                      );
                                    },
                                  ),
                                  const SizedBox(width: 16),
                                  IconButton(
                                    icon: const Icon(Icons.tiktok),
                                    iconSize: 25,
                                    color: Colors.white,
                                    onPressed: () {
                                      _launchURL(
                                        'https://www.tiktok.com/@xheroes_official?_t=ZS-90YWRNEqAaL&_r=1',
                                      );
                                    },
                                  ),
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
                  itemBuilder: (context, index) {
                    final imagePath = imageList[index];
                    final isNetwork = imagePath.startsWith('http');

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: isNetwork
                            ? Image.network(
                                imagePath,
                                fit: BoxFit.cover,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                errorBuilder: (context, error, stackTrace) {
                                  return const Center(
                                    child: Icon(
                                      Icons.broken_image,
                                      color: Colors.white54,
                                    ),
                                  );
                                },
                              )
                            : Image.asset(imagePath, fit: BoxFit.cover),
                      ),
                    );
                  },
                ),
              ),
              // 📅 EVENT LIST
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
