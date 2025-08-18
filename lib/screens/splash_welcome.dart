import 'package:flutter/material.dart';
import '../delyad_animations.dart';
import 'login_company.dart';

const kBlue = Color(0xFF2E8BD8);

class SplashWelcome extends StatelessWidget {
  static const routeName = '/';
  const SplashWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: kBlue,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.12),
              DelayedAnimations(
                delay: 700,
                child: Column(
                  children: [
                    // Remplace par ton Image.asset(logo) si tu veux
                    Text('arias\ninformatique',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 42,
                          height: 1.05,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.0,
                        )),
                    const SizedBox(height: 16),
                    const Text(
                      'Support client',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              DelayedAnimations(
                delay: 1400,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: kBlue,
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, LoginCompanyPage.routeName);
                    },
                    child: const Text('Continuer'),
                  ),
                ),
              ),
              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }
}
