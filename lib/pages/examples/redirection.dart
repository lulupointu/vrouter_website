import 'package:flutter/material.dart';
import 'package:vrouter_website/main.dart';

class RedirectionExampleDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      TextSpan(
        text: '''
You can use VRouter advances navigation control to protect some routes or use a dedicate VRouteElement (VRouteRedirector) to redirect from specific routes.''',
        style: textStyle,
      ),
    );
  }
}
