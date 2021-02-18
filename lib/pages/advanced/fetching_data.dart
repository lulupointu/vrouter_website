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
When the user presses a button, you will be able to use the beforeEnter method (of the VRouter of a VRouteElement) to fetch data.''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        MyDartCodeViewer(
          code: r'''
VRouter(
  beforeEnter: (context, from, to) async {
    final isUserConnected = await database.isUserConnected();
    if (!isUserConnected) {
      VRouterData.of(context).push('/login');
      // If we redirect, we return false
      return false;
    }
    return true;
  },
  routes: [
    VStacked(
      // The path /login has no data fetching
      path: '/login',
      widget: LoginWidget(),
      subroutes: [
        VStacked(
          path: 'profile',
          // The path /login/profile fetches data
          beforeEnter: (context, from, to) async {
            await database.getUserInfo();
            return true;
          },
          widget: ProfileWidget(),
        )
      ],
    ),
  ],
)
          ''',
        ),
        SizedBox(height: 10),
        SelectableText.rich(
          TextSpan(
            text: '''
This will have the effect of staying on the actual page until you have the data before navigating. Therefore you might want to display a progress bar of some sort, and also an error message in case the data fetch fails.''',
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
            text: '''
This approach first loads the widgets of the tree, then fetches the data you need. You can use the afterEnter or the afterUpdate method, either in the VRouter, a VRouteElement, or a VNavigationGuard.''',
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
    VStacked(
      // The path /login has no data fetching
      path: '/login',
      widget: LoginWidget(),
      subroutes: [
        VStacked(
          path: 'profile/:userId',
          // The path /login/profile fetches data after loading
          afterEnter: (context, from, to) {
            // You have access to the new queryParameters and pathParameters
            database.getUserInfo(userId: VRouteData.of(context).pathParameters['userId']);
          },
          widget: ProfileWidget(),
        )
      ],
    ),
  ],
)
          ''',
        ),
        SizedBox(height: 10),
        Text('ProfileWidget:', style: textStyle.copyWith(fontWeight: FontWeight.bold),),
        MyDartCodeViewer(
          code: r'''
class ProfileWidget extends StatefulWidget {
  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}
class _ProfileWidgetState extends State<ProfileWidget> {
  int userId;

  @override
  Widget build(BuildContext context) {
    return VNavigationGuard(
      // You can access local information from VRouteElementData
      afterUpdate: (context, from, to) => setState(
          () => userId = int.parse(VRouteElementData.of(context).pathParameters['userId'])),
      afterEnter: (context, from, to) => setState(
          () => userId = int.parse(VRouteElementData.of(context).pathParameters['userId'])),
      child: Text('Profile of user $userId'),
    );
  }
}
          ''',
        ),
        SizedBox(height: 10),
        SelectableText.rich(
          TextSpan(
            text: '''
Note that with this approach, some of your widget will have missing data while loading so you might want to take that into account.''',
            style: textStyle,
          ),
        ),
      ],
    );
  }
}


