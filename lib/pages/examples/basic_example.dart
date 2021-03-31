import 'package:flutter/material.dart';
import 'package:vrouter_website/main.dart';

class BasicExampleDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      TextSpan(
        text: '''
Basic mechanic of routes creation.
Use VRouteElement such a VWidget to map your path to your widgets.''',
        style: textStyle,
      ),
    );
  }
}
