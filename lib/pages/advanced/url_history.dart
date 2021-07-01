import 'package:flutter/material.dart';
import 'package:vrouter_website/main.dart';

class UrlHistoryDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      TextSpan(
        text: '''
The url history is something built in every browser. However it can also be very useful in a mobile app. For example, the android Youtube app uses this concept for the android system back button.

The url history is the browser history that you get by long pressing on the browser back or forward button. Concretely, it is a list of every url visited associated with your position in this list.
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
context.vRouter.urlHistoryGo(delta);

// Navigate to the previous url history entry (delta = -1)
context.vRouter.urlHistoryBack();

// Navigate to the next url history entry (delta = +1)
context.vRouter.urlHistoryForward();
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
context.vRouter.urlHistoryCanGo(delta);

// Check if you can navigate to the previous url history entry
context.vRouter.urlHistoryCanBack();

// Check if you can navigate to the next url history entry (delta = +1)
context.vRouter.urlHistoryCanForward();
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
