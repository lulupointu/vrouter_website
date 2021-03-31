import 'dart:math';

import 'package:vrouter/vrouter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vrouter_website/main.dart';
import 'package:vrouter_website/pages/Introduction/installation.dart';
import 'package:vrouter_website/pages/Introduction/what_is_vrouter.dart';
import 'package:vrouter_website/pages/essentials/getting_started.dart';
import 'package:vrouter_website/pages/advanced/navigation_control.dart';
import 'package:vrouter_website/pages/essentials/programmatic_navigation.dart';
import 'package:vrouter_website/pages/essentials/redirection.dart';
import 'package:vrouter_website/pages/examples/basic_example.dart';
import 'package:vrouter_website/pages/examples/history_state.dart';
import 'package:vrouter_website/pages/examples/nesting.dart';
import 'package:vrouter_website/pages/examples/path_parameters.dart';
import 'package:vrouter_website/pages/examples/redirection.dart';
import 'package:vrouter_website/pages/examples/transitions.dart';

import 'package:vrouter_website/pages/tutorial_pages_handler.dart';

import 'left_navigation_bar.dart';
import 'pages/advanced/custom_pages.dart';
import 'pages/advanced/fetching_data.dart';
import 'pages/advanced/history_state.dart';
import 'pages/advanced/pop_events.dart';
import 'pages/advanced/transitions.dart';
import 'pages/essentials/about_material_app.dart';
import 'pages/essentials/history_mode.dart';
import 'pages/essentials/name_and_aliases.dart';
import 'pages/essentials/nesting_widgets.dart';
import 'pages/essentials/route_formation.dart';
import 'pages/essentials/url_pattern.dart';

