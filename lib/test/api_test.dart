import 'package:cruise_buddy/core/services/api_services.dart';
import 'package:flutter/material.dart';

class ApiTest extends StatelessWidget {
  const ApiTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await ApiServices().login('email', 'password');
              },
              child: Text("Call Api"),
            ),
          ],
        ),
      ),
    );
  }
}
