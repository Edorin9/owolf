import 'package:flutter/widgets.dart';

import '../features/break/view/break_page.dart';
import '../features/home/view/home_page.dart';

final routes = <String, WidgetBuilder>{
  HomePage.name: HomePage.route(),
  BreakPage.name: BreakPage.route(),
};
