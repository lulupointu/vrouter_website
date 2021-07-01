import 'package:flutter/material.dart';
import 'package:vrouter_website/main.dart';

class CustomVRouteElementAndScalingDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      TextSpan(
        text: '''
Creating you own widget allows you to:
    • Create reusable widgets
    • Separate widget for specific screen/part of the screen

Creating your own VRouteElement allows you to do the same for routes.''',
        style: textStyle,
      ),
    );
  }
}

class CustomVRouteElementDescriptionPageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText.rich(
          TextSpan(
            text:
            '''To create a custom VRouteElement, extend a VRouteElementBuilder, implement its buildRoutes method and you are good to go!''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        MyDartCodeViewer(
          code: r'''
class HomeRoute extends VRouteElementBuilder {
  static String home = '/home';

  @override
  List<VRouteElement> buildRoutes() {
    return [
      VGuard(
        // LoginRoute.login = '/login' for example
        beforeEnter: (vRedirector) async =>
            !isLoggedIn ? vRedirector.to(LoginRoute.login) : null,
        stackedRoutes: [
          VWidget(path: home, widget: HomeScreen()),
        ],
      ),
    ];
  }
}
          ''',
        ),
        SelectableText.rich(
          TextSpan(
            text:
            '''Then use it as any VRouteElement:''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        MyDartCodeViewer(
          code: r'''
VRouter(
  routes: [
    HomeRoute(),
  ],
)
          ''',
        ),
        SelectableText.rich(
          TextSpan(
            text:
            '''And navigate as you usually do:''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        MyDartCodeViewer(
          code: r'''
context.vRouter.to(HomeRoute.home);
          ''',
        ),
        SizedBox(height: 10),
        SelectableText.rich(
          TextSpan(
            text:
                '''Note the use of static String, this is very useful to avoid String typos.''',
            style: textStyle,
          ),
        ),
      ],
    );
  }
}

class ScalingDescriptionPageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText.rich(
          TextSpan(
            text: '''
Here is an example of a shopping app with and without the use of VRouteElementBuilder.''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        SelectableText.rich(
          TextSpan(
              text: '''Without''',
              style: textStyle.copyWith(fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: ''' VRouteElementBuilder:''',
                  style: textStyle,
                ),
              ]),
        ),
        MyDartCodeViewer(
          code: r'''
VRouter(
  routes: [
    VNester(
      path: null,
      widgetBuilder: (child) => MyScaffold(body: child),
      nestedRoutes: [
        VWidget(
            path: '/shop',
            widget: HomeScreen(),
            aliases: ['/shop/order'],
            key: ValueKey('Shop')),
        VWidget(
            path: '/profile',
            widget: ProfileScreen(),
            aliases: ['/profile/settings'],
            key: ValueKey('Profile')),
      ],
      stackedRoutes: [
        VPopHandler(
          onPop: (vRedirector) async => vRedirector.to('/shop'),
          stackedRoutes: [
            VWidget(path: '/shop/order', widget: ShopScreen()),
          ],
        ),
        VPopHandler(
          onPop: (vRedirector) async => vRedirector.to('/profile'),
          stackedRoutes: [
            VWidget(path: '/profile/settings', widget: SettingsScreen()),
          ],
        ),
      ],
    ),
  ],
)
          ''',
        ),
        SizedBox(height: 10),
        SelectableText.rich(
          TextSpan(
              text: '''With''',
              style: textStyle.copyWith(fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: ''' VRouteElementBuilder:''',
                  style: textStyle,
                ),
              ]),
        ),
        MyDartCodeViewer(
          code: r'''
main() {
  runApp(
    VRouter(
      routes: [
        ShopRoute(),
        ProfileRoute(),
      ],
    ),
  );
}

class ShopRoute extends VRouteElementBuilder {
  static final String shop = '/shop';
  static final String order = shop + '/order';

  @override
  List<VRouteElement> buildRoutes() {
    return [
      ScaffoldRouteElement(
        path: shop,
        nestedRoute: VWidget(path: null, aliases: [order], widget: HomeScreen(), key: ValueKey('Shop')),
        stackedRoute: VWidget(path: order, widget: ShopScreen()),
      )
    ];
  }
}

class ProfileRoute extends VRouteElementBuilder {
  static final String profile = '/profile';
  static final String settings = profile + '/settings';

  @override
  List<VRouteElement> buildRoutes() {
    return [
      ScaffoldRouteElement(
        path: profile,
        nestedRoute: VWidget(path: null, aliases: [settings], widget: ProfileScreen(), key: ValueKey('Profile')),
        stackedRoute: VWidget(path: settings, widget: SettingsScreen()),
      )
    ];
  }
}

class ScaffoldRouteElement extends VRouteElementBuilder {
  static final navigatorKey = GlobalKey<NavigatorState>();

  final String path;
  final VRouteElement nestedRoute;
  final VRouteElement stackedRoute;

  ScaffoldRouteElement({required this.path, required this.nestedRoute, required this.stackedRoute});

  @override
  List<VRouteElement> buildRoutes() {
    return [
      VNester(
        key: ValueKey('MyScaffold'),
        navigatorKey: navigatorKey,
        path: path,
        widgetBuilder: (child) => MyScaffold(body: child),
        nestedRoutes: [nestedRoute],
        stackedRoutes: [stackedRoute],
      )
    ];
  }
}
          ''',
        ),
        SizedBox(height: 10),
        SelectableText.rich(
          TextSpan(
            text: '''Here are some of the issues that have been fixed:
    • Create VRouteElement specific to our routes
    • Use static String attached to meaningful classes to organise ourselves
    • Remove VPopHandler since the path is now in VNester so can be inferred by pop
    • Create a reusable VRouteElement: ScaffoldRouteElement

Something interesting here is how we duplicated VNester while keeping the animations the same (i.e. only the inside of the scaffold changes between ProfileScreen and ShopScreen):
    1. Use a key for VNester, so that MyScaffold doesn't animate when the path changes from ‘/profile’ to ‘/shop’ and vise versa
    2. Use a unique GlobalKey which allows the body of MyScaffold animates properly

That’s it ! With this example in mind you can scale your app as much as you want!''',
            style: textStyle,
          ),
        )
      ],
    );
  }
}
