import 'package:flutter/material.dart';

import 'models/listing.dart';

void main() => runApp(const LostAndFoundApp());

class LostAndFoundApp extends StatelessWidget {
  const LostAndFoundApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lost and Found Board',
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      home: const LostAndFoundHome(),
    );
  }
}

class LostAndFoundHome extends StatefulWidget {
  const LostAndFoundHome({super.key});

  @override
  State<LostAndFoundHome> createState() => _LostAndFoundHomeState();
}

class _LostAndFoundHomeState extends State<LostAndFoundHome> {
  final List<Listing> _listings = [];
  int _nextId = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lost and Found Board')),
      body: _listings.isEmpty ? const _EmptyState() : _buildList(),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: _listings.length,
      itemBuilder: (context, index) {
        final listing = _listings[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          child: ListTile(
            title: Text(listing.description),
            subtitle: Text(listing.location),
          ),
        ); // Card
      },
    ); // ListView.builder
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.inventory_2_outlined, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              'No listings yet',
              style: Theme.of(context).textTheme.titleMedium,
            ), // Text
            const SizedBox(height: 4),
            Text(
              'Tap the + button to report a lost or found item.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600),
            ), // Text
          ],
        ), // Column
      ), // Padding
    ); // Center
  }
}
