
import 'package:flutter/material.dart';

import '../features/auth/login_page.dart';
import '../features/home/home_page.dart';

class AppRoutes{
  static const homePage = '/home-page';
  static const loginPage = '/login-page';
  
}

class AppRouter {
 static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
   switch (settings.name) {
     case AppRoutes.homePage:
       return MaterialPageRoute<dynamic>(
           builder: (_) => const HomePage(),
         settings: settings,
       );

       case AppRoutes.loginPage:
       return MaterialPageRoute<dynamic>(
           builder: (_) => const LoginPage(),
         settings: settings,
       );


     default:
       return null;
   }
 }

}