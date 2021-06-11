import 'package:ecommerce/providers/auth_provider.dart';
import 'package:ecommerce/screens/products_overview_screen.dart';
import 'package:ecommerce/widgets/shared_function.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'login_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailValid = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  String _fullName, _email, _phoneNumber, _password;
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
        alignment: Alignment.center,
        children: [
          SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 30),
                    Image.asset(
                      'assets/images/logo.jpg',
                      height: screenHeight(context) / 5,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      color: Colors.white.withOpacity(.5),
                      child: TextFormField(
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                        keyboardType: TextInputType.name,
                        maxLines: 1,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue)),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white60)),
                          errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          hintText: "Full Name",
                          hintStyle: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: Colors.black),
                        ),
                        onChanged: (value) {
                          _fullName = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Full Name Cannot be Empty!';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 10),
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
                              borderSide: BorderSide(color: Colors.white60)),
                          errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          hintText: "Email",
                          hintStyle: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: Colors.black),
                        ),
                        onChanged: (value) {
                          _email = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Email Cannot be Empty!';
                          }
                          if (!_emailValid.hasMatch(value)) {
                            return 'Enter a valid email address.';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: Colors.white.withOpacity(.5),
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      margin: EdgeInsets.only(top: 20),
                      child: IntlPhoneField(
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                        initialCountryCode: 'GH',
                        countryCodeTextColor:
                            Theme.of(context).textTheme.bodyText1.color,
                        keyboardType: TextInputType.phone,
                        autoValidate: false,
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)),
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white60)),
                            errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            hintText: 'Phone Number',
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(color: Colors.black)),
                        showDropdownIcon: true,
                        onChanged: (value) {
                          _phoneNumber = value.completeNumber;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Phone Number Cannot be Empty!';
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
                        maxLines: 1,
                        obscureText: true,
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)),
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white60)),
                            errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            hintText: "Password",
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(color: Colors.black)),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Password Cannot be Empty!';
                          }
                          if (value.length <= 6) {
                            return 'Password must be more than 6 characters!';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          _password = value;
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
                        maxLines: 1,
                        obscureText: true,
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)),
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white60)),
                            errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            hintText: "Confirm Password",
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(color: Colors.black)),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Password Cannot be Empty!';
                          }
                          if (_password != value) {
                            return 'Passwords do not match!';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
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
                                  "Sign Up",
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
                              message: "Registering please wait",
                            );

                            try {
                              //sign-in the user
                              final _authProvider = Provider.of<AuthProvider>(
                                  context,
                                  listen: false);
                              await _authProvider.createUser(
                                  fullName: _fullName.trim(),
                                  email: _email.trim(),
                                  phoneNumber: _phoneNumber.trim(),
                                  password: _password.trim(),
                                  context: context);
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
                                    builder: (BuildContext context) =>  ProductsOverviewScreen(),
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
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Already have an Account?',
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
                                  builder: (BuildContext context) => const LoginScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'SIGN IN',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
