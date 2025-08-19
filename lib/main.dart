import 'package:flutter/material.dart';
import 'screens/splash_welcome.dart';
import 'screens/login_company.dart';
import 'screens/dashboard_support.dart';
import 'screens/create_ticket.dart';
import 'screens/sav_request.dart';
import 'screens/faq_page.dart';
import 'screens/arias_intervention.dart';

const kBlue = Color(0xFF2E8BD8);
const kBg = Color(0xFFF6F7FA);

void main() {
  runApp(const AriasApp());
}

class AriasApp extends StatelessWidget {
  const AriasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Arias – Support',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: kBlue,
        scaffoldBackgroundColor: kBg,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kBlue,
            foregroundColor: Colors.white,
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: const BorderSide(color: Color(0xFFE0E3E8)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: const BorderSide(color: Color(0xFFE0E3E8)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: const BorderSide(color: kBlue, width: 1.4),
          ),
        ),
      ),
      initialRoute: SplashWelcome.routeName,
      routes: {
        SplashWelcome.routeName: (_) => const SplashWelcome(),
        LoginCompanyPage.routeName: (_) => const LoginCompanyPage(),
        DashboardSupport.routeName: (_) => const DashboardSupport(),
        CreateTicketPage.routeName: (_) => const CreateTicketPage(),
        SavRequestPage.routeName: (_) => const SavRequestPage(),
        FaqPage.routeName: (_) => const FaqPage(),
        InterventionFormPage.routeName: (_) => const InterventionFormPage(),
      },
    );
  }
}
