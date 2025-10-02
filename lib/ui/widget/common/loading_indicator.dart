// lib/ui/widgets/common/loading_indicator.dart
import 'package:flutter/material.dart';
import '../../../utils/size_config.dart';

class LoadingIndicator extends StatelessWidget {
  final String? message;

  const LoadingIndicator({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: SizeConfig.getProportionateScreenWidth(40),
            height: SizeConfig.getProportionateScreenWidth(40),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              strokeWidth: 3,
            ),
          ),
          if (message != null) ...[
            SizedBox(height: SizeConfig.getProportionateScreenHeight(16)),
            Text(
              message!,
              style: TextStyle(
                fontSize: SizeConfig.getProportionateScreenWidth(14),
                color: Colors.grey[600],
              ),
            ),
          ],
        ],
      ),
    );
  }
}