import 'dart:math';

import 'package:vrouter/vrouter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vrouter_website/main.dart';
import 'package:vrouter_website/pages/Introduction/installation.dart';
import 'package:vrouter_website/pages/Introduction/what_is_vrouter.dart';
import 'package:vrouter_website/pages/advanced/scaling_and_custom_vroute_element.dart';
import 'package:vrouter_website/pages/essentials/getting_started.dart';
import 'package:vrouter_website/pages/advanced/navigation_control.dart';
import 'package:vrouter_website/pages/essentials/programmatic_navigation.dart';
import 'package:vrouter_website/pages/essentials/redirection.dart';
import 'package:vrouter_website/pages/examples/basic_example.dart';
// import 'package:vrouter_website/pages/examples/history_state.dart';
import 'package:vrouter_website/pages/examples/nesting.dart';
import 'package:vrouter_website/pages/examples/path_parameters.dart';
import 'package:vrouter_website/pages/examples/redirection.dart';
import 'package:vrouter_website/pages/examples/stacked_routes.dart';
import 'package:vrouter_website/pages/examples/transitions.dart';

import 'left_navigation_bar.dart';
import 'pages/advanced/custom_pages.dart';
import 'pages/advanced/fetching_data.dart';
import 'pages/advanced/pop_events.dart';
import 'pages/advanced/transitions.dart';
import 'pages/advanced/history.dart';
import 'pages/essentials/about_material_app.dart';
import 'pages/essentials/history_mode.dart';
import 'pages/essentials/name_and_aliases.dart';
import 'pages/essentials/nesting_widgets.dart';
import 'pages/essentials/route_formation.dart';
import 'pages/essentials/url_pattern.dart';
import 'pages/examples/history.dart';

class InAppPage extends StatelessWidget {
  final MainSection mainSection;
  final SubSection subSection;
  final PageSection pageSection;

  final SubSection previousSubSection;
  final SubSection nextSubSection;

  final Widget body;

  InAppPage({
    @required this.mainSection,
    @required this.subSection,
    @required this.pageSection,
    @required this.body,
  })  : previousSubSection = mainSection.subSections.indexOf(subSection) == 0
            ? sections.indexOf(mainSection) == 0
                ? null
                : sections[sections.indexOf(mainSection) - 1].subSections.last
            : mainSection.subSections[mainSection.subSections.indexOf(subSection) - 1],
        nextSubSection =
            mainSection.subSections.indexOf(subSection) == mainSection.subSections.length - 1
                ? sections.indexOf(mainSection) == sections.length - 1
                    ? null
                    : sections[sections.indexOf(mainSection) + 1].subSections.first
                : mainSection.subSections[mainSection.subSections.indexOf(subSection) + 1];

  InAppPage.fromMainSection({
    @required this.mainSection,
    @required this.body,
  })  : subSection = mainSection.subSections.first,
        pageSection = mainSection.subSections.first.pageSections.isNotEmpty
            ? mainSection.subSections.first.pageSections.first
            : null,
        previousSubSection =
            mainSection.subSections.indexOf(mainSection.subSections.first) == 0
                ? sections.indexOf(mainSection) == 0
                    ? null
                    : sections[sections.indexOf(mainSection) - 1].subSections.last
                : mainSection.subSections[
                    mainSection.subSections.indexOf(mainSection.subSections.first) - 1],
        nextSubSection = mainSection.subSections.indexOf(mainSection.subSections.first) ==
                mainSection.subSections.length - 1
            ? sections.indexOf(mainSection) == sections.length - 1
                ? null
                : sections[sections.indexOf(mainSection) + 1].subSections.first
            : mainSection.subSections[
                mainSection.subSections.indexOf(mainSection.subSections.first) + 1];

