// lib/ui/pages/profile/profile_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shophy/ui/widget/common/empty_state.dart';
import 'package:shophy/ui/widget/profile/profile_header.dart';
import 'package:shophy/ui/widget/profile/setting_tile.dart';
import '../../../utils/size_config.dart';
import '../../../providers/auth_provider.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  void initState() {
    super.initState();
    // Load orders when the page initializes if user is authenticated
    Future.microtask(() {
      final authState = ref.read(authProvider);
      if (authState.isAuthenticated) {
        // We would load orders here if we had an order provider
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    
    SizeConfig.init(context);
    
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(SizeConfig.getProportionateScreenWidth(16)),
        child: Column(
          children: [
            SizedBox(height: SizeConfig.getProportionateScreenHeight(10)),
            
            // Profile Header
            ProfileHeader(
              user: authState.user,
              onLoginPressed: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
            
            SizedBox(height: SizeConfig.getProportionateScreenHeight(30)),
            
            // Recent Orders Section
            if (authState.isAuthenticated) _buildRecentOrdersSection(),
            
            SizedBox(height: SizeConfig.getProportionateScreenHeight(30)),
            
            // Profile Options
            _buildProfileOptionsSection(),
            
            SizedBox(height: SizeConfig.getProportionateScreenHeight(30)),
            
            // App Settings
            _buildAppSettingsSection(),
            
            SizedBox(height: SizeConfig.getProportionateScreenHeight(30)),
            
            // Logout Button
            if (authState.isAuthenticated) _buildLogoutButton(),
            
            SizedBox(height: SizeConfig.getProportionateScreenHeight(20)),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentOrdersSection() {
    // Mock orders data - in real app, this would come from orderProvider
    final mockOrders = [];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(SizeConfig.getProportionateScreenWidth(16)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Orders',
                  style: TextStyle(
                    fontSize: SizeConfig.getProportionateScreenWidth(18),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    print('View All Orders pressed');
                  },
                  child: Text(
                    'View All',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: SizeConfig.getProportionateScreenWidth(14),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Empty state for orders
          Padding(
            padding: EdgeInsets.all(SizeConfig.getProportionateScreenWidth(16)),
            child: EmptyState(
              title: 'No orders yet',
              description: 'Your recent orders will appear here',
              icon: Icons.shopping_bag_outlined,
              buttonText: 'Start Shopping',
              onButtonPressed: () {
                print('Start Shopping pressed');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileOptionsSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          SettingTile(
            title: 'My Orders',
            icon: Icons.shopping_bag_outlined,
            onTap: () {
              print('My Orders tapped');
            },
          ),
          Divider(height: 1),
          SettingTile(
            title: 'My Addresses',
            icon: Icons.location_on_outlined,
            onTap: () {
              print('My Addresses tapped');
            },
          ),
          Divider(height: 1),
          SettingTile(
            title: 'Payment Methods',
            icon: Icons.payment_outlined,
            onTap: () {
              print('Payment Methods tapped');
            },
          ),
          Divider(height: 1),
          SettingTile(
            title: 'My Reviews',
            icon: Icons.star_border_outlined,
            onTap: () {
              print('My Reviews tapped');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAppSettingsSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          SettingTile(
            title: 'Notifications',
            icon: Icons.notifications_outlined,
            onTap: () {
              print('Notifications tapped');
            },
          ),
          Divider(height: 1),
          SettingTile(
            title: 'Privacy Policy',
            icon: Icons.privacy_tip_outlined,
            onTap: () {
              print('Privacy Policy tapped');
            },
          ),
          Divider(height: 1),
          SettingTile(
            title: 'Terms of Service',
            icon: Icons.description_outlined,
            onTap: () {
              print('Terms of Service tapped');
            },
          ),
          Divider(height: 1),
          SettingTile(
            title: 'Help & Support',
            icon: Icons.help_outline,
            onTap: () {
              print('Help & Support tapped');
            },
          ),
          Divider(height: 1),
          SettingTile(
            title: 'About App',
            icon: Icons.info_outline,
            onTap: () {
              print('About App tapped');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Container(
      width: double.infinity,
      height: SizeConfig.getProportionateScreenHeight(50),
      child: ElevatedButton(
        onPressed: () {
          ref.read(authProvider.notifier).logout();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          'Logout',
          style: TextStyle(
            fontSize: SizeConfig.getProportionateScreenWidth(16),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}