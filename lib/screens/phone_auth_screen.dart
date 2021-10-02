import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:myfood/controllers/phone_auth_controller.dart';
import 'package:myfood/widgets/dialogs.dart';
import 'package:sms_autofill/sms_autofill.dart';

class PhoneAuthScreen extends StatefulWidget {
  @override
  _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  var phoneAuthController = Get.put(PhoneAuthController());

  String cleanNumber(String number) {
    return number.replaceAll(' ', '').replaceAll('+91', '');
  }

  @override
  void initState() {
    super.initState();
    final SmsAutoFill _autoFill = SmsAutoFill();

    /// This lines display the available mobile numbers
    _autoFill.hint.then((number) {
      if (number != null)
        phoneAuthController.phoneTEController.text = cleanNumber(number);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: GetBuilder<PhoneAuthController>(
              builder: (controller) {
                return Column(
                  children: [
                    if (!controller.showOTPField)
                      TextField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter 10-digit Mobile Number'),
                        keyboardType: TextInputType.phone,
                        controller: phoneAuthController.phoneTEController,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                      ),
                    if (controller.showOTPField) ...[
                      Text('Enter 6-Digit OTP'),
                      PinFieldAutoFill(
                        currentCode: controller.otp,
                        onCodeChanged: (code) {
                          controller.otp = code;
                          if (code.length == 6) {
                            controller.signInWithPhoneNumber();
                          }
                        },
                        onCodeSubmitted: (code) {
                          if (code.length == 6) {
                            controller.signInWithPhoneNumber();
                          }
                        },
                      ),
                    ],
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.green),
                      onPressed: () {
                        if (phoneAuthController.showOTPField) {
                          if (phoneAuthController.otp.length == 6)
                            controller.signInWithPhoneNumber();
                          else
                            showError(
                                title: 'Invalid OTP',
                                message:
                                    'Please Enter 6-digit OTP sent to you');
                        } else {
                          if (phoneAuthController
                                  .phoneTEController.text.length ==
                              10)
                            phoneAuthController.sendOTP();
                          else
                            showError(
                                title: 'Invalid number',
                                message: 'Please Enter 10-digit Mobile number');
                        }
                      },
                      child: Text(
                          '${controller.showOTPField ? 'Verify' : 'Get'} OTP'),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
