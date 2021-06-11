import 'package:ecommerce/providers/auth_provider.dart';
import 'package:ecommerce/screens/auth_screen.dart';
import 'package:ecommerce/screens/forget_password_page.dart';
import 'package:ecommerce/screens/products_overview_screen.dart';
import 'package:ecommerce/widgets/shared_function.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isChecked = false;
  String _email, _password;
  bool _isLoading = false;

  void setIsLoadingTrue() {
    setState(() {
      _isLoading = true;
    });
  }

  void setIsLoadingFalse() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                          child: Image.asset(
                        'assets/images/logo.jpg',
                        height: screenHeight(context) / 5,
                      )),
                      SizedBox(height: 30),
                      Container(
                        color: Colors.white.withOpacity(.5),
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: TextFormField(
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: Colors.black),
                          keyboardType: TextInputType.emailAddress,
                          maxLines: 1,
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue)),
                              border: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white60)),
                              errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green)),
                              hintText: "Email",
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(color: Colors.black)),
                          onChanged: (value) {
                            _email = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Field cannot be Empty';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        color: Colors.white.withOpacity(.5),
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        margin: EdgeInsets.only(top: 30),
                        child: TextFormField(
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: Colors.black),
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          obscureText: true,
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue)),
                              border: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white60)),
                              errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green)),
                              hintText: "Password",
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(color: Colors.black)),
                          onChanged: (value) {
                            _password = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Password field cannot be Empty';
                            }
                            return null;
                          },
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Checkbox(
                              activeColor: Colors.green,
                              value: _isChecked,
                              onChanged: (x) {
                                setState(() {
                                  _isChecked = x;
                                });
                              }),
                          Text(
                            'Keep me signed in',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(color: Colors.black),
                          )
                        ],
                      ),
                      // Align(
                      //   alignment: Alignment.centerRight,
                      //   child: GestureDetector(
                      //     onTap: () {
                      //       Navigator.pushReplacement<void, void>(
                      //         context,
                      //         MaterialPageRoute<void>(
                      //           builder: (BuildContext context) =>
                      //               ForgotPasswordPage(),
                      //         ),
                      //       );
                      //     },
                      //     child: Text(
                      //       'Forgot Password?',
                      //       style: Theme.of(context)
                      //           .textTheme
                      //           .bodyText2
                      //           .copyWith(color: Colors.green),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(height: 25),
                      Container(
                        width: 300,
                        child: Column(children: [
                          SizedBox(height: 30),
                          Container(
                            width: 150,
                            child: MaterialButton(
                              elevation: 4,
                              color: Colors.green,
                              focusColor: Colors.greenAccent,
                              textColor: Colors.white,
                              splashColor: Colors.yellow[600],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: _isLoading
                                    ? CupertinoActivityIndicator()
                                    : Text(
                                        "Sign in",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  setIsLoadingTrue();

                                  showProgressDialog(
                                    context: context,
                                    message: "Authenticating please wait",
                                  );
                                  try {
                                    //sign-in the user
                                    final _authProvider =
                                        Provider.of<AuthProvider>(context,
                                            listen: false);
                                    await _authProvider.loginUser(
                                      email: _email.trim(),
                                      password: _password.trim(),
                                    );
                                    //show success alert message
                                    Navigator.pop(context);
                                    actionAlertWidget(
                                      alertType: 'success',
                                      context: context,
                                    );
                                    //send to dashboard page
                                    Future.delayed(Duration(seconds: 3), () {
                                      Navigator.pushReplacement<void, void>(
                                        context,
                                        MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              ProductsOverviewScreen(),
                                        ),
                                      );
                                    });
                                  } catch (e) {
                                    Navigator.pop(context);
                                    alertNotification(
                                      context: context,
                                      message: e.toString(),
                                    );
                                    actionAlertWidget(
                                      alertType: 'error',
                                      context: context,
                                    );
                                  }
                                  setIsLoadingFalse();
                                }
                              },
                            ),
                          ),
                        ]),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Do not have an Account yet?',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.black,
                                  )),
                              SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement<void, void>(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          const AuthScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'SIGN UP',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline),
                                ),
                              )
                            ]),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
