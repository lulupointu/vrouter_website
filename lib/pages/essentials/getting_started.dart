import 'package:flutter/material.dart';
import 'package:vrouter_website/main.dart';



class GettingStartedDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      TextSpan(
        text:
            'Starting with VRouter only takes a few lines, and you will soon see that it feels very natural.\n\n'
            'Create a VRouter, provide your routes via VRouteElements and you are all set!',
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
            text: '''
VRouter is a widget which allows you to create your routing structure via the `routes` attribute. It should often be placed at the top of the tree and there should only be one in your app. Its `routes` attribute takes VRouteElements, which will be the building blocks of your routing system.

Note that It also acts as a MaterialApp so you can pass it all the usual MaterialApp arguments.''',
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
There are different VRouteElement classes based on your needs. The most basic is VStacked.
VStacked takes a widget and stacks it on top of another VRouteElement’s widget. This idea of stack is important for nested routes, which we will see later.

For now, we can already create a simple app with 2 routes:''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        MyDartCodeViewer(
          code: r'''
VRouter(
  routes: [
    // The path '/' goes to ProfileWidget
    VStacked(path: '/', widget: ProfileWidget()),
    // The path '/settings' goes to SettingsWidget
    VStacked(path: '/settings', widget: SettingsWidget()),
  ],
)
          ''',
        ),
        SizedBox(
          height: 20
        ),
        SelectableText.rich(
          TextSpan(
            text: '''
On any platform, there is already a transition between the routes. You will be able to customize it later of course. 
On the web, this handles the navigator back/forward button, and handles a url typed directly in the browser search bar.

For now, the only way to navigate is by typing a new url. Not very practical, especially on mobile! In the next chapter, Programmatic Navigation, we should see how to navigate with a button press.
            ''',
            style: textStyle,
          ),
        )
      ],
    );
  }
}


