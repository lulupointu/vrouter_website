import 'package:flutter/material.dart';
import 'package:vrouter_website/main.dart';


class NestedRouteDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText.rich(
          TextSpan(
            text: '''
Flutter as a tendency to nest, if you know what I mean. So nesting with this package is really easy, all you have to do is use the `subroutes` attributes.
Note that subroutes is a list of VRouteElement, just like VRouter.routes, so you can nest as much as you want.''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        MyDartCodeViewer(
          code: r'''
VRouter(
  routes: [
    VStacked(
      path: '/topWidget', // This matches the path /topWiget
        widget: TopWidget(),
        subroutes: [
          VChild(
            path: 'profile', // This matches the path /topWidget/profile
            widget: ProfileWidget(),
          ),
          VChild(
            path: '/settings', // This matches the path /settings
            widget: SettingsWidget(),
          ),
        ]
    )
  ],
)
          ''',
        ),
        SizedBox(height: 10),
        SelectableText.rich(
          TextSpan(
            text: '''
Note that if a nested path starts with `/`, it will be matched as if it was a root path. 
This gives you the liberty to nest your widgets as you want without being restrained by your url structure.''',
            style: textStyle,
          ),
        )
      ],
    );
  }
}

class PathlessPageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText.rich(
          TextSpan(
            text: '''
Sometimes, you might find that you don’t want to give a path to your VRouteElement. For example if you only want to match the route if one of your subroutes path is matched.''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        MyDartCodeViewer(
          code: r'''
VRouter(
  routes: [
    VStacked(
      // No path, only if one of the subroutes path is match will this
      // route be displayed
        widget: TopWidget(),
        // No path so we must give a key for route animations
        key: ValueKey('TopWidget'),
        subroutes: [
          VChild(
            path: 'profile', // This matches the path /topWidget/profile
            widget: ProfileWidget(),
          ),
          VChild(
            path: '/settings', // This matches the path /settings
            widget: SettingsWidget(),
          ),
        ]
    )
  ],
)
          ''',
        ),
        SizedBox(height: 10),
        SelectableText.rich(
          TextSpan(
            text: '''
Note that if VStack does not have a path, you must give it a key. This key is used by flutter to handle the animations between the routes.

Stacking is great, but this section was meant to be about nesting. 
To achieve this, we will need the next section to introduction us to a new VRouteElement: VChild.''',
            style: textStyle,
          ),
        )
      ],
    );
  }
}
