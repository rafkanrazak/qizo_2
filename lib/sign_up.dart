import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:qizo_2/home.dart';
import 'package:qizo_2/verification_pg.dart';


import 'auth_service.dart';
import 'components/square_tile.dart';

class otplogin extends StatefulWidget {
  const otplogin({super.key});

  @override
  State<otplogin> createState() => _otploginState();
}

class _otploginState extends State<otplogin> {
  getotp() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91 9747 670 448',
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {},
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  final TextEditingController phoneController = TextEditingController();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  void _handleGoogleSignInAndNavigate() async {
    // Sign in with Google
    bool isSignedIn = await AuthService().signInWithGoogle();

    // Check if the sign-in process is successful
    if (isSignedIn) {
      // Navigate to the next page (VerificationcodeWidget) only if the user is signed in
      Navigator.push(
        context as BuildContext,
        MaterialPageRoute(builder: (context) => home_pg()),
      );
    } else {
      // Handle the case when Google sign-in fails
      // For example, you can show a snackbar or display an error message.
      print("Google Sign-In Failed");
    }
  }

  Future<void> signOutGoogle() async {
    try {
      await _googleSignIn.signOut();
    } catch (e) {
      // Handle any sign-out errors here
      print("Error signing out: $e");
    }
  }

  Country SelectedCountry = Country(
    phoneCode: '91',
    countryCode: 'IN',
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: 'India',
    example: 'India',
    displayName: 'India (+91)',
    displayNameNoCountryCode: 'IN',
    e164Key: "",
  );
  @override
  Widget build(BuildContext context) {
    phoneController.selection = TextSelection.fromPosition(
        TextPosition(offset: phoneController.text.length));
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 60),
                child: Image.asset("assets/images/qi.jpg", height: 200),
              ),
              SizedBox(
                height: 22,
              ),

              //phone otp

              TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    phoneController.text = value;
                  });
                },
                controller: phoneController,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellow.shade800),
                  ),
                  // fillColor: Colors.yellow.shade100,
                  // filled: true,
                  labelText: 'Phone Number',
                  labelStyle: TextStyle(color: Colors.black, fontSize: 18),
                  //hintText: "Phone number",
                  hintStyle: TextStyle(
                    color: Colors.grey[500],
                  ),
                  prefixIcon: Container(
                    height: 70,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: InkWell(
                        onTap: () {
                          showCountryPicker(
                              context: context,
                              countryListTheme: CountryListThemeData(
                                bottomSheetHeight: 450,
                              ),
                              onSelect: (value) {
                                setState(() {
                                  SelectedCountry = value;
                                });
                              });
                        },
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            "${SelectedCountry.flagEmoji} + ${SelectedCountry.phoneCode}",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  suffixIcon: phoneController.text.length > 9
                      ? Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.green),
                          child:
                              Icon(Icons.done, color: Colors.white, size: 20),
                        )
                      : null,
                ),
              ),

              SizedBox(
                height: 32,
              ),

              GestureDetector(
                onTap: () {
                  getotp();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OtpVerificationPage()));
                },
                child: Container(
                  height: 65,
                  width: double.maxFinite,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      "Get OTP",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // google button
                  GestureDetector(
                    onTap: () {
                      _handleGoogleSignInAndNavigate();
                      AuthService().signInWithGoogle();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  home_pg()),
                      );
                    },
                    child: SquareTile(imagePath: 'assets/images/google.png'),
                  ),
                ],
              ),

              // const SizedBox(height: 50),

              // not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Register now',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
