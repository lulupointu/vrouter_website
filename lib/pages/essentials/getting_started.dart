import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';
import 'package:vrouter_website/main.dart';
import 'package:vrouter_website/routes/guide_routes.dart';

class GettingStartedDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      TextSpan(
        text:
            '''Starting with VRouter only takes a few lines, and you will soon see that it feels very natural.

Create a VRouter, provide routes with VRouteElements and you are all set!''',
        style: textStyle,
      ),
    );
  }
}

class VRouterPageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText.rich(
          TextSpan(
            text:
                '''VRouter is a widget which allows you to create your routing structure via the routes attribute. It should often be placed at the top of the tree and there should only be one in your app. Its `routes` attribute takes VRouteElements, which will be the building blocks of your routing system.''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        MyDartCodeViewer(
          code: r'''
VRouter(
  debugShowCheckedModeBanner: false, // Passing a MaterialApp argument
  // Here is the most important: your routes
  routes: [
    // Here you will place your VRouteElements
  ],
)
          ''',
        ),
        SizedBox(height: 10),
        SelectableText.rich(
          TextSpan(
            text: '''
Note that It also acts as a MaterialApp so you can pass it all the usual MaterialApp arguments.''',
            style: textStyle,
          ),
        ),
      ],
    );
  }
}

class VRouteElementPageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText.rich(
          TextSpan(
            text: '''
There are different VRouteElement classes based on your needs:
    • VWidget is the most basic: it allows you to map a path to a widget
    • VNester which is like VWidget, but also enable widget nesting
    • VGuard which allows you to react to navigation changes
    • …
  
Here is an example of how to create a simple app with 2 routes:''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        MyDartCodeViewer(
          code: r'''
VRouter(
  routes: [
    VWidget(path: '/', widget: ProfileScreen()),
    VWidget(path: '/settings', widget: SettingsWidget()),
  ],
)
          ''',
        ),
        SizedBox(height: 10),
        SelectableText.rich(
          TextSpan(
            text:
                '''In this example, going to ‘/ will show the profile widget while going to ‘/settings’ will show the settings widget.''',
            style: textStyle,
          ),
        ),
      ],
    );
  }
}

class VRouterMagicPageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText.rich(
          TextSpan(
            text: '''
The most interesting part of VRouter is everything it does automatically for you that you don’t have to worry about. 

In the example above:
    • There are transitions between the routes, which is adapted to each platform. You will be able to customize it later of course
    • On the web, the browser back/forward button and the url are handled as you would expect

For now however, the only way to navigate is by typing a new url. Not very practical, especially on mobile! In the next chapter, ''',
            style: textStyle,
            children: [
              TextSpan(
                text: 'Programmatic Navigation',
                style: linkStyle,
                recognizer: TapGestureRecognizer()
                  ..onTap = () => GuideRoute.toSectionFromTitle(
                        context,
                        mainSectionTitle: 'Essentials',
                        subSectionTitle: 'Programmatic Navigation',
                      ),
              ),
              TextSpan(
                text: ', we will see how to navigate with a button press.',
              ),
            ],
          ),
        )
      ],
    );
  }
}
