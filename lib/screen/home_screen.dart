import 'package:flutter/material.dart';
import 'merchandise_screen.dart';
import 'ProfileScreen.dart';
import 'post_feed_screen.dart';
import 'artist_list_screen.dart';

class XdhFansScreen extends StatelessWidget {
  final String username;
  const XdhFansScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
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
                              Text(
                                "Hello, $username 👋",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white70,
                                ),
                              ),

                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.music_note,
                                    color: Colors.white,
                                  ),
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
                    Tab(text: "FAN"),
                    Tab(text: "MEDIA"),
                    Tab(text: "NOTICES"),
                    Tab(text: "EVENTS"),
                  ],
                ),
              ),
            ];
          },
          body: const TabBarView(
            children: [
              ArtistListScreen(),
              PostFeedScreen(),
              Center(
                child: Text(
                  "Media Page",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Center(
                child: Text(
                  "Notices Page",
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
          backgroundColor: Colors.black,
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
            } else if (index == 3) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(username: username),
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
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: "Notices",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
    );
  }
}
