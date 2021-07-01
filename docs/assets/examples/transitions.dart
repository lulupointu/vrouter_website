import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

void main() {
  runApp(
    VRouter(
      debugShowCheckedModeBanner: false,
      routes: [
        // You can use buildTransition to create a transition
        VWidget(
          path: '/',
          widget: HomeScreen(),
          transitionDuration: Duration(seconds: 1),
          buildTransition: (animation, _, child) => ScaleTransition(
            scale: animation,
            child: child,
          ),
        ),

        // Or you can create your own Page with the animation inside
        VPage(
          path: '/settings',
          widget: SettingsScreen(),
          pageBuilder: (LocalKey key, Widget child, String name) =>
              AnimatedPage(child, key, name),
        ),
      ],
    ),
  );
}

class AnimatedPage extends Page {
  final Widget child;

  AnimatedPage(this.child, LocalKey key, String name) : super(key: key, name: name);

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (_, animation, __) => RotationTransition(
        turns: animation,
        child: child,
      ),
    );
  }
}

abstract class BaseWidget extends StatelessWidget {
  String get title;

  String get buttonText;

  String get to;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () => context.vRouter.to(to),
              child: Text(buttonText),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends BaseWidget {
  @override
  String get title => 'Home';

  @override
  String get buttonText => 'Go to Settings';

  @override
  String get to => '/settings';
}

class SettingsScreen extends BaseWidget {
  @override
  String get title => 'Settings';

  @override
  String get buttonText => 'Go to Home';

  @override
  String get to => '/';
}
