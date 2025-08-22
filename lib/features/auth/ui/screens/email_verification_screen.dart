import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/controllers/email_verification_controller.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/screens/otp_verification_screen.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/widgets/app_logo_widget.dart';
import 'package:crafty_bay_ecommerce/features/common/ui/widgets/center_progress_indicator.dart';
import 'package:crafty_bay_ecommerce/features/common/ui/widgets/snack_bar_message.dart';

class EmailVerificationScreen extends StatefulWidget {
  static const String name = 'email-verification';

  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final EmailVerificationController _emailVerificationController =
      Get.find<EmailVerificationController>();
  final TextEditingController _emailTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                  "Welcome Back",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Text(
                  'Please Enter Your Email Address',
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
                GetBuilder<EmailVerificationController>(builder: (controller) {
                  return Visibility(
                    visible: !controller.isLoading,
                    replacement: const CenterProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: _onPressedNextButton,
                      child: const Text("Next"),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onPressedNextButton() async {
    if (_formKey.currentState?.validate() ?? false) {
      bool isSuccess = await _emailVerificationController
          .verifyEmail(_emailTEController.text.trim());
      if (isSuccess) {
        if (mounted) {
          showSnackBarMessage(context, "OTP sent to your email address");
          _emailTEController.clear();
          _formKey.currentState?.reset();
          FocusScope.of(context).unfocus();
          Navigator.pushNamed(
            context,
            OtpVerificationScreen.name,
            arguments: _emailTEController.text.trim(),
          );
          print("navigate to otp screen");
        }
      } else {
        if (mounted) {
          showSnackBarMessage(context, "Something went wrong", true);
        }
      }
    }
  }
}
