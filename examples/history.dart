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
          widgetBuilder: (child) => MyScaffold(child: child),
          nestedRoutes: [
            // Handles the systemPop event
            VPopHandler(
              onSystemPop: (vRedirector) async {
                // DO check if going back is possible
                if (vRedirector.historyCanBack()) {
                  vRedirector.historyBack();
                }
              },
              stackedRoutes: [
                VWidget(
                    path: '/', widget: HomeScreen(title: 'Home', color: Colors.blueAccent)),
                VWidget(
                    path: '/social',
                    widget: BasicScreen(title: 'Social', color: Colors.greenAccent)),
                VWidget(
                    path: '/settings',
                    widget: BasicScreen(title: 'Settings', color: Colors.redAccent)),
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

  const MyScaffold({required this.child});

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
    switch (context.vRouter.url) {
      case '/':
        return 0;
      case '/social':
        return 1;
      case '/settings':
        return 2;
    }

    throw 'Unknown url: ${context.vRouter.url}';
  }

  void _navigateToIndex(BuildContext context, int index) {
    final to = context.vRouter.to;
    switch (index) {
      case 0:
        return to('/');
      case 1:
        return to('/social');
      case 2:
        return to('/settings');
    }
  }
}

class BasicScreen extends StatelessWidget {
  final String title;
  final Color color;
  final Widget? child;

  const BasicScreen({required this.title, required this.color, this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        leading: context.vRouter.historyCanBack()
            ? BackButton(onPressed: context.vRouter.historyBack)
            : null,
        actions: [
          if (context.vRouter.historyCanForward())
            Transform.rotate(
              angle: 3.14,
              child: BackButton(onPressed: context.vRouter.historyForward),
            ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 200,
              height: 50,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: color, width: 3),
                ),
                child: Center(
                  child: Text('This is your ${title.toLowerCase()}'),
                ),
              ),
            ),
            if (child != null) ...[SizedBox(height: 20), child!],
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final String title;
  final Color color;

  const HomeScreen({required this.title, required this.color});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return BasicScreen(
      title: widget.title,
      color: widget.color,
      // VNavigationGuard allows you to react to navigation events locally
      child: VWidgetGuard(
        // When entering or updating the route, we try to get the count from the history state
        // This history state will be restored when using historyBack to go back here
        afterEnter: (context, __, ___) => getCountFromState(context),
        child: ElevatedButton(
          style: buttonStyle,
          onPressed: () {
            VRouter.of(context).to(
              context.vRouter.url,
              isReplacement: true, // We use replacement to override the history entry
              historyState: {'count': '${count + 1}'},
            );
            setState(() => count++);
          },
          child: Text(
            'Your pressed this button $count times',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }

  void getCountFromState(BuildContext context) {
    setState(() => count = int.parse(VRouter.of(context).historyState['count'] ?? '0'));
  }

  final buttonStyle = ButtonStyle(
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
    ),
    padding: MaterialStateProperty.all(
      EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
    ),
  );
}