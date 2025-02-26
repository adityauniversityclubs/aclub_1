import 'package:aclub/home/homepage.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:aclub/home/profilePage.dart';
import 'package:aclub/admin/admin_page.dart';
import 'package:aclub/home/all_Clubs_page.dart';

class Nav_Bar extends StatefulWidget {
  final int val; // 0 for normal user, 1 for admin
  const Nav_Bar({super.key, required this.val});

  @override
  _Nav_BarState createState() => _Nav_BarState();
}

class _Nav_BarState extends State<Nav_Bar> {
  int _currentIndex = 0;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _updateScreens();
  }

  void _updateScreens() {
    _screens = widget.val == 0
        ? [
            const HomeScreen(),
            // const MyEPage(),
            // const SizedBox(), // Placeholder for admin screen
            AdminPage(),

            const ProfileScreen(),
          ]
        : [
            const HomeScreen(),
            // const ProfileScreen(),
            const ProfileScreen(),
          ];
  }

  List<BottomNavigationBarItem> _getNavItems() {
    if (widget.val == 0) {
      return [
        const BottomNavigationBarItem(
          icon: Icon(Iconsax.home),
          label: 'Home',
        ),
        // const BottomNavigationBarItem(
        //   icon: Icon(Iconsax.group),
        //   label: 'Chats',
        // ),
        const BottomNavigationBarItem(
          icon: Icon(Iconsax.setting),
          label: 'Admin',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Iconsax.user),
          label: 'Profile',
        ),
      ];
    } else {
      return [
        const BottomNavigationBarItem(
          icon: Icon(Iconsax.home),
          label: 'Home',
        ),
// BottomNavigationBarItem(
//   icon: Icon(Icons.groups_outlined),
//   label: 'Clubs',
// )
// ,
        const BottomNavigationBarItem(
          icon: Icon(Iconsax.user),
          label: 'Profile',
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: _buildWhatsAppStyleNavBar(),
    );
  }

  Widget _buildWhatsAppStyleNavBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) => setState(() => _currentIndex = index),
      items: _getNavItems(),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color.fromARGB(255, 70, 0, 168), // WhatsApp green
      unselectedItemColor: Colors.grey[600],
      selectedLabelStyle: const TextStyle(fontSize: 12),
      unselectedLabelStyle: const TextStyle(fontSize: 12),
      iconSize: 28,
    );
  }
}