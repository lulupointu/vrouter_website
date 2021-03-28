import 'package:flutter/material.dart';
import 'package:vrouter_website/main.dart';

class DataFetchingDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return         SelectableText.rich(
      TextSpan(
        text: '''
You might need to fetch data to display in a route. This can be achieved in two different ways: before navigation or after navigation.''',
        style: textStyle,
      ),
    );
  }
}

class FetchingDataBeforeNavigationPageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText.rich(
          TextSpan(
            text: '''
When the user presses a button, you will be able to use the beforeEnter method (of VRouter or VGuard) to fetch data.''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        MyDartCodeViewer(
          code: r'''
VRouter(
  beforeEnter: (vRedirector) async {
    final isUserConnected = await database.isUserConnected();
    if (!isUserConnected && vRedirector.to != 'login') {
      vRedirector.push('/login'); // Use VRedirector to redirect
    }
  },
  routes: [
    VWidget(
      // The path /login has no data fetching
      path: '/login',
      widget: LoginScreen(),
      stackedRoutes: [
        VGuard(
          // The sub paths (here /login/profile) fetches data before being displayed
          beforeEnter: (vRedirector) async => await database.getUserInfo(),
          stackedRoutes: [
            VWidget(
              path: 'profile',
              widget: ProfileScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
)
          ''',
        ),
        SizedBox(height: 10),
        SelectableText.rich(
          TextSpan(
            text: '''This will have the effect of staying on the actual page until you have the data before navigating. Therefore you might want to display a progress bar of some sort, and also an error message in case the data fetch fails. ''',
            style: textStyle,
          ),
        ),
      ],
    );
  }
}

class FetchingDataAfterNavigationPageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText.rich(
          TextSpan(
            text: '''This approach first loads the widgets of the tree, then fetches the data you need. You can use the afterEnter or the afterUpdate method, either in the VRouter, a VGuard, or a VWidgetGuard.''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        Text('Router configuration:', style: textStyle.copyWith(fontWeight: FontWeight.bold),),
        MyDartCodeViewer(
          code: r'''
VRouter(
  afterEnter: (context, from, to) {
    // Always fetch this data after entering
    database.increaseLoadCount();
  },
  routes: [
    VWidget(
      // The path /login has no data fetching
      path: '/login',
      widget: LoginScreen(),

      // The sub paths (here /login/profile) fetches data after being displayed
      stackedRoutes: [
        VGuard(
          afterEnter: (context, from, to) {
            // You have access to the new queryParameters and pathParameters
            database.getUserInfo(userId: context.vRouter.pathParameters['userId']);
          },
          stackedRoutes: [
            VWidget(
              path: 'profile/:userId',
              widget: ProfileScreen(),
            )
          ],
        )
      ],
    ),
  ],
)
          ''',
        ),
        SizedBox(height: 10),
        Text('ProfileScreen:', style: textStyle.copyWith(fontWeight: FontWeight.bold),),
        MyDartCodeViewer(
          code: r'''
class ProfileScreen extends StatefulWidget {
  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  int userId;

  @override
  Widget build(BuildContext context) {
    return VWidgetGuard(
      afterUpdate: (context, from, to) => setState(
          () => userId = int.parse(context.vRouter.pathParameters['userId'])),
      afterEnter: (context, from, to) => setState(
          () => userId = int.parse(context.vRouter.pathParameters['userId'])),
      child: Text('Profile of user $userId'),
    );
  }
}
          ''',
        ),
        SizedBox(height: 10),
        SelectableText.rich(
          TextSpan(
            text: '''Note that with this approach, some of your widget will have missing data when being first displayed so you might want to take that into account.''',
            style: textStyle,
          ),
        ),
      ],
    );
  }
}


