import 'package:flutter/material.dart';
import 'package:vrouter_website/main.dart';

class RedirectionDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      TextSpan(
        text: '''
Redirection is an important aspect of your routing system. There are two typical scenarios:
    • You might want to redirect to “/404” if the user types an unknown url: You can use VRouteRedirector
    • You might want to redirect based on a condition, for example if the user is not logged in: You can use VRedirector.''',
        style: textStyle,
      ),
    );
  }
}

class VRouteRedirectorPageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText.rich(
          TextSpan(
            text: '''VRouteRedirector is a VRouteElement that can be placed anywhere in your routes. You will often use it with the path “.+” at the end of your routes to catch an unknown route.''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        MyDartCodeViewer(
          code: r'''
VRouter(
  routes: [
    VWidget(path: '/login', widget: LoginScreen()),
    VWidget(path: '/404', widget: UnknowScreen()),
    VRouteRedirector(
      path: r':_(.+)', 
      redirectTo: '/404',
    ),
  ],
)
          ''',
        ),
      ],
    );
  }
}

class VRedirectorPageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText.rich(
          TextSpan(
            text: '''A VRedirector is given to you in VGuard.beforeLeave, VGuard.beforeEnter or VGuard.beforeUpdate. 

You can (and should) use VRedirector to redirect in those methods:''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        MyDartCodeViewer(
          code: r'''
VRouter(
  routes: [
    VWidget(path: '/login', widget: LoginScreen()),

    VGuard(
      // We use VRedirector.push to redirect to '/login' if the user is not authenticated
      beforeEnter: (vRedirector) async => isLoggedIn ? null : vRedirector.push('/login'),
      stackedRoutes: [
        VWidget(path: '/profile', widget: ProfileScreen()),
        VWidget(path: '/settings', widget: SettingsScreen()),
      ],
    ),
  ],
)
          ''',
        ),
      ],
    );
  }
}
