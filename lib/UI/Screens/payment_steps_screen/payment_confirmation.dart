import 'package:cruise_buddy/core/constants/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PaymentConfirmationSCreen extends StatefulWidget {
  const PaymentConfirmationSCreen({super.key});

  @override
  State<PaymentConfirmationSCreen> createState() =>
      _PaymentConfirmationSCreenState();
}

class _PaymentConfirmationSCreenState extends State<PaymentConfirmationSCreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Center(child: Text('Payment Confirmation Screen')));
  }
}
