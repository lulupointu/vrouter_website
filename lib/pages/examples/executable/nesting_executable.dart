import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

abstract class BaseWidget extends StatelessWidget {
  String get title;

  String get buttonText;

  String get pushTo;

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
              onPressed: () => context.vRouter.push(pushTo),
              child: Text(buttonText),
            ),
          ],
        ),
      ),
    );
  }
}

class MyScaffold extends StatelessWidget {
  final Widget child;

  const MyScaffold(this.child);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: context.vRouter.url.contains('settings') ? 1 : 0,
        onTap: (value) => context.vRouter.push((value==0) ? '/examples/nesting/' : '/examples/nesting/settings'),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
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
  String get pushTo => '/examples/nesting/settings';
}

class SettingsScreen extends BaseWidget {
  @override
  String get title => 'Settings';

  @override
  String get buttonText => 'Go to Home';

  @override
  String get pushTo => '/examples/nesting/';
}
