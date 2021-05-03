import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

void main() {
  runApp(
    VRouter(
      debugShowCheckedModeBanner: false,
      routes: [
        VWidget(path: '/', widget: CounterScreen()),
        VWidget(path: '/other', widget: OtherScreen()),
      ],
    ),
  );
}

class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int count = int.parse(context.vRouter.historyState['count'] ?? '0');
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: OutlinedButton(
            onPressed: () => context.vRouter.replaceHistoryState({'count': '${count + 1}'}),
            child: Text('You clicked this button $count times'),
          ),
        ),
        SizedBox(height: 20),
        Flexible(
          child: ElevatedButton(
            onPressed: () => context.vRouter.push('/other'),
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