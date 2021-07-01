import 'package:flutter/material.dart';
import 'package:vrouter_website/main.dart';

class HistoryStateDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      TextSpan(
        text:
            '''The history state is a Map<String, String> that you can pass when going to a new route, and then change once in that route. 
While this might be useful to pass data around, the real power of the history states is on the web: This state is tight to an history entry. Meaning that if the user uses the back or forward button (or clicks in their web history), the state will be the same as when you left!''',
        style: textStyle,
      ),
    );
  }
}

class ProvidingAHistoryStatePageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText.rich(
          TextSpan(
            text:
                '''When navigating to a route, you can pass a historyState argument which will be associated with the new route.''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        MyDartCodeViewer(
          code: r'''
// You can add an history state alongside a new url
context.vRouter.to('/profile', historyState: {'name': 'bob'});
          ''',
        ),
        SizedBox(height: 10),
        MyDartCodeViewer(
          code: r'''
// In /profile, you can access what you just passed
context.vRouter.historyState;
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
            text:
                '''Sometimes you are on a route and you want to replace the history state.''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        MyDartCodeViewer(
          code: r'''
context.vRouter.replaceHistoryState({'name': 'alice'});
          ''',
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
            text: '''Something really useful is to save the state right before you leave. 
You can do this be in the beforeLeave method, by using saveHistoryState''',
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
      beforeLeave: (vRedirector, saveHistoryState) async {
        saveHistoryState({'name': 'Charlie'});
        return true;
      },
      routes: [
        VGuard(
          beforeLeave: (vRedirector, saveHistoryState) async {
            saveHistoryState({'name': 'Charlie'});
            return true;
          },
          stackedRoutes: [...],
        ),
      ],
    )
          ''',
        ),
        SizedBox(height: 10),
        Text(
          'Usage in VWidgetGuard:',
          style: textStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        MyDartCodeViewer(
          code: r'''
VWidgetGuard(
  beforeLeave: (vRedirector, saveHistoryState) async {
    saveHistoryState({'name': 'Charlie'});
  },
  child: ...,
)
          ''',
        ),
        SizedBox(height: 10),
        SelectableText.rich(
          TextSpan(
            text: '''     
This can be really useful on the web, so that if the user uses the back button, you can restore the state (using afterEnter or afterUpdate for example).''',
            style: textStyle,
          ),
        ),
      ],
    );
  }
}
