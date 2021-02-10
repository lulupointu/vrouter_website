import 'package:complete_app/vrouter/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/link.dart';
import 'package:vrouter_website/main.dart';
import 'package:vrouter_website/pages/Introduction/installation.dart';
import 'package:vrouter_website/pages/Introduction/what_is_vrouter.dart';
import 'package:vrouter_website/pages/essentials/getting_started.dart';
import 'package:vrouter_website/pages/essentials/nested_route.dart';
import 'package:vrouter_website/pages/essentials/programmatic_navigation.dart';
import 'package:vrouter_website/pages/essentials/vChild.dart';

import 'package:vrouter_website/pages/tutorial_pages_handler.dart';

import 'left_navigation_bar.dart';
import 'pages/essentials/name_and_aliases.dart';
import 'pages/essentials/url_pattern.dart';

class InAppPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderWidget(),
          Container(height: 1, color: separatorColor),
          Expanded(child: BodyWidget()),
        ],
      ),
    );
  }
}

class HeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LinkButton(
      onPressed: () {
        VRouterData.of(context).push('/');
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/v_logo.svg',
              height: 50,
            ),
            Text(
              'Router',
              style: GoogleFonts.ubuntu(
                  textStyle: TextStyle(fontSize: 30, color: Color(0xFF015292))),
            ),
          ],
        ),
      ),
    );
  }
}

