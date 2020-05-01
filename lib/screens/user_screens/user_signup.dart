import 'package:essentials/services/auth.dart';
import 'package:essentials/services/database.dart';
import 'package:essentials/shared/loading.dart';
import 'package:flutter/material.dart';

class UserSignUp extends StatefulWidget {
  final Function toogleView;

  UserSignUp({this.toogleView});

  @override
  _UserSignUpState createState() => _UserSignUpState();
}

class _UserSignUpState extends State<UserSignUp> {
  DatabaseServices _databaseServices = DatabaseServices();

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String name = '';
  String email = '';
  String password = '';
  String initpassword = '';
  String errorText = '';
  bool loading = false;

  bool isHidden = true;

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
                            "User Sign Up",
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
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            validator: (value) =>
                                value.isEmpty ? 'Enter a Name' : null,
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
                                ? 'Enter alleast 6 char'
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
                                initpassword = value;
                              });
                            },
                          ),
                          TextFormField(
                            validator: (value) => value != initpassword
                                ? 'Password doesn\'t match'
                                : null,
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
                          SizedBox(
                            height: 25,
                          ),
                          MaterialButton(
                            color: Colors.blueAccent,
                            minWidth: screenWidth,
                            height: 45,
                            textColor: Colors.white,
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                var result = await _auth.registerEmailPass(
                                    email, password);
                                if (result == null) {
                                  setState(() {
                                    errorText = 'Email already in use';
                                    loading = false;
                                  });
                                  print('Email already in use');
                                } else {
                                  print('Registered successfully');
                                  _databaseServices.updateUserData(
                                    email: email,
                                    name: name,
                                    uid: result.uid,
                                    locationLat: 0,
                                    locationLng: 0,
                                  );
                                  print('data saved');
                                  Navigator.pop(context);
                                }
                              }
                            },
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
