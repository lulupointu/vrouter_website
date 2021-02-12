import 'package:flutter/material.dart';
import 'package:vrouter_website/main.dart';


class ProgrammaticNavigationDescription extends StatelessWidget {
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
VRouterData.of(context).push('/home');

// Pushing is relative if we omit the '/'.
// For example if we are at '/login" and we
// do the following, the address will be /login/home
VRouterData.of(context).push('home');

// Pushing a named route
VRouterData.of(context).pushNamed('home');

// Pushing with query parameters (/home?user=123)
VRouterData.of(context).push('/home', queryParameters: {'user': '123'});

// Pushing with path parameter
// For example if /home/:user is the path
VRouterData.of(context).push('/home/username');
VRouterData.of(context).pushNamed('home', pathParameters: {'user' :'username'});

// Pushing an external route
// This can't be stopped
VRouterData.of(context).pushExternal('google.com');

// On the web, you can choose to open in a new window
VRouterData.of(context).pushExternal('google.com', openNewTab: true);
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
On the web, this is the same as push except for the fact that the current history entry will be overwritten by this entry. This means that the route you are leaving from won’t appear in the browser history (so neither when using back/forward buttons). 
This is very useful for redirecting.''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        MyDartCodeViewer(
          code: r'''
// Pushing a new url
VRouterData.of(context).pushReplacement('/home');

// PushReplacement is also relative if we omit the '/'.
// For example if we are at '/login" and we
// do the following, the address will be /login/home
VRouterData.of(context).pushReplacement('home');

// Pushing a named route
VRouterData.of(context).pushReplacementNamed('home');

// Pushing with query parameters (/home?user=123)
VRouterData.of(context).pushReplacement('/home', queryParameters: {'user': '123'});

// Pushing with path parameter
// For example if /home/:user is the path
VRouterData.of(context).pushReplacement('/home/username');
VRouterData.of(context).pushReplacementNamed('home', pathParameters: {'user' :'username'});
          ''',
        ),
        SizedBox(height: 10),
        SelectableText.rich(
          TextSpan(
            text: '''
Note that on mobile, this is exactly the same as push.
            ''',
            style: textStyle,
          ),
        ),
      ],
    );
  }
}


