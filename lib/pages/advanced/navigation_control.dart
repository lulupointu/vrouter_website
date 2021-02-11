import 'package:complete_app/vrouter/main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vrouter_website/main.dart';

class NavigationControlDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      TextSpan(
        text: '''
The idea of the navigation cycle is to give you as much control as possible over what happens when a route changes. To achieve such control, four functions can be used in various places: beforeLeave, beforeEnter, afterEnter, afterUpdate.
These function have different scope depending on where they are specified: 
    • Global if specified if the VRouter (i.e. they will always be called)
    • Route specific if specified in a VRouteElement (For each route, if the last VRouteElement of the list specifies beforeLeave, beforeEnter or afterEnter, then these functions will be called when appropriate)
    • Element specific by using VNavigationGuard

Be careful, specifying beforeLeave, beforeEnter or afterEnter in a VRouteElement participate in a route specific scope, not a Element specific scope. This is because element specific scope is easier to handle in a widget directly, i.e. using a VNavigationGuard.''',
        style: textStyle,
      ),
    );
  }
}

class VNavigationGuardPageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText.rich(
          TextSpan(
            text: '''
VNavigationGuard is a widget that can be used like any other. It is useful to handle navigation (with beforeLeave, afterEnter and afterUpdate) locally.''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        MyDartCodeViewer(
          code: r'''
VNavigationGuard(
  // This is called before leaving the route, returning false cancels the navigation
  beforeLeave: (_, __, ___, ____) async => (isLoggedIn) ? true : false,
  // This is called if this widget is in the old route and in the new route
  afterUpdate: () => (isLoggedIn) ? VRouterData.of(context).push('/profile') : null,
  // This is called the first time this widget is displayed in the route
  afterEnter: () => (isLoggedIn) ? VRouterData.of(context).push('/profile') : null,
  child: ...,
),
          ''',
        ),
      ],
    );
  }
}

class NavigationCyclePageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      TextSpan(
        text: '''
The navigation cycle is the list of events which happen when a user navigates from a route to another. The cycle is important to understand as it allows you to better manage your navigation system in a declarative way.

When you try to navigate, here is when will happen:
     1. Call beforeLeave in all deactivated [VNavigationGuard]
     2. Call beforeLeave in the nest-most [VRouteElement] of the current route
     3. Call beforeLeave in the [VRouter]
     4. Call beforeEnter in the [VRouter]
     5. Call beforeEnter in the nest-most [VRouteElement] of the new route
     ## The history state got in beforeLeave are stored   
     ## The state of the VRouter changes            
     6. Call afterEnter in the [VRouter]
     7. Call afterEnter in the nest-most [VRouteElement] of the new route
     8. Call afterUpdate in all reused [VNavigationGuard]
     9. Call afterEnter in all initialized [VNavigationGuard]

Deactivated VNavigationGuard are those attached to widgets which were in the previousRoute but not in the new one.
Reused VNavigationGuard are those attached to widgets which were in the previousRoute and in the new one.
Initialized VNavigationGuard are those attached to widgets which were not in the previousRoute but are in the new one.
Any beforeLeave or beforeEnter function returns a future which will be awaited. If any of these functions return false, then the redirection will be stopped.''',
        style: textStyle,
      ),
    );
  }
}

class WebCaveatPageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      TextSpan(
        text: '''
When a user tries to access an external url by clicking on a button where you use VRouterData.of(context).pushExternal, everything works as expected.

When a user tries to access an external url either by typing it, or using the forward/backward button to navigate to them, you can’t prevent the user from navigating. This means that if any beforeLeave returns false, this will be ignored. 

Reloading the page cannot be stopped as well.

Everything else should work as expected.''',
        style: textStyle,
      ),
    );
  }
}
