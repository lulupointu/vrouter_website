import 'package:vrouter/vrouter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vrouter_website/main.dart';

class NavigationControlDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      TextSpan(
        text: '''
Giving you as much control as possible over what happens when a route changes is a core principle of VRouter.

To achieve such control, five functions can be used in various places: beforeLeave, beforeEnter, beforeUpdate, afterEnter, afterUpdate.
These function have different scope depending on where they are specified: 
    • Global if specified if the VRouter (i.e. they will always be called)
    • Route specific if specified in a VGuard
    • Widget specific by using VWidgetGuard''',
        style: textStyle,
      ),
    );
  }
}

class VGuardPageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText.rich(
          TextSpan(
            text: '''VGuard is a VRouteElement which can be used to guard some routes, use it as any VRouteElement and specify beforeLeave, beforeEnter, beforeUpdate, afterEnter or afterUpdate.''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        MyDartCodeViewer(
          code: r'''
VRouter(
  routes: [
    // This VRouteElement is not guarded
    VWidget(path: '/login', widget: LoginScreen()),

    // All VRouteElement in VGuard are guarded
    VGuard(
      beforeEnter: (vRedirector) async => isLoggedIn ? null : vRedirector.push('/login'),
      stackedRoutes: [
        VWidget(path: '/profile', widget: ProfileScreen()),
        VWidget(path: '/settings', widget: SettingsScreen()),
      ],
    ),
  ],
)
          ''',
        ),
      ],
    );
  }
}


class VWidgetGuardPageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText.rich(
          TextSpan(
            text: '''VWidgetGuard is a widget. You can place this widget where you want in your widget tree, and have access to beforeLeave, beforeUpdate, afterEnter, afterUpdate.''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        Text('Router configuration:', style: textStyle.copyWith(fontWeight: FontWeight.bold),),
        MyDartCodeViewer(
          code: r'''
VRouter(
  routes: [
    VWidget(path: '/', widget: LoginScreen()),
    VWidget(path: '/profile', widget: ProfileScreen()),
  ],
)
          ''',
        ),
        SizedBox(height: 10),
        Text('LoginScreen:', style: textStyle.copyWith(fontWeight: FontWeight.bold),),
        MyDartCodeViewer(
          code: r'''
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<Login> {
  bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: VWidgetGuard(
        // This is called before leaving the route
        beforeLeave: (vRedirector, __) async => (!isLoggedIn) ? vRedirector.stopRedirection() : null,
        // This is called if this widget is in the old route and in the new route
        afterUpdate: (_, __, ___) => (isLoggedIn) ? context.vRouter.push('/profile') : null,
        // This is called the first time this widget is displayed in the route
        afterEnter: (_, __, ___) => (isLoggedIn) ? context.vRouter.push('/profile') : null,
        child: ...,
      ),
    );
  }
}
          ''',
        ),
        SizedBox(height: 20),
        SelectableText.rich(
          TextSpan(
            text: '''Note that you don’t have access to beforeEnter in a VWidgetGuard, this is a limitation of Flutter. Use VGuard if you want to have access to beforeEnter.''',
            style: textStyle,
          ),
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
The navigation cycle is the list of events which happen when a user navigates from a route to another. The cycle is important to understand as it allows you to better manage your navigation control.

When you try to navigate, here is what will happen:    
  1. Call beforeLeave in all deactivated [VWidgetGuard]
  2. Call beforeLeave in all deactivated [VRouteElement]
  3. Call beforeLeave in the [VRouter]
  4. Call beforeEnter in the [VRouter]
  5. Call beforeEnter in all initialized [VRouteElement] of the new route
  6. Call beforeUpdate in all reused [VRouteElement]

  ## The history state got in beforeLeave are stored
  ## The state is updated

  7. Call afterEnter in all initialized [VWidgetGuard]
  8. Call afterEnter all initialized [VRouteElement]
  9. Call afterEnter in the [VRouter]
  10. Call afterUpdate in all reused [VWidgetGuard]
  11. Call afterUpdate in all reused [VRouteElement]


Deactivated are those which were in the previousRoute but not in the new one.
Reused are those which were in the previousRoute and in the new one.
Initialized are those which were not in the previousRoute but are in the new one.

beforeLeave, beforeEnter and beforeUpdate function return a future which will be awaited. 

In beforeLeave, beforeEnter and beforeUpdate, you can stop the navigation cycle by using VRedirector. However do NOT use context.vRouter to redirect in those functions.''',
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
When a user tries to access an external url by clicking on a button where you use context.vRouter.pushExternal, everything works as expected.

When a user tries to access an external url either by typing it, or using the forward/backward button to navigate to an external url, you can’t prevent the user from navigating. This means that trying to use vRedirector.stopRedirection, vRedirector.push, ... in beforeLeave will be ignored. 

Reloading the page cannot be stopped as well.

Everything else should work as expected.''',
        style: textStyle,
      ),
    );
  }
}
