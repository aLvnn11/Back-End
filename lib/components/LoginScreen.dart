import 'package:basic/components/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:basic/components/Firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AuthFirebase auth;

  @override
  void initState() {
    super.initState();
    auth = AuthFirebase();
    auth.getUser().then((value) {
      if (value != null) {
        MaterialPageRoute route;
        route = MaterialPageRoute(builder: (context) => MyHome(wid: value.uid));
        Navigator.pushReplacement(context, route);
      }
    }).catchError((err) => print(err));
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      onLogin: _loginUser,
      onRecoverPassword: _recoveryPassword,
      onSignup: _onSignup,
      passwordValidator: (value) {
        if (value != null) {
          if (value.length < 6) {
            return "Password Must Be 6 Characters";
          }
        }
        return null; // Return null if password is valid.
      },
      loginProviders: <LoginProvider>[
        LoginProvider(
          icon: FontAwesomeIcons.google,
          label: 'Google',
          callback: _onLoginGoogle,
        )
      ],
      onSubmitAnimationCompleted: () {
        auth.getUser().then((value) {
          MaterialPageRoute route;
          if (value != null) {
            route =
                MaterialPageRoute(builder: (context) => MyHome(wid: value.uid));
          } else {
            route = MaterialPageRoute(builder: (context) => LoginScreen());
          }
          Navigator.pushReplacement(context, route);
        }).catchError((err) => print(err));
      },
    );
  }

  Future<String?> _loginUser(LoginData data) async {
    return auth.login(data.name, data.password).then((value) {
      if (value != null) {
        return value;
      } else {
        final snackBar = SnackBar(
          content: const Text('Login Failed, User Not Found'),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {
              //Some code To undo Change
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return null;
      }
    });
  }

  Future<String?> _recoveryPassword(String name) {
    return Future.value(null);
  }

  Future<String?> _onSignup(SignupData data) async {
    return auth.signUp(data.name!, data.password!).then((value) {
      if (value != null) {
        final snackBar = SnackBar(
          content: const Text('Sign Up Successful'),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {
              //Some code to Undo the change
            },
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return value;
      } else {
        return null;
      }
    });
  }

  Future<String?> _onLoginGoogle() {
    return Future.value(null);
  }
}
