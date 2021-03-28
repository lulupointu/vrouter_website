import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';
import 'package:vrouter_website/main.dart';

class TransitionDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return         SelectableText.rich(
      TextSpan(
        text: '''

Transitions in your app are important, and one of Flutter's strengths is that it makes them easy. VRouter complies with this spirit, using what Flutter does best and making it easy to use.

What did not change are hero animations. They work as they always have.

What we provide is a way to easily handle the transitions between each route. You can provide a default transition or per-route transition.''',
        style: textStyle,
      ),
    );
  }
}

class DefaultTransitionPageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText.rich(
          TextSpan(
            text: '''To provide a default transition between all of your routes, you have to specify it in the VRouter.''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        MyDartCodeViewer(
          code: r'''
VRouter(
  // This transition will be applied to every route
  buildTransition: (animation1, _, child) {
    return FadeTransition(opacity: animation1, child: child);
  },
  // You can specify a transition duration (default 300)
  transitionDuration: Duration(milliseconds: 500),

  routes: [...]
)
          ''',
        ),
      ],
    );
  }
}

class LocalRouteTransitionPageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText.rich(
          TextSpan(
            text: '''
If you want to set a transition for a precise route, you need to specify it in the last VRouteElement of this route.''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        MyDartCodeViewer(
          code: r'''
VRouter(
  // This transition will be applied to every route
  buildTransition: (animation1, _, child) =>
      FadeTransition(opacity: animation1, child: child),
  routes: [
    // The custom transition will be played when accessing '/'
    VWidget(
      path: '/',
      widget: ProfileScreen(),
      buildTransition: (animation1, _, child) =>
          ScaleTransition(scale: animation1, child: child),
    ),
    // No transition is specified, so the default one will play
    VWidget(path: '/settings', widget: SettingsScreen()),
  ],
)
          ''',
        ),
        SizedBox(height: 10),
        SelectableText.rich(
          TextSpan(
            text:
            '''Note that this transition will have the priority over one which is specified in VRouter.

You can also create your own Page and set your transitions there, you can then use it with VPage or VNesterPage, please see the ''',
            style: textStyle,
            children: [
              TextSpan(
                  text: 'Custom Page section',
                  style: linkStyle,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      context.vRouter.pushNamed('guide', pathParameters: {
                        'mainSection': 'Advanced',
                        'subSection': 'Custom Pages',
                      });
                    }),
              TextSpan(text: '.'),
            ],
          ),
        )
      ],
    );
  }
}


