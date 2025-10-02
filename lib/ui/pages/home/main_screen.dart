// lib/ui/pages/home/main_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shophy/ui/widget/common/custom_app_bar.dart';
import 'package:shophy/ui/widget/common/custom_bottom_nav.dart';
import 'package:shophy/ui/widget/common/custom_drawer.dart';
import '../../../utils/size_config.dart';
import '../../../providers/auth_provider.dart';
import 'home_page.dart';
import '../wishlist/wishlist_page.dart';
import '../cart/cart_page.dart';
import '../profile/profile_page.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> _pages = [
    HomePage(),
    WishlistPage(),
    CartPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    
    SizeConfig.init(context);
    
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        appName: "Shophy",
        onMenuPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
        onProfilePressed: () {
          // Navigate to profile or login
          if (authState.isAuthenticated) {
            setState(() {
              _currentIndex = 3; // Profile page
            });
          } else {
            Navigator.pushNamed(context, '/login');
          }
        },
      ),
      drawer: CustomDrawer(),
      body: _pages[_currentIndex],
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentIndex,
        onTabChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}