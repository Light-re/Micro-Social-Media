import 'package:flutter/material.dart';

import '../feed/compose_screen.dart';
import '../feed/feed_screen.dart';
import '../profile/profile_screen.dart';

/// Main shell with a slim bottom tab bar: Feed · Post · Profile.
class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  final GlobalKey<FeedScreenState> _feedKey = GlobalKey<FeedScreenState>();
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _tab,
        children: [
          FeedScreen(key: _feedKey),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab == 0 ? 0 : 2,
        onDestinationSelected: (index) {
          if (index == 1) {
            _openCompose();
            return;
          }
          setState(() => _tab = index == 0 ? 0 : 1);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Feed',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_circle_outline),
            selectedIcon: Icon(Icons.add_circle),
            label: 'Post',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Future<void> _openCompose() async {
    final created = await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(
        fullscreenDialog: true,
        builder: (_) => const ComposeScreen(),
      ),
    );
    if (created == true) {
      await _feedKey.currentState?.reload();
    }
  }
}
