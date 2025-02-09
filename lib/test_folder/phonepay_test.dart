// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// class PhonepayTest extends StatefulWidget {
//   const PhonepayTest({super.key});

//   @override
//   _PhonepayTestState createState() => _PhonepayTestState();
// }

// class _PhonepayTestState extends State<PhonepayTest> {
//   final String upiId = "9744765904@ybl"; // Replace with actual UPI ID
//   final String payeeName = "Vishnu Dev";
//   final String amount = "5"; 
//   final String transactionNote = "Cruise Buddy Payment";

//   void _payWithPhonePe() async {
//     String url =
//         "phonepe://upi/pay?pa=$upiId&pn=$payeeName&mc=&tid=&tr=&tn=$transactionNote&am=$amount&cu=INR";

//     if (await canLaunchUrl(Uri.parse(url))) {
//       await launchUrl(Uri.parse(url));
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("PhonePe app not found!")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return  Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: _payWithPhonePe,
//               child: Text("Pay via PhonePe"),
//             ),
//           ],
//         );
//   }
// }
