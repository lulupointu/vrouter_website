import 'package:flutter/material.dart';
import 'package:vrouter_website/main.dart';

class CustomPagesDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      TextSpan(
        text: '''By default, VRouter uses CupertinoPage on IOS and MaterialPage otherwise. However, if you want to create your own page, you can easily do so. The only rule is that you have to use pageBuilder child.''',
        style: textStyle,
      ),
    );
  }
}

class VPagePageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText.rich(
          TextSpan(
            text: '''VPage is the same as VWidget but allows you to provide a pageBuilder to build your own page.''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        Text('Router configuration:', style: textStyle.copyWith(fontWeight: FontWeight.bold),),
        MyDartCodeViewer(
          code: r'''
VRouter(
  routes: [
    VPage(
      path: '/login',
      pageBuilder: (key, child) => LoginPage(key, child),
      widget: LoginScren(),
    ),
  ],
)
          ''',
        ),
        SizedBox(height: 10),
        Text('Custom page:', style: textStyle.copyWith(fontWeight: FontWeight.bold),),
        MyDartCodeViewer(
          code: r'''
class LoginPage extends Page {
  @override
  final LocalKey key;

  final Widget child;

  LoginPage(this.key, this.child) : super(key: key);

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(builder: (_) => child);
  }
}
          ''',
        ),
      ],
    );
  }
}

class VNesterPagePageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText.rich(
          TextSpan(
            text: '''VNesterPage is the same as VNester but allows you to provide a pageBuilder to build your own page.''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        Text('Router configuration:', style: textStyle.copyWith(fontWeight: FontWeight.bold),),
        MyDartCodeViewer(
          code: r'''
VRouter(
  routes: [
    VNesterPage(
      path: null,
      pageBuilder: (key, child) => LoginPage(key, child),
      widgetBuilder: (child) => MyScaffold(body: child),
      nestedRoutes: [
        VWidget(path: '/home', widget: HomeScreen()),
        VWidget(path: '/settings', widget: SettingsScreen()),
      ]
    ),
  ],
)
          ''',
        ),
        SizedBox(height: 10),
        Text('Custom page:', style: textStyle.copyWith(fontWeight: FontWeight.bold),),
        MyDartCodeViewer(
          code: r'''
class LoginPage extends Page {
  @override
  final LocalKey key;

  final Widget child;

  LoginPage(this.key, this.child) : super(key: key);

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(builder: (_) => child);
  }
}
          ''',
        ),
        SizedBox(height: 10),
        Text('MyScaffold:', style: textStyle.copyWith(fontWeight: FontWeight.bold),),
        MyDartCodeViewer(
          code: r'''
class MyScaffold extends StatelessWidget {
  final Widget body;

  const MyScaffold({Key key, this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: body);
  }
}
          ''',
        ),
      ],
    );
  }
}
