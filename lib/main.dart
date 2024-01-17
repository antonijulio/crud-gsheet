import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_data/pages/home/home_page.dart';
import 'package:user_data/pages/home/submit_provider.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SubmitProvider(),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
