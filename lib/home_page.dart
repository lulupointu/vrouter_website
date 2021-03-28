import 'dart:math';

import 'package:vrouter/vrouter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                const Color(0xFF00a6ff),
                const Color(0xFF00CCFF),
              ],
              begin: const FractionalOffset(1.0, 0.0),
              end: const FractionalOffset(0.0, 1.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LogoWidget(),
              VersionWidget(),
              SizedBox(height: MediaQuery.of(context).size.height / 20),
              CatchPhraseWidget(),
              SizedBox(height: MediaQuery.of(context).size.height / 20),
              CallToActionWidgets(),
            ],
          ),
        ),
      ),
    );
  }
}

class LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          'assets/v_logo.svg',
          width: min(130, MediaQuery.of(context).size.width/4),
        ),
        Text(
          'Router',
          style: GoogleFonts.ubuntu(
              textStyle: TextStyle(fontSize: min(100, MediaQuery.of(context).size.width/5), color: Color(0xFF015292))),
        ),
      ],
    );
  }
}

class VersionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'v1.1',
      style: GoogleFonts.ubuntu(textStyle: TextStyle(fontSize: 20, color: Color(0xFF015292))),
    );
  }
}

class CatchPhraseWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'An easy way to manage routing on Flutter.',
      style: GoogleFonts.ubuntu(textStyle: TextStyle(fontSize: 20, color: Color(0xFF015292))),
      textAlign: TextAlign.center,
    );
  }
}

class CallToActionWidgets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      runSpacing: min(MediaQuery.of(context).size.width / 20, 40),
      spacing: min(MediaQuery.of(context).size.width / 20, 40),
      children: [
        LightButton(
          title: 'GitHub',
          onPressed: () => context.vRouter.pushExternal('https://github.com/lulupointu/vrouter'),
        ),
        LightButton(
          title: 'Pub.dev',
          onPressed: () => context.vRouter.pushExternal('https://pub.dev/packages/vrouter'),
        ),
        GetStartedButton(),
      ],
    );
  }
}

class LightButton extends StatefulWidget {
  final String title;
  final VoidCallback onPressed;

  const LightButton({Key key, @required this.title, @required this.onPressed})
      : super(key: key);

  @override
  _LightButtonState createState() => _LightButtonState();
}

class _LightButtonState extends State<LightButton> {
  bool hasMouseHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() {
          hasMouseHover = true;
        });
      },
      onExit: (_) {
        setState(() {
          hasMouseHover = false;
        });
      },
      child: GestureDetector(
        onTap: widget.onPressed,
        child: TweenAnimationBuilder(
          duration: Duration(milliseconds: 300),
          tween: ColorTween(
              begin: Color(0xFF9ce0ff),
              end: hasMouseHover ? Color(0xFF015292) : Color(0xFF9ce0ff)),
          builder: (_, Color color, __) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(60),
                border: Border.all(width: 1, color: color),
              ),
              padding: EdgeInsets.all(10),
              child: Text(
                widget.title,
                style: GoogleFonts.ubuntu(textStyle: TextStyle(fontSize: 20, color: color)),
              ),
            );
          },
        ),
      ),
    );
  }
}

class GetStartedButton extends StatefulWidget {
  @override
  _GetStartedButtonState createState() => _GetStartedButtonState();
}

class _GetStartedButtonState extends State<GetStartedButton> {
  bool hasMouseHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() {
          hasMouseHover = true;
        });
      },
      onExit: (_) {
        setState(() {
          hasMouseHover = false;
        });
      },
      child: GestureDetector(
        onTap: () => context.vRouter.push('/guide'),
        child: TweenAnimationBuilder(
          duration: Duration(milliseconds: 300),
          tween: ColorTween(
              begin: Color(0xFF80d7ff),
              end: hasMouseHover ? Color(0xFF015292) : Color(0xFF80d7ff)),
          builder: (_, Color color, child) {
            return Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(60),
                border: Border.all(width: 1, color: color),
              ),
              padding: EdgeInsets.all(10),
              child: child,
            );
          },
          child: TweenAnimationBuilder(
            duration: Duration(milliseconds: 300),
            tween: ColorTween(
                begin: Color(0xFF80d7ff),
                end: hasMouseHover ? Color(0xFF80d7ff) : Color(0xFF015292)),
            builder: (_, Color color, __) {
              return Text(
                'Get Started',
                style: GoogleFonts.ubuntu(textStyle: TextStyle(fontSize: 20, color: color)),
              );
            },
          ),
        ),
      ),
    );
  }
}
