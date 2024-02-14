import 'package:flutter/cupertino.dart';

abstract class GlobalContext {
  static GlobalKey<NavigatorState> globalNavigatorContext = GlobalKey<NavigatorState>();
}