import 'package:flutter/cupertino.dart';
import 'package:demo/pages/demo.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting('nl_NL', null);
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: DemoPage(),
    );
  }
}
