import 'package:flutter/material.dart';
import 'package:vrouter_website/main.dart';


class ProgrammaticNavigationDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      TextSpan(
        text:
        'Navigating between your screens at a button press is easy, just use the path that you defined.',
        style: textStyle,
      ),
    );
  }
}

class PushARoutePageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText.rich(
          TextSpan(
            text: '''
Pushing a route can be achieved using the push method. 
This is the most basic way to navigate: just enter the url you want to navigate to and the navigation cycle will start.''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        MyDartCodeViewer(
          code: r'''
// Pushing a new url
context.vRouter.push('/home');

// push is relative if we omit the '/'.
// For example if we are at '/login' and we
// do the following, the new path will be /login/home
context.vRouter.pushReplacement('home');

// Pushing with query parameters (/home?user=123)
context.vRouter.push('/home', queryParameters: {'user': '123'});

// Pushing with path parameter
// For example if /home/:user is the path
context.vRouter.push('/home/username');
context.vRouter.pushNamed('home', pathParameters: {'user' :'username'});

// Pushing an external route
// This can't be stopped
context.vRouter.pushExternal('flutter.dev');

// On the web, you can choose to open in a new window
context.vRouter.pushExternal('flutter.dev', openNewWindow: true);
          ''',
        ),
      ],
    );
  }
}

class ReplaceARoutePageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText.rich(
          TextSpan(
            text: '''
On the web pushReplacement will cause the current history entry will be overwritten. This means that the route you are leaving from won’t appear in the browser history.
This is very useful for redirecting for example.''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        MyDartCodeViewer(
          code: r'''
// Pushing a new url
context.vRouter.pushReplacement('/home');

// pushReplacement is also relative if we omit the '/'.
// For example if we are at '/login' and we
// do the following, the new path will be /login/home
context.vRouter.pushReplacement('home');

// Pushing a named route
context.vRouter.pushReplacementNamed('home');

// Pushing with query parameters (/home?user=123)
context.vRouter.pushReplacement('/home', queryParameters: {'user': '123'});

// Pushing with path parameter
// For example if /home/:user is the path
context.vRouter.pushReplacement('/home/username');
context.vRouter.pushReplacementNamed('home', pathParameters: {'user' :'username'});
          ''',
        ),
        SizedBox(height: 20),
        SelectableText.rich(
          TextSpan(
            text: '''
Note that on mobile, this is exactly the same as push.''',
            style: textStyle,
          ),
        ),
      ],
    );
  }
}


