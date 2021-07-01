import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return VRouter(
      debugShowCheckedModeBanner: false,
      routes: [
        VNester(
          path: null,
          widgetBuilder: (child) => MyScaffold(child: child, baseUrl: ''),
          nestedRoutes: [
            // Handles the systemPop event
            VPopHandler(
              onPop: (vRedirector) async {
                // DO check if going back is possible
                if (vRedirector.urlHistoryCanBack()) {
                  vRedirector.urlHistoryBack();
                }
              },
              stackedRoutes: [
                VWidget(path: null, widget: BasicScreen(title: 'home')),
                VWidget(path: 'social', widget: BasicScreen(title: 'social')),
                VWidget(path: 'settings', widget: BasicScreen(title: 'settings')),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class MyScaffold extends StatelessWidget {
  final Widget child;

  final String baseUrl;

  const MyScaffold({
    @required this.child,
    @required this.baseUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indexFromUrl(context),
        onTap: (index) => _navigateToIndex(context, index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(icon: Icon(Icons.supervisor_account_sharp), label: 'social'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'settings'),
        ],
      ),
    );
  }

  int _indexFromUrl(BuildContext context) {
    if (context.vRouter.url == baseUrl + '/') {
      return 0;
    } else if (context.vRouter.url == baseUrl + '/social') {
      return 1;
    } else if (context.vRouter.url == baseUrl + '/settings') {
      return 2;
    }

    throw 'Unknown url: ${context.vRouter.url}';
  }

  void _navigateToIndex(BuildContext context, int index) {
    final to = context.vRouter.to;
    switch (index) {
      case 0:
        return to(baseUrl + '/');
      case 1:
        return to(baseUrl + '/social');
      case 2:
        return to(baseUrl + '/settings');
    }
  }
}

class BasicScreen extends StatelessWidget {
  final String title;

  const BasicScreen({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: context.vRouter.urlHistoryCanBack() ? BackButton() : null,
      ),
      body: Center(
        child: SizedBox(
          width: 200,
          height: 50,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueAccent, width: 3),
            ),
            child: Center(
              child: Text('This is your $title'),
            ),
          ),
        ),
      ),
    );
  }
}