class InAppPage extends StatelessWidget {
  final List<MainSection> sections = [
    MainSection(title: 'Introduction', subSections: [
      SubSection(
        title: 'What Is VRouter?',
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
          PageSection(title: 'Add Dependency', description: AddDependencyPageSection()),
          PageSection(title: 'Install', description: InstallPageSection()),
          PageSection(title: 'Import', description: ImportPageSection()),
        ],
      ),
    ]),
    MainExampleSection(
      title: 'Examples',
      subExampleSections: [
        SubExampleSection(
          title: 'Basic example',
          description: BasicExampleDescription(),
          codeName: 'basic_example',
        ),
        SubExampleSection(
          title: 'Nesting',
          description: NestingExampleDescription(),
          codeName: 'nesting',
        ),
        SubExampleSection(
          title: 'Path parameters',
          description: PathParametersExampleDescription(),
          codeName: 'path_parameters',
        ),
        SubExampleSection(
          title: 'Redirection',
          description: RedirectionExampleDescription(),
          codeName: 'redirection',
        ),
        SubExampleSection(
          title: 'Transitions',
          description: TransitionsExampleDescription(),
          codeName: 'transitions',
        ),
        SubExampleSection(
          title: 'History State',
          description: HistoryStateExampleDescription(),
          codeName: 'history_state',
        ),
      ],
    ),
    MainSection(title: 'Essentials', subSections: [
      SubSection(
        title: 'Getting Started',
        description: GettingStartedDescription(),
        pageSections: [
          PageSection(title: 'VRouter', description: VRouterPageSection()),
          PageSection(title: 'VRouteElement', description: VRouteElementPageSection()),
          PageSection(title: 'VRouter Magic', description: VRouterMagicPageSection()),
        ],
      ),
      SubSection(
        title: 'Programmatic Navigation',
        description: ProgrammaticNavigationDescription(),
        pageSections: [
          PageSection(title: 'Push A Route', description: PushARoutePageSection()),
          PageSection(title: 'Replace A Route', description: ReplaceARoutePageSection()),
        ],
      ),
      SubSection(
        title: 'Route formation',
        description: RouteFormationDescription(),
        pageSections: [
          PageSection(title: 'Stacked widgets', description: StackedWidgetPageSection()),
          PageSection(title: 'Path formation', description: PathFormationPageSection()),
        ],
      ),
      SubSection(
        title: 'Widget nesting',
        description: WidgetNestingDescription(),
        pageSections: [],
      ),
      SubSection(
        title: 'Name And Aliases',
        pageSections: [
          PageSection(title: 'Named Route', description: NamedRoutePageSection()),
          PageSection(title: 'Aliases', description: AliasesPageSection()),
        ],
      ),
      SubSection(
        title: 'Redirection',
        description: RedirectionDescription(),
        pageSections: [
          PageSection(title: 'VRouteRedirector', description: VRouteRedirectorPageSection()),
          PageSection(title: 'VRedirector', description: VRedirectorPageSection()),
        ],
      ),
      SubSection(
        title: 'HTML5 History Mode',
        description: HistoryModeDescription(),
        pageSections: [],
      ),
      SubSection(
        description: AboutMaterialAppDescription(),
        title: 'About MaterialApp',
        pageSections: [],
      ),
    ]),
    MainSection(title: 'Advanced', subSections: [
      SubSection(
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
      SubSection(
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
      SubSection(
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
      SubSection(
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
      SubSection(
        title: 'Pop Events',
        description: PopEventsDescription(),
        pageSections: [
          PageSection(title: 'onPop', description: OnPopPageSection()),
          PageSection(title: 'onSystemPop', description: OnSystemPopPageSection()),
        ],
      ),
      SubSection(
        title: 'History State',
        description: HistoryStateDescription(),
        pageSections: [
          PageSection(
              title: 'Pushing A History State',
              description: PushingAHistoryStatePageSection()),
          PageSection(
              title: 'Replace A History State',
              description: ReplaceAHistoryStatePageSection()),
          PageSection(
              title: 'Saving Before Leave', description: SavingBeforeLeavePageSection()),
        ],
      ),
      SubSection(
        title: 'Custom Pages',
        description: CustomPagesDescription(),
        pageSections: [
          PageSection(title: 'VPage', description: VPagePageSection()),
          PageSection(title: 'VNesterPage', description: VNesterPagePageSection()),
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

    final mainSectionTitle = context.vRouter.pathParameters['mainSection'];
    if (mainSectionTitle != null) {
      // Check the validity of the main section
      try {
        selectedMainSection =
            sections.firstWhere((section) => section.title == mainSectionTitle);
      } on StateError {
        selectedMainSection = null;
      }
      if (selectedMainSection == null) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          context.vRouter.pushNamed('guide');
        });
      } else {
        final subSectionTitle = context.vRouter.pathParameters['subSection'];
        if (subSectionTitle != null) {
          // Check the validity of the sub section
          for (var subSectionIndex = 0;
              subSectionIndex < selectedMainSection.subSections.length;
              subSectionIndex++) {
            if (selectedMainSection.subSections[subSectionIndex].title == subSectionTitle) {
              selectedSubSection = selectedMainSection.subSections[subSectionIndex];

              // Try to get the previous subSection
              final selectedMainSectionIndex = sections.indexOf(selectedMainSection);
              if (subSectionIndex != 0) {
                previousSubSectionTitle =
                    selectedMainSection.subSections[subSectionIndex - 1].title;
                previousSubSectionLink =
                    '/guide/${selectedMainSection.title}/$previousSubSectionTitle';
              } else {
                if (selectedMainSectionIndex != 0) {
                  previousSubSectionTitle =
                      sections[selectedMainSectionIndex - 1].subSections.last.title;
                  previousSubSectionLink =
                      '/guide/${sections[selectedMainSectionIndex - 1].title}/$previousSubSectionTitle';
                }
              }

              // Try to get the next subSection
              if (subSectionIndex != selectedMainSection.subSections.length - 1) {
                nextSubSectionTitle =
                    selectedMainSection.subSections[subSectionIndex + 1].title;
                nextSubSectionLink =
                    '/guide/${selectedMainSection.title}/$nextSubSectionTitle';
              } else {
                if (selectedMainSectionIndex != sections.length - 1) {
                  nextSubSectionTitle =
                      sections[selectedMainSectionIndex + 1].subSections.first.title;
                  nextSubSectionLink =
                      '/guide/${sections[selectedMainSectionIndex + 1].title}/$nextSubSectionTitle';
                }
              }

              break;
            }
          }

          if (selectedSubSection == null) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              context.vRouter.pushNamed('guide', pathParameters: {
                'mainSection': selectedMainSection.title,
              });
            });
          } else {
            final pageSectionTitle = context.vRouter.pathParameters['pageSection'];
            if (pageSectionTitle != null) {
              // Check the validity of the page section
              try {
                selectedPageSection = selectedSubSection.pageSections
                    ?.firstWhere((section) => section.title == pageSectionTitle);
              } on StateError {
                selectedPageSection = null;
              }
              if (selectedPageSection == null) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  context.vRouter.pushNamed('guide', pathParameters: {
                    'mainSection': selectedMainSection.title,
                    'subSection': selectedSubSection.title,
                  });
                });
              }
            }
          }
        }
      }
    }

    // Put default value if needed
    selectedMainSection ??= sections.first;
    if (selectedSubSection == null) {
      selectedSubSection ??= selectedMainSection.subSections.first;
      // Try to get the previous subSection
      final selectedMainSectionIndex = sections.indexOf(selectedMainSection);
      final subSectionIndex = selectedMainSection.subSections.indexOf(selectedSubSection);
      if (subSectionIndex != 0) {
        previousSubSectionTitle = selectedMainSection.subSections[subSectionIndex - 1].title;
        previousSubSectionLink =
            '/guide/${selectedMainSection.title}/$previousSubSectionTitle';
      } else {
        if (selectedMainSectionIndex != 0) {
          previousSubSectionTitle =
              sections[selectedMainSectionIndex - 1].subSections.last.title;
          previousSubSectionLink =
              '/guide/${sections[selectedMainSectionIndex - 1].title}/$previousSubSectionTitle';
        }
      }

      // Try to get the next subSection
      if (subSectionIndex != selectedMainSection.subSections.length - 1) {
        nextSubSectionTitle = selectedMainSection.subSections[subSectionIndex + 1].title;
        nextSubSectionLink = '/guide/${selectedMainSection.title}/$nextSubSectionTitle';
      } else {
        if (selectedMainSectionIndex != sections.length - 1) {
          nextSubSectionTitle = sections[selectedMainSectionIndex + 1].subSections.first.title;
          nextSubSectionLink =
              '/guide/${sections[selectedMainSectionIndex + 1].title}/$nextSubSectionTitle';
        }
      }
    }

    final tutorialPageHandler = TutorialPagesHandler(
      selectedMainSection: selectedMainSection,
      previousSubSectionTitle: previousSubSectionTitle,
      previousSubSectionLink: previousSubSectionLink,
      selectedSubSection: selectedSubSection,
      nextSubSectionTitle: nextSubSectionTitle,
      nextSubSectionLink: nextSubSectionLink,
      selectedPageSection: selectedPageSection,
    );

    return ScrollConfiguration(
      behavior: MyScrollBehavior(),
      child: LayoutBuilder(builder: (context, constraints) {
        return (constraints.maxWidth > 1000)
            ? ComputerInApp(
                tutorialPageHandler: tutorialPageHandler,
                leftNavigationBar: LeftNavigationBar(sections: sections),
              )
            : MobileInApp(
                tutorialPageHandler: tutorialPageHandler,
                leftNavigationBar: LeftNavigationBar(sections: sections),
              );
      }),
    );
  }
}

