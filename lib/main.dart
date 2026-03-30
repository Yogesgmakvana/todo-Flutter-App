import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:todo_app/controllers/theme_controller.dart';
import 'package:todo_app/screens/addTodos_page.dart';
import 'package:todo_app/screens/home_screen.dart';
import 'package:todo_app/screens/splash_screen.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeController controller = Get.put(ThemeController());
   MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: controller.theme,
      home:SplashScreen(),
    );
  }
}