  InAppPage.fromSubSection({
    @required this.mainSection,
    @required this.subSection,
    @required this.body,
  })  : pageSection =
            subSection.pageSections.isNotEmpty ? subSection.pageSections.first : null,
        previousSubSection = mainSection.subSections.indexOf(subSection) == 0
            ? sections.indexOf(mainSection) == 0
                ? null
                : sections[sections.indexOf(mainSection) - 1].subSections.last
            : mainSection.subSections[mainSection.subSections.indexOf(subSection) - 1],
        nextSubSection =
            mainSection.subSections.indexOf(subSection) == mainSection.subSections.length - 1
                ? sections.indexOf(mainSection) == sections.length - 1
                    ? null
                    : sections[sections.indexOf(mainSection) + 1].subSections.first
                : mainSection.subSections[mainSection.subSections.indexOf(subSection) + 1];

  static final List<MainSection> sections = [
    MainSectionText(title: 'Introduction', subSections: [
      SubSectionText(
        title: 'What Is VRouter?',
        description: WhatIsVRouterDescription(),
        pageSections: [
          PageSection(
            title: 'Features',
            description: FeaturesPageSection(),
          ),
        ],
      ),
      SubSectionText(
        title: 'Installation',
        description: InstallationDescription(),
        pageSections: [
          PageSection(title: 'Add Dependency', description: AddDependencyPageSection()),
          PageSection(title: 'Install', description: InstallPageSection()),
          PageSection(title: 'Import', description: ImportPageSection()),
        ],
      ),
    ]),
    MainExampleSection(
      title: 'Examples',
      subExampleSections: [
        SubSectionExample(
          title: 'Basic example',
          description: BasicExampleDescription(),
          codeName: 'basic_example',
        ),
        SubSectionExample(
          title: 'Nesting',
          description: NestingExampleDescription(),
          codeName: 'nesting',
        ),
        SubSectionExample(
          title: 'Stacking',
          description: StackedRoutesDescription(),
          codeName: 'stacked_routes',
        ),
        SubSectionExample(
          title: 'Path parameters',
          description: PathParametersExampleDescription(),
          codeName: 'path_parameters',
        ),
        SubSectionExample(
          title: 'Redirection',
          description: RedirectionExampleDescription(),
          codeName: 'redirection',
        ),
        SubSectionExample(
          title: 'Transitions',
          description: TransitionsExampleDescription(),
          codeName: 'transitions',
        ),
        SubSectionExample(
          title: 'History',
          description: HistoryExampleDescription(),
          codeName: 'history',
        ),
        // SubSectionExample(
        //   title: 'History State',
        //   description: HistoryStateExampleDescription(),
        //   codeName: 'history_state',
        // ),
      ],
    ),
    MainSectionText(title: 'Essentials', subSections: [
      SubSectionText(
        title: 'Getting Started',
        description: GettingStartedDescription(),
        pageSections: [
          PageSection(title: 'VRouter', description: VRouterPageSection()),
          PageSection(title: 'VRouteElement', description: VRouteElementPageSection()),
          PageSection(title: 'VRouter Magic', description: VRouterMagicPageSection()),
        ],
      ),
      SubSectionText(
        title: 'Programmatic Navigation',
        description: ProgrammaticNavigationDescription(),
        pageSections: [
          // PageSection(title: 'Navigating To A Route', description: NavigatingToARoutePageSection()),
          // PageSection(title: 'Replace A Route', description: ReplaceARoutePageSection()),
        ],
      ),
      SubSectionText(
        title: 'Route formation',
        description: RouteFormationDescription(),
        pageSections: [
          PageSection(title: 'Stacked widgets', description: StackedWidgetPageSection()),
          PageSection(title: 'Path formation', description: PathFormationPageSection()),
        ],
      ),
      SubSectionText(
        title: 'Widget nesting',
        description: WidgetNestingDescription(),
        pageSections: [],
      ),
      SubSectionText(
        title: 'Name And Aliases',
        pageSections: [
          PageSection(title: 'Named Route', description: NamedRoutePageSection()),
          PageSection(title: 'Aliases', description: AliasesPageSection()),
        ],
      ),
      SubSectionText(
        title: 'Redirection',
        description: RedirectionDescription(),
        pageSections: [
          PageSection(title: 'VRouteRedirector', description: VRouteRedirectorPageSection()),
          PageSection(title: 'VRedirector', description: VRedirectorPageSection()),
        ],
      ),
      SubSectionText(
        title: 'HTML5 History Mode',
        description: HistoryModeDescription(),
        pageSections: [],
      ),
      SubSectionText(
        description: AboutMaterialAppDescription(),
        title: 'About MaterialApp',
        pageSections: [],
      ),
    ]),
    MainSectionText(title: 'Advanced', subSections: [
      SubSectionText(
        title: 'Path parameters',
        pageSections: [
          PageSection(
              title: 'Path parameters basics', description: PathParametersPageSection()),
          PageSection(
              title: 'Advanced Pattern Matching',
              description: AdvancedPatternMatchingPageSection()),
          PageSection(title: 'Matching Priority', description: MatchingPriorityPageSection()),
        ],
      ),
      SubSectionText(
        title: 'Navigation Control',
        description: NavigationControlDescription(),
        pageSections: [
          PageSection(title: 'VGuard', description: VGuardPageSection()),
          PageSection(title: 'VWidgetGuard', description: VWidgetGuardPageSection()),
          PageSection(
              title: 'The Navigation Cycle', description: NavigationCyclePageSection()),
          PageSection(title: 'Web Caveat', description: WebCaveatPageSection()),
        ],
      ),
      SubSectionText(
        title: 'Transitions',
        description: TransitionDescription(),
        pageSections: [
          PageSection(
              title: 'Default Transition', description: DefaultTransitionPageSection()),
          PageSection(
              title: 'Local Route Transitions',
              description: LocalRouteTransitionPageSection()),
        ],
      ),
      SubSectionText(
        title: 'Data Fetching',
        description: DataFetchingDescription(),
        pageSections: [
          PageSection(
              title: 'Fetching Before Navigation',
              description: FetchingDataBeforeNavigationPageSection()),
          PageSection(
              title: 'Fetching After Navigation',
              description: FetchingDataAfterNavigationPageSection()),
        ],
      ),
      SubSectionText(
        title: 'Custom VRouteElement And Scaling',
        description: CustomVRouteElementAndScalingDescription(),
        pageSections: [
          PageSection(
              title: 'Custom VRouteElement',
              description: CustomVRouteElementDescriptionPageSection()),
          PageSection(title: 'Scaling', description: ScalingDescriptionPageSection()),
        ],
      ),
      SubSectionText(
        title: 'Pop Events',
        description: PopEventsDescription(),
        pageSections: [
          PageSection(title: 'onPop', description: OnPopPageSection()),
          PageSection(title: 'onSystemPop', description: OnSystemPopPageSection()),
        ],
      ),
      SubSectionText(
        title: 'History',
        description: HistoryDescription(),
        pageSections: [
          PageSection(title: 'Using It To Navigate', description: UsingItToNavigatePageSection()),
          PageSection(title: 'Replacing An History Entry', description: ReplacingAnHistoryEntryPageSection()),
          PageSection(title: 'History State', description: HistoryStatePageSection()),
        ],
      ),
      // SubSectionText(
      //   title: 'History State',
      //   description: HistoryStateDescription(),
      //   pageSections: [
      //     PageSection(
      //         title: 'Providing A History State',
      //         description: ProvidingAHistoryStatePageSection()),
      //     PageSection(
      //         title: 'Replace A History State',
      //         description: ReplaceAHistoryStatePageSection()),
      //     PageSection(
      //         title: 'Saving Before Leave', description: SavingBeforeLeavePageSection()),
      //   ],
      // ),
      SubSectionText(
        title: 'Custom Pages',
        description: CustomPagesDescription(),
        pageSections: [
          PageSection(title: 'VPage', description: VPagePageSection()),
          PageSection(title: 'VNesterPage', description: VNesterPagePageSection()),
        ],
      ),
    ]),
  ];

  static InAppPageData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InAppPageData>();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: MyScrollBehavior(),
      child: InAppPageData(
        mainSection: mainSection,
        subSection: subSection,
        pageSection: pageSection,
        previousSubSection: previousSubSection,
        nextSubSection: nextSubSection,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return (constraints.maxWidth > 1000)
                ? ComputerInApp(
                    tutorialPageHandler: body,
                    leftNavigationBar: LeftNavigationBar(sections: sections),
                  )
                : MobileInApp(
                    tutorialPageHandler: body,
                    leftNavigationBar: LeftNavigationBar(sections: sections),
                  );
          },
        ),
      ),
    );
  }
}

class InAppPageData extends InheritedWidget {
  final MainSection mainSection;
  final SubSection subSection;
  final PageSection pageSection;

  final SubSection previousSubSection;
  final SubSection nextSubSection;

  const InAppPageData({
    Key key,
    @required Widget child,
    @required this.mainSection,
    @required this.subSection,
    @required this.pageSection,
    @required this.previousSubSection,
    @required this.nextSubSection,
  })  : assert(child != null),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InAppPageData old) {
    return old.mainSection != mainSection ||
        old.subSection != subSection ||
        old.pageSection != pageSection ||
        old.previousSubSection != previousSubSection ||
        old.nextSubSection != nextSubSection;
  }
}

