//@dart=2.9
import 'package:deai_client/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'CompositionRoot.dart';
import 'Constants/strings.dart';
import 'start.dart';


class AppRouter {

  static Route generateRoute(RouteSettings settings) {
    CompositionRoot.configure();
    switch (settings.name) {
      case HOME_SCREEN:
        return MaterialPageRoute(
          builder: (_) => Start(),
        );

      case DASHBOARD_SCREEN:
        return MaterialPageRoute(
          builder: (_) => CompositionRoot.composeHomeUi()
        );

      

      default:
        return null;
    }
  }
}
