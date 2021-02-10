import 'package:complete_app/vrouter/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

class LeftNavigationBar extends StatelessWidget {
  final List<MainSection> sections;

  LeftNavigationBar({@required this.sections});

  @override
  Widget build(BuildContext context) {
    return LeftNavigationBarData(
      sections: sections,
      child: Scrollbar(
        child: Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: SingleChildScrollView(
            child: Builder(builder: (context) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: sections,
              );
            }),
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
  })  : assert(child != null),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(LeftNavigationBarData old) {
    return false;
  }
}

class MainSection extends StatelessWidget {
  final String title;
  final List<SubSection> subSections;

  const MainSection({Key key, @required this.title, @required this.subSections})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSelected = (VRouteData.of(context).pathParameters['mainSection'] != null)
        ? (VRouteData.of(context).pathParameters['mainSection'] == Uri.encodeComponent(title))
        : LeftNavigationBar.of(context).sections.first == this;

    return MainSectionData(
      title: title,
      isSelected: isSelected,
      subSections: subSections,
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
                      color: Color(0xFF2c3e50))),
            ),
          ),
          ...subSections,
        ],
      ),
    );
  }

  static MainSectionData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MainSectionData>();
  }
}

class MainSectionData extends InheritedWidget {
  final String title;
  final bool isSelected;
  final List<SubSection> subSections;

  const MainSectionData({
    Key key,
    @required Widget child,
    @required this.title,
    @required this.isSelected,
    @required this.subSections,
  })  : assert(child != null),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(MainSectionData old) {
    return old.title != title || old.isSelected != isSelected;
  }
}

class SubSection extends StatelessWidget {
  final String title;
  final List<PageSection> pageSections;
  final Widget description;
  final GlobalKey titleKey;

  SubSection({
    Key key,
    @required this.title,
    @required this.pageSections,
    this.description,
  })  : titleKey = GlobalKey(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSelected = (VRouteData.of(context).pathParameters['subSection'] != null)
        ? (VRouteData.of(context).pathParameters['subSection'] == Uri.encodeComponent(title))
        : (MainSection.of(context).isSelected &&
            MainSection.of(context).subSections.first == this);

    return SubSectionData(
      title: title,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LinkButton(
            onPressed: () {
              VRouterData.of(context).push(
                  '/guide/${Uri.encodeComponent(MainSection.of(context).title)}/${Uri.encodeComponent(title)}');
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

  static SubSectionData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SubSectionData>();
  }
}

class SubSectionData extends InheritedWidget {
  final String title;

  const SubSectionData({
    Key key,
    @required Widget child,
    @required this.title,
  })  : assert(child != null),
        super(key: key, child: child);

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
      : titleKey = GlobalKey(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSelected =
        VRouteData.of(context).pathParameters['pageSection'] == Uri.encodeComponent(title);

    return LinkButton(
      onPressed: () {
        VRouterData.of(context).push(
            '/guide/${Uri.encodeComponent(MainSection.of(context).title)}/${Uri.encodeComponent(SubSection.of(context).title)}/${Uri.encodeComponent(title)}');
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 46, top: 4, bottom: 4),
        child: Text(
          title,
          style: GoogleFonts.ubuntu(
              textStyle: TextStyle(
            fontSize: 15,
            color: isSelected ? Color(0xFF00afff) : Color(0xFF2c3e50),
            height: 1.4,
          )),
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
