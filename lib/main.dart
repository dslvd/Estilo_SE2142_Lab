import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

const Color kPurple = Color(0xFF6C5CE7);
const Color kPurpleLight = Color(0xFFF1EEFD);
const Color kNameColor = Color(0xFF2D2A4A);

const String kMemberPhotoUrl =
    'https://relay.xstlo.com/p/kevqzo.jpg';
const String kOrgFacebookUrl =
    'https://www.facebook.com/CentralPhilippineUniversity.CPU/';

void main() => runApp(const MembershipApp());

class MembershipApp extends StatelessWidget {
  const MembershipApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(textTheme: GoogleFonts.interTextTheme()),
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: const Padding(
                  padding: EdgeInsets.all(24),
                  child: MembershipCard(),
                ), // Padding
              ), // ConstrainedBox
            ), // SingleChildScrollView
          ), // Center
        ), // SafeArea
      ), // Scaffold
    ); // MaterialApp
  }
}

class MembershipCard extends StatelessWidget {
  const MembershipCard({super.key});

  static const double _avatarRadius = 55;

  Future<void> _openOrgFacebook(BuildContext context) async {
    final uri = Uri.parse(kOrgFacebookUrl);
    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!launched && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open the Facebook page.')),
      );
    }
  }

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
                const OrgHeader(),
                const SizedBox(height: 16),
                Text(
                  'Matthew Estilo',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: kNameColor,
                  ), // TextStyle
                ), // Text
                const SizedBox(height: 4),
                Text(
                  'BS Software Engineering - 2nd Year',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(fontSize: 13, color: Colors.grey),
                ), // Text
                const SizedBox(height: 16),
                const Divider(height: 1),
                const SizedBox(height: 16),
                const MemberDetails(),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => _openOrgFacebook(context),
                    icon: const Icon(Icons.facebook),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPurple,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ), // RoundedRectangleBorder
                    ),
                    label: Text(
                      'Visit CPU on Facebook',
                      style: GoogleFonts.inter(fontWeight: FontWeight.bold),
                    ), // Text
                  ), // ElevatedButton.icon
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
            child: CachedNetworkImage(
              imageUrl: kMemberPhotoUrl,
              width: _avatarRadius * 2,
              height: _avatarRadius * 2,
              fit: BoxFit.cover, // crop-to-fill: correct choice for an avatar
              placeholder: (context, url) => const SizedBox(
                width: _avatarRadius * 2,
                height: _avatarRadius * 2,
                child: Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                ), // Center
              ), // SizedBox
              errorWidget: (context, url, error) => Image.asset(
                'assets/images/profile.png',
                width: _avatarRadius * 2,
                height: _avatarRadius * 2,
                fit: BoxFit.cover,
              ), // Image.asset
            ), // CachedNetworkImage
          ), // ClipOval
        ), // Container
      ],
    ); // Stack
  }
}

class OrgHeader extends StatelessWidget {
  const OrgHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'CENTRAL PHILIPPINE UNIVERSITY',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.1,
            color: kPurple,
          ), // TextStyle
        ), // Text
        const SizedBox(height: 2),
        Text(
          'CPU Software Engineering - Digital Membership Card',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(fontSize: 11, color: Colors.grey),
        ), // Text
      ],
    ); // Column
  }
}

class MemberDetails extends StatelessWidget {
  const MemberDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _DetailRow(icon: Icons.badge, label: 'Member No.', value: 'CS-2026-0142'),
        SizedBox(height: 10),
        _DetailRow(icon: Icons.event_available, label: 'Valid Until', value: 'August 2027'),
      ],
    ); // Column
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.icon, required this.label, required this.value});

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: kPurpleLight,
          child: Icon(icon, color: kPurple, size: 16),
        ), // CircleAvatar
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(fontSize: 13, color: Colors.grey),
          ), // Text
        ), // Expanded
        Text(
          value,
          style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: kNameColor),
        ), // Text
      ],
    ); // Row
  }
}
