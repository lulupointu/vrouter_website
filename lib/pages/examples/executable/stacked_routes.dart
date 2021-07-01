import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

void main() {
  runApp(
    VRouter(
      debugShowCheckedModeBanner: false,
      routes: [
        VWidget(
          path: '/',
          widget: HomeScreen(),
          // Use stackedRoutes to stack
          stackedRoutes: [
            // You will be able to pop from Settings on Home
            // Note that 'settings' does not start with '/', it's a relative path
            VWidget(path: 'settings', widget: SettingsScreen()),
          ],
        ),
      ],
    ),
  );
}

abstract class BaseWidget extends StatelessWidget {
  String get title;

  String get buttonText;

  String get to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
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
  String get to => '/examples/stacked_routes/settings';
}

class SettingsScreen extends BaseWidget {
  @override
  String get title => 'Settings';

  @override
  String get buttonText => 'Go to Home';

  @override
  String get to => '/examples/stacked_routes/';
}