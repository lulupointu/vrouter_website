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
            text: '''Some VRouteElements like VWidget or VNester take a name parameter, this acts as an identifier and can be used for easier navigation.''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        Text('Router configuration:', style: textStyle.copyWith(fontWeight: FontWeight.bold),),
        MyDartCodeViewer(
          code: r'''
VRouter(
  routes: [
    VWidget(path: '/a', widget: Container(), stackedRoutes: [
      VWidget(path: 'very', widget: Container(), stackedRoutes: [
        VWidget(path: 'nested', widget: Container(), stackedRoutes: [
          VWidget(
            path: 'route', // This path matches /a/very/nested/route
            widget: VeryNestedWidget(),
            name: 'nestedRoute', // This name can be used to access this route easily
          ),
        ]),
      ]),
    ]),
  ],
)
          ''',
        ),
        Text('Navigating:', style: textStyle.copyWith(fontWeight: FontWeight.bold),),
        MyDartCodeViewer(
          code: r'''
// Navigating with pushNamed
context.vRouter.pushNamed('nestedRoute');
          ''',
        ),
        SizedBox(height: 20),
        SelectableText.rich(
          TextSpan(
            text: '''Also note that if the path contains path parameters, you might want to path the path parameters in pushNamed as a map:''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        Text('Router configuration:', style: textStyle.copyWith(fontWeight: FontWeight.bold),),
        MyDartCodeViewer(
          code: r'''
VRouter(
  routes: [
    VWidget(path: '/a', widget: Container(), stackedRoutes: [
      VWidget(path: 'very', widget: Container(), stackedRoutes: [
        VWidget(path: 'nested', widget: Container(), stackedRoutes: [
          VWidget(
            path: ':id', // This path matches /a/very/nested/:id
            widget: VeryNestedWidget(),
            name: 'nestedRoute', // This name can be used to access this route easily
          ),
        ]),
      ]),
    ]),
  ],
)
          ''',
        ),
        Text('Navigating:', style: textStyle.copyWith(fontWeight: FontWeight.bold),),
        MyDartCodeViewer(
          code: r'''
// Navigating with pushNamed
// You can pass path parameters in a Map object
context.vRouter.pushNamed('nestedRoute', pathParameters: {'id': '0'});
          ''',
        ),
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
If you need to assign different paths to the same route, you can do so by using the 'aliases' parameter.
Since aliases behave as a path:
    • starting with '/' will create an absolute path
    • you can use path parameters''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        MyDartCodeViewer(
          code: r'''
// The following route matches /user, /other and /user/:id
VWidget(
  path: '/user',
  aliases: ['/other', '/user/:id'],
  widget: MyWidget(),
),
          ''',
        ),
        SizedBox(height: 20),
        SelectableText.rich(
          TextSpan(
            text: '''Also note that the path is matched first, then the aliases (in the order they are in the list).''',
            style: textStyle,
          ),
        ),
      ],
    );
  }
}
