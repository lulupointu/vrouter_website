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

class HomeScreen extends BaseWidget {
  @override
  String get title => 'Home';

  @override
  String get buttonText => 'Go to Settings';

  @override
  String get pushTo => '/examples/basic_example/settings';
}

class SettingsScreen extends BaseWidget {
  @override
  String get title => 'Settings';

  @override
  String get buttonText => 'Go to Home';

  @override
  String get pushTo => '/examples/basic_example/';
}
