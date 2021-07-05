import 'package:flutter/material.dart';
import 'package:vrouter_website/main.dart';

class HistoryExampleDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      TextSpan(
        text: '''
Url history is what all browser use. VRouter allows you to go to back and forward in this list of visited url.''',
        style: textStyle,
      ),
    );
  }
}
