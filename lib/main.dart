import 'dart:math';

import 'package:clipboard/clipboard.dart';
import 'package:vrouter/vrouter.dart';
import 'package:dart_code_viewer/dart_code_viewer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vrouter_website/left_navigation_bar.dart';
import 'package:vrouter_website/pages/examples/examples_screen.dart';
import 'package:vrouter_website/pages/examples/navigator_wrapper.dart';

import 'home_page.dart';
import 'in_app_page.dart';

import 'package:vrouter_website/pages/examples/executable/basic_example_executable.dart'
    as basic_example;
import 'package:vrouter_website/pages/examples/executable/history_state_executable.dart'
    as history_state;
import 'package:vrouter_website/pages/examples/executable/nesting_executable.dart' as nesting;
import 'package:vrouter_website/pages/examples/executable/redirection_executable.dart'
    as redirection;
import 'package:vrouter_website/pages/examples/executable/transitions_executable.dart'
    as transitions;
import 'package:vrouter_website/pages/examples/executable/path_parameters_executable.dart'
    as path_parameters;

final Widget Function(Animation<double>, Animation<double>, Widget) fadeTransition =
    (animation, __, child) {
  return FadeTransition(
    opacity: animation,
    child: child,
  );
};

void main() {
  runApp(
    VRouter(
      title: 'Router',
      debugShowCheckedModeBanner: false,
      mode: VRouterModes.history,
      beforeEnter: (vRedirector) async => print(vRedirector.to),
      routes: [
        // Home
        VWidget(widget: HomePage(), path: '/', buildTransition: fadeTransition),

        // Guide
        GuideRoute(),

        // Examples
        ExampleRoute(),

        // Redirection
        VRouteRedirector(path: ':_(.*)', redirectTo: '/'),
      ],
    ),
  );
}

class GuideRoute extends VRouteElementBuilder {
  static void toMainSection(
    BuildContext context, {
    @required MainSection mainSection,
  }) =>
      context.vRouter.pushSegments(['guide', mainSection.title]);

  static void toSubSection(
    BuildContext context, {
    @required SubSection subSection,
  }) {
    final mainSection = InAppPage.sections
        .firstWhere((mainSection) => mainSection.subSections.contains(subSection));
    context.vRouter.pushSegments(['guide', mainSection.title, subSection.title]);
  }

  static void toPageSection(
    BuildContext context, {
    @required PageSection pageSection,
  }) {
    SubSection subSection;
    for (var mainSection in InAppPage.sections) {
      final subSectionIndex = mainSection.subSections.indexWhere(
        (subSections) => subSections.pageSections.contains(pageSection),
      );
      if (subSectionIndex != -1) {
        subSection = mainSection.subSections[subSectionIndex];
        break;
      }
    }

    final mainSection = InAppPage.sections
        .firstWhere((mainSection) => mainSection.subSections.contains(subSection));

    context.vRouter
        .pushSegments(['guide', mainSection.title, subSection.title, pageSection.title]);
  }

  static void toSectionFromTitle(
    BuildContext context, {
    @required String mainSectionTitle,
    String subSectionTitle,
    String pageSectionTitle,
  }) {
    context.vRouter.pushSegments([
      'guide',
      mainSectionTitle,
      if (subSectionTitle != null) ...[
        subSectionTitle,
        if (pageSectionTitle != null) pageSectionTitle
      ]
    ]);
  }

  @override
  List<VRouteElement> buildRoutes() {
    return [
      VWidget(
        path: '/guide',
        widget: InAppPage.fromMainSection(mainSection: InAppPage.sections.first),
      ),
      for (var mainSection in InAppPage.sections) ...[
        VWidget(
          path: '/guide/${Uri.encodeComponent(mainSection.title)}',
          name: 'guide',
          widget: InAppPage.fromMainSection(mainSection: mainSection),
          buildTransition: fadeTransition,
        ),
        for (var subSection in mainSection.subSections) ...[
          VGuard(
            afterEnter: (_, __, ___) => Scrollable.ensureVisible(
              subSection.titleKey.currentContext,
              duration: Duration(milliseconds: 300),
            ),
            stackedRoutes: [
              VWidget(
                path:
                    '/guide/${Uri.encodeComponent(mainSection.title)}/${Uri.encodeComponent(subSection.title)}',
                name: 'guide',
                key: ValueKey(subSection.title),
                widget:
                    InAppPage.fromSubSection(mainSection: mainSection, subSection: subSection),
                buildTransition: fadeTransition,
              )
            ],
          ),
          for (var pageSection in subSection.pageSections) ...[
            VGuard(
              afterEnter: (_, __, ___) => Scrollable.ensureVisible(
                pageSection.titleKey.currentContext,
                duration: Duration(milliseconds: 300),
              ),
              stackedRoutes: [
                VWidget(
                  path:
                      '/guide/${Uri.encodeComponent(mainSection.title)}/${Uri.encodeComponent(subSection.title)}/${Uri.encodeComponent(pageSection.title)}',
                  name: 'guide',
                  key: ValueKey(subSection.title),
                  widget: InAppPage(
                    mainSection: mainSection,
                    subSection: subSection,
                    pageSection: pageSection,
                  ),
                  buildTransition: fadeTransition,
                )
              ],
            )
          ]
        ]
      ],
    ];
  }
}

