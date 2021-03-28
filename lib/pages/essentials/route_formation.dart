import 'package:flutter/material.dart';
import 'package:vrouter_website/main.dart';

class RouteFormationDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      TextSpan(
        text:
            '''In Flutter, you alway place widget in relation to each other by nesting them. In VRouter, you do the same.''',
        style: textStyle,
      ),
    );
  }
}

class StackedWidgetPageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText.rich(
          TextSpan(
            text: '''A first example is when you when to place widget from a VWidget on top of another, in that case you can use stackedRoutes:''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        MyDartCodeViewer(
          code: r'''
VRouter(
  routes: [
    VWidget(
      path: '/user',
      widget: UserScreen(), // UserScreen will be displayed when the path is '/user'
      stackedRoutes: [
        VWidget(
          path: 'settings',
          widget: SettingsScreen(), // SettingsScreen will be stacked on top of UserWidget when the path is '/user/settings'
        ),
      ],
    )
  ],
)
          ''',
        ),
      ],
    );
  }
}

class PathFormationPageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText.rich(
          TextSpan(
            text: '''Having a relation between two routes can also mean that a route will have a path which is relative to the parent route. The rule is, if you want to match:
    • An absolute path, start with “/”
    • A relative path, do NOT start with “/”
    • The parent path, use a null path''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        MyDartCodeViewer(
          code: r'''
VRouter(
  routes: [
    VWidget(
      path: '/user',
      widget: UserScreen(),
      stackedRoutes: [
        VWidget(
          path: 'settings', // This path matches '/user/settings'
          widget: SettingsScreen(),
        ),
        VWidget(
          path: '/settings', // This path matches '/settings'
          widget: SettingsScreen(),
        ),
        VWidget(
          path: null, // This path matches '/user'
          widget: OtherScreen(),
        ),
      ],
    )
  ],
)
          ''',
        ),
        SizedBox(height: 10),
        SelectableText.rich(
          TextSpan(
            text: '''Note that in the example above, UserWidget will never be visible because for the path '/user', OtherWidget will be displayed on top (since the nested most route wins). However, having a null path can come in handy when using a VNester, check the next section to learn more.''',
            style: textStyle,
          ),
        )
      ],
    );
  }
}
