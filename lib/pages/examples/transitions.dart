import 'package:flutter/material.dart';
import 'package:vrouter_website/main.dart';

class TransitionsExampleDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      TextSpan(
        text: '''
Transitions between routes are a great tool provided by Flutter. VRouter make them easy to implement yet still extremely flexible.''',
        style: textStyle,
      ),
    );
  }
}