class ComputerInApp extends StatelessWidget {
  final LeftNavigationBar leftNavigationBar;
  final Widget tutorialPageHandler;

  const ComputerInApp(
      {Key key, @required this.leftNavigationBar, @required this.tutorialPageHandler})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              VRouterLogo(),
              VRouterShields(),
            ],
          ),
          Container(height: 1, color: separatorColor),
          Expanded(
            child: ComputerBodyWidget(
              tutorialPagesHandler: tutorialPageHandler,
              leftNavigationBar: leftNavigationBar,
            ),
          ),
        ],
      ),
    );
  }
}

class VRouterLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LinkButton(
      onPressed: () {
        context.vRouter.to('/');
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/v_logo.svg',
                  height: min(50, kToolbarHeight - 20),
                ),
                Text(
                  'Router',
                  style: GoogleFonts.ubuntu(
                      textStyle: TextStyle(fontSize: 30, color: Color(0xFF015292))),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class VRouterShields extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [],
    );
  }
}

class ComputerBodyWidget extends StatelessWidget {
  final LeftNavigationBar leftNavigationBar;
  final Widget tutorialPagesHandler;

  const ComputerBodyWidget({
    Key key,
    @required this.leftNavigationBar,
    @required this.tutorialPagesHandler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 100 * constraints.maxWidth / 15),
              child: leftNavigationBar,
            ),
            Container(
              width: 1,
              color: separatorColor,
            ),
            Expanded(
              child: tutorialPagesHandler,
            ),
          ],
        );
      },
    );
  }
}

class MobileInApp extends StatefulWidget {
  final LeftNavigationBar leftNavigationBar;
  final Widget tutorialPageHandler;

  const MobileInApp(
      {Key key, @required this.leftNavigationBar, @required this.tutorialPageHandler})
      : super(key: key);

  @override
  _MobileInAppState createState() => _MobileInAppState();
}

class _MobileInAppState extends State<MobileInApp> {
  bool showLeftNavigationBar = false;
  bool isAnimating = false;

