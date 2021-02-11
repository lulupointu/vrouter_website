import 'package:complete_app/vrouter/main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vrouter_website/main.dart';


class WhatIsVRouterDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SelectableText.rich(
          TextSpan(
            text: 'As its name suggests, VRouter is heavily inspired by ',
            style: textStyle,
            children: [
              TextSpan(
                  text: 'Vue router',
                  style: linkStyle,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      VRouterData.of(context).pushExternal('https://router.vuejs.org', openNewWindow: true);
                    }),
              TextSpan(
                text:
                    '. If you know how this works, or look at their tutorial, you will see that many principles apply.\n'
                    'However, this package is written for Flutter and therefore takes the best of both worlds to '
                    'provide you an easy Fluttery way of handling routing in your app.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class FeaturesPageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      TextSpan(
        text: 'Here are some of the things that will be made easy be this package:\n',
        style: textStyle,
        children: [
          TextSpan(
            text: '   • Named route\n'
                '   • Nesting route\n'
                '   • Dynamic route matching\n'
                '   • Default or customizable handling of back buttons (in AppBar or in android phones for example)\n'
                '   • React to route changes\n'
                '   • Create route transitions: global or local\n'
                '   • And much more...',
          ),
        ],
      ),
    );
  }
}
