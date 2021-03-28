import 'package:flutter/material.dart';
import 'package:vrouter_website/main.dart';

class WidgetNestingDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText.rich(
          TextSpan(
            text: '''Flutter has a tendency to nest, if you know what I mean. So nesting in VRouter has always been a major concern. This is why we created a VRouteElement dedicated to nesting: VNester''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        SelectableText.rich(
          TextSpan(
            text: '''VNester is a VRouteElement that you can use just like VWidget. The only differences are:
    • You have access to nestedRoute, which allows you to create a route which will be nested inside your widget
    • You use a widgetBuilder instead of a widget. The widgetBuilder gives you the child which is the widget of the VRouteElement used in nestedRoute''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        Text('Router configuration:', style: textStyle.copyWith(fontWeight: FontWeight.bold),),
        MyDartCodeViewer(
          code: r'''
VRouter(
  routes: [
    VNester(
      path: null,
      widgetBuilder: (child) => MyScaffold(body: child), // child is the widget of the matched VWidget in nestedRoutes
      nestedRoutes: [
        VWidget(
          path: '/profile',
          widget: ProfileScreen(),
        ),
        VWidget(
          path: '/settings',
          widget: SettingsScreen(),
        ),
      ],
    )
  ],
)
          ''',
        ),
        SizedBox(height: 10),
        Text('MyScaffold:', style: textStyle.copyWith(fontWeight: FontWeight.bold),),
        MyDartCodeViewer(
          code: r'''
class MyScaffold extends StatelessWidget {
  final Widget body;

  const MyScaffold({Key key, this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: body);
  }
}
          ''',
        ),
        SizedBox(height: 10),
        SelectableText.rich(
          TextSpan(
            text: '''
In the example, child in widgetBuilder will be:
    • ProfileScreen if the path is “/profile” 
    • SettingsScreen if the path is “/settings” 

Also note that VNester has a null path, which means that it will match the path of the parent. However, a property of a VNester is that it will only be displayed if a nestedRoute matches, so this is not an issue.''',
            style: textStyle,
          ),
        )
      ],
    );
  }
}
