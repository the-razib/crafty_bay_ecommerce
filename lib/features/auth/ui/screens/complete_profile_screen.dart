import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/screens/otp_verification_screen.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/widgets/app_logo_widget.dart';

class CompleteProfileScreen extends StatefulWidget {
  static const String name = 'complete-profile';

  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _cityTEController = TextEditingController();
  final TextEditingController _shippingAddressTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              const AppLogoWidget(
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 28),
              Text(
                "Complete Profile",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Text(
                'Get started with us with your details',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black54,
                    ),
              ),
              const SizedBox(height: 16),
              _buildForm(),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Navigator.pushNamed(context, OtpVerificationScreen.name);
                  }
                },
                child: const Text("Complete"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _firstNameTEController,
            validator: (value) {
              if (value?.trim().isEmpty ?? true) {
                return "Please enter your first name";
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: "First Name",
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _lastNameTEController,
            validator: (value) {
              if (value?.trim().isEmpty ?? true) {
                return "Please enter your last name";
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: "Last Name",
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.phone,
            controller: _mobileTEController,
            validator: (value) {
              if (value?.trim().isEmpty ?? true) {
                return "Please enter your mobile number";
              }

              if (RegExp(r'^(?:\+88|88)?(01[3-9]\d{8})$').hasMatch(value!) ==
                  false) {
                return "Please Enter your valid email";
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: "Mobile",
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _cityTEController,
            validator: (value) {
              if (value?.trim().isEmpty ?? true) {
                return "Please enter your city name";
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: "City",
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            maxLines: 3,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _shippingAddressTEController,
            validator: (value) {
              if (value?.trim().isEmpty ?? true) {
                return "Please enter your shipping address";
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: "Shipping Address",
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _cityTEController.dispose();
    _shippingAddressTEController.dispose();
    super.dispose();
  }
}
