import 'package:vrouter/vrouter.dart';
import 'package:flutter/material.dart';
import 'package:vrouter_website/in_app_page.dart';
import 'package:vrouter_website/left_navigation_bar.dart';

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

final Widget Function(Animation<double>, Animation<double>, Widget) fadeTransition =
    (animation, __, child) {
  return FadeTransition(
    opacity: animation,
    child: child,
  );
};
