import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'presentation/pages/login_page.dart';
import 'presentation/pages/product_list_page.dart';


SharedPreferences? prefs;
bool isLogin = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  isLogin = prefs!.getBool('isLogin') ?? false;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'mobile_store',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: isLogin ? ProductListPage() : LoginPage(),
    );
  }
}
