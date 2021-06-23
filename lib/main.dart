import 'package:flutter/material.dart';
import 'package:mero_share_portfolio/screens/main_screen.dart';
import 'package:provider/provider.dart';
import 'package:mero_share_portfolio/models/share_data_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ShareDataProvider(),
      child: MaterialApp(
        title: 'Mero Share Portfolio',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainScreen(),
      ),
    );
  }
}
