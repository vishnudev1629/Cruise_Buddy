import 'package:cruise_buddy/core/constants/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Profile', style: TextStyles.ubuntu20black15w700),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: const Size(120, 120),
                painter: DottedBorderPainter(),
              ),
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.transparent,
                child: ClipOval(
                  child: SvgPicture.asset(
                    'assets/bottomNav/profile.svg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 5,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(4),
                      child: SvgPicture.asset(
                          'assets/image/profile/profile_pic_edit.svg')),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text('Rohan Jacob', style: TextStyles.ubuntu20black15w700),
          const SizedBox(height: 5),
          Text('rohanjacob123@gmail.com',
              style: TextStyles.ubuntu14black55w400),
          const SizedBox(height: 5),
          Text('+91 9826 727 916', style: TextStyles.ubuntu14black55w400),
          const SizedBox(height: 30),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                buildListTile(
                  leadingIconPath: 'assets/image/profile/payment method.svg',
                  title: 'Payment Methods',
                  onTap: () {},
                ),
                const Divider(
                  thickness: 0,
                ),
                buildListTile(
                  leadingIconPath: 'assets/image/profile/change password.svg',
                  title: 'Change Password',
                  onTap: () {},
                ),
                const Divider(
                  thickness: 0,
                ),
                buildListTile(
                  leadingIconPath:
                      'assets/image/profile/privacy and policy.svg',
                  title: 'Privacy Policy',
                  onTap: () {},
                ),
                const Divider(
                  thickness: 0,
                ),
                buildListTile(
                  leadingIconPath: 'assets/image/profile/logout (2).svg',
                  title: 'Logout',
                  titleStyle: TextStyles.ubuntu16blue86w500,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildListTile({
    required String leadingIconPath,
    required String title,
    required VoidCallback onTap,
    TextStyle? titleStyle,
  }) {
    return ListTile(
      leading: SvgPicture.asset(
        leadingIconPath,
        width: 24,
        height: 24,
      ),
      title: Text(
        title,
        style: titleStyle ??
            const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
      ),
      trailing: SvgPicture.asset(
        'assets/image/profile/arrow_right.svg',
        width: 16,
        height: 16,
      ),
      onTap: onTap,
    );
  }
}

class DottedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double radius = size.width / 2;

    final paint = Paint()
      ..color = Color(0XFF1F8386)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    double dashWidth = 30, dashSpace = 10;
    double circumference = 2 * 3.14159265359 * radius;
    double dashCount = circumference / (dashWidth + dashSpace);

    for (int i = 0; i < dashCount; i++) {
      double startAngle = (i * (dashWidth + dashSpace)) / radius;
      double endAngle = startAngle + dashWidth / radius;

      canvas.drawArc(
        Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: radius,
        ),
        startAngle,
        endAngle - startAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