class ExampleRoute extends VRouteElementBuilder {
  @override
  List<VRouteElement> buildRoutes() {
    return [
      VWidget(
        path: '/examples/all',
        widget: ExamplesScreen(),
        stackedRoutes: [
          VNester(
            path: '/examples',
            widgetBuilder: (child) => NavigatorWrapper(child: child),
            nestedRoutes: examplesRoutes,
          ),
        ],
      )
    ];
  }
}

final examplesRoutes = [
  // Basic example
  VWidget(path: 'basic_example/', widget: basic_example.HomeScreen()),
  VWidget(path: 'basic_example/settings', widget: basic_example.SettingsScreen()),
  VRouteRedirector(path: r'basic_example:_(.*)', redirectTo: '/examples/basic_example/'),

  // History state
  VWidget(path: 'history_state/', widget: history_state.CounterScreen()),
  VWidget(path: 'history_state/other', widget: history_state.OtherScreen()),
  VRouteRedirector(path: r'history_state:_(.*)', redirectTo: '/examples/history_state/'),

  // Nesting
  VNester(
    path: 'nesting/',
    widgetBuilder: (child) => nesting.MyScaffold(child),
    // Child is the widget from nestedRoutes
    nestedRoutes: [
      VWidget(path: null, widget: nesting.HomeScreen()), // null path matches parent
      VWidget(path: 'settings', widget: nesting.SettingsScreen()),
    ],
  ),
  VRouteRedirector(path: r'nesting:_(.*)', redirectTo: '/examples/nesting/'),

  // Redirection
  VWidget(path: 'redirection/login', widget: redirection.LoginScreen(redirection.login)),
  VGuard(
    beforeEnter: (vRedirector) async =>
        redirection.isLoggedIn ? null : vRedirector.push('/examples/redirection/login'),
    stackedRoutes: [
      VWidget(path: 'redirection/home', widget: redirection.HomeScreen(redirection.logout))
    ],
  ),
  VRouteRedirector(path: r'redirection/:_(.*)', redirectTo: '/examples/redirection/home'),

  // Transitions
  VWidget(
    path: 'transitions/',
    widget: transitions.HomeScreen(),
    transitionDuration: Duration(seconds: 1),
    buildTransition: (animation, _, child) => ScaleTransition(
      scale: animation,
      child: child,
    ),
  ),
  VPage(
    path: 'transitions/settings',
    widget: transitions.SettingsScreen(),
    pageBuilder: (LocalKey key, Widget child, String name) =>
        transitions.AnimatedPage(child, key, name),
  ),
  VRouteRedirector(path: r'transitions:_(.*)', redirectTo: '/examples/transitions/'),

  // Url parameters
  VWidget(path: 'path_parameters/user/:userId', widget: path_parameters.UserScreen()),
  VGuard(
    beforeEnter: (vRedirector) async => vRedirector.push('/examples/path_parameters/user/bob'),
    stackedRoutes: [VWidget(path: 'path_parameters', widget: Container())],
  ),
  VRouteRedirector(path: r'path_parameters:_(.*)', redirectTo: '/examples/path_parameters'),
];

Size getTextSize(String text, TextStyle style, {double maxWidth = double.infinity}) {
  final textPainter =
      TextPainter(text: TextSpan(text: text, style: style), textDirection: TextDirection.ltr)
        ..layout(minWidth: 0, maxWidth: maxWidth);
  return textPainter.size;
}

class MyDartCodeViewer extends StatelessWidget {
  final String code;
  static final backgroundColor = const Color(0xFF282C34);
  final bool roundedEdges;

  MyDartCodeViewer({Key key, @required String code, this.roundedEdges = false})
      : code = code.replaceAll('  ', '      '),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16.0, bottom: 0.0, left: 8.0, right: 16.0),
      decoration: BoxDecoration(
        borderRadius: roundedEdges ? BorderRadius.all(Radius.circular(8.0)) : null,
        color: backgroundColor,
      ),
      child: LayoutBuilder(builder: (context, constraints) {
        final fontSize = min(16, max(8, constraints.maxWidth / 25)).toDouble();

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
                maxWidth:
                    max(1, constraints.maxWidth - 60), // 60 is DartCodeViewer internal padding
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
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
