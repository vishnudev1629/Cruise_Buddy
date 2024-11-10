import 'package:cruise_buddy/UI/Widgets/Button/full_width_bluebutton.dart';
import 'package:cruise_buddy/core/constants/styles/text_styles.dart';
import 'package:cruise_buddy/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:msh_checkbox/msh_checkbox.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  bool isTextVisible = false;
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 70),
                Center(
                  child: Image.asset(
                    'assets/email_logo.png',
                    width: 80,
                    height: 80,
                  ),
                ),
                const SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "welcome ",
                        style: TextStyles.ubuntu32blue24w2700,
                      ),
                      TextSpan(
                        text: "back!",
                        style: TextStyles.ubuntu32black24w2700,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Your gateway to seamless boat rentals and memorable experiences on the water.",
                  style: TextStyles.ubuntu16black55w400,
                ),
                const SizedBox(height: 12),
                Text(
                  "Email Address",
                  style: TextStyles.ubuntu16black23w500,
                ),
                const SizedBox(height: 12),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    prefixIcon: const Icon(Icons.mail_outline_rounded),
                  ),
                  controller: emailController,
                  focusNode: emailFocusNode,
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Text(
                      "Password",
                      style: TextStyles.ubuntu16black23w500,
                    ),
                    const Spacer(),
                    TextButton(
                        onPressed: () {
                          AppRoutes.navigateToForgotPasswordScreen(context);
                        },
                        child: Text(
                          "Forgot Password?",
                          style: TextStyles.ubuntu12blue23w500,
                        ))
                  ],
                ),
                const SizedBox(height: 12),
                TextField(
                  obscureText: isTextVisible,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_open_outlined),
                      suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              isTextVisible = !isTextVisible;
                            });
                          },
                          child: Icon(isTextVisible
                              ? Icons.visibility
                              : Icons.visibility_off)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32))),
                  controller: passwordController,
                  focusNode: passwordFocusNode,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    MSHCheckbox(
                      size: 25,
                      value: isChecked,
                      colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                        checkedColor: Colors.blue,
                      ),
                      style: MSHCheckboxStyle.stroke,
                      onChanged: (selected) {
                        setState(() {
                          isChecked = selected;
                        });
                      },
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text("Keep me signed in",
                        style: TextStyles.ubuntu16black23w300),
                  ],
                ),
                const SizedBox(height: 12),
                const FullWidthBlueButton(
                  text: 'Login',
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text("or sign in with"),
                    ),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Center(
                  child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 201, 201, 201)),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset("assets/Google.png"),
                      )),
                ),
                const SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Don’t have an account?",
                        style: TextStyles.ubuntu16black23w400,
                      ),
                      TextSpan(
                        text: " Create an account",
                        style: TextStyles.ubuntu16blue86w400,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
