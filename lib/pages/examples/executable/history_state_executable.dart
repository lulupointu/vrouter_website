import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final count = int.parse(context.vRouter.historyState['count'] ?? '0');
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: OutlinedButton(
            onPressed: () => context.vRouter.to(
              context.vRouter.url,
              isReplacement: true,
              historyState: {'count': '${count + 1}'},
            ),
            child: Text('You clicked this button $count times'),
          ),
        ),
        SizedBox(height: 20),
        Flexible(
          child: ElevatedButton(
            onPressed: () => context.vRouter.to('/examples/history_state/other'),
            child: Text('Go to Other'),
          ),
        )
      ],
    );
  }
}

class OtherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: SizedBox(
          width: 400,
          child: Text(
            'Press the back button to go to the previous page and see that the count has been saved',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
