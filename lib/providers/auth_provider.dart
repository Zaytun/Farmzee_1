import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider with ChangeNotifier {
  Future createUser(
      {String fullName, String phoneNumber,String email,String password, BuildContext context}) async {
    final _auth = FirebaseAuth.instance;
    final _userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if(_userCredential.user.uid != null){
      await FirebaseFirestore.instance.collection('users').doc(_userCredential.user.uid).set({
        "id": _userCredential.user.uid,
        "fullName": fullName,
        "phoneNumber": phoneNumber,
        "email": email,
      });


    }


  }



  Future<void> loginUser({
    @required String email,
    @required String password,
  }) async {
    final _auth = FirebaseAuth.instance;

    final _userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (_userCredential?.user?.uid != null) {

      /// redirect user to main page.
    }
  }

  Future<bool> logout() async {
    try {
      final _auth = FirebaseAuth.instance;
      await _auth.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }

   Future<void> sendPasswordReset({String email}) async {
    final _auth = FirebaseAuth.instance;
    await _auth.sendPasswordResetEmail(email: email);
  }





}
