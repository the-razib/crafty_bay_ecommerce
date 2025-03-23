import 'package:crafty_bay_ecommerce/features/app/app_colors.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/screens/otp_verification_screen.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/widgets/app_logo_widgets.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  static const String name = 'complete-profile';

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _cityTEController = TextEditingController();
  final TextEditingController _shippingTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              SizedBox(height: 60),
              AppLogoWidget(
                height: 100,
                width: 100,
              ),
              SizedBox(height: 24),
              Text(
                'Complete Profile',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 4),
              Text(
                'Get stated with us with your details',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.grey),
              ),
              SizedBox(height: 24),
              _buildForm(),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {}
                },
                child: Text('Next'),
              )
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
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Please enter first name';
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _firstNameTEController,
            decoration: InputDecoration(hintText: 'First Name'),
          ),
          const SizedBox(height: 8),
          TextFormField(
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Please enter last name';
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _lastNameTEController,
            decoration: InputDecoration(hintText: 'Last Name'),
          ),
          const SizedBox(height: 8),
          TextFormField(
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Please enter Mobile number';
              }
              if (!RegExp(r'^(?:\+880|880|0)(13|14|15|16|17|18|19)\d{8}$')
                  .hasMatch(value!)) {
                return 'Please enter valid mobile number';
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            maxLength: 11,
            keyboardType: TextInputType.phone,
            controller: _mobileTEController,
            decoration: InputDecoration(hintText: 'Mobile '),
          ),
          const SizedBox(height: 8),
          TextFormField(
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Please enter City name';
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _cityTEController,
            decoration: InputDecoration(hintText: 'City'),
          ),
          const SizedBox(height: 8),
          TextFormField(
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Please enter shipping address';
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _shippingTEController,
            maxLines: 3,
            decoration: InputDecoration(hintText: 'Shipping Address'),
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
    _shippingTEController.dispose();
    super.dispose();
  }
}
