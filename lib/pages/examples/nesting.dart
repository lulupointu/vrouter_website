import 'package:flutter/material.dart';
import 'package:vrouter_website/main.dart';

class NestingExampleDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      TextSpan(
        text: '''
Nesting your widget is at the heart of Flutter. Therefore it has been a priority in VRouter and we've made a VRouteElement dedicated to that: VNester''',
        style: textStyle,
      ),
    );
  }
}
