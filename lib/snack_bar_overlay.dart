import 'package:flutter/material.dart';

void showSnackBarOverlay(BuildContext context) {
  final entry = OverlayEntry(
    builder: (context) {
      return CustomSnackBar();
    },
  );
  Overlay.of(context, rootOverlay: true).insert(entry);

  Future.delayed(Duration(seconds: 2)).then((_) => entry.remove());
}

class CustomSnackBar extends StatefulWidget {
  @override
  _CustomSnackBarState createState() => _CustomSnackBarState();
}

class _CustomSnackBarState extends State<CustomSnackBar> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _fadeAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.0, 1, curve: Curves.easeIn),
      ),
    );

    _animate();

    // Time the animation
    super.initState();
  }

  Future<void> _animate() async {
    await _animationController.forward();

    await Future.delayed(Duration(milliseconds: 1400));

    await _animationController.reverse();
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Material(
        color: Colors.transparent,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.grey[300],
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text("Link copied"),
            ),
          ),
        ),
      ),
    );
  }
}
