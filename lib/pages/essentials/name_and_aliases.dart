import 'package:flutter/material.dart';
import 'package:vrouter_website/main.dart';

class NamedRoutePageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText.rich(
          TextSpan(
            text: '''
Any VRouteElement takes a `name` parameter, this acts as an identifier and can be used for easier navigation.''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        Text('Router configuration:', style: textStyle.copyWith(fontWeight: FontWeight.bold),),
        MyDartCodeViewer(
          code: r'''
VRouter(
  routes: [
    VStacked(path: '/a', widget: Container(), subroutes: [
      VStacked(path: 'very', widget: Container(), subroutes: [
        VStacked(path: 'nested', widget: Container(), subroutes: [
          VStacked(path: 'route/:id', widget: VeryNestedWidget(), name: 'nestedRoute'),
        ]),
      ]),
    ]),
  ],
),
          ''',
        ),
        Text('Navigating:', style: textStyle.copyWith(fontWeight: FontWeight.bold),),
        MyDartCodeViewer(
          code: r'''
// Navigating with pushNamed
// You can pass path parameters in a Map object
VRouterData.of(context).pushNamed('nestedRoute', pathParameters: {'id': '4'});
          ''',
        ),
        SizedBox(height: 10),
        SelectableText.rich(
          TextSpan(
            text: '''

Note that this is what was used in the VChild section to help identifying them.''',
            style: textStyle,
          ),
        )
      ],
    );
  }
}

class AliasesPageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText.rich(
          TextSpan(
            text: '''
If you need to assign different path to the same route, you can do so by using the aliases parameter. This aliases will be matched the path would.
Since aliases behaves as a path, starting with '/' will create a root path and you can use path parameters in aliases.
''',
            style: textStyle,
          ),
        ),
        MyDartCodeViewer(
          code: r'''
VRouter(
  routes: [
    VStacked(
      // The path /user will be matched
      path: '/user',
      // The path /user/123 will also be matched
      aliases: ['/user/:id'],
      widget: MyWidget(),
    ),
  ],
)
          ''',
        ),
      ],
    );
  }
}
