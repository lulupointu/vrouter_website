import 'package:complete_app/vrouter/main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vrouter_website/main.dart';

class HistoryModeDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText.rich(
          TextSpan(
            text: 'The default mode of VRouter is hash-mode. However we also include the ',
            style: textStyle,
            children: [
              TextSpan(
                  text: 'url_strategy',
                  style: linkStyle,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      VRouterData.of(context)
                          .pushExternal('https://pub.dev/packages/url_strategy', openNewTab: true);
                    }),
              TextSpan(
                text: ''' 
 so that you can change to history mode. 
This is passed directly as a VRouter argument:''',
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        MyDartCodeViewer(
          code: r'''
// Hash mode, the default
VRouter(mode: VRouterMode.hash, routes: ...)

// History mode
VRouter(mode: VRouterMode.history, routes: ...)
          ''',
        ),
        SizedBox(height: 20),
        SelectableText.rich(
          TextSpan(
            text: '''When using hash mode the path will be displayed after the “#/” in the url. 
When using history mode, the url will display normally. However, you have to configure your server specifically or the user will have a 404 not found error if they type anything in the BrowserHelpers. Mitigating this problem is easy but an extra step. 
''',
            style: textStyle,
            children: [
              TextSpan(
                  text: 'Here is a useful guide: the vue router tutorial itself.',
                  style: linkStyle,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      VRouterData.of(context)
                          .pushExternal('https://router.vuejs.org/guide/essentials/history-mode.html#example-server-configurations', openNewTab: true);
                    }),
            ],
          ),
        ),
      ],
    );
  }
}
