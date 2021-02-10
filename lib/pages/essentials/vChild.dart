import 'package:flutter/material.dart';
import 'package:vrouter_website/main.dart';



class VChildDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return         SelectableText.rich(
      TextSpan(
        text: '''What we have seen so far can get you a long way, but does not really embrace fully the nested structure of Flutter. Indeed, with VStack, we can display some widget on top of each other as much as we want, but what if we want to put a widget inside a widget. This is what VChild is for.''',
        style: textStyle,
      ),
    );
  }
}

class VChildBasicsPageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText.rich(
          TextSpan(
            text: '''
VChild is a VRouteElement, so you will be using it in subroutes. And use it pretty much as VStack.
However, since VChild is not stacked, we don’t know where to place it. So you will have to place it yourself wherever you want. To achieve so, you have access to this widget using VRouteElementData.of(context).vChild. This is only accessible in a context below the one where you placed the VChild.''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        Text('Router configuration:', style: textStyle.copyWith(fontWeight: FontWeight.bold),),
        MyDartCodeViewer(
          code: r'''
VRouter(
  routes: [
    VStacked(
        // No path, only if one of the subroutes path is match will this
        // route be displayed
        widget: MyScaffold(),
        // No path so we must give a key for route animations
        key: ValueKey('MyScaffold'),
        subroutes: [
          // Here we use VChild because we want to nest not stack
          VChild(
            path: '/profile', // This matches the path /profile
            widget: ProfileWidget(),
          ),
          VChild(
            path: '/settings', // This matches the path /settings
            widget: SettingsWidget(),
          ),
        ])
  ],
)
          ''',
        ),
        Text('MyScaffold:', style: textStyle.copyWith(fontWeight: FontWeight.bold),),
        MyDartCodeViewer(
          code: r'''
class MyScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('VChild named example')),
      // HERE we access the vChild
      body: VRouteElementData.of(context).vChild,
    );
  }
}
          ''',
        ),
        SizedBox(height: 10),
        SelectableText.rich(
          TextSpan(
            text: '''
We can see that we nest the VChild inside a VStack which has a MyScaffold widget. So in MyScaffold we have access to the VChild widget by using VRouteElementData.of(context).vChild.''',
            style: textStyle,
          ),
        )
      ],
    );
  }
}

class IdentifyAVChildPageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText.rich(
          TextSpan(
            text: '''
VChild can be accessed through VRouteElementData.of(context).vChild, but the issue is, this vChild is not directly the widget you gave in the VChild’s widget argument. So it might be hard to identify it. In order to fix this, you can use VRouteElementData.of(context).vChildName, which value will be the same as the VChild name attribute. 
An obvious case where this happens, is when you have a scaffold where you have a vChild as a body but you need to keep its bottom navigation bar in sync. Here is an example on how you can achieve this:''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        Text('Router configuration:', style: textStyle.copyWith(fontWeight: FontWeight.bold),),
        MyDartCodeViewer(
          code: r'''
VRouter(
  routes: [
    VStacked(
      // No path, only if one of the subroutes path is match will this
      // route be displayed
        widget: MyScaffold(),
        // No path so we must give a key for route animations
        key: ValueKey('MyScaffold'),
        subroutes: [
          // Here we use VChild because we want to nest not stack
          VChild(
            path: '/profile', // This matches the path /profile
            name: 'profile', // Here we give it a name
            widget: ProfileWidget(),
          ),
          VChild(
            path: '/settings', // This matches the path /settings
            name: 'settings', // Here we give it a name
            widget: SettingsWidget(),
          ),
        ])
  ],
)
          ''',
        ),
        Text('MyScaffold:', style: textStyle.copyWith(fontWeight: FontWeight.bold),),
        MyDartCodeViewer(
          code: r'''
class MyScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('VChild named example')),
      bottomNavigationBar: BottomNavigationBar(

        // Here we can access the name of the vChild
        currentIndex: VRouteElementData.of(context).vChildName == 'profile' ? 0 : 1,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: 'Settings'),
        ],
      ),
      body: VRouteElementData.of(context).vChild,
    );
  }
}
          ''',
        ),
      ],
    );
  }
}


