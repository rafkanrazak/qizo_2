// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// class OTPVerificationPage extends StatefulWidget {
//   @override
//   _OTPVerificationPageState createState() => _OTPVerificationPageState();
// }

// class _OTPVerificationPageState extends State<OTPVerificationPage> {
//   TextEditingController otpController = TextEditingController();

//   void verifyOTP() {
  
//     // Replace this with your own logic to verify the OTP.
//     String otp = otpController.text;
//     if (otp == '123456') {
//       Fluttertoast.showToast(msg: 'OTP verified successfully!');
//     } else {
//       Fluttertoast.showToast(msg: 'Invalid OTP. Please try again.');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('OTP Verification'),
//       ),
//       body: Center(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 40),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               PinCodeTextField(
//                 appContext: context,
//                 length: 6,
//                 onChanged: (value) {},
//                 controller: otpController,
//                 pinTheme: PinTheme(
//                   shape: PinCodeFieldShape.box,
//                   borderRadius: BorderRadius.circular(5),
//                   fieldHeight: 50,
//                   fieldWidth: 40,
//                   activeFillColor: Colors.white,
//                 ),
//                 keyboardType: TextInputType.number,
//                 onCompleted: (value) {
//                   verifyOTP();
//                 },
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: verifyOTP,
//                 child: Text('Verify OTP'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OtpVerificationPage(),
    );
  }
}

class OtpVerificationPage extends StatefulWidget {
  @override
  _OtpVerificationPageState createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  String enteredOtp = "";

  void _onOtpSubmit(String otp) {
    setState(() {
      enteredOtp = otp;
    });

    // You can perform OTP verification here.
    // For demonstration purposes, we'll just print the entered OTP.
    print("Entered OTP: $otp");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP Verification"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PinCodeTextField(
                pinBoxHeight: 50,
                pinBoxWidth: 50,
                pinBoxRadius: 8,
                highlight: true,
                highlightColor: Colors.blue,
                defaultBorderColor: Colors.black,
                hasTextBorderColor: Colors.green,
                maxLength: 6,
                pinBoxDecoration:
                    ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                pinTextStyle: TextStyle(fontSize: 22),
                pinTextAnimatedSwitcherTransition:
                    ProvidedPinBoxTextAnimation.scalingTransition,
                pinTextAnimatedSwitcherDuration: Duration(milliseconds: 300),
                keyboardType: TextInputType.number,
                onDone: _onOtpSubmit,
                pinBoxColor: Colors.white,
              ),
              SizedBox(height: 20),
              Text(
                "Entered OTP: $enteredOtp",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
