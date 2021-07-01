import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

class NavigatorWrapper extends StatelessWidget {
  final Widget child;
  final TextEditingController urlController = TextEditingController();

  NavigatorWrapper({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    urlController.text = context.vRouter.url
        .substring(RegExp('(.*?\/){3}').firstMatch(context.vRouter.url).end - 1);
    final currentExample =
        RegExp('((?<=\/).*?(?=\/))').allMatches(context.vRouter.url).elementAt(1).group(1);

    return Material(
      child: Column(
        children: [
          Row(
            children: [
              RemoveSplash(
                child: IconButton(
                  onPressed: context.vRouter.urlHistoryCanBack()
                      ? () => context.vRouter.urlHistoryBack()
                      : null,
                  icon: Icon(Icons.navigate_before),
                ),
              ),
              RemoveSplash(
                child: IconButton(
                  onPressed: context.vRouter.urlHistoryCanForward()
                      ? () => context.vRouter.urlHistoryForward()
                      : null,
                  icon: Icon(Icons.navigate_next),
                ),
              ),
              RemoveSplash(
                child: IconButton(
                  onPressed: () => context.vRouter.to(
                    context.vRouter.url,
                    isReplacement: true,
                    historyState: context.vRouter.historyState,
                  ),
                  icon: Icon(Icons.refresh),
                ),
              ),
              SizedBox(width: 10),
              Flexible(
                child: Container(
                  height: 30,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.circular(5000),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
                    ),
                    controller: urlController,
                    style: TextStyle(fontSize: 18),
                    onSubmitted: (newUrl) =>
                        context.vRouter.to('/examples/$currentExample$newUrl'),
                  ),
                ),
              ),
              SizedBox(width: 20),
            ],
          ),
          Flexible(child: child),
        ],
      ),
    );
  }
}

class RemoveSplash extends StatelessWidget {
  final Widget child;

  const RemoveSplash({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
      ),
      child: child,
    );
  }
}
