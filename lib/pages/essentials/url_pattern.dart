import 'package:vrouter/vrouter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vrouter_website/main.dart';

class PathParametersPageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText.rich(
          TextSpan(
            text: '''
You will often need to match a path with a certain pattern. To easily achieve this, you can use path parameters. To use them you just need to insert ':parameterName' in the url, and you will have access to them using context.vRouter.pathParameters''',
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
  routes: [
    VWidget(
      path: '/user/:id',
      widget: UserWidget(),
    ),
  ],
)
          ''',
        ),
        Text(
          'Access path parameters:',
          style: textStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        MyDartCodeViewer(
          code: r'''
class UserWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('User id is ${context.vRouter.pathParameters['id']}');
  }
}
          ''',
        ),
        SizedBox(height: 20),
        Table(
          border: TableBorder.all(color: Colors.black, width: 0.5),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              children: [
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Text('pattern',
                            style: textStyle.copyWith(
                                fontWeight: FontWeight.bold))),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text('matched path',
                          style:
                              textStyle.copyWith(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text('context\n.vRouter\n.pathParameters',
                          style:
                              textStyle.copyWith(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('/user/:name', style: textStyle),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('/user/bob', style: textStyle),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('{‘name’: ‘bob’}', style: textStyle),
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('/user/:name/post/:postId', style: textStyle),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('/user/bob/post/123', style: textStyle),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('{‘name’: ‘bob’, ‘postId: ‘123’}',
                        style: textStyle),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class AdvancedPatternMatchingPageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText.rich(
          TextSpan(
            text: 'VRouter uses the ',
            style: textStyle,
            children: [
              TextSpan(
                  mouseCursor: MaterialStateMouseCursor.clickable,
                  text: 'path_to_regexp',
                  style: linkStyle,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      context.vRouter.toExternal(
                          'https://pub.dev/packages/path_to_regexp',
                          openNewTab: true);
                    }),
              TextSpan(
                text:
                    ' package to do url matching so you can use do thing like this:',
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Table(
          border: TableBorder.all(color: Colors.black, width: 0.5),
          children: [
            TableRow(
              children: [
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Text('pattern',
                            style: textStyle.copyWith(
                                fontWeight: FontWeight.bold))),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text('matched path',
                          style:
                              textStyle.copyWith(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text('NOT matched path',
                          style:
                              textStyle.copyWith(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('/user/:id(\d+)', style: textStyle),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('/user/123', style: textStyle),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('/user/bob', style: textStyle),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 20),
        SelectableText.rich(
          TextSpan(
            text: '''
Note that it is better to use raw string ( r’string’ ) when specifying path parameters.''',
            style: textStyle,
          ),
        ),
      ],
    );
  }
}

class MatchingPriorityPageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      TextSpan(
        text:
            '''It might happen that several urls match multiple paths, in this case the priority is to the path which is the highest in the routes list.''',
        style: textStyle,
      ),
    );
  }
}
