import 'package:essentials/services/auth.dart';
import 'package:essentials/services/database.dart';
import 'package:essentials/shared/loading.dart';
import 'package:flutter/material.dart';

class UserLogin extends StatefulWidget {
  final Function toogleView;

  UserLogin({this.toogleView});

  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  DatabaseServices _databaseServices = DatabaseServices();

  bool loading = false;

  String email = '';
  String password = '';
  String errorText = '';

  bool isHidden = true;

  // giving _auth intance of class in service/auth.dart
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: loading
          ? Loading()
          : SingleChildScrollView(
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
                      key: _formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            validator: (value) =>
                                value.isEmpty ? 'Enter a Email' : null,
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
                            validator: (value) => value.length < 6
                                ? 'Please check your password'
                                : null,
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
                            onPressed: () async {
                              if (_formkey.currentState.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                var autherisationResult =
                                    await _databaseServices
                                        .getUserAutherisation(email);
                                if (autherisationResult) {
                                  var result = await _auth.signInEmailPass(
                                      email, password);
                                  if (result == null) {
                                    setState(() {
                                      errorText =
                                          'error signing in Email Id or password is wrong';
                                      loading = false;
                                    });
                                    print(
                                        'error signing in Email Id or password is wrong');
                                  } else {
                                    print('Signed successfully');
                                    // DatabaseServices _store = DatabaseServices(user: result.uid);
                                    Navigator.pop(context);
                                  }
                                } else {
                                  setState(() {
                                    errorText =
                                        'error signing in Email not found in user try vendor login';
                                    loading = false;
                                  });
                                }
                              }
                            },
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
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Text(
                              errorText,
                              style: TextStyle(color: Colors.red),
                            ),
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
