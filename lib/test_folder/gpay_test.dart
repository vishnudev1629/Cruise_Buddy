// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// class GpayTest extends StatefulWidget {
//   const GpayTest({super.key});

//   @override
//   _GpayTestState createState() => _GpayTestState();
// }

// class _GpayTestState extends State<GpayTest> {
//   final String upiId = "adeebabu655@okaxis";
//   final String phoneNumber = "8848055651"; // Phone number
//   final String payeeName = "Adeeb Abu";
//   final String amount = "5"; 
//   final String transactionNote = "Cruise Buddy Payment";

//   Future<void> _payWithUPI() async {
//     String url =
//         "upi://pay?pa=$upiId&pn=$payeeName&mc=&tid=&tr=&tn=$transactionNote&am=$amount&cu=INR&url=&mam=$phoneNumber";

//     try {
//       Uri uri = Uri.parse(url);
//       if (await canLaunchUrl(uri)) {
//         await launchUrl(uri, mode: LaunchMode.externalApplication);
//       } else {
//         _showSnackBar("UPI app not found!");
//       }
//     } catch (e) {
//       _showSnackBar("Error: $e");
//     }
//   }

//   void _showSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: ElevatedButton(
//         onPressed: _payWithUPI,
//         child: Text("Pay via Google Pay"),
//       ),
//     );
//   }
// }
