import 'dart:math';

import 'package:easy_web_view/easy_web_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vrouter_website/in_app_page.dart';
import 'package:vrouter_website/main.dart';
import 'package:flutter/services.dart' show Clipboard, ClipboardData, rootBundle;
import 'package:vrouter_website/routes/guide_routes.dart';

import '../left_navigation_bar.dart';
import '../snack_bar_overlay.dart';

class TutorialPagesHandler extends StatefulWidget {
  @override
  _TutorialPagesHandlerState createState() => _TutorialPagesHandlerState();
}

class _TutorialPagesHandlerState extends State<TutorialPagesHandler> {
  Key mainSectionKey;
  MainSection mainSection;
  SubSection previousSubSection;
  SubSection selectedSubSection;
  SubSection nextSubSection;

  @override
  void didChangeDependencies() {
    mainSection ??= InAppPage.of(context).mainSection;
    mainSectionKey ??= ValueKey(InAppPage.of(context).subSection);
    previousSubSection ??= InAppPage.of(context).previousSubSection;
    selectedSubSection ??= InAppPage.of(context).subSection;
    nextSubSection ??= InAppPage.of(context).nextSubSection;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: mainSection.buildPage(
          key: mainSectionKey,
          previousSubSection: previousSubSection,
          selectedSubSection: selectedSubSection,
          nextSubSection: nextSubSection,
        ),
      ),
    );
  }

  void scrollToSection(BuildContext context) {
    if (InAppPage.of(context).pageSection != null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Scrollable.ensureVisible(InAppPage.of(context).pageSection.titleKey.currentContext,
            duration: Duration(milliseconds: 300));
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Scrollable.ensureVisible(InAppPage.of(context).subSection.titleKey.currentContext,
            duration: Duration(milliseconds: 300));
      });
    }
  }
}

abstract class TutorialPage extends StatelessWidget {
  SubSection get previousSubSection;

  SubSection get selectedSubSection;

  SubSection get nextSubSection;

