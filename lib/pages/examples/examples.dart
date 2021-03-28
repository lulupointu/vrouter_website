// import 'package:dart_pad_widget/dart_pad_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:vrouter_website/main.dart';
//
// class ExampleDescription extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SelectableText.rich(
//       TextSpan(
//         text: 'This is just an example',
//         style: textStyle,
//       ),
//     );
//   }
// }
//
// class ExamplePageSection extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (BuildContext context, BoxConstraints constraints) {
//         print('constraints.maxWidth: ${constraints.maxWidth}');
//         print('constraints.maxHeight: ${constraints.maxHeight}');
//
//         return DartPad(
//           key: Key('example1'),
//           width: constraints.maxWidth,
//           height: MediaQuery.of(context).size.height,
//           code: 'void main() => print("Hello DartPad Widget");',
//           flutter: true,
//           runImmediately: true,
//         );
//       },
//     );
//   }
// }
