import 'package:crafty_bay_ecommerce/features/app/app_colors.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/screens/otp_verification_screen.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/widgets/app_logo_widgets.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  static const String name = 'email-verification';

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(

        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 100),
                AppLogoWidget(),
                SizedBox(height: 24),
                Text(
                  'Welcome Back',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 4),
                Text(
                  'Please enter your email address',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.grey),
                ),
                SizedBox(height: 24),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.emailAddress,
                  validator: (String? value){
                    if(value?.trim().isEmpty?? true){
                      return 'Please enter your email';
                    }
                    if(EmailValidator.validate(value!)==false){
                      return 'Please enter valid email';
                    }
                    return null;
                  },
                  controller: _emailTEController,
                  decoration: InputDecoration(hintText: 'Email Address'),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // if(_formKey.currentState!.validate()){
                    //
                    // }
                    Navigator.pushNamed(context, OTPVerificationScreen.name);
                  },
                  child: Text('Next'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
