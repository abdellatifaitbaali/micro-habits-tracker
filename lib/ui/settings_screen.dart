import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/habit_provider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: ListView(
        padding: EdgeInsets.all(24),
        children: [
          _buildSectionHeader('Privacy'),
          _buildSettingsCard(
            context,
            icon: Icons.shield_outlined,
            title: 'Privacy Policy',
            subtitle: 'This app is "Offline-First". No data leaves your device.',
          ),
          SizedBox(height: 16),
          _buildSettingsCard(
            context,
            icon: Icons.delete_forever_outlined,
            title: 'Delete All My Data',
            subtitle: 'Permanently clear all local storage.',
            iconColor: Colors.red,
            onTap: () => _showDeleteConfirmation(context),
          ),
          SizedBox(height: 32),
          _buildSectionHeader('About'),
          _buildSettingsCard(
            context,
            icon: Icons.info_outline,
            title: 'Micro-Habits Tracker',
            subtitle: 'Version 1.1.0 • Built for Privacy',
          ),
          SizedBox(height: 24),
          Center(
            child: Text(
              'Your data stays on your device.\nWe do not use Cloud or Tracking SDKs.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 8),
      child: Text(
        title.toUpperCase(),
        style: GoogleFonts.outfit(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildSettingsCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    Color? iconColor,
    VoidCallback? onTap,
  }) {
    return Card(
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Icon(icon, color: iconColor ?? Theme.of(context).colorScheme.primary),
        title: Text(title, style: GoogleFonts.outfit(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle, style: TextStyle(fontSize: 13)),
        onTap: onTap,
        trailing: onTap != null ? Icon(Icons.chevron_right) : null,
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Deletion'),
        content: Text('Are you sure? This will wipe your database clean. This action cannot be undone.'),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text('Delete Everything', style: TextStyle(color: Colors.red)),
            onPressed: () {
              Provider.of<HabitProvider>(context, listen: false).clearAllData();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('All data successfully purged.')),
              );
            },
          ),
        ],
      ),
    );
  }
}
