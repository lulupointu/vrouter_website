import 'package:flutter/material.dart';
import 'package:vrouter_website/main.dart';

class ProgrammaticNavigationDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText.rich(
          TextSpan(
            text:
            'Navigating between your screens at a button press is easy, just use the path that you defined.',
            style: textStyle,
          ),
        ),
        SizedBox(height: 20),
        SelectableText.rich(
          TextSpan(
            text: '''
Navigating to a route can be achieved using the "to" method. 
This is the most basic way to navigate: just enter the url you want to navigate to and the navigation cycle will start.''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        MyDartCodeViewer(
          code: r'''
// Navigating to a new url
context.vRouter.to('/home');

// The path is relative if we omit the '/'.
// For example if we are at '/login' and we
// do the following, the new path will be /login/home
context.vRouter.to('home');

// DO use toSegments to encode your parameters
context.vRouter.toSegments(['book', 'some title']); // encodes the url to '/book/some%20title'

// Navigating with query parameters (/home?user=123)
context.vRouter.to('/home', queryParameters: {'user': '123'});

// Navigating with path parameter
// For example if /home/:username is the path
context.vRouter.to('/home/bob');
context.vRouter.toNamed('home', pathParameters: {'username': 'bob'});

// Navigating to an external route
// This can't be stopped
context.vRouter.toExternal('flutter.dev');

// On the web, you can choose to open in a new window
context.vRouter.toExternal('flutter.dev', openNewWindow: true);
          ''',
        ),
      ],
    );
  }
}
