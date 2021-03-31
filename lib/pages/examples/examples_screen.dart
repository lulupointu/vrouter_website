import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';
import 'package:vrouter_website/in_app_page.dart';
import 'package:vrouter_website/main.dart';

class ExamplesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VRouterLogo(),
          Container(height: 1, color: separatorColor),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Examples', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                  SizedBox(height: 30),
                  ExampleButton(underscoreName: 'basic_example'),
                  ExampleButton(underscoreName: 'history_state'),
                  ExampleButton(underscoreName: 'nesting'),
                  ExampleButton(underscoreName: 'path_parameters'),
                  ExampleButton(underscoreName: 'redirection'),
                  ExampleButton(underscoreName: 'transitions'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ExampleButton extends StatelessWidget {
  final String underscoreName;
  final String prettifiedName;

  ExampleButton({Key key, @required this.underscoreName})
      : prettifiedName = underscoreName
            .replaceAllMapped(
              RegExp('(^[a-z]|(?<=_)[a-z])'), // Matching the first letters
              (match) => match.group(0).toUpperCase(),
            )
            .replaceAll('_', ' '),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 100,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: ElevatedButton(
          onPressed: () => context.vRouter.push('/examples/$underscoreName/'),
          child: Text(prettifiedName),
        ),
      ),
    );
  }
}