  @override
  Widget build(BuildContext context) {
    return VWidgetGuard(
      beforeLeave: (_, __) async {
        if (showLeftNavigationBar) {
          setState(() {
            showLeftNavigationBar = false;
            isAnimating = true;
          });
        }
      },
      onPop: (vRedirector) async {
        if (showLeftNavigationBar) {
          setState(() {
            showLeftNavigationBar = false;
            isAnimating = true;
          });
          return vRedirector.stopRedirection();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Stack(
            alignment: AlignmentDirectional.centerStart,
            children: [
              Align(
                alignment: Alignment.center,
                child: VRouterLogo(),
              ),
              IconButton(
                onPressed: () => setState(() {
                  isAnimating = true;
                  showLeftNavigationBar = !showLeftNavigationBar;
                }),
                icon: Icon(Icons.menu),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            widget.tutorialPageHandler,
            if (showLeftNavigationBar || isAnimating)
              TweenAnimationBuilder<double>(
                duration: Duration(milliseconds: 300),
                tween: Tween<double>(begin: 0, end: (showLeftNavigationBar) ? 1 : 0),
                builder: (context, value, _) {
                  final newIsAnimating =
                      (showLeftNavigationBar) ? !(value == 1) : !(value == 0);
                  if (newIsAnimating != isAnimating) {
                    WidgetsBinding.instance.addPostFrameCallback(
                        (_) => setState(() => isAnimating = newIsAnimating));
                  }
                  return GestureDetector(
                    onTap: () {
                      isAnimating = true;
                      setState(() => showLeftNavigationBar = false);
                    },
                    child: Container(
                      color: Colors.black.withAlpha((50 * value).ceil()),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return SlideTransition(
                                position:
                                    Tween<Offset>(begin: Offset(-1.0, 0), end: Offset(0, 0))
                                        .animate(AlwaysStoppedAnimation<double>(value)),
                                child: Container(
                                  color: Colors.white,
                                  height: constraints.maxHeight,
                                  child: widget.leftNavigationBar,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}

// class MobileBody extends StatefulWidget {
//   final LeftNavigationBar leftNavigationBar;
//   final TutorialPagesHandler tutorialPagesHandler;
//
//   const MobileBody({
//     Key key,
//     @required this.leftNavigationBar,
//     @required this.tutorialPagesHandler,
//   }) : super(key: key);
//
//   @override
//   _MobileBodyState createState() => _MobileBodyState();
// }
//
// class _MobileBodyState extends State<MobileBody> {
//   bool showLeftNavigationBar = false;
//   bool isAnimating = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return VWidgetGuard(
//       afterUpdate: (_, __, ___) {
//         if (showLeftNavigationBar) {
//           setState(() {
//             showLeftNavigationBar = false;
//             isAnimating = true;
//           });
//         }
//       },
//       onPop: (vRediretor) async {
//         if (showLeftNavigationBar) {
//           setState(() {
//             showLeftNavigationBar = false;
//             isAnimating = true;
//           });
//           return vRediretor.stopRedirection();
//         }
//       },
//       child: Stack(
//         children: [
//           widget.tutorialPagesHandler,
//           Align(
//             alignment: Alignment.topLeft,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: IconButton(
//                 onPressed: () => setState(() => showLeftNavigationBar = true),
//                 icon: Icon(Icons.menu),
//               ),
//             ),
//           ),
//           if (showLeftNavigationBar || isAnimating)
//             TweenAnimationBuilder<double>(
//               duration: Duration(milliseconds: 300),
//               tween: Tween<double>(begin: 0, end: (showLeftNavigationBar) ? 1 : 0),
//               builder: (context, value, _) {
//                 final newIsAnimating = (showLeftNavigationBar) ? !(value == 1) : !(value == 0);
//                 if (newIsAnimating != isAnimating) {
//                   WidgetsBinding.instance.addPostFrameCallback(
//                       (_) => setState(() => isAnimating = newIsAnimating));
//                 }
//                 return GestureDetector(
//                   onTap: () {
//                     isAnimating = true;
//                     setState(() => showLeftNavigationBar = false);
//                   },
//                   child: Container(
//                     color: Colors.black.withAlpha((50 * value).ceil()),
//                     child: Align(
//                       alignment: Alignment.topLeft,
//                       child: GestureDetector(
//                         child: LayoutBuilder(
//                           builder: (context, constraints) {
//                             return SlideTransition(
//                               position:
//                                   Tween<Offset>(begin: Offset(-1.0, 0), end: Offset(0, 0))
//                                       .animate(AlwaysStoppedAnimation<double>(value)),
//                               child: Container(
//                                 color: Colors.white,
//                                 height: constraints.maxHeight,
//                                 child: widget.leftNavigationBar,
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//         ],
//       ),
//     );
//   }
// }
