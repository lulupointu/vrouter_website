import 'package:flutter/material.dart';
import 'package:vrouter_website/main.dart';

class StackedRoutesDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      TextSpan(
        text: '''
Create a screen on top of another.
Use VRouteElement.stackedRoutes to nest VRouteElement. If you nested VRouteElement containing widgets, the two widgets will be stacked on top of each other.''',
        style: textStyle,
      ),
    );
  }
}
