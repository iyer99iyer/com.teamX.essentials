import 'package:essentials/screens/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneNumber extends StatefulWidget {
  @override
  _PhoneNumberState createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
  final _codeController = TextEditingController();

  String phone = '';
  String otp = '';
  String name = '';
  String errorText = '';
  String otpErrorText = 'hey';

  Future<void> loginUser(String phoneNo, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
      phoneNumber: phoneNo,
      timeout: Duration(seconds: 120),
      verificationCompleted: (AuthCredential credential) async {
        Navigator.of(context).pop();
        AuthResult result = await _auth.signInWithCredential(credential);
        FirebaseUser user = result.user;
        if (user != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Welcome(),
            ),
          );
        } else {
          print('error');
        }
      },
      verificationFailed: (AuthException exception) {
        print(exception);
      },
      codeSent: (String verificationId, [int forceResendingToken]) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: Text('Give the code?'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      maxLength: 6,
                      keyboardType: TextInputType.number,
                      controller: _codeController,
                      onChanged: (val) {
                        otp = val;
                        print(otp.toString());
                      },
                    ),
                    Text(
                      otpErrorText,
                      style: TextStyle(color: Colors.red),
                    )
                  ],
                ),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      setState(() {
                        otpErrorText = '';
                      });
                      final sms = otp.trim();

                      AuthCredential credential =
                          PhoneAuthProvider.getCredential(
                        verificationId: verificationId,
                        smsCode: sms,
                      );

                      AuthResult result =
                          await _auth.signInWithCredential(credential);

                      FirebaseUser user = result.user;

                      if (user != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Welcome(),
                          ),
                        );
                      } else {
                        print('error');
                      }
                    },
                    color: Colors.blueAccent,
                    child: Text('Verify'),
                  )
                ],
              );
            });
      },
      codeAutoRetrievalTimeout: null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: EdgeInsets.only(left: 12),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  size: 40,
                ),
                onPressed: () {
                  print('back');
                  Navigator.pop(context);
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Container(
                child: Text(
                  "User SignUp",
                  style: TextStyle(fontSize: 32),
                ),
              ),
            ),
            Container(
              height: screenHeight * .4,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.phone_android,
                      size: 150,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Mobile Number',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Please Enter your mobile number to receive a verification code. Carrier rates may apply',
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: screenHeight * .5,
              child: Center(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: (screenWidth * .25), vertical: 8),
                      child: Column(
                        children: <Widget>[
                          TextField(
                            keyboardType: TextInputType.phone,
                            maxLength: 10,
                            onChanged: (value) {
                              phone = '+91' + value;
                              print(phone);
                            },
                            onSubmitted: (value) {
                              phone = '+91' + value;
                              print(phone);
                            },
                            decoration: InputDecoration(
                              labelText: 'phone number',
                              prefixText: '+91  ',
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        print(phone);

                        if (phone.length < 12) {
                          setState(() {
                            errorText = 'Phone number invalid';
                          });
                        } else {
                          setState(() {
                            errorText = '';
                          });
                          final phoneNo = phone.trim();
                          loginUser(phoneNo, context);
                        }
                      },
                      child: Container(
                        height: 45,
                        width: screenWidth * .3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blueAccent,
                        ),
                        child: Center(
                          child: Text(
                            'Continue',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      errorText,
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
