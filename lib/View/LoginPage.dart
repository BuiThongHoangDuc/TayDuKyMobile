import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobiletayduky/Helper/Validate.dart';
import 'package:mobiletayduky/ViewModel/LoginViewModel.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginPage extends StatelessWidget {
  final LoginViewModel loginVM;

  LoginPage(this.loginVM);

  Widget _buildEmailEdt() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Time New Roman",
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Color(0xFF90CAF9),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                )
              ]),
//          height: 60,
          child: TextField(
            onChanged: (text) {
              loginVM.changeEmail(text);
            },
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              errorText: loginVM.email.error,
              border: InputBorder.none,
              counterText: "",
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
              prefixIcon: Icon(Icons.email, color: Colors.white),
              hintText: 'Enter your Email',
              hintStyle: TextStyle(
                  color: Colors.white70, fontFamily: "Time New Roman"),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildPasswordEdt() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Time New Roman",
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Color(0xFF90CAF9),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                )
              ]),
//          height: 60,
          child: TextField(
            onChanged: (text) {
              loginVM.changePassword(text);
            },
            obscureText: true,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              errorText: loginVM.pass.error,
              border: InputBorder.none,
//              counterText: "",
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
              prefixIcon: Icon(Icons.lock, color: Colors.white),
              hintText: 'Enter your Password',
              hintStyle: TextStyle(
                  color: Colors.white70, fontFamily: "Time New Roman"),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5,
        onPressed: () => {loginVM.login()},
        padding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        color: Colors.lightBlue[50],
        child: Text(
          'LOGIN',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Time New Roman',
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpBtn() {
    return GestureDetector(
      onTap: () => print('Sign Up Press'),
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
            text: 'Don\'t have an Account? ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          TextSpan(
              text: 'SIGN UP',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<LoginViewModel>(
      model: loginVM,
      child: Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: <Widget>[
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Theme.of(context).primaryColor,
                          Theme.of(context).primaryColorLight
                        ]),
                  ),
                ),
                ScopedModelDescendant<LoginViewModel>(
                    builder: (context, child, model) {
                  return Container(
                    height: double.infinity,
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 120,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Sign In',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Time New Roman",
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 30),
                          _buildEmailEdt(),
                          SizedBox(height: 30),
                          _buildPasswordEdt(),
                          SizedBox(height: 30),
                          _buildLoginBtn(),
                          _buildSignUpBtn(),
                        ],
                      ),
                    ),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
