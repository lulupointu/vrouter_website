import 'package:vrouter/vrouter.dart';
import 'package:flutter/material.dart';
import 'package:vrouter_website/in_app_page.dart';
import 'package:vrouter_website/left_navigation_bar.dart';
import 'package:vrouter_website/pages/tutorial_pages_handler.dart';

class GuideRoute extends VRouteElementBuilder {
  static String toMainSection(
    BuildContext context, {
    @required MainSection mainSection,
  }) {
    final segments = ['guide', mainSection.title];
    final encodedPath =
        '/' + segments.map((segment) => Uri.encodeComponent(segment)).join('/');

    // avoid repeated url history entry
    final isReplacement = context.vRouter.url == encodedPath;

    context.vRouter.to(encodedPath, isReplacement: isReplacement);

    // Return encoded path
    return encodedPath;
  }

  static String toSubSection(
    BuildContext context, {
    @required SubSection subSection,
  }) {
    final mainSection = InAppPage.sections
        .firstWhere((mainSection) => mainSection.subSections.contains(subSection));

    final segments = ['guide', mainSection.title, subSection.title];
    final encodedPath =
        '/' + segments.map((segment) => Uri.encodeComponent(segment)).join('/');

    // avoid repeated url history entry
    final isReplacement = context.vRouter.url == encodedPath;

    context.vRouter.to(encodedPath, isReplacement: isReplacement);

    // Return encoded path
    return encodedPath;
  }

  static String toPageSection(
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

    final segments = ['guide', mainSection.title, subSection.title, pageSection.title];
    final encodedPath =
        '/' + segments.map((segment) => Uri.encodeComponent(segment)).join('/');

    // avoid repeated url history entry
    final isReplacement = context.vRouter.url == encodedPath;

    context.vRouter.to(encodedPath, isReplacement: isReplacement);

    // Return encoded path
    return encodedPath;
  }

  static void toSectionFromTitle(
    BuildContext context, {
    @required String mainSectionTitle,
    String subSectionTitle,
    String pageSectionTitle,
  }) {
    context.vRouter.toSegments([
      'guide',
      mainSectionTitle,
      if (subSectionTitle != null) ...[
        subSectionTitle,
        if (pageSectionTitle != null) pageSectionTitle
      ]
    ]);
  }

  final vNesterNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'THE VNESTER NAVIGATOR KEY');

  final noTransition = (Animation<double> _, Animation<double> __, Widget child) => child;

  @override
  List<VRouteElement> buildRoutes() {
    return [
      VNesterBase(
        key: ValueKey('InAppPage'),
        navigatorKey: vNesterNavigatorKey,
        widgetBuilder: (child) => InAppPage.fromMainSection(
          mainSection: InAppPage.sections.first,
          body: child,
        ),
        nestedRoutes: [
          VWidget(
            path: '/guide',
            widget: TutorialPagesHandler(),
            buildTransition: noTransition,
          ),
        ],
      ),
      for (var mainSection in InAppPage.sections) ...[
        VGuard(
          afterEnter: (_, __, ___) {},
          stackedRoutes: [
            VNesterBase(
              key: ValueKey('InAppPage'),
              navigatorKey: vNesterNavigatorKey,
              widgetBuilder: (child) => InAppPage.fromMainSection(
                mainSection: mainSection,
                body: child,
              ),
              nestedRoutes: [
                VWidget(
                  path: '/guide/${Uri.encodeComponent(mainSection.title)}',
                  widget: TutorialPagesHandler(),
                  buildTransition: noTransition,
                ),
              ],
            ),
          ],
        ),
        for (var subSection in mainSection.subSections) ...[
          VGuard(
            afterEnter: (_, __, ___) {
              // Ensures that the text in the body is at it's right scroll offset
              return Scrollable.ensureVisible(
                subSection.titleKey.currentContext,
                duration: Duration(milliseconds: 300),
              );
            },
            stackedRoutes: [
              VNesterBase(
                key: ValueKey('InAppPage'),
                navigatorKey: vNesterNavigatorKey,
                widgetBuilder: (child) => InAppPage.fromSubSection(
                  mainSection: mainSection,
                  subSection: subSection,
                  body: child,
                ),
                nestedRoutes: [
                  VWidget(
                    key: ValueKey(mainSection.title + subSection.title),
                    path:
                        '/guide/${Uri.encodeComponent(mainSection.title)}/${Uri.encodeComponent(subSection.title)}',
                    widget: TutorialPagesHandler(),
                    buildTransition: noTransition,
                  ),
                ],
              ),
            ],
          ),
          for (var pageSection in subSection.pageSections) ...[
            VGuard(
              afterEnter: (_, __, ___) {
                // Ensures that the text in the body is at it's right scroll offset
                return Scrollable.ensureVisible(
                  pageSection.titleKey.currentContext,
                  duration: Duration(milliseconds: 300),
                );
              },
              stackedRoutes: [
                VNesterBase(
                  key: ValueKey('InAppPage'),
                  navigatorKey: vNesterNavigatorKey,
                  widgetBuilder: (child) => InAppPage(
                    mainSection: mainSection,
                    subSection: subSection,
                    pageSection: pageSection,
                    body: child,
                  ),
                  nestedRoutes: [
                    VWidget(
                      key: ValueKey(mainSection.title + subSection.title),
                      path:
                          '/guide/${Uri.encodeComponent(mainSection.title)}/${Uri.encodeComponent(subSection.title)}/${Uri.encodeComponent(pageSection.title)}',
                      widget: TutorialPagesHandler(),
                      buildTransition: noTransition,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ],
      ],
    ];
  }
}
