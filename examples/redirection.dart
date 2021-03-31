import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return VRouter(
      debugShowCheckedModeBanner: false,
      routes: [
        VWidget(path: '/login', widget: LoginScreen(login)),

        // VGuard protects the routes in stackedRoutes
        VGuard(
          beforeEnter: (vRedirector) async => isLoggedIn ? null : vRedirector.push('/login'),
          stackedRoutes: [VWidget(path: '/home', widget: HomeScreen(logout))],
        ),

        // :_ is a path parameters named _
        // .+ is a regexp to match any path
        VRouteRedirector(path: ':_(.+)', redirectTo: '/home')
      ],
    );
  }

  void login(BuildContext context) {
    isLoggedIn = true;
    context.vRouter.push('/home');
  }

  void logout(BuildContext context) {
    isLoggedIn = false;
    context.vRouter.push('/login');
  }
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
