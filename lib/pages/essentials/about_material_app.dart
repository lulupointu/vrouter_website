import 'package:flutter/material.dart';
import 'package:vrouter_website/main.dart';

class AboutMaterialAppDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText.rich(
          TextSpan(
            text: '''
The default MaterialApp uses navigator 1.0, and VRouter uses navigator 2.0, so for the moment, using MaterialApp will crash your app.

Using MaterialApp.router would be the solution, since it uses navigator 2.0. However there are 2 drawbacks:
    • If you badly setup MaterialApp.router, it might break VRouter
    • It requires you to write a lot of code
    
The solution is to use VMaterialApp. It uses MaterialApp.router under the hood and sets it up so that it does not interfere with VRouter.''',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        MyDartCodeViewer(
          code: r'''
VMaterialApp(
  // Use MaterialApp properties as you normally would
  theme: ThemeData(...),
  // Just provide a child as any other widget
  child: YourChildWidget(),
)
          ''',
        ),
      ],
    );
  }
}
