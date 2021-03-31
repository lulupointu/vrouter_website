import 'package:flutter/material.dart';
import 'package:vrouter_website/main.dart';

class Description extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      TextSpan(
        text: '''
Path parameters allow you to map a path pattern to a widget.
VRouter allows RegExp in path parameters for even more flexibility!''',
        style: textStyle,
      ),
    );
  }
}
