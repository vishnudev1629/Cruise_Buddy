import 'package:cruise_buddy/UI/Widgets/Button/full_width_bluebutton.dart';
import 'package:cruise_buddy/core/constants/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otp_pin_field/otp_pin_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});
  final _otpPinFieldController = GlobalKey<OtpPinFieldState>();

  void _hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _hideKeyboard();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 70),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: const Color.fromARGB(255, 183, 183, 183),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset(
                      'assets/lock_icon.png',
                      width: 50,
                      height: 50,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Forgot ",
                      style: TextStyles.ubuntu32blue24w2900,
                    ),
                    TextSpan(
                      text: "password ?",
                      style: TextStyles.ubuntu32black24w2900,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "Allow users to securely reset their password if they have trouble logging in.",
                style: TextStyles.ubuntu16black55w400,
              ),
              const SizedBox(height: 33),
              Center(
                child: Text(
                  "Please enter the 4 digit code sent to hello@example.com",
                  style: TextStyles.ubuntu16black23w700,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: double.infinity,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      OtpPinField(
                        autoFocus: false,
                        fieldHeight: 50,
                        fieldWidth: 60,
                        key: _otpPinFieldController,
                        autoFillEnable: false,
                        textInputAction: TextInputAction.done,
                        onSubmit: (text) {
                          debugPrint('Entered pin is $text');
                        },
                        onChange: (text) {
                          debugPrint('Enter on change pin is $text');
                        },
                        onCodeChanged: (code) {
                          debugPrint('onCodeChanged is $code');
                        },
                        otpPinFieldStyle: OtpPinFieldStyle(
                          textStyle: TextStyles.ubuntu32blue86w700,
                          fieldBorderRadius: 25,
                          fieldBorderWidth: 1,
                          fieldPadding: 25,
                          hintTextColor: Colors.grey,
                          showHintText: true,
                          activeFieldBorderGradient: const LinearGradient(
                            colors: [
                              Colors.blue,
                              Colors.blue,
                            ],
                          ),
                          filledFieldBorderGradient: const LinearGradient(
                            colors: [
                              Colors.black,
                              Colors.black,
                            ],
                          ),
                          defaultFieldBorderGradient: const LinearGradient(
                            colors: [
                              Colors.grey,
                              Colors.grey,
                            ],
                          ),
                        ),
                        maxLength: 4,
                        showCursor: true,
                        cursorColor: Colors.grey,
                        upperChild: const Column(
                          children: [
                            SizedBox(height: 30),
                            Icon(Icons.flutter_dash_outlined, size: 150),
                            SizedBox(height: 20),
                          ],
                        ),
                        middleChild: Column(
                          children: [
                            const SizedBox(height: 30),
                            ElevatedButton(
                              onPressed: () {
                                _otpPinFieldController.currentState?.clearOtp();
                              },
                              child: const Text('Clear OTP'),
                            ),
                          ],
                        ),
                        cursorWidth: 2,
                        mainAxisAlignment: MainAxisAlignment.center,
                        otpPinFieldDecoration: OtpPinFieldDecoration.custom,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50),
              const FullWidthBlueButton(
                text: 'Verify',
              ),
              const SizedBox(
                height: 12,
              ),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Resend Code",
                    style: TextStyles.ubuntu16blue86w400,
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:cruise_buddy/UI/Widgets/custom_bottombutton.dart';
// import 'package:cruise_buddy/core/constants/styles/text_styles.dart';
// import 'package:flutter/material.dart';

// class ForgotPasswordScreen extends StatelessWidget {
//   const ForgotPasswordScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0XFFFFFFFF),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 90),

//               // SvgPicture.asset(
//               //   'assets/image/auth_img/forgot_password.svg',
//               //   height: 80,
//               //   width: 80,
//               // ),
//               Center(
//                   child: SizedBox(
//                       child: Image.asset(
//                           'assets/image/auth_img/forgot_password.png'))),
//               const SizedBox(height: 20),

//               const Row(
//                 children: [
//                   Text(
//                     'Forgot',
//                     style: TextStyle(
//                       fontSize: 32,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xff1F8386),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 5,
//                   ),
//                   Text(
//                     'Password?',
//                     style: TextStyle(
//                       fontSize: 32,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 8),

//               // Subtext
//               const Text(
//                 'Allow users to securely reset their password\nif they have trouble logging in.',
//                 textAlign: TextAlign.start,
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Color(0xff555555),
//                 ),
//               ),

//               const SizedBox(height: 60),

//               // Instruction Text
//               const Center(
//                 child: Text(
//                   'Please enter the 4 digit code sent to\nhello@example.com',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xff555555),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 24),

//               // OTP Fields
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   _otpTextField(),
//                   _otpTextField(),
//                   _otpTextField(),
//                   _otpTextField(),
//                 ],
//               ),

//               const SizedBox(height: 54),

//               // Verify Button

//               CustomBottomButton(
//                   backgroundcolor: const Color(0xff1F8386),
//                   foregroundColor: const Color(0xffFFFFFF),
//                   text: 'Verify',
//                   onPressed: () {}),
//               // SizedBox(
//               //   width: double.infinity,
//               //   height: 48,
//               //   child: ElevatedButton(
//               //     style: ElevatedButton.styleFrom(
//               //       backgroundColor: const Color(0xff1F8386),
//               //       foregroundColor: const Color(0xffFFFFFF),
//               //     ),
//               //     onPressed: () {},
//               //     child: Text(
//               //       'Verify',
//               //       style: TextStyles.rubik16whitew2700,
//               //     ),
//               //   ),
//               // ),

//               const SizedBox(height: 10),

//               // Resend Code Text
//               Center(
//                 child: TextButton(
//                   onPressed: () {},
//                   child: const Text(
//                     'Resend Code',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Color(0xff1F8386),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // OTP Text Field
//   Widget _otpTextField() {
//     return SizedBox(
//       width: 70,
//       height: 70,
//       child: TextField(
//         cursorColor: const Color(0xff1F8386),
//         decoration: InputDecoration(
//           counterText: '',
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(30),
//             borderSide: const BorderSide(
//                 color: Color(0XFFE2E2E2)), // Default border color
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(30),
//             borderSide: const BorderSide(
//                 color: Color(0xff1F8386)), // Border color when focused
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(30),
//             borderSide: const BorderSide(
//                 color: Color(0XFFE2E2E2)), // Border color when enabled
//           ),
//         ),
//         style: const TextStyle(
//             fontSize: 26,
//             fontWeight: FontWeight.bold,
//             color: Color(0xff1F8386)),
//         textAlign: TextAlign.center,
//         keyboardType: TextInputType.number,
//         maxLength: 1,
//       ),
//     );
//   }
// }
