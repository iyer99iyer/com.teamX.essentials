import 'package:flutter/material.dart';

class UserLogin extends StatefulWidget {

  final Function toogleView;

  UserLogin({this.toogleView});

  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  String email = '';
  String password = '';

  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: screenHeight * .06,
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      size: 40,
                    ),
                    onPressed: () {
                      print('back');
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    height: screenHeight * .08,
                  ),
                  Container(
                    child: Text(
                      "User Login",
                      style: TextStyle(fontSize: 32),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * .04,
            ),
            Container(
              height: screenHeight * .65,
              padding: EdgeInsets.symmetric(horizontal: 24),
              color: Colors.white,
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(fontSize: 18),
                      ),
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      obscureText: isHidden,
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(fontSize: 18),
                          suffixIcon: IconButton(
                              icon: Icon(
                                isHidden
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  isHidden = !isHidden;
                                });
                              })),
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        print('Forgot Password!');
                      },
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    MaterialButton(
                      color: Colors.blueAccent,
                      minWidth: screenWidth,
                      height: 45,
                      textColor: Colors.white,
                      onPressed: () {},
                      child: Text('Login'),
                    ),
                    MaterialButton(
                      onPressed: () {},
                      minWidth: screenWidth,
                      height: 45,
                      child: Text(
                        'Login with OTP',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.grey,
                    ),
                    MaterialButton(
                      elevation: 0,
                      color: Colors.white,
                      minWidth: screenWidth,
                      height: 45,
                      textColor: Colors.black,
                      onPressed: () {
                        widget.toogleView();
                      },
                      child: Text('Sign Up'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
