import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Playlist',
      home: const PlaylistScreen(),
    );
  }
}

class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({super.key});

  final List<String> songs = const [
    'Sunset Drive',
    'Strategy (feat. Megan Thee Stallion)',
    'Upuan by Gloc-9',
    'Kumilos (feat. Higit Sa Pag-Ibig)',
    // you can add or change songs you want
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Playlist')),
      body: ListView.builder(
        itemCount: songs.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.music_note),
            title: Text(songs[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NowPlayingScreen(songTitle: songs[index]),
                ), // MaterialPageRoute
              );
            },
          ); // ListTile
        },
      ), // ListView.builder
    ); // Scaffold
  }
}

class NowPlayingScreen extends StatelessWidget {
  final String songTitle;
  const NowPlayingScreen({super.key, required this.songTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Now Playing')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Playing: $songTitle'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Stop and Go Back'),
            ), // ElevatedButton
          ],
        ), // Column
      ), // Center
    ); // Scaffold
  }
}
