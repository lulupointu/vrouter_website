import 'package:clipboard/clipboard.dart';
import 'package:vrouter/vrouter.dart';
import 'package:dart_code_viewer/dart_code_viewer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home_page.dart';
import 'in_app_page.dart';

void main() {
  runApp(
    VRouter(
      title: 'Router',
      debugShowCheckedModeBanner: false,
      mode: VRouterModes.history,
      buildTransition: (animation, __, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      routes: [
        VStacked(widget: HomePage(), path: '/'),
        VStacked(
            path: '/guide/:mainSection/:subSection/:pageSection',
            name: 'guide',
            widget: InAppPage(),
            aliases: ['/guide', '/guide/:mainSection', '/guide/:mainSection/:subSection']),
        VRouteRedirector(path: ':_(.*)', redirectTo: '/'),
      ],
    ),
  );
}

Size getTextSize(String text, TextStyle style, {double maxWidth = double.infinity}) {
  final textPainter =
      TextPainter(text: TextSpan(text: text, style: style), textDirection: TextDirection.ltr)
        ..layout(minWidth: 0, maxWidth: maxWidth);
  return textPainter.size;
}

class MyDartCodeViewer extends StatelessWidget {
  final String code;
  final backgroundColor = const Color(0xFF282C34);
  final fontSize = 16.0;

  MyDartCodeViewer({Key key, @required String code})
      : code = code.replaceAll('  ', '      '),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16.0, bottom: 0.0, left: 8.0, right: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        color: backgroundColor,
      ),
      child: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          children: [
            DartCodeViewer(
              code,
              showCopyButton: false,
              backgroundColor: backgroundColor,
              baseStyle: GoogleFonts.ubuntu(
                  textStyle: TextStyle(
                      fontSize: fontSize,
                      color: Color(0xFFc5c8c6),
                      fontWeight: FontWeight.w400,
                      height: 1.4)),
              punctuationStyle: GoogleFonts.ubuntu(
                  textStyle: TextStyle(
                      fontSize: fontSize,
                      color: Color(0xFFc5c8c6),
                      fontWeight: FontWeight.w400,
                      height: 1.4)),
              constantStyle: GoogleFonts.ubuntu(
                  textStyle: TextStyle(
                      fontSize: fontSize,
                      color: Color(0xFF81a2be),
                      fontWeight: FontWeight.w400,
                      height: 1.4)),
              numberStyle: GoogleFonts.ubuntu(
                  textStyle: TextStyle(
                      fontSize: fontSize,
                      color: Color(0xFF81a2be),
                      fontWeight: FontWeight.w400,
                      height: 1.4)),
              keywordStyle: GoogleFonts.ubuntu(
                  textStyle: TextStyle(
                      fontSize: fontSize,
                      color: Color(0xFFb294bb),
                      fontWeight: FontWeight.w400,
                      height: 1.4)),
              commentStyle: GoogleFonts.ubuntu(
                  textStyle: TextStyle(
                      fontSize: fontSize,
                      color: Color(0xFF969896),
                      fontWeight: FontWeight.w400,
                      height: 1.4)),
              stringStyle: GoogleFonts.ubuntu(
                  textStyle: TextStyle(
                      fontSize: fontSize,
                      color: Color(0xFF618658),
                      fontWeight: FontWeight.w400,
                      height: 1.4)),
              classStyle: GoogleFonts.ubuntu(
                  textStyle: TextStyle(
                      fontSize: fontSize,
                      color: Color(0xFFde935f),
                      fontWeight: FontWeight.w400,
                      height: 1.4)),
              height: getTextSize(
                code,
                GoogleFonts.ubuntu(textStyle: TextStyle(fontSize: fontSize, height: 1.4)),
                maxWidth: constraints.maxWidth - 40, // 40 is DartCodeViewer internal padding
              ).height,
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Color(0xFF015292), padding: EdgeInsets.all(16.0)),
                  onPressed: () {
                    FlutterClipboard.copy(code);
                  },
                  child: Text(
                    'Copy all',
                    style: GoogleFonts.ubuntu(
                        textStyle: TextStyle(fontSize: fontSize, color: Color(0xFF00afff))),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

final textStyle = GoogleFonts.ubuntu(
  textStyle: TextStyle(
    fontSize: 16,
    height: 1.7,
  ),
);

final linkStyle = GoogleFonts.ubuntu(
  textStyle: TextStyle(
    fontSize: 16,
    color: Color(0xFF00afff),
    decoration: TextDecoration.underline,
  ),
);

final separatorColor = Colors.black12;

class MyScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
