import 'package:cruise_buddy/UI/Widgets/Button/full_width_bluebutton.dart';
import 'package:cruise_buddy/core/constants/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:msh_checkbox/msh_checkbox.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypepasswordController = TextEditingController();

  bool isTextVisible = false;
  bool isChecked = false;
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode reTypepasswordFocusNode = FocusNode();


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 70),
                Center(
                  child: Image.asset(
                    'assets/signup_icon.png',
                    width: 70,
                    height: 70,
                  ),
                ),
                const SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Hello ",
                        style: TextStyles.ubuntu32blue24w2700,
                      ),
                      TextSpan(
                        text: "there!",
                        style: TextStyles.ubuntu32black24w2700,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Join us and unlock access to a world of boating experiences at your fingertips.",
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
                Text(
                  "Create Password",
                  style: TextStyles.ubuntu16black23w500,
                ),
                const SizedBox(height: 12),
                TextField(
                  obscureText: false,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_open_outlined),
                      suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              //   isTextVisible = !isTextVisible;
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
                Text(
                  "Re-type your Password",
                  style: TextStyles.ubuntu16black23w500,
                ),
                const SizedBox(height: 12),
                TextField(
                  obscureText: false,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_open_outlined),
                      suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              //   isTextVisible = !isTextVisible;
                            });
                          },
                          child: Icon(isTextVisible
                              ? Icons.visibility
                              : Icons.visibility_off)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32))),
                  controller: retypepasswordController,
                  focusNode: reTypepasswordFocusNode,
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
                  text: 'Signup',
                ),
                const SizedBox(
                  height: 12,
                ),
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
                      child: Text("or sign up with"),
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
                const SizedBox(height: 12),
                Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Join Already have an account? ",
                          style: TextStyles.ubuntu16black23w400,
                        ),
                        TextSpan(
                          text: "Sign in.",
                          style: TextStyles.ubuntu16blue86w400,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
