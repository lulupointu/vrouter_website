import 'package:flutter/material.dart';
import 'package:vrouter_website/main.dart';

class HistoryStateExampleDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      TextSpan(
        text: '''
Use the history state to store information relative to a path but not visible of the url.
On the web, this state will be linked to the current web entry and therefore restore on back button press.''',
        style: textStyle,
      ),
    );
  }
}
