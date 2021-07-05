import 'package:flutter/material.dart';
import 'package:vrouter_website/main.dart';

class HistoryDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      TextSpan(
        text: '''
The history is something built in every browser. However it can also be very useful in a mobile app. For example, the android Youtube app uses this concept for the android system back button.

The history is the browser history that you get by long pressing on the browser back or forward button. Concretely, it is a list of every url visited associated with your position in this list.
''',
        style: textStyle,
      ),
    );
  }
}

class UsingItToNavigatePageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText.rich(
          TextSpan(
            text: '''With the url history, you can navigate backward or forward:''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        MyDartCodeViewer(
          code: r'''
// Navigate by delta
context.vRouter.historyGo(delta);

// Navigate to the previous url history entry (delta = -1)
context.vRouter.historyBack();

// Navigate to the next url history entry (delta = +1)
context.vRouter.historyForward();
          ''',
        ),
        SizedBox(height: 20),
        SelectableText.rich(
          TextSpan(
            text: '''
Trying to navigate in the url history to an unavailable position throws an error. You should therefore be sure that you can navigate before doing so:''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        MyDartCodeViewer(
          code: r'''
// Check if you can navigate by delta
context.vRouter.historyCanGo(delta);

// Check if you can navigate to the previous url history entry
context.vRouter.historyCanBack();

// Check if you can navigate to the next url history entry (delta = +1)
context.vRouter.historyCanForward();
          ''',
        ),
      ],
    );
  }
}

class ReplacingAnHistoryEntryPageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText.rich(
          TextSpan(
            text:
            '''Changing the url history is limited, the only action you can do is replacing the current history entry using “isReplacement”:''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        MyDartCodeViewer(
          code: r'''
// Navigating by replacing the current url history
context.vRouter.to('/home', isReplacement: true);
context.vRouter.toSegments(['home'], isReplacement: true);
context.vRouter.toNamed('home', isReplacement: true);
          ''',
        ),
      ],
    );
  }
}

class HistoryStatePageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText.rich(
          TextSpan(
            text:
                '''As we have seen, the history is a list of url you can use to navigate. However, this list also contains something else: The history state. 
It is a Map<String, String> that you can pass when going to a new route, and then change once in that route. 

The real power of the history states is that it is linked with the history entry. Meaning that if the user uses the back or forward button (or clicks in their web history), or you use `VRouter.historyBack` the state will be the same as when you left!''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 20),
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
        SizedBox(height: 20),
        SelectableText.rich(
          TextSpan(
            text: '''You may then access it using context.vRouter:''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        MyDartCodeViewer(
          code: r'''
// In /profile, you can access what you just passed
context.vRouter.historyState;
          ''',
        ),
        SizedBox(height: 20),
        SelectableText.rich(
          TextSpan(
            text: '''You can also change it (only affect the current history entry):''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        MyDartCodeViewer(
          code: r'''
VRouter.of(context).to(
  context.vRouter.url, // Stay at the current url
  isReplacement: true, // We use replacement to override the history entry
  historyState: newHistoryState,
);
          ''',
        ),
        SizedBox(height: 20),
        SelectableText.rich(
          TextSpan(
            text:
            '''Note that if you use isReplacement but do not specify the state (as seen in the previous section), the history state will be reset to an empty map.''',
            style: textStyle,
          ),
        ),
      ],
    );
  }
}
