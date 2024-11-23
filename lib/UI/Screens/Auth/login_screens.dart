import 'package:cruise_buddy/UI/Widgets/Button/full_width_bluebutton.dart';
import 'package:cruise_buddy/core/constants/styles/text_styles.dart';
import 'package:cruise_buddy/core/routes/app_routes.dart';
import 'package:cruise_buddy/core/view_model/login/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:msh_checkbox/msh_checkbox.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController =
      TextEditingController(text: 'test@example.com');
  TextEditingController passwordController =
      TextEditingController(text: 'test@example.com');
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
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          state.map(
            initial: (_) {
              print('initial');
            },
            loading: (_) {
              print('loading');
            },
            loginSuccess: (success) {
              AppRoutes.navigateToMainLayoutScreen(context);
            },
            loginFailure: (failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("${failure.error}"),
                ),
              );
            },
            noInternet: (value) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("No Internet please try again"),
                ),
              );
            },
          );
        },
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 70),
                  Center(
                    child: Image.asset(
                      'assets/email_logo.png',
                      width: 120,
                      height: 120,
                    ),
                  ),
                  const SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "welcome ",
                          style: TextStyles.ubuntu32blue24w2900,
                        ),
                        TextSpan(
                          text: "back!",
                          style: TextStyles.ubuntu32black24w2900,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Your gateway to seamless boat rentals and memorable experiences on the water.",
                    style: TextStyles.ubuntu16black55w400,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Email Address",
                    style: TextStyles.ubuntu16black23w700,
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SvgPicture.asset(
                          'assets/image/auth_img/ion_mail-outline.svg',
                        ),
                      ),
                    ),
                    controller: emailController,
                    focusNode: emailFocusNode,
                  ),
                  Row(
                    children: [
                      Text(
                        "Password",
                        style: TextStyles.ubuntu16black23w700,
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Forgot Password?",
                          style: TextStyles.ubuntu12blue23w700,
                        ),
                      ),
                    ],
                  ),
                  TextField(
                    obscureText: isTextVisible,
                    decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SvgPicture.asset(
                            'assets/image/auth_img/icon_password-outline.svg',
                          ),
                        ),
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
                        colorConfig:
                            MSHColorConfig.fromCheckedUncheckedDisabled(
                          checkedColor: const Color(0xFF1F8386),
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
                  FullWidthBlueButton(
                    text: 'Login',
                    onPressed: () {
                      BlocProvider.of<LoginBloc>(context).add(
                        LoginEvent.loginRequested(
                          email: emailController.text,
                          password: passwordController.text,
                        ),
                      );
                    },
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
                  Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Don’t have an account?",
                              style: TextStyles.ubuntu16black23w400,
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          AppRoutes.navigateToRegistartionScreen(context);
                        },
                        child: Text(
                          "Create an account",
                          style: TextStyles.ubuntu12blue23w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
