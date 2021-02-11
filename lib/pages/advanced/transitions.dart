import 'package:flutter/material.dart';
import 'package:vrouter_website/main.dart';

class TransitionDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return         SelectableText.rich(
      TextSpan(
        text: '''
Transitions in your app are important, and one of Flutter straight is that it makes them easy. VRouter complies with this spirit, using what Flutter does best and making it easy to use.

What did not change is hero animations. They work as they always have with no issues.

What we provide is a way to easily handle the transitions between each route.  You can provide a default transition or per-route transition.''',
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
            text: '''
To provide a default transition between all of your routes, you have to specify it in the VRouter.''',
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
);
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
    VStacked(
        path: '/',
        widget: ProfileWidget(),
      buildTransition: (animation1, _, child) =>
          ScaleTransition(scale: animation1, child: child),
    ),
    // No transition is specified, so the default one will play
    VStacked(path: '/settings', widget: SettingsWidget()),
  ],
);
          ''',
        ),
        SizedBox(height: 10),
        SelectableText.rich(
          TextSpan(
            text: '''
Note that this transition will have the priority over one which is specified in VRouter.''',
            style: textStyle,
          ),
        ),
      ],
    );
  }
}

class KeyWarningPageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return         SelectableText.rich(
      TextSpan(
        text: '''
When animating between two routes (say A and B), they are both on the screen at the same time. If the user navigates back to A quickly, then two instances of A will be displayed at the same time. Since they will both use the same global key, this will break your app.

Hopefully this should never happen if your animations are short enough but this is something to keep in mind. 

A possible mitigation if necessary would be -apart for not having too slow animations- to disable any button which would navigate before the animation ends. 

In any case, the most probable case would be if a user is on the web and presses the back button right after entering. In which case a broken application would be a blank screen and the user will reload the page which will solve the issue.''',
        style: textStyle,
      ),
    );
  }
}


