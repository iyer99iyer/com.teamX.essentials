import 'package:flutter/material.dart';

class ShopkeeperSignUp extends StatefulWidget {
  final Function toogleView;

  ShopkeeperSignUp({this.toogleView});

  @override
  _ShopkeeperSignUpState createState() => _ShopkeeperSignUpState();
}

class _ShopkeeperSignUpState extends State<ShopkeeperSignUp> {
  String name = '';
  String sKey = '';
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
                      "Vendor Sign Up",
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
                        labelText: 'Name',
                        labelStyle: TextStyle(fontSize: 18),
                      ),
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                    ),
                    TextFormField(
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        labelText: 'Secret Key',
                        labelStyle: TextStyle(fontSize: 18),
                      ),
                      onChanged: (value) {
                        setState(() {
                          sKey = value;
                        });
                      },
                    ),
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
                    TextFormField(
                      obscureText: isHidden,
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                          labelText: 'Confirm Password',
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
                      child: Text('Signup'),
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
                      child: Text('Login'),
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
