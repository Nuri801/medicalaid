import 'package:flutter/material.dart';
import 'package:medicalaid/services/app_notification_service.dart';
import 'components/app_themes.dart';
import 'package:medicalaid/pages/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final notification = AppNotificationService();
  notification.initializeLocalNotification();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppThemes.lightTheme,
      home: const HomePage(),
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: child!,
      ),
    );

  }
}