class ComputerInApp extends StatelessWidget {
  final LeftNavigationBar leftNavigationBar;
  final TutorialPagesHandler tutorialPageHandler;

  const ComputerInApp(
      {Key key, @required this.leftNavigationBar, @required this.tutorialPageHandler})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VRouterLogo(),
          Container(height: 1, color: separatorColor),
          Expanded(
              child: ComputerBodyWidget(
            tutorialPagesHandler: tutorialPageHandler,
            leftNavigationBar: leftNavigationBar,
          )),
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
        context.vRouter.push('/');
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: LayoutBuilder(builder: (context, constraints) {
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
        }),
      ),
    );
  }
}

class ComputerBodyWidget extends StatelessWidget {
  final LeftNavigationBar leftNavigationBar;
  final TutorialPagesHandler tutorialPagesHandler;

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
            )
          ],
        );
      },
    );
  }
}

class MobileInApp extends StatefulWidget {
  final LeftNavigationBar leftNavigationBar;
  final TutorialPagesHandler tutorialPageHandler;

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
      afterUpdate: (_, __, ___) {
        if (showLeftNavigationBar) {
          setState(() {
            showLeftNavigationBar = false;
            isAnimating = true;
          });
        }
      },
      onPop: (_) async {
        if (showLeftNavigationBar) {
          setState(() {
            showLeftNavigationBar = false;
            isAnimating = true;
          });
          return false;
        }
        return true;
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
              )
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

class MobileBody extends StatefulWidget {
  final LeftNavigationBar leftNavigationBar;
  final TutorialPagesHandler tutorialPagesHandler;

  const MobileBody({
    Key key,
    @required this.leftNavigationBar,
    @required this.tutorialPagesHandler,
  }) : super(key: key);

  @override
  _MobileBodyState createState() => _MobileBodyState();
}

class _MobileBodyState extends State<MobileBody> {
  bool showLeftNavigationBar = false;
  bool isAnimating = false;

  @override
  Widget build(BuildContext context) {
    return VWidgetGuard(
      afterUpdate: (_, __, ___) {
        if (showLeftNavigationBar) {
          setState(() {
            showLeftNavigationBar = false;
            isAnimating = true;
          });
        }
      },
      onPop: (_) async {
        if (showLeftNavigationBar) {
          setState(() {
            showLeftNavigationBar = false;
            isAnimating = true;
          });
          return false;
        }
        return true;
      },
      child: Stack(
        children: [
          widget.tutorialPagesHandler,
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () => setState(() => showLeftNavigationBar = true),
                icon: Icon(Icons.menu),
              ),
            ),
          ),
          if (showLeftNavigationBar || isAnimating)
            TweenAnimationBuilder<double>(
              duration: Duration(milliseconds: 300),
              tween: Tween<double>(begin: 0, end: (showLeftNavigationBar) ? 1 : 0),
              builder: (context, value, _) {
                final newIsAnimating = (showLeftNavigationBar) ? !(value == 1) : !(value == 0);
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
    );
  }
}
