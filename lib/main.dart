import 'package:flutter/material.dart';

const Color kPurple = Color(0xFF6C5CE7);
const Color kPurpleLight = Color(0xFFF1EEFD);
const Color kNameColor = Color(0xFF2D2A4A);

void main() => runApp(const ProfileApp());

class ProfileApp extends StatelessWidget {
  const ProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: kPurple,
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: const ProfileCard(),
              ), // Padding
            ), // ConstrainedBox
          ), // Center
        ), // SafeArea
      ), // Scaffold
    ); // MaterialApp
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  static const double _avatarRadius = 55;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Card(
          color: Colors.white,
          elevation: 8,
          margin: const EdgeInsets.only(top: _avatarRadius),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ), // RoundedRectangleBorder
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, _avatarRadius + 16, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Matthew Estilo',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Baloo2',
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: kNameColor,
                  ), // TextStyle
                ), // Text
                const SizedBox(height: 10),
                const Text(
                  'Software Engineering Student',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ), // Text
                const Text(
                  'code.debug.repeat',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ), // Text
                const SizedBox(height: 16),
                const Divider(height: 1),
                const SizedBox(height: 16),
                const StatsRow(),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPurple,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ), // RoundedRectangleBorder
                    ),
                    child: const Text(
                      'Edit Profile',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ), // Text
                  ), // ElevatedButton
                ), // SizedBox
              ],
            ), // Column
          ), // Padding
        ), // Card
        Container(
          padding: const EdgeInsets.all(4),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ), // BoxDecoration
          child: ClipOval(
            child: Image.asset(
              'assets/images/profile.png',
              width: _avatarRadius * 2,
              height: _avatarRadius * 2,
              fit: BoxFit.cover, // crop-to-fill: correct choice for an avatar
            ), // Image.asset
          ), // ClipOval
        ), // Container
      ],
    ); // Stack
  }
}

class StatsRow extends StatelessWidget {
  const StatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _statItem(Icons.grid_on, '6', 'Posts'),
        _statItem(Icons.people, '6.7K', 'Followers'),
        _statItem(Icons.person_add, '10', 'Following'),
      ],
    ); // Row
  }

  Widget _statItem(IconData icon, String value, String label) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: kPurpleLight,
            child: Icon(icon, color: kPurple, size: 20),
          ), // CircleAvatar
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ), // Text
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ), // Text
        ],
      ), // Column
    ); // Expanded
  }
}
