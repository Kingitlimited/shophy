// lib/ui/widgets/common/custom_drawer.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/size_config.dart';
import '../../../providers/auth_provider.dart';

class CustomDrawer extends ConsumerWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildDrawerHeader(authState),
          ..._buildDrawerItems(context, authState, ref),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader(AuthState authState) {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: Colors.blue,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CircleAvatar(
            radius: SizeConfig.getProportionateScreenWidth(25),
            backgroundColor: Colors.white,
            child: Icon(
              Icons.person,
              color: Colors.blue,
              size: SizeConfig.getProportionateScreenWidth(25),
            ),
          ),
          SizedBox(height: SizeConfig.getProportionateScreenHeight(10)),
          Text(
            authState.user?.fullName ?? 'Welcome Guest',
            style: TextStyle(
              color: Colors.white,
              fontSize: SizeConfig.getProportionateScreenWidth(18),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: SizeConfig.getProportionateScreenHeight(4)),
          Text(
            authState.user?.email ?? 'guest@example.com',
            style: TextStyle(
              color: Colors.white70,
              fontSize: SizeConfig.getProportionateScreenWidth(14),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildDrawerItems(BuildContext context, AuthState authState, WidgetRef ref) {
    final drawerItems = [
      _DrawerItem('Home', Icons.home, () {
        Navigator.pop(context);
        // Navigate to home or stay on home
      }),
      _DrawerItem('Categories', Icons.category, () {
        Navigator.pop(context);
        print('Categories pressed');
      }),
      if (authState.isAuthenticated) 
        _DrawerItem('My Orders', Icons.shopping_bag, () {
          Navigator.pop(context);
          print('My Orders pressed');
        }),
      _DrawerItem('Wishlist', Icons.favorite, () {
        Navigator.pop(context);
        print('Wishlist pressed');
      }),
      _DrawerItem('Notifications', Icons.notifications, () {
        Navigator.pop(context);
        print('Notifications pressed');
      }),
      _DrawerItem('Settings', Icons.settings, () {
        Navigator.pop(context);
        print('Settings pressed');
      }),
      _DrawerItem('About', Icons.info, () {
        Navigator.pop(context);
        print('About pressed');
      }),
      _DrawerItem('Help & Support', Icons.help, () {
        Navigator.pop(context);
        print('Help & Support pressed');
      }),
    ];
    
    var items = drawerItems.map((item) => ListTile(
      leading: Icon(
        item.icon,
        color: Colors.grey[700],
        size: SizeConfig.getProportionateScreenWidth(22),
      ),
      title: Text(
        item.title,
        style: TextStyle(
          fontSize: SizeConfig.getProportionateScreenWidth(16),
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: item.onTap,
    )).toList();

    // Add logout button if authenticated
    if (authState.isAuthenticated) {
      items.add(ListTile(
        leading: Icon(
          Icons.logout,
          color: Colors.red,
          size: SizeConfig.getProportionateScreenWidth(22),
        ),
        title: Text(
          'Logout',
          style: TextStyle(
            fontSize: SizeConfig.getProportionateScreenWidth(16),
            fontWeight: FontWeight.w500,
            color: Colors.red,
          ),
        ),
        onTap: () {
          ref.read(authProvider.notifier).logout();
          Navigator.pop(context); // Close the drawer
        },
      ));
    }

    return items;
  }
}

class _DrawerItem {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  _DrawerItem(this.title, this.icon, this.onTap);
}