import 'dart:async';

import 'package:crafty_bay_ecommerce/features/app/app_colors.dart';
import 'package:crafty_bay_ecommerce/features/app/app_constants.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/screens/compelete_profile_screen.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/widgets/app_logo_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPVerificationScreen extends StatefulWidget {
  const OTPVerificationScreen({super.key});

  static const String name = 'otp-verification';

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final TextEditingController _otpTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /*Timer? _timer;
  int _countDown = 120;
  bool _isButtonEnable = false;*/

  final RxInt _remainingTime = AppConstants.resendOTPTimeOutInSecond.obs;
  late Timer? timer;
  final RxBool _enableResendCodeButton = false.obs;

  @override
  void initState() {
    _startResendCodeTimer();
    super.initState();
  }

  void _startResendCodeTimer() {
    _enableResendCodeButton.value = false;
    _remainingTime.value = AppConstants.resendOTPTimeOutInSecond;
    timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        _remainingTime.value--;
        if (_remainingTime.value == 0) {
          timer.cancel();
          _enableResendCodeButton.value = true;
        }
      },
    );
  }

/*
  void _startTimer(){
    _timer = Timer.periodic(Duration(seconds: 1), (timer){
      setState(() {
        if(_countDown> 0){
          _countDown --;
        } else{
          _isButtonEnable =true;
          _timer?.cancel();
        }
      });
    });
  }
*/

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
                  'Enter OTP code',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 4),
                Text(
                  'A 4 Digit OTP code has been Sent',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.grey),
                ),
                SizedBox(height: 24),
                PinCodeTextField(
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  animationDuration: Duration(milliseconds: 300),
                  keyboardType: TextInputType.number,
                  pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(8),
                      activeColor: AppColors.themeColor,
                      inactiveColor: AppColors.themeColor),
                  appContext: context,
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // if(_formKey.currentState!.validate()){
                    //
                    // }
                    Navigator.pushNamed(context, CompleteProfileScreen.name);
                  },
                  child: Text('Next'),
                ),
                SizedBox(height: 24),
                Obx(
                  () => Visibility(
                    visible: !_enableResendCodeButton.value,
                    child: RichText(
                      text: TextSpan(
                        text: 'This code will expire in ',
                        style: TextStyle(color: Colors.grey),
                        children: [
                          TextSpan(
                            text: '$_remainingTime s',
                            style: TextStyle(
                              color: AppColors.themeColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => Visibility(
                    visible: _enableResendCodeButton.value,
                    child: TextButton(
                      onPressed: () {
                        _startResendCodeTimer();
                      },
                      child: Text('Resend Code'),
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

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
