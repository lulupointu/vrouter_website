import 'package:vrouter/vrouter.dart';
import 'package:flutter/material.dart';
import 'package:vrouter_website/pages/examples/examples_screen.dart';
import 'package:vrouter_website/pages/examples/navigator_wrapper.dart';

import 'package:vrouter_website/pages/examples/executable/basic_example_executable.dart'
    as basic_example;
import 'package:vrouter_website/pages/examples/executable/stacked_routes.dart'
    as stacked_routes;
import 'package:vrouter_website/pages/examples/executable/nesting_executable.dart' as nesting;
import 'package:vrouter_website/pages/examples/executable/redirection_executable.dart'
    as redirection;
import 'package:vrouter_website/pages/examples/executable/transitions_executable.dart'
    as transitions;
import 'package:vrouter_website/pages/examples/executable/path_parameters_executable.dart'
    as path_parameters;
import 'package:vrouter_website/pages/examples/executable/history_example.dart' as history;

class ExampleRoute extends VRouteElementBuilder {
  @override
  List<VRouteElement> buildRoutes() {
    return [
      VWidget(
        path: '/examples/all',
        widget: ExamplesScreen(),
        stackedRoutes: [
          VNester(
            path: '/examples',
            widgetBuilder: (child) => NavigatorWrapper(child: child),
            nestedRoutes: [
              // Basic example
              VWidget(path: 'basic_example/', widget: basic_example.HomeScreen()),
              VWidget(path: 'basic_example/settings', widget: basic_example.SettingsScreen()),
              VRouteRedirector(
                path: r'basic_example:_(.*)',
                redirectTo: '/examples/basic_example/',
              ),

              // Stacking example
              VWidget(
                path: 'stacked_routes/',
                widget: stacked_routes.HomeScreen(),
                stackedRoutes: [
                  VWidget(path: 'settings', widget: stacked_routes.SettingsScreen()),
                ],
              ),
              VRouteRedirector(
                path: r'stacked_routes:_(.*)',
                redirectTo: '/examples/stacked_routes/',
              ),

              // Nesting
              VNester(
                path: 'nesting/',
                widgetBuilder: (child) => nesting.MyScaffold(child),
                // Child is the widget from nestedRoutes
                nestedRoutes: [
                  VWidget(path: null, widget: nesting.HomeScreen()),
                  // null path matches parent
                  VWidget(path: 'settings', widget: nesting.SettingsScreen()),
                ],
              ),
              VRouteRedirector(path: r'nesting:_(.*)', redirectTo: '/examples/nesting/'),

              // Redirection
              VWidget(
                  path: 'redirection/login',
                  widget: redirection.LoginScreen(redirection.login)),
              VGuard(
                beforeEnter: (vRedirector) async => redirection.isLoggedIn
                    ? null
                    : vRedirector.to('/examples/redirection/login'),
                stackedRoutes: [
                  VWidget(
                      path: 'redirection/home',
                      widget: redirection.HomeScreen(redirection.logout))
                ],
              ),
              VRouteRedirector(
                path: r'redirection/:_(.*)',
                redirectTo: '/examples/redirection/home',
              ),

              // Transitions
              VWidget(
                path: 'transitions/',
                widget: transitions.HomeScreen(),
                transitionDuration: Duration(seconds: 1),
                buildTransition: (animation, _, child) => ScaleTransition(
                  scale: animation,
                  child: child,
                ),
              ),
              VPage(
                path: 'transitions/settings',
                widget: transitions.SettingsScreen(),
                pageBuilder: (LocalKey key, Widget child, String name) =>
                    transitions.AnimatedPage(child, key, name),
              ),
              VRouteRedirector(
                path: r'transitions:_(.*)',
                redirectTo: '/examples/transitions/',
              ),

              // Url parameters
              VWidget(
                  path: 'path_parameters/user/:userId', widget: path_parameters.UserScreen()),
              VGuard(
                beforeEnter: (vRedirector) async =>
                    vRedirector.to('/examples/path_parameters/user/bob'),
                stackedRoutes: [VWidget(path: 'path_parameters', widget: Container())],
              ),
              VRouteRedirector(
                path: r'path_parameters:_(.*)',
                redirectTo: '/examples/path_parameters',
              ),

              // Url history
              VNester(
                path: 'history/',
                widgetBuilder: (child) => history.MyScaffold(
                  child: child,
                  baseUrl: '/examples/history',
                ),
                nestedRoutes: [
                  // Handles the systemPop event
                  VPopHandler(
                    onSystemPop: (vRedirector) async {
                      // DO check if going back is possible
                      if (vRedirector.historyCanBack()) {
                        vRedirector.historyBack();
                      }
                    },
                    stackedRoutes: [
                      VWidget(
                          path: '',
                          widget: history.HomeScreen(title: 'Home', color: Colors.blueAccent)),
                      VWidget(
                          path: 'social',
                          widget:
                              history.BasicScreen(title: 'Social', color: Colors.greenAccent)),
                      VWidget(
                          path: 'settings',
                          widget:
                              history.BasicScreen(title: 'Settings', color: Colors.redAccent)),
                    ],
                  ),
                ],
              ),
              VRouteRedirector(
                path: r'history:_(.*)',
                redirectTo: '/examples/history/',
              ),
            ],
          ),
        ],
      )
    ];
  }
}
