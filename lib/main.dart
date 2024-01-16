import 'package:flutter/material.dart';
import 'package:user_data/pages/home_page.dart';
import 'package:user_data/service/gsheets_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //init gsheet
  GSheetsService.init();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
