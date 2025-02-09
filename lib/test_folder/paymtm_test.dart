// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// class PaymtmTest extends StatefulWidget {
//   const PaymtmTest({super.key});

//   @override
//   _PaymtmTestState createState() => _PaymtmTestState();
// }

// class _PaymtmTestState extends State<PaymtmTest> {
//   final String upiId = "9744765904@pthdfc"; // Replace with actual UPI ID
//   final String payeeName = "Vishnu Dev";
//   final String amount =  "5"; 
//   final String transactionNote = "Cruise Buddy Payment";

//   void _payWithPaytm() async {
//     String url =
//         "paytmmp://pay?pa=$upiId&pn=$payeeName&mc=&tid=&tr=&tn=$transactionNote&am=$amount&cu=INR";

//     if (await canLaunchUrl(Uri.parse(url))) {
//       await launchUrl(Uri.parse(url));
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Paytm app not found!")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return  Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: _payWithPaytm,
//               child: Text("Pay via Paytm"),
//             ),
//           ],
//         );
//   }
// }
