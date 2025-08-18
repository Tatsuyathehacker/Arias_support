import 'package:flutter/material.dart';
import '../delyad_animations.dart';
import 'dashboard_support.dart';
import 'package:google_fonts/google_fonts.dart';

const kBlue = Color(0xFF2E8BD8);

class LoginCompanyPage extends StatefulWidget {
  static const routeName = '/login';
  const LoginCompanyPage({super.key});

  @override
  State<LoginCompanyPage> createState() => _LoginCompanyPageState();
}

class _LoginCompanyPageState extends State<LoginCompanyPage> {
  final _formKey = GlobalKey<FormState>();
  final _userCtrl = TextEditingController();
  final _companyCtrl = TextEditingController();

  @override
  void dispose() {
    _userCtrl.dispose();
    _companyCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: kBlue,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 520),
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DelayedAnimations(
                      delay: 400,
                      child: SizedBox(
                        height: 200,
                        child: Image.asset(
                          'assets/images/logo_arias_bleu_nobackground.png',
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    DelayedAnimations(
                      delay: 700,
                      child: const Text('Nom d’utilisateur :',
                          style:
                              TextStyle(color: Colors.black54, fontSize: 16)),
                    ),
                    const SizedBox(height: 8),
                    DelayedAnimations(
                      delay: 900,
                      child: TextFormField(
                        controller: _userCtrl,
                        validator: (v) =>
                            (v == null || v.trim().isEmpty) ? 'Obligatoire' : null,
                      ),
                    ),
                    const SizedBox(height: 20),
                    DelayedAnimations(
                      delay: 1100,
                      child: const Text('Entreprise :',
                          style:
                              TextStyle(color: Colors.black54, fontSize: 16)),
                    ),
                    const SizedBox(height: 8),
                    DelayedAnimations(
                      delay: 1300,
                      child: TextFormField(
                        controller: _companyCtrl,
                        validator: (v) =>
                            (v == null || v.trim().isEmpty) ? 'Obligatoire' : null,
                      ),
                    ),
                    SizedBox(height: size.height * 0.06),
                    DelayedAnimations(
                      delay: 1500,
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.pushReplacementNamed(
                                  context, DashboardSupport.routeName,
                                  arguments: {
                                    'user': _userCtrl.text.trim(),
                                    'company': _companyCtrl.text.trim(),
                                  });
                            }
                          },
                          child: const Text('Continuer'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
