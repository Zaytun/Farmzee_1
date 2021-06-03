import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/auth/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;

  void _submitAuthForm(String name,
      int number,
      String email,
      String password,
      bool isLogin,
      BuildContext ctx,) async {
    var authResult;
    try{
      if(isLogin){
        authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
      }else{
        authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      }
    } on PlatformException catch(err){
      var message = 'An error occurred. Please check your credentials';

      if(err.message != null){
        message = err.message;
      }
      Scaffold.of(ctx).showSnackBar(SnackBar(content: Text(message), backgroundColor: Theme.of(context).errorColor,),);
    } catch(err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body:AuthForm(_submitAuthForm),
    );
  }
}

class FirebaseAuth {
}
