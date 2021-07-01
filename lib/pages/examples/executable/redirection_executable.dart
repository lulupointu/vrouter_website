import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

var isLoggedIn = false;

void login(BuildContext context) {
  isLoggedIn = true;
  context.vRouter.to('/examples/redirection/home');
}

void logout(BuildContext context) {
  isLoggedIn = false;
  context.vRouter.to('/examples/redirection/login');
}

abstract class BaseWidget extends StatelessWidget {
  String get title;

  String get buttonText;

  void Function(BuildContext context) get onButtonPress;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () => onButtonPress(context),
              child: Text(buttonText),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends BaseWidget {
  HomeScreen(this.logout);

  @override
  String get title => 'Home';

  @override
  String get buttonText => 'Logout';

  @override
  void Function(BuildContext context) get onButtonPress => logout;

  final void Function(BuildContext context) logout;
}

class LoginScreen extends BaseWidget {
  LoginScreen(this.login);

  @override
  String get title => 'Login';

  @override
  String get buttonText => 'Login and go to Home';

  @override
  void Function(BuildContext context) get onButtonPress => login;

  final void Function(BuildContext context) login;
}
