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

The default behaviour is to pop all VRouteElement until a VStacked is popped.''',
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
            text: 'If we are on the last VStacked:\n',
            style: textStyle,
            children: [
              TextSpan(
                text: '''   
• On mobile: the application closes 
• On the web: nothing happens

Also note that when a default pop happens, a new url corresponding to the new route will be pushed, causing the navigation cycle to start.''',
              ),
            ],
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
This allows you to handle what happens during a programmatic pop. This happens automatically with an app bar back button, or you can activate it manually with VRouterData.of(context).pop(context).
To handle this event, consider the following pop cycle:
    1. onPop is called in all VNavigationGuards
    2. onPop is called in the nested-most VRouteElement of the current route
    3. onPop is called in VRouter
    4. Default behaviour of pop is called

For each of the calls, if onPop returns false, the pop event stops.
Note that in VNavigationGuard, onPop is called starting from the most nested one.''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        MyDartCodeViewer(
          code: r'''
VStacked(
  // popping while the path is '/profile' will call this
  onPop: (context) async {
    VRouterData.of(context).push('/other'); // You can use VRouterData to redirect
    return false; // returning false stops the pop event
  },
  path: 'profile',
  widget: ProfileWidget(),
)
          ''',
        ),
        SizedBox(height: 10),
        MyDartCodeViewer(
          code: r'''
VNavigationGuard(
  // If this VNavigationGuard is in the path and a pop
  // event occurs, this will be called
  onPop: (context) async {
    ...
  },
  child: ...,
)
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
This allows you to handle what happens during a system pop. This happens on android when the back button is pressed, or you can activate it manually with VRouterData.of(context).systemPop(context).
To handle this event, consider the following systemPop cycle:
    1. onSystemPop is called in all VNavigationGuards
    2. onSystemPop is called in the nested-most VRouteElement of the current route
    3. onSystemPop is called in VRouter
    4. pop is called, see the pop cycle above 

For each of the calls, if onSystemPop returns false, the systemPop event stops.
Note that in VNavigationGuard, onSystemPop is called starting from the most nested one.''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        MyDartCodeViewer(
          code: r'''
VStacked(
  // pressing the android back button while the path is '/profile' will call this
  onSystemPop: (context) async {
    VRouterData.of(context).push('/other'); // You can use VRouterData to redirect
    return false; // returning false stops the pop event
  },
  path: '/profile',
  widget: ProfileWidget(),
)
          ''',
        ),
        SizedBox(height: 10),
        SelectableText.rich(
          TextSpan(
            text: '''
Note that is no systemPop methods are implemented, the pop cycle will start instead.''',
            style: textStyle,
          ),
        ),
      ],
    );
  }
}