class BodyWidget extends StatelessWidget {
  final List<MainSection> sections = [
    MainSection(title: 'Introduction', subSections: [
      SubSection(
        title: 'What is VRouter?',
        description: WhatIsVRouterDescription(),
        pageSections: [
          PageSection(
            title: 'Features',
            description: FeaturesPageSection(),
          ),
        ],
      ),
      SubSection(
        title: 'Installation',
        description: InstallationDescription(),
        pageSections: [
          PageSection(title: 'Add dependency', description: AddDependencyPageSection()),
          PageSection(title: 'Install', description: InstallPageSection()),
          PageSection(title: 'Import', description: ImportPageSection()),
        ],
      ),
    ]),
    MainSection(title: 'Essentials', subSections: [
      SubSection(
        title: 'Getting started',
        description: GettingStartedDescription(),
        pageSections: [
          PageSection(title: 'VRouter', description: VRouterPageSection()),
          PageSection(title: 'VRouteElement', description: VRouteElementPageSection()),
        ],
      ),
      SubSection(
        title: 'Programmatic Navigation',
        description: ProgrammaticNavigationDescription(),
        pageSections: [
          PageSection(title: 'Push a route', description: PushARoutePageSection()),
          PageSection(title: 'Replace a route', description: ReplaceARoutePageSection()),
        ],
      ),
      SubSection(
        title: 'Nested routes',
        description: NestedRouteDescription(),
        pageSections: [
          PageSection(title: 'Pathless VRouteElement', description: PathlessPageSection()),
        ],
      ),
      SubSection(
        title: 'VChild',
        description: VChildDescription(),
        pageSections: [
          PageSection(title: 'VChild basics', description: VChildBasicsPageSection()),
          PageSection(title: 'Identify a VChild', description: IdentifyAVChildPageSection()),
        ],
      ),
      SubSection(
        title: 'Url pattern',
        pageSections: [
          PageSection(title: 'Path parameters', description: PathParametersPageSection()),
          PageSection(
              title: 'Advanced pattern matching',
              description: AdvancedPatternMatchingPageSection()),
          PageSection(title: 'Matching priority', description: MatchingPriorityPageSection()),
        ],
      ),
      SubSection(
        title: 'Name and aliases',
        pageSections: [
          PageSection(title: 'Named route', description: NamedRoutePageSection()),
          PageSection(title: 'Aliases', description: AliasesPageSection()),
        ],
      ),
      SubSection(
        title: 'Navigation control',
        pageSections: [
          PageSection(title: 'Control the navigation', description: Container()),
          PageSection(title: 'VNavigationGuard', description: Container()),
          PageSection(title: 'The navigation cycle', description: Container()),
          PageSection(title: 'Web caveat', description: Container()),
        ],
      ),
      SubSection(
        title: 'Redirection',
        pageSections: [
          PageSection(title: 'Redirects and VRedirector', description: Container()),
          PageSection(title: 'Aliases', description: Container()),
        ],
      ),
      SubSection(
        title: 'HTML5 history mode',
        pageSections: [],
      ),
      SubSection(
        title: 'About MaterialApp',
        pageSections: [],
      ),
    ]),
    MainSection(title: 'Advanced', subSections: [
      SubSection(
        title: 'Passing Data',
        pageSections: [],
      ),
      SubSection(
        title: 'History state',
        pageSections: [
          PageSection(title: 'VRouter', description: Container()),
          PageSection(title: 'VRoute', description: Container()),
          PageSection(title: 'VNavigationGuard', description: Container()),
        ],
      ),
      SubSection(
        title: 'Transitions',
        pageSections: [
          PageSection(title: 'Local route transitions', description: Container()),
          PageSection(title: 'Default transition', description: Container()),
        ],
      ),
      SubSection(
        title: 'Data fetching',
        pageSections: [
          PageSection(title: 'Fetching after navigation', description: Container()),
          PageSection(title: 'Fetching before navigation', description: Container()),
        ],
      ),
      SubSection(
        title: 'Back buttons',
        pageSections: [
          PageSection(title: 'onPop', description: Container()),
          PageSection(title: 'onSystemPop', description: Container()),
        ],
      ),
      SubSection(
        title: 'Browser events',
        pageSections: [
          PageSection(title: 'Forward/Back button', description: Container()),
          PageSection(title: 'Typed url', description: Container()),
        ],
      ),
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    MainSection selectedMainSection;
    String previousSubSectionLink;
    String previousSubSectionTitle;
    SubSection selectedSubSection;
    String nextSubSectionLink;
    String nextSubSectionTitle;
    PageSection selectedPageSection;

    final mainSectionTitle = VRouteData.of(context).pathParameters['mainSection'];
    if (mainSectionTitle != null) {
      // Check the validity of the main section
      try {
        selectedMainSection = sections
            .firstWhere((section) => Uri.encodeComponent(section.title) == mainSectionTitle);
      } on StateError {
        selectedMainSection = null;
      }
      if (selectedMainSection == null) {
        VRouterData.of(context).push('/guide');
      } else {
        final subSectionTitle = VRouteData.of(context).pathParameters['subSection'];
        if (subSectionTitle != null) {
          // Check the validity of the sub section
          for (var subSectionIndex = 0;
              subSectionIndex < selectedMainSection.subSections.length;
              subSectionIndex++) {
            if (Uri.encodeComponent(selectedMainSection.subSections[subSectionIndex].title) ==
                subSectionTitle) {
              selectedSubSection = selectedMainSection.subSections[subSectionIndex];

              // Try to get the previous subSection
              final selectedMainSectionIndex = sections.indexOf(selectedMainSection);
              if (subSectionIndex != 0) {
                previousSubSectionTitle =
                    selectedMainSection.subSections[subSectionIndex - 1].title;
                previousSubSectionLink =
                    '/guide/${Uri.encodeComponent(selectedMainSection.title)}/${Uri.encodeComponent(previousSubSectionTitle)}';
              } else {
                if (selectedMainSectionIndex != 0) {
                  previousSubSectionTitle =
                      sections[selectedMainSectionIndex - 1].subSections.last.title;
                  previousSubSectionLink =
                      '/guide/${Uri.encodeComponent(sections[selectedMainSectionIndex - 1].title)}/${Uri.encodeComponent(previousSubSectionTitle)}';
                }
              }

              // Try to get the next subSection
              if (subSectionIndex != selectedMainSection.subSections.length - 1) {
                nextSubSectionTitle =
                    selectedMainSection.subSections[subSectionIndex + 1].title;
                nextSubSectionLink =
                    '/guide/${Uri.encodeComponent(selectedMainSection.title)}/${Uri.encodeComponent(nextSubSectionTitle)}';
              } else {
                if (selectedMainSectionIndex != sections.length - 1) {
                  nextSubSectionTitle =
                      sections[selectedMainSectionIndex + 1].subSections.first.title;
                  nextSubSectionLink =
                      '/guide/${Uri.encodeComponent(sections[selectedMainSectionIndex + 1].title)}/${Uri.encodeComponent(nextSubSectionTitle)}';
                }
              }

              break;
            }
          }
          // try {
          //   selectedSubSection = selectedMainSection.subSections.firstWhere(
          //       (section) => Uri.encodeComponent(section.title) == subSectionTitle);
          // } on StateError {
          //   selectedSubSection = null;
          // }
          if (selectedSubSection == null) {
            VRouterData.of(context)
                .push('/guide/${Uri.encodeComponent(selectedMainSection.title)}');
          } else {
            final pageSectionTitle = VRouteData.of(context).pathParameters['pageSection'];
            if (pageSectionTitle != null) {
              // Check the validity of the page section
              try {
                selectedPageSection = selectedSubSection.pageSections?.firstWhere(
                    (section) => Uri.encodeComponent(section.title) == pageSectionTitle);
              } on StateError {
                selectedPageSection = null;
              }
              if (selectedPageSection == null) {
                VRouterData.of(context).push(
                    '/guide/${Uri.encodeComponent(selectedMainSection.title)}/${Uri.encodeComponent(selectedSubSection.title)}');
              }
            }
          }
        }
      }
    }

    selectedMainSection ??= sections.first;
    selectedSubSection ??= selectedMainSection.subSections.first;

    return VNavigationGuard(
      afterEnter: (context, __, ___) => checkParamsValidity(context),
      afterUpdate: (_, __, ___) => checkParamsValidity(context),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 15,
            child: LeftNavigationBar(sections: sections),
          ),
          Container(
            width: 1,
            color: separatorColor,
          ),
          Expanded(
            child: TutorialPagesHandler(
              selectedMainSection: selectedMainSection,
              previousSubSectionTitle: previousSubSectionTitle,
              previousSubSectionLink: previousSubSectionLink,
              selectedSubSection: selectedSubSection,
              nextSubSectionTitle: nextSubSectionTitle,
              nextSubSectionLink: nextSubSectionLink,
              selectedPageSection: selectedPageSection,
            ),
            flex: 85,
          )
        ],
      ),
    );
  }

  void checkParamsValidity(BuildContext context) {}
}
