import 'dart:math';

import 'package:vrouter/vrouter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vrouter_website/main.dart';


import '../left_navigation_bar.dart';

class TutorialPagesHandler extends StatelessWidget {
  final MainSection selectedMainSection;
  final String previousSubSectionLink;
  final String previousSubSectionTitle;
  final SubSection selectedSubSection;
  final String nextSubSectionLink;
  final String nextSubSectionTitle;
  final PageSection selectedPageSection;

  const TutorialPagesHandler({
    Key key,
    @required this.selectedMainSection,
    @required this.previousSubSectionLink,
    @required this.previousSubSectionTitle,
    @required this.selectedSubSection,
    @required this.nextSubSectionLink,
    @required this.nextSubSectionTitle,
    @required this.selectedPageSection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (selectedPageSection != null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Scrollable.ensureVisible(selectedPageSection.titleKey.currentContext,
            duration: Duration(milliseconds: 300));
      });
    } else if (selectedSubSection != null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Scrollable.ensureVisible(selectedSubSection.titleKey.currentContext,
            duration: Duration(milliseconds: 300));
      });
    }

    return Center(
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: TutorialPage(
          key: ValueKey(selectedSubSection),
          previousSubSectionTitle: previousSubSectionTitle,
          previousSubSectionLink: previousSubSectionLink,
          selectedSubSection: selectedSubSection,
          nextSubSectionTitle: nextSubSectionTitle,
          nextSubSectionLink: nextSubSectionLink,
        ),
      ),
    );
  }

// void getSelectedPage() {
//   print('GET SELECTED PAGE');
//   for (var mainSection in widget.sections) {
//     if (Uri.encodeComponent(mainSection.title) == VRouteData.of(context).pathParameters['mainSection']) {
//       for (var subSection in mainSection.subSections) {
//         if (Uri.encodeComponent(subSection.title) == VRouteData.of(context).pathParameters['subSection']) {
//           setState(() {
//             selectedPage = subSection.tutorialPageBuilder(title: subSection.title);
//           });
//           break;
//         }
//       }
//       break;
//     }
//   }
// }
}

class TutorialPage extends StatelessWidget {
  final String previousSubSectionTitle;
  final String previousSubSectionLink;
  final SubSection selectedSubSection;
  final String nextSubSectionTitle;
  final String nextSubSectionLink;
  final ScrollController _scrollController = ScrollController();

  TutorialPage({
    Key key,
    @required this.previousSubSectionTitle,
    @required this.previousSubSectionLink,
    @required this.selectedSubSection,
    @required this.nextSubSectionTitle,
    @required this.nextSubSectionLink,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Scrollbar(
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 800,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Padding(
                  padding:
                      EdgeInsets.only(bottom: max(20, MediaQuery.of(context).size.height / 10)),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          key: selectedSubSection.titleKey,
                          padding: const EdgeInsets.only(top: 40.0),
                          child: Text(
                            selectedSubSection.title,
                            style: GoogleFonts.ubuntu(
                              textStyle: TextStyle(
                                fontSize: max(24, MediaQuery.of(context).size.height * 0.035),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        if (selectedSubSection.description != null) ...[
                          SizedBox(height: MediaQuery.of(context).size.height / 30),
                          selectedSubSection.description,
                        ],
                        if (selectedSubSection.pageSections != null)
                          for (var i = 0; i < selectedSubSection.pageSections.length; i++) ...[
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 30,
                            ),
                            Text(
                              selectedSubSection.pageSections[i].title,
                              key: selectedSubSection.pageSections[i].titleKey,
                              style: GoogleFonts.ubuntu(
                                textStyle: TextStyle(
                                  fontSize: max(20, MediaQuery.of(context).size.height * 0.025),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 4),
                            Container(color: Colors.grey.shade400, height: 0.5),
                            SizedBox(height: MediaQuery.of(context).size.height / 50),
                            selectedSubSection.pageSections[i].description,
                          ],
                        SizedBox(height: MediaQuery.of(context).size.height / 30),
                        Container(color: Colors.grey.shade400, height: 0.5),
                        SizedBox(height: MediaQuery.of(context).size.height / 50),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            (previousSubSectionTitle != null)
                                ? LinkButton(
                                    onPressed: () {
                                      VRouterData.of(context).push(previousSubSectionLink);
                                    },
                                    child: Row(
                                      children: [
                                        RotatedBox(
                                            quarterTurns: 2,
                                            child: Icon(Icons.arrow_right_alt,
                                                color: linkStyle.color)),
                                        Text(
                                          '$previousSubSectionTitle',
                                          style: linkStyle.copyWith(
                                              decoration: TextDecoration.none,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(),
                            (nextSubSectionTitle != null)
                                ? LinkButton(
                                    onPressed: () {
                                      VRouterData.of(context).push(nextSubSectionLink);
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          '$nextSubSectionTitle',
                                          style: linkStyle.copyWith(
                                              decoration: TextDecoration.none,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Icon(Icons.arrow_right_alt, color: linkStyle.color),
                                      ],
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
