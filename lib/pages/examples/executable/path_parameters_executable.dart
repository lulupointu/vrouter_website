import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

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
                        onPressed: () =>
                            context.vRouter.to('/examples/path_parameters/user/$user'),
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
