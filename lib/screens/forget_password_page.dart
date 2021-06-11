import 'package:ecommerce/providers/auth_provider.dart';
import 'package:ecommerce/screens/auth_screen.dart';
import 'package:ecommerce/screens/login_screen.dart';
import 'package:ecommerce/widgets/shared_function.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  bool _isLoading = false;
  String _email;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: Image.asset(
                'assets/images/logo.jpg',
                height: screenHeight(context) / 5,
              ),
            ),
            Text(
              'PASSWORD RESET',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.green),
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
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
                      borderSide: BorderSide(color: Colors.green)),
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white60)),
                  errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)),
                  hintText: 'Email',
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.grey)),
              onChanged: (value) {
                _email = value;
              },
              validator: (value) {
                if (value.isEmpty) {
                  return 'Email Field cannot be Empty';
                }
                return null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: MaterialButton(
                color: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    setState(() {
                      _isLoading = true;
                    });
                    showProgressDialog(
                      context: context,
                      message: "Sending link, please wait",
                    );

                    try {
                      final _authProvider =
                      Provider.of<AuthProvider>(context,
                          listen: false);

                      await _authProvider.sendPasswordReset(email: _email);
                      //show success alert message
                      Navigator.pop(context);
                      alertNotification(
                        context: context,
                        message: 'Password reset link sent!',
                      );
                      actionAlertWidget(alertType: 'success', context: context);
                      Future.delayed(Duration(seconds: 3), () {
                        Navigator.pushReplacement<void, void>(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>  AuthScreen(),
                          ),
                        );
                      });
                    } catch (e) {
                      Navigator.pop(context);
                      alertNotification(
                          context: context,
                          message: 'Could not send Password reset link!');
                      actionAlertWidget(alertType: 'error', context: context);
                    }
                    setState(() {
                      _isLoading = false;
                    });
                  }
                },
                child: Center(
                  child: _isLoading
                      ? CupertinoActivityIndicator()
                      : Text('Send',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(color: Colors.white)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void setState(fn) {
    if (!mounted) {
      return;
    }
    super.setState(fn);
  }
}
