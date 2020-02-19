import 'package:flutter/widgets.dart';

class Routing {
  final current;
  final previous;
  final args;
  final previousArgs;
  final removed;
  final bool isBack;
  final bool isSnackbar;
  final bool isBottomSheet;
  final bool isDialog;
  Routing({
    this.current,
    this.previous,
    this.args,
    this.previousArgs,
    this.removed,
    this.isBack,
    this.isSnackbar,
    this.isBottomSheet,
    this.isDialog,
  });
}

class GetObserver extends NavigatorObserver {
  final Function(Routing) routing;
  GetObserver(this.routing);
  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    if ('${route?.settings?.name}' == 'snackbar') {
      print("[OPEN SNACKBAR] ${route?.settings?.name}");
    } else if ('${route?.settings?.name}' == 'bottomsheet') {
      print("[OPEN BOTTOMSHEET] ${route?.settings?.name}");
    } else if ('${route?.settings?.name}' == 'dialog') {
      print("[OPEN DIALOG] ${route?.settings?.name}");
    } else {
      print("[GOING TO ROUTE] ${route?.settings?.name}");
    }

    routing(Routing(
        removed: null,
        isBack: false,
        current: '${route?.settings?.name}',
        previous: '${previousRoute?.settings?.name}',
        args: route?.settings?.arguments,
        previousArgs: previousRoute?.settings?.arguments,
        isSnackbar: '${route?.settings?.name}' == 'snackbar'));
  }

  @override
  void didPop(Route route, Route previousRoute) {
    super.didPop(route, previousRoute);

    if ('${route?.settings?.name}' == 'snackbar') {
      print("[CLOSE SNACKBAR] ${route?.settings?.name}");
    } else if ('${route?.settings?.name}' == 'bottomsheet') {
      print("[CLOSE BOTTOMSHEET] ${route?.settings?.name}");
    } else if ('${route?.settings?.name}' == 'dialog') {
      print("[CLOSE DIALOG] ${route?.settings?.name}");
    } else if ('${route?.settings?.name}' == 'snackbar') {
      print("[CLOSE SNACKBAR] ${route?.settings?.name}");
    } else {
      print("[BACK ROUTE] ${route?.settings?.name}");
    }

    routing(Routing(
        removed: null,
        isBack: true,
        current: '${previousRoute?.settings?.name}',
        previous: '${route?.settings?.name}',
        args: previousRoute?.settings?.arguments,
        previousArgs: route?.settings?.arguments,
        isSnackbar: '${route?.settings?.name}' == 'snackbar'));
  }

  @override
  void didReplace({Route newRoute, Route oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    print("[REPLACE ROUTE] ${oldRoute?.settings?.name}");

    routing(Routing(
        removed: null, // add '${oldRoute?.settings?.name}' or remain null ???
        isBack: false,
        current: '${newRoute?.settings?.name}',
        previous: '${oldRoute?.settings?.name}',
        args: newRoute?.settings?.arguments,
        isSnackbar: null,
        previousArgs: null));
  }

  @override
  void didRemove(Route route, Route previousRoute) {
    super.didRemove(route, previousRoute);
    print("[REMOVING ROUTE] ${route?.settings?.name}");

    routing(Routing(
        isBack: false,
        current: '${previousRoute?.settings?.name}',
        removed: '${route?.settings?.name}',
        previous: null,
        isSnackbar: null,
        args: previousRoute?.settings?.arguments,
        previousArgs: route?.settings?.arguments));
  }
}
