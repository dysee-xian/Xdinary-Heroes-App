import 'package:flutter/material.dart';
import '../data/artist_data.dart';
import 'artist_detail_screen.dart';

class ArtistListScreen extends StatelessWidget {
  const ArtistListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Artist Profiles",
          style: TextStyle(
            color: Colors.deepPurple,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: artists.length,
        itemBuilder: (context, index) {
          final artist = artists[index];
          return ListTile(
            leading: CircleAvatar(backgroundImage: AssetImage(artist.image)),
            title: Text(
              artist.name,
              style: const TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              artist.position,
              style: const TextStyle(color: Colors.grey),
            ),
            onTap: () {
              // 👉 Navigate ke detail screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArtistDetailScreen(artist: artist),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