  final ScrollController _scrollController = ScrollController();

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
                  padding: EdgeInsets.only(
                      bottom: max(20, MediaQuery.of(context).size.height / 10)),
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
                            (previousSubSection != null)
                                ? LinkButton(
                                    onPressed: () {
                                      GuideRoute.toSubSection(
                                        context,
                                        subSection: previousSubSection,
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        RotatedBox(
                                            quarterTurns: 2,
                                            child: Icon(Icons.arrow_right_alt,
                                                color: linkStyle.color)),
                                        Text(
                                          '${previousSubSection.title}',
                                          style: linkStyle.copyWith(
                                              decoration: TextDecoration.none,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(),
                            (nextSubSection != null)
                                ? LinkButton(
                                    onPressed: () {
                                      GuideRoute.toSubSection(
                                        context,
                                        subSection: nextSubSection,
                                      );
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          '${nextSubSection.title}',
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

class TutorialPageText extends TutorialPage {
  final SubSection previousSubSection;
  final SubSection selectedSubSection;
  final SubSection nextSubSection;
  final ScrollController _scrollController = ScrollController();

  TutorialPageText({
    Key key,
    @required this.previousSubSection,
    @required this.selectedSubSection,
    @required this.nextSubSection,
  });

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
                  padding: EdgeInsets.only(
                      bottom: max(20, MediaQuery.of(context).size.height / 10)),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          key: selectedSubSection.titleKey,
                          padding: const EdgeInsets.only(top: 40.0),
                          child: LinkedText(
                            onTap: () async {
                              final path = GuideRoute.toSubSection(
                                context,
                                subSection: selectedSubSection,
                              );

                              await Clipboard.setData(
                                  ClipboardData(text: 'https://vrouter.dev' + path));
                              showSnackBarOverlay(context);
                            },
                            text: Text(
                              selectedSubSection.title,
                              style: GoogleFonts.ubuntu(
                                textStyle: TextStyle(
                                  fontSize:
                                      max(24, MediaQuery.of(context).size.height * 0.035),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (selectedSubSection.description != null) ...[
                          SizedBox(height: MediaQuery.of(context).size.height / 30),
                          selectedSubSection.description,
                        ],
                        for (var i = 0; i < selectedSubSection.pageSections.length; i++) ...[
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 30,
                          ),
                          LinkedText(
                            onTap: () async {
                              final path = GuideRoute.toPageSection(
                                context,
                                pageSection: selectedSubSection.pageSections[i],
                              );

                              await Clipboard.setData(
                                  ClipboardData(text: 'https://vrouter.dev' + path));
                              showSnackBarOverlay(context);
                            },
                            text: Text(
                              selectedSubSection.pageSections[i].title,
                              key: selectedSubSection.pageSections[i].titleKey,
                              style: GoogleFonts.ubuntu(
                                textStyle: TextStyle(
                                  fontSize:
                                      max(20, MediaQuery.of(context).size.height * 0.025),
                                  fontWeight: FontWeight.bold,
                                ),
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
                            (previousSubSection != null)
                                ? LinkButton(
                                    onPressed: () {
                                      GuideRoute.toSubSection(
                                        context,
                                        subSection: previousSubSection,
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        RotatedBox(
                                            quarterTurns: 2,
                                            child: Icon(Icons.arrow_right_alt,
                                                color: linkStyle.color)),
                                        Text(
                                          '${previousSubSection.title}',
                                          style: linkStyle.copyWith(
                                              decoration: TextDecoration.none,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(),
                            (nextSubSection != null)
                                ? LinkButton(
                                    onPressed: () {
                                      GuideRoute.toSubSection(
                                        context,
                                        subSection: nextSubSection,
                                      );
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          '${nextSubSection.title}',
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

class TutorialPageExample extends TutorialPage {
  @override
  final SubSection previousSubSection;
  @override
  final SubSectionExample selectedSubSection;
  @override
  final SubSection nextSubSection;
  @override
  final ScrollController _scrollController = ScrollController();

  TutorialPageExample({
    Key key,
    @required this.previousSubSection,
    @required this.selectedSubSection,
    @required this.nextSubSection,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Padding(
          padding: EdgeInsets.only(bottom: max(20, MediaQuery.of(context).size.height / 100)),
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  key: selectedSubSection.titleKey,
                  padding: const EdgeInsets.only(top: 40.0),
                  child: LinkedText(
                    onTap: () => GuideRoute.toSubSection(
                      context,
                      subSection: selectedSubSection,
                    ),
                    text: Text(
                      selectedSubSection.title,
                      style: GoogleFonts.ubuntu(
                        textStyle: TextStyle(
                          fontSize: max(24, MediaQuery.of(context).size.height * 0.035),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                ...[
                  SizedBox(height: MediaQuery.of(context).size.height / 30),
                  selectedSubSection.description,
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 30,
                  ),
                ],
                Expanded(
                  child: ExampleContainer(codeName: selectedSubSection.codeName),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 30),
                Container(color: Colors.grey.shade400, height: 0.5),
                SizedBox(height: MediaQuery.of(context).size.height / 50),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    (previousSubSection != null)
                        ? LinkButton(
                            onPressed: () {
                              GuideRoute.toSubSection(
                                context,
                                subSection: previousSubSection,
                              );
                            },
                            child: Row(
                              children: [
                                RotatedBox(
                                    quarterTurns: 2,
                                    child:
                                        Icon(Icons.arrow_right_alt, color: linkStyle.color)),
                                Text(
                                  '${previousSubSection.title}',
                                  style: linkStyle.copyWith(
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                    (nextSubSection != null)
                        ? LinkButton(
                            onPressed: () {
                              GuideRoute.toSubSection(
                                context,
                                subSection: nextSubSection,
                              );
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '${nextSubSection.title}',
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
    );
  }
}

class ExampleContainer extends StatefulWidget {
  final String codeName;
  @override
  final GlobalKey<_ExampleContainerState> key;

  ExampleContainer({@required this.codeName}) : key = GlobalKey<_ExampleContainerState>();

  @override
  _ExampleContainerState createState() => _ExampleContainerState();
}

class _ExampleContainerState extends State<ExampleContainer> {
  final maxFlex = 1000;
  double offsetFraction = 0.5;

  @override
  Widget build(BuildContext context) {
    final offsetFlex = min(maxFlex - 1, max(1, (offsetFraction * maxFlex).toInt()));
    final inverseOffsetFlex = maxFlex - offsetFlex;

    return Container(
      color: MyDartCodeViewer.backgroundColor,
      padding: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
            children: [
              Container(
                height: 25,
                child: Stack(
                  children: [
                    Positioned(
                      left: min(constraints.maxWidth - 28,
                          max(-20, offsetFraction * (constraints.maxWidth - 4) + 2 - 19)),
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onHorizontalDragUpdate: (DragUpdateDetails dragUpdateDetails) {
                          RenderBox box =
                              widget.key.currentContext.findRenderObject() as RenderBox;
                          final localX =
                              box.globalToLocal(dragUpdateDetails.globalPosition).dx;

                          setState(() => offsetFraction = localX / constraints.maxWidth);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: HandleWidget(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Row(
                  children: [
                    Flexible(
                      flex: offsetFlex,
                      child: FutureBuilder(
                        future: rootBundle.loadString('examples/${widget.codeName}.dart'),
                        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                          return MyDartCodeViewer(
                            code: snapshot.data ?? '',
                            roundedEdges: false,
                          );
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: HandleWidget.color),
                        color: HandleWidget.color,
                      ),
                      width: 4,
                    ),
                    Flexible(
                      flex: inverseOffsetFlex,
                      child: EasyWebView(
                        src:
                            'https://vrouter.dev/examples/${Uri.encodeComponent(widget.codeName)}/',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class HandleWidget extends StatelessWidget {
  static final color = Colors.lightBlueAccent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            RotatedBox(
              quarterTurns: 3,
              child: CustomPaint(
                size: Size(10, 6),
                painter: TrianglePainter(
                  strokeColor: color,
                  strokeWidth: 0,
                  paintingStyle: PaintingStyle.fill,
                ),
              ),
            ),
            SizedBox(
              width: 4,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: color),
                color: color,
              ),
              height: 15,
              width: 3,
            ),
            SizedBox(
              width: 4,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: color),
                color: color,
              ),
              height: 15,
              width: 4,
            ),
            SizedBox(
              width: 4,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: color),
                color: color,
              ),
              height: 15,
              width: 3,
            ),
            SizedBox(
              width: 4,
            ),
            RotatedBox(
              quarterTurns: 1,
              child: CustomPaint(
                size: Size(10, 6),
                painter: TrianglePainter(
                  strokeColor: color,
                  strokeWidth: 0,
                  paintingStyle: PaintingStyle.fill,
                ),
              ),
            )
          ],
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: color),
            color: color,
          ),
          height: 5,
          width: 4,
        ),
      ],
    );
  }
}

class TrianglePainter extends CustomPainter {
  final Color strokeColor;
  final PaintingStyle paintingStyle;
  final double strokeWidth;

  TrianglePainter(
      {this.strokeColor = Colors.black,
      this.strokeWidth = 3,
      this.paintingStyle = PaintingStyle.stroke});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..style = paintingStyle;

    canvas.drawPath(getTrianglePath(size.width, size.height), paint);
  }

  Path getTrianglePath(double x, double y) {
    return Path()
      ..moveTo(0, y)
      ..lineTo(x / 2, 0)
      ..lineTo(x, y)
      ..lineTo(0, y);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return oldDelegate.strokeColor != strokeColor ||
        oldDelegate.paintingStyle != paintingStyle ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}

class LinkedText extends StatefulWidget {
  final Text text;
  final VoidCallback onTap;

  const LinkedText({
    @required this.text,
    @required this.onTap,
  });

  @override
  _LinkedTextState createState() => _LinkedTextState();
}

class _LinkedTextState extends State<LinkedText> {
  bool shouldShowLink = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() {
          shouldShowLink = true;
        });
      },
      onExit: (_) {
        setState(() {
          shouldShowLink = false;
        });
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.text,
            if (shouldShowLink)
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Icon(
                  Icons.link,
                  size: max(24, (context.findRenderObject() as RenderBox).size.height - 10),
                  color: Colors.grey[700],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
