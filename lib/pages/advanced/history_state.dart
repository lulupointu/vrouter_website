import 'package:flutter/material.dart';
import 'package:vrouter_website/main.dart';

class HistoryStateDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      TextSpan(
        text: '''
The history state is a String that you can pass when going to a new route, and then change once in that route. 
While this might be useful to pass data around, the real power of the history states is on the web: This state is tight to an history entry. Meaning that if the user uses the back or forward button (or clicks in their web history), the state will be the same as when you left!''',
        style: textStyle,
      ),
    );
  }
}

class PushingAHistoryStatePageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText.rich(
          TextSpan(
            text: '''
When pushing a route, you can pass a state as a String argument. This argument will be stored in the next VRoute history state.''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        MyDartCodeViewer(
          code: r'''
// You can push the state alongside a new url
VRouterData.of(context).push('/profile', newRouterState: 'bob');
          ''',
        ),
        SizedBox(height: 10),
        MyDartCodeViewer(
          code: r'''
// In /profile, you can access what you just passed
VRouterData.of(context).historyState;
          ''',
        ),
      ],
    );
  }
}

class ReplaceAHistoryStatePageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText.rich(
          TextSpan(
            text: '''
Sometimes you are on a route and you want to replace the history state with a current state. You can replace the state at three levels: VRouterData, VRouteData or VRouteElementData.''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        MyDartCodeViewer(
          code: r'''
// Replace the state of VRouterData
VRouterData.of(context).replaceHistoryState('anyRouterInformation');

// Replace the state of VRouteData
VRouteData.of(context).replaceHistoryState('anyRouteInformation');

// Replace the state of VRouteElementData
VRouteElementData.of(context).replaceHistoryState('anyRouteInformation');
          ''',
        ),
        SizedBox(height: 10),
        MyDartCodeViewer(
          code: r'''
// You can access what you just passed, in different scopes
  
// Globally
VRouterData.of(context).historyState;
VRouteData.of(context).historyState;

// Locally
VRouteElementData.of(context).historyState;
          ''',
        ),
        SizedBox(height: 20),
        SelectableText.rich(
          TextSpan(
              text: 'Warning:',
              style: textStyle.copyWith(fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: '''
 do not use the replaceState! This will not work when the user uses any browser functionality.
 
 Note that, as always, VRouteElementData is a local information specific to where in the route your widget is.''',
                  style: textStyle.copyWith(fontWeight: FontWeight.normal),
                )
              ]),
        ),
      ],
    );
  }
}

class SavingBeforeLeavePageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText.rich(
          TextSpan(
            text: '''
Sometimes you are on a route and you want to replace the history state with a current state. You can replace the state at three levels: VRouterData, VRouteData or VRouteElementData.''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Router configuration:',
          style: textStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        MyDartCodeViewer(
          code: r'''
VRouter(
  beforeLeave: (context, from, to, saveHistoryState) async {
    saveHistoryState('anyRouterInformation');
    return true;
  },
  routes: [
    VStacked(
      path: '/',
      widget: Profile(),
      // Remember that this is only called for the route '/'
      // Not any subroute. This is a global event.
      beforeLeave: (context, from, to, saveHistoryState) async {
        saveHistoryState('anyRouteInformation');
        return true;
      },
    ),
  ],
)
          ''',
        ),
        SizedBox(height: 10),
        Text(
          'Usage in VNavigationGuard:',
          style: textStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        MyDartCodeViewer(
          code: r'''
VNavigationGuard(
  beforeLeave: (context, from, to, saveHistoryState) async {
    // This will be later accessible using VRouteElementData.of(context).historyState
    saveHistoryState('local state');
    return true;
  },
  child: ...,
);
          ''',
        ),
        SizedBox(height: 10),
        SelectableText.rich(
          TextSpan(
            text: '''
This can be really useful on the web, so that if the user uses the back button, you can restore the state (using afterEnter for example).''',
            style: textStyle,
          ),
        ),
      ],
    );
  }
}
