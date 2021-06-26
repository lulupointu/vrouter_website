import 'package:vrouter/vrouter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vrouter_website/in_app_page.dart';
import 'package:vrouter_website/main.dart';
import 'package:vrouter_website/pages/tutorial_pages_handler.dart';
import 'package:vrouter_website/routes/guide_routes.dart';

class LeftNavigationBar extends StatelessWidget {
  final List<MainSection> sections;
  final ScrollController _scrollController = ScrollController();

  LeftNavigationBar({@required this.sections});

  @override
  Widget build(BuildContext context) {
    return LeftNavigationBarData(
      sections: sections,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 32.0, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: sections,
          ),
        ),
      ),
    );
  }

  static LeftNavigationBarData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<LeftNavigationBarData>();
  }
}

class LeftNavigationBarData extends InheritedWidget {
  final List<MainSection> sections;

  const LeftNavigationBarData({
    Key key,
    @required Widget child,
    @required this.sections,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(LeftNavigationBarData old) {
    return false;
  }
}

abstract class MainSection extends StatelessWidget {
  String get title;

  List<SubSection> get subSections;

  @override
  Widget build(BuildContext context) {
    final isSelected = InAppPage.of(context).mainSection == this;

    return MainSectionData(
      mainSection: this,
      isSelected: isSelected,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25, top: 20, bottom: 8),
            child: Text(
              title,
              style: GoogleFonts.ubuntu(
                textStyle: TextStyle(
                  fontSize: 17.5,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2c3e50),
                ),
              ),
            ),
          ),
          ...subSections,
        ],
      ),
    );
  }

  TutorialPage buildPage({
    Key key,
    @required SubSection previousSubSection,
    @required SubSection selectedSubSection,
    @required SubSection nextSubSection,
  });

  static MainSectionData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MainSectionData>();
  }
}

class MainSectionText extends MainSection {
  @override
  final String title;

  @override
  final List<SubSectionText> subSections;

  MainSectionText({Key key, @required this.title, @required this.subSections});

  TutorialPage buildPage({
    Key key,
    @required SubSection previousSubSection,
    @required SubSection selectedSubSection,
    @required SubSection nextSubSection,
  }) =>
      TutorialPageText(
        previousSubSection: previousSubSection,
        selectedSubSection: selectedSubSection,
        nextSubSection: nextSubSection,
      );
}

class MainExampleSection extends MainSection {
  @override
  final String title;

  @override
  List<SubSection> get subSections => subExampleSections;

  final List<SubSectionExample> subExampleSections;

  MainExampleSection({
    @required this.title,
    @required this.subExampleSections,
  });

  @override
  TutorialPage buildPage({
    Key key,
    @required SubSection previousSubSection,
    @required SubSection selectedSubSection,
    @required SubSection nextSubSection,
  }) =>
      TutorialPageExample(
        previousSubSection: previousSubSection,
        selectedSubSection: selectedSubSection as SubSectionExample,
        nextSubSection: nextSubSection,
      );
}

class MainSectionData extends InheritedWidget {
  final MainSection mainSection;

  String get title => mainSection.title;
  final bool isSelected;

  List<SubSection> get subSections => mainSection.subSections;

  const MainSectionData({
    Key key,
    @required Widget child,
    @required this.mainSection,
    @required this.isSelected,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(MainSectionData old) {
    return old.title != title || old.isSelected != isSelected;
  }
}

abstract class SubSection extends StatelessWidget {
  String get title;

  List<PageSection> get pageSections;

  Widget get description;

  GlobalKey _titleKey;

  GlobalKey get titleKey =>
      _titleKey ?? (_titleKey = GlobalKey(debugLabel: 'SubSection with title $title'));

  static SubSectionData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SubSectionData>();
  }

  @override
  Widget build(BuildContext context) {
    final isSelected = InAppPage.of(context).subSection == this;

    if (isSelected) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Scrollable.ensureVisible(
          context,
          duration: Duration(milliseconds: 300),
          alignmentPolicy: ScrollPositionAlignmentPolicy.keepVisibleAtEnd,
        );
      });
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Scrollable.ensureVisible(
          context,
          duration: Duration(milliseconds: 300),
          alignmentPolicy: ScrollPositionAlignmentPolicy.keepVisibleAtStart,
        );
      });
    }
    return SubSectionData(
      subSection: this,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LinkButton(
            onPressed: () {
              GuideRoute.toSubSection(
                context,
                subSection: this,
              );
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                      width: 4.0,
                      color: (isSelected) ? Color(0xFF00afff) : Colors.transparent),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 30, top: 5.6, bottom: 5.6),
                child: Text(
                  title,
                  style: GoogleFonts.ubuntu(
                      textStyle: TextStyle(
                        fontSize: 15,
                        color: (isSelected) ? Color(0xFF00afff) : Color(0xFF2c3e50),
                        height: 1.4,
                      ),
                      fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal),
                ),
              ),
            ),
          ),
          if (isSelected) ...pageSections,
        ],
      ),
    );
  }
}

class SubSectionText extends SubSection {
  final String title;
  final List<PageSection> pageSections;
  final Widget description;

  SubSectionText({
    Key key,
    @required this.title,
    @required this.pageSections,
    this.description,
  });
}

class SubSectionExample extends SubSection {
  @override
  final String title;

  @override
  List<PageSection> get pageSections => [];
  @override
  final Widget description;
  final String codeName;

  SubSectionExample({
    @required this.title,
    @required this.description,
    @required this.codeName,
  });
}

class SubSectionData extends InheritedWidget {
  String get title => subSection.title;
  final SubSection subSection;

  const SubSectionData({
    Key key,
    @required Widget child,
    @required this.subSection,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(SubSectionData old) {
    return old.title != title;
  }
}

class PageSection extends StatelessWidget {
  final String title;
  final Widget description;
  final GlobalKey titleKey;

  PageSection({Key key, @required this.title, @required this.description})
      : titleKey = GlobalKey(debugLabel: 'PageSection with title $title'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSelected = InAppPage.of(context).pageSection == this;

    return LinkButton(
      onPressed: () {
        GuideRoute.toPageSection(
          context,
          pageSection: this,
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 46, top: 4, bottom: 4),
        child: Builder(
          builder: (context) {
            return Text(
              title,
              style: GoogleFonts.ubuntu(
                textStyle: TextStyle(
                  fontSize: 15,
                  color: isSelected ? Color(0xFF00afff) : Color(0xFF2c3e50),
                  height: 1.4,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class LinkButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const LinkButton({Key key, @required this.onPressed, @required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
        child: child,
      ),
    );
  }
}
