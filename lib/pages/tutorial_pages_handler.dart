import 'dart:math';

import 'package:easy_web_view/easy_web_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vrouter/vrouter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vrouter_website/main.dart';
import 'package:flutter/services.dart' show rootBundle;

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
      if (selectedPageSection.titleKey != null) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          Scrollable.ensureVisible(selectedPageSection.titleKey.currentContext,
              duration: Duration(milliseconds: 300));
        });
      }
    } else if (selectedSubSection != null) {
      if (selectedSubSection.titleKey != null) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          Scrollable.ensureVisible(selectedSubSection.titleKey.currentContext,
              duration: Duration(milliseconds: 300));
        });
      }
    }

    return Center(
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: selectedMainSection.buildPage(
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
                                  fontSize:
                                      max(20, MediaQuery.of(context).size.height * 0.025),
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
                                      context.vRouter.push(previousSubSectionLink);
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
                                      context.vRouter.push(nextSubSectionLink);
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

class TutorialExamplePage extends TutorialPage {
  @override
  final String previousSubSectionTitle;
  @override
  final String previousSubSectionLink;
  @override
  final SubExampleSection selectedSubSection;
  @override
  final String nextSubSectionTitle;
  @override
  final String nextSubSectionLink;
  @override
  final ScrollController _scrollController = ScrollController();

  TutorialExamplePage({
    Key key,
    @required this.previousSubSectionTitle,
    @required this.previousSubSectionLink,
    @required this.selectedSubSection,
    @required this.nextSubSectionTitle,
    @required this.nextSubSectionLink,
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
                    (previousSubSectionTitle != null)
                        ? LinkButton(
                            onPressed: () {
                              context.vRouter.push(previousSubSectionLink);
                            },
                            child: Row(
                              children: [
                                RotatedBox(
                                    quarterTurns: 2,
                                    child:
                                        Icon(Icons.arrow_right_alt, color: linkStyle.color)),
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
                              context.vRouter.push(nextSubSectionLink);
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
                          RenderBox box = widget.key.currentContext.findRenderObject();
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
