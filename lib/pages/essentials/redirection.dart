import 'package:flutter/material.dart';
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
To achieve such an effect, using the beforeLeave or beforeEnter (either on the router, on a VRouteElement or a VNavigationGuard) can be very effective. 
All you need to do is redirect using VRouterData for navigating, and return false to indicate that the current navigation change should be ignored.''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        MyDartCodeViewer(
          code: r'''
beforeLeave: (context, __, ___, ____) async {
 if (shouldRedirect) {
   VRouterData.of(context).pushReplacement('newUrl');
   // We must return false to stop the current url update
   return false;
 }
 return true;
},
          ''',
        ),
        SizedBox(height: 10),
        SelectableText.rich(
          TextSpan(
            text: '''
Note that you should always consider the navigation cycle to know the order in which the functions are called.''',
            style: textStyle,
          ),
        ),
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
   VRouteRedirector(path: '.*', redirectTo: '/unknown'),
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

