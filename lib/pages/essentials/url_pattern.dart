import 'package:complete_app/vrouter/main.dart';
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
You will often need to match with a certain path pattern to the same route. To easily achieve this, you can use path parameters. To use them you just need to insert :parameterName in the url.
To access them, use VRouteElementData or VRouteData.''',
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
    VStacked(
      path: '/user/:id',
      widget: UserWidget(),
      subroutes: [
        VStacked(path: 'other', widget: OtherWidget()),
      ],
    ),
  ],
)
          ''',
        ),
        Text(
          'Widgets:',
          style: textStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        MyDartCodeViewer(
          code: r'''
class UserWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // DO use VRouteElement to access general information about the route
    print('The current id is: ${VRouteData.of(context).pathParameters['id']}');
    
    // DO use VRouteElementData to data which belong to this VRouteElement
    return Text('User id is ${VRouteElementData.of(context).pathParameters['id']}');
  }
}

class OtherWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // DO use VRouteElement to access general information about the route
    print('The current id is: ${VRouteData.of(context).pathParameters['id']}');

    // DON'T use VRouteElementData to access data which belong to another VRouteElement
    return Text('User id is ${VRouteElementData.of(context).pathParameters['id']}');
  }
}
          ''',
        ),
        SizedBox(height: 20),
        SelectableText.rich(
          TextSpan(
            text: '''You can also have several path parameters in the same path:''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        Table(
          border: TableBorder.all(color: Colors.black, width: 0.5),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              children: [
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        Center(child: Text('pattern', style: textStyle.copyWith(fontWeight: FontWeight.bold))),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text('matched path',
                          style: textStyle.copyWith(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text('VRouteData\n.of(context)\n.pathParameters',
                          style: textStyle.copyWith(fontWeight: FontWeight.bold)),
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
                    child: Text('{‘name’: ‘bob’, ‘postId: ‘123’}', style: textStyle),
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
                  text: 'path_to_regexp',
                  style: linkStyle,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      VRouterData.of(context)
                          .pushExternal('https://pub.dev/packages/path_to_regexp', openNewTab: true);
                    }),
              TextSpan(
                text: ' package to do url matching so you can use do thing like this:',
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
                  child:
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text('pattern', style: textStyle.copyWith(fontWeight: FontWeight.bold))),
                      ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text('matched path',
                          style: textStyle.copyWith(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text('NOT matched path',
                          style: textStyle.copyWith(fontWeight: FontWeight.bold)),
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
            '''It might happen that several urls match multiple paths, in this case the priority is to the path which is the highest in the routes list.
If you have aliases, they have the priority over nested routes.''',
        style: textStyle,
      ),
    );
  }
}
