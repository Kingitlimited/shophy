// lib/ui/pages/profile/order_history.dart
import 'package:flutter/material.dart';
import 'package:shophy/ui/widget/common/empty_state.dart';
import 'package:shophy/ui/widget/profile/order_item.dart';
import '../../../utils/size_config.dart';

class OrderHistory extends StatelessWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    
    // Sample orders data - in real app, this would come from API
    final orders = [
      {
        'id': '12345',
        'date': '2024-01-15',
        'status': 'Delivered',
        'total': '\$99.99',
        'itemCount': 2,
      },
      {
        'id': '12346',
        'date': '2024-01-10',
        'status': 'Processing',
        'total': '\$149.99',
        'itemCount': 3,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Order History'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(SizeConfig.getProportionateScreenWidth(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Orders',
              style: TextStyle(
                fontSize: SizeConfig.getProportionateScreenWidth(24),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: SizeConfig.getProportionateScreenHeight(8)),
            Text(
              'Track and manage your orders',
              style: TextStyle(
                fontSize: SizeConfig.getProportionateScreenWidth(14),
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: SizeConfig.getProportionateScreenHeight(20)),
            
            Expanded(
              child: orders.isEmpty
                  ? EmptyState(
                      title: 'No orders yet',
                      description: 'Your order history will appear here',
                      icon: Icons.shopping_bag_outlined,
                      buttonText: 'Start Shopping',
                      onButtonPressed: () {
                        // Navigate to products
                      },
                    )
                  : ListView.builder(
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        final order = orders[index];
                        return OrderItem(
                          orderId: order['id']! as String,
                          date: order['date']!as String,
                          status: order['status']!as String,
                          total: order['total']!as String,
                          itemCount: order['itemCount'] as int,
                          onTap: () {
                            // Navigate to order details
                            print('View order details for ${order['id']}');
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}