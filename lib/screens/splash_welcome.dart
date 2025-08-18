import 'package:flutter/material.dart';
import '../delyad_animations.dart';
import 'login_company.dart';
import 'package:google_fonts/google_fonts.dart';

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

              // Bloc logo + texte
              DelayedAnimations(
                delay: 700,
                child: Column(
                  children: [
                    DelayedAnimations(
                      delay: 1500,
                      child: SizedBox(
                        height: 450,
                        child: Image.asset(
                          'assets/images/logo_arias-nobackground.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    DelayedAnimations(
                      delay: 2000,
                      child: Text(
                        'Support Technique',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunito(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Bouton Continuer
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
                        context,
                        LoginCompanyPage.routeName,
                      );
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
