import 'package:flutter/material.dart';

import '../../main.dart';

class InstallationDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      TextSpan(
        text: 'Installing VRouter is the some as installing any other Flutter package, with no'
            'additional configuration needed.',
        style: textStyle,
      ),
    );
  }
}

class AddDependencyPageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText.rich(
          TextSpan(
            text: 'Add this to your package\'s pubspec.yaml file:',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        MyDartCodeViewer(
          code: r'''
dependencies:
  vrouter: ^1.1.0
          ''',
        ),
      ],
    );
  }
}

class InstallPageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText.rich(
          TextSpan(
            text: 'You can install packages from the command line:',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        MyDartCodeViewer(
          code: r'''
flutter pub get
          ''',
        ),
      ],
    );
  }
}

class ImportPageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText.rich(
          TextSpan(
            text: 'Now in your Dart code, you can use:',
            style: textStyle,
          ),
        ),
        SizedBox(height: 10),
        MyDartCodeViewer(
          code: r'''
import 'package:vrouter/vrouter.dart';
          ''',
        ),
      ],
    );
  }
}
