import 'package:flutter/material.dart';
import 'package:vrouter_website/main.dart';

class PopEventsDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText.rich(
          TextSpan(
            text: '''
Handling back buttons is always important. While you often seek the default behaviour, you sometimes want to have a custom one. 
VRouter provides you with a default behaviour close to the one in Flutter but also enables you to customize it.

The default behaviour is to pop the latest VRouteElement containing a widget.''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 30),
        Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 300),
            child: Image.asset('assets/default_pop.png'),
          ),
        ),
        SizedBox(height: 30),
        SelectableText.rich(
          TextSpan(
            text: '''If you pop the VRouteElement on top of a VNester, VNester will be popped as well:''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 30),
        Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 300),
            child: Image.asset('assets/default_pop_with_vnester.png'),
          ),
        ),
        SizedBox(height: 30),
        SelectableText.rich(
          TextSpan(
            text: '''Note that when a default pop happens, a new url corresponding to the new route will be pushed, causing the navigation cycle to start.

Also note that if we are on the last VRouteElement:
  • On mobile: the application closes 
  • On the web: nothing happens

If you want to customize your pop events, you can use onPop or onSystemPop.''',
            style: textStyle,
          ),
        ),
      ],
    );
  }
}

class OnPopPageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText.rich(
          TextSpan(
            text: '''
This allows you to handle what happens during a programmatic pop. This happens automatically with an app bar back button, or you can activate it manually with context.vRouter.pop().

To handle this event, consider the following pop cycle:
  1. onPop is called in all VWidgetGuard
  2. onPop is called in all VPopHandler of the current route
  3. onPop is called in VRouter
  4. Default behaviour of pop is called

You get a VRedirector in onPop, which can be used to stop the pop event.''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        MyDartCodeViewer(
          code: r'''
VRouter(
  // Every pop event will call this
  onPop: (vRedirector) async {},
  routes: [
    // popping while the path is '/profile' will call this
    VPopHandler(
      onPop: (vRedirector) async {
        vRedirector.push('/other'); // You can use VRedirector to redirect
      },
      stackedRoutes: [
        VWidget(
          path: 'profile',
          widget: ProfileScreen(),
        ),
      ],
    ),
  ],
)
          ''',
        ),
        SizedBox(height: 10),
        MyDartCodeViewer(
          code: r'''
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    VWidgetGuard(
      // If this VWidgetGuard is in the widget tree and a pop
      // event occurs, this will be called
      onPop: (vRedirector) async {
        ...
      },
      child: ...,
    );
  }
}
          ''',
        ),
      ],
    );
  }
}

class OnSystemPopPageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText.rich(
          TextSpan(
            text: '''
This allows you to handle what happens during a system pop. This happens on android when the back button is pressed, or you can activate it manually with context.vRouter.systemPop(context).

To handle this event, consider the following systemPop cycle:
  1. onSystemPop is called in all VWidgetGuards
  2. onSystemPop is called in all VPopHandler of the current route
  3. onSystemPop is called in VRouter
  4. pop is called, see the pop cycle above 

You get a VRedirector in onSystemPop, which can be used to stop the pop event.''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        MyDartCodeViewer(
          code: r'''
VRouter(
  // Every systemPop event will call this
  onSystemPop: (vRedirector) async {},
  routes: [
    VPopHandler(
      onSystemPop: (vRedirector) async {
        vRedirector.push('/other'); // You can use VRedirector to redirect
      },
      stackedRoutes: [
        VWidget(
          path: 'profile',
          widget: ProfileScreen(),
        ),
      ],
    ),
  ],
)
          ''',
        ),
        SizedBox(height: 10),
        MyDartCodeViewer(
          code: r'''
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    VWidgetGuard(
      // If this VWidgetGuard is in the widget tree and a systemPop
      // event occurs, this will be called
      onSystemPop: (vRedirector) async {
        ...
      },
      child: ...,
    );
  }
}
          ''',
        ),
        SizedBox(height: 10),
        SelectableText.rich(
          TextSpan(
            text: '''
Note that, at each step of the systepPop cycle, if onSystemPop is not implemented, onPop will be called instead.''',
            style: textStyle,
          ),
        ),
      ],
    );
  }
}
