import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

void main() {
  runApp(
    VRouter(
      debugShowCheckedModeBanner: false,
      initialUrl: '/user/bob',
      routes: [
        VWidget(path: '/user/:userId', widget: UserScreen()),

        // :_ designate a path parameter named "_"
        // In parentheses you can put any regexp, here .+ matches everything
        VRouteRedirector(path: ':_(.+)', redirectTo: '/user/bob'),
      ],
    ),
  );
}

class UserScreen extends StatelessWidget {
  final List<String> users = ['alice', 'bob', 'charlie'];

  @override
  Widget build(BuildContext context) {
    final name = context.vRouter.pathParameters['userId'];

    return Material(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Welcome $name'),
            SizedBox(height: 20),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  for (final user in users.where((user) => user != name))
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: ElevatedButton(
                        onPressed: () => context.vRouter.to('/user/$user'),
                        child: Text('Go to $user'),
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
