import 'package:flutter/material.dart';
import 'package:vrouter_website/main.dart';

class RedirectionExampleDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      TextSpan(
        text: '''
In this example, VGuard protects the /home route from unauthenticated users by redirecting them to the /login route and VRouteRedirector redirects any routes not matching /login or /home to the /home route.''',
        style: textStyle,
      ),
    );
  }
}
