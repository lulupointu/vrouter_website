import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';
import 'package:vrouter_website/main.dart';

class RedirectionDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText.rich(
          TextSpan(
            text: '''
Redirection often happens when the user lands on a page and you want him to go to a new one seemingly.
To achieve such an effect, using the beforeLeave or beforeEnter (either in VRouter, VRouteElement or VNavigationGuard) can be very effective. 
All you need to do is to use vRedirector, which is a parameter of this methods, to redirect the user.''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        MyDartCodeViewer(
          code: r'''
beforeLeave: (vRedirector, ____) async {
  // shouldRedirect is your variable
  if (shouldRedirect)
    // You must use vRedirector to redirect
    vRedirector.pushReplacement('newUrl');
},
          ''',
        ),
        SizedBox(height: 10),
        SelectableText.rich(
          TextSpan(
            text: '''
Note that vRedirector also holds information about the previous and the next route
            
Also note that you should always consider the ''',
            style: textStyle,
            children: [
              TextSpan(
                  text: 'navigation cycle',
                  style: linkStyle,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      VRouterData.of(context).push('/guide/Advanced/Navigation Control/The Navigation Cycle');
                    }),
              TextSpan(
                text:
                ' to know the order in which the functions are called.',
              ),
            ],
          ),
        )
      ],
    );
  }
}

class VRouteRedirectorPageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText.rich(
          TextSpan(
            text: '''
More often than not, you need a route which only redirects. You might want such a route at the bottom of your route to match any mistyped url and redirect to /unknown. The VRouteElement VRouteRedirector is here to make this easy:''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        MyDartCodeViewer(
          code: r'''
VRouter(
 routes: [
   VStacked(path: '/', widget: Login()),
   VStacked(path: '/unknown', widget: UnknownPathWidget()),
   VRouteRedirector(path: ':_(.*)', redirectTo: '/unknown'),
 ],
),
          ''',
        ),
        SizedBox(height: 10),
        SelectableText.rich(
          TextSpan(
            text: '''
In VRouteRedirector, you can either use beforeLeave or redirectTo.''',
            style: textStyle,
          ),
        ),
      ],
    );
  }
}

