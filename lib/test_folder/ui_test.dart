import 'package:flutter/material.dart';

class UiTest extends StatelessWidget {
  const UiTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 60),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 200,
                  height: 400,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                  ),
                ),
                Positioned(
                  left: -20, 
                  child: ClipOval(
                    child: Container(
                      width: 40,
                      height: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  right:
                      -20, 
                  child: ClipOval(
                    child: Container(
                      width: 40,
                      height: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
