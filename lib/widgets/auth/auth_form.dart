import 'package:flutter/material.dart';



class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn);

  final void Function(
      String name,
      int number,
      String email,
      String password,
      bool isLogin,
      BuildContext ctx,
      ) submitFn;
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userName = '';
  var _userNumber ;
  var _userEmail = '';
  var _userPassword = '';

  void _trySubmit(){
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if(isValid){
      _formKey.currentState.save();
      widget.submitFn(
          _userName.trim(),
          _userNumber.trim(),
          _userEmail.trim(),
          _userPassword.trim(),
           _isLogin,
          context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if(!_isLogin)
                     TextFormField(
                       key: ValueKey('name'),
                     validator: (value){
                      if(value.isEmpty){
                        return 'Please enter your name';
                      }return null;
                    } ,
                    decoration: InputDecoration(
                      labelText: 'Name: '
                    ) ,
                    onSaved: (value){
                      _userName = value;
                    },
                  ),
                  if(!_isLogin)
                      TextFormField(
                        key: ValueKey('number'),
                       validator: (value){
                      if(value.isEmpty || value.length < 10){
                        return'Please enter a valid phone number';
                      }return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Phone Number: '
                    ),
                    onSaved: (value){
                      _userNumber = value as int;
                    },
                  ),
                  TextFormField(
                    key: ValueKey('email'),
                    validator:(value){
                      if(value.isEmpty || !value.contains('@')){
                        return 'Please enter a valid email address.';
                      }
                      return null;
                    } ,
                    keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText:'Email Address: ',
                  ),
                    onSaved: (value){
                      _userEmail = value;
                    },
                  ),
                  TextFormField(
                    key: ValueKey('password'),
                    validator: (value){
                      if(value.isEmpty || value.length < 7){
                        return 'Password must be 7 characters long at least';
                      } return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Password: ',
                    ),
                    obscureText: true,
                    onSaved: (value){
                      _userPassword = value;
                    },
                  ),
                  SizedBox(height: 12,),
                  MaterialButton(child: Text(_isLogin? 'Login': 'Signup'),onPressed: _trySubmit,),
                  MaterialButton( child: Text(_isLogin?'Create New Account':'Already have an account'), onPressed: (){
                   setState(() {
                     _isLogin = !_isLogin;
                   });
                  },)

                ],
              ),
            ),),),),
    );
  }
}
