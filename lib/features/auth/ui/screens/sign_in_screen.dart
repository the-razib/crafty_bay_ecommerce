import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crafty_bay_ecommerce/app/app_colors.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/controllers/sign_in_controller.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/screens/sign_up_screen.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/widgets/app_logo_widget.dart';
import 'package:crafty_bay_ecommerce/features/common/ui/screens/main_layout.dart';
import 'package:crafty_bay_ecommerce/features/common/ui/widgets/center_progress_indicator.dart';
import 'package:crafty_bay_ecommerce/features/common/ui/widgets/snack_bar_message.dart';

class SignInScreen extends StatefulWidget {
  static const String name = 'sign-in';

  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final SignInController _signInController = Get.find<SignInController>();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
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
                TextFormField(
                  obscureText: true,
                  obscuringCharacter: '*',
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _passwordTEController,
                  validator: (value) {
                    if (value?.trim().isEmpty ?? true) {
                      return "Please enter your password";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "Password",
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
                      onPressed: _onPressedNextButton,
                      child: const Text("Next"),
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

  Future<void> _onPressedNextButton() async {
    if (_formKey.currentState?.validate() ?? false) {
      bool isSuccess = await _signInController.signIn(
          _emailTEController.text.trim(), _passwordTEController.text);
      if (isSuccess) {
        if (mounted) {
          _emailTEController.clear();
          _formKey.currentState?.reset();
          Navigator.pushNamed(
            context,
            MainLayout.name,
          );
        }
      } else {
        if (mounted) {
          showSnackBarMessage(context, "Something went wrong", true);
        }
      }
    }
  }

  Widget _buildSignUpSection(TextTheme textTheme) {
    return Center(
      child: Column(
        children: [
          TextButton(
            onPressed: () => Get.toNamed(SignInScreen.name),
            child: const Text(
              'Forgot Password?',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
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
                    ..onTap = () => Get.toNamed(SignUpScreen.name),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
