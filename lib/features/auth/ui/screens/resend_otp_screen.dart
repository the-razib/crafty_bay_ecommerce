import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crafty_bay_ecommerce/app/app_colors.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/controllers/resend_otp_controller.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/controllers/sign_in_controller.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/screens/otp_verification_screen.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/screens/sign_up_screen.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/widgets/app_logo_widget.dart';
import 'package:crafty_bay_ecommerce/features/common/ui/widgets/center_progress_indicator.dart';
import 'package:crafty_bay_ecommerce/features/common/ui/widgets/snack_bar_message.dart';

class ResendOtpScreen extends StatefulWidget {
  static const String name = 'resend-otp-screen';

  const ResendOtpScreen({super.key});

  @override
  State<ResendOtpScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<ResendOtpScreen> {
  final ResendOtpController _resendOtpController =
      Get.find<ResendOtpController>();
  final TextEditingController _emailTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 134),
                const AppLogoWidget(),
                const SizedBox(height: 28),
                Text(
                  "Resend OTP",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Text(
                  'Please Enter Your Email Address to Resend OTP',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.black54,
                      ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _emailTEController,
                  validator: (value) {
                    if (value?.trim().isEmpty ?? true) {
                      return "Please enter your email address";
                    }
                    if (EmailValidator.validate(value!) == false) {
                      return "Please Enter your valid email";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "Email Address",
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                GetBuilder<SignInController>(builder: (controller) {
                  return Visibility(
                    visible: !controller.isLoading,
                    replacement: const CenterProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: _onPressedSendOTPButton,
                      child: const Text("Send OTP"),
                    ),
                  );
                }),
                _buildSignUpSection(textTheme),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onPressedSendOTPButton() async {
    if (_formKey.currentState?.validate() ?? false) {
      bool isSuccess =
          await _resendOtpController.resendOtp(_emailTEController.text.trim());
      if (mounted) {
        if (isSuccess) {
          Navigator.pushNamed(
            context,
            OtpVerificationScreen.name,
            arguments: _emailTEController.text.trim(),
          );

          _emailTEController.clear();
          _formKey.currentState?.reset();
        } else {
          showSnackBarMessage(context, "Something went wrong", true);
        }
      }
    }
  }

  Widget _buildSignUpSection(TextTheme textTheme) {
    return Center(
      child: Column(
        children: [
          RichText(
            text: TextSpan(
              text: 'Don\'t have an account? ',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              children: [
                TextSpan(
                  text: ' Sign Up',
                  style: textTheme.bodyLarge?.copyWith(
                    color: AppColors.themeColor,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap =
                        () => Navigator.pushNamed(context, SignUpScreen.name),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
