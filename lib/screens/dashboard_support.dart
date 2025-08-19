import 'package:flutter/material.dart';
import '../delyad_animations.dart';
import 'create_ticket.dart';
import 'sav_request.dart';
import 'faq_page.dart';
import 'package:google_fonts/google_fonts.dart';

const kBlue = Color(0xFF2E8BD8);
const kBg = Color(0xFFF6F7FA);

class DashboardSupport extends StatelessWidget {
  static const routeName = '/dashboard';
  const DashboardSupport({super.key});

  @override
  Widget build(BuildContext context) {
    final args = (ModalRoute.of(context)?.settings.arguments ?? {}) as Map;
    final user = args['user'] ?? '';
    return Scaffold(
      backgroundColor: kBg,
      body: SafeArea(
        child: Column(
          children: [
            // Bandeau bleu avec logo
            Container(
              width: double.infinity,
              color: kBlue,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // petit padding
              child: SafeArea(
                bottom: false,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      DelayedAnimations(
                        delay: 100,
                        child: Image.asset(
                          'assets/images/logo_arias-nobackground.png',
                        height: 100, // taille du logo
                        fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            // Le reste de la page prend tout l’espace restant
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DelayedAnimations(
                      delay: 400,
                      child: const Text(
                        'Support',
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(height: 6),
                    DelayedAnimations(
                      delay: 700,
                      child: Text(
                        user.toString().isNotEmpty
                            ? 'Bienvenue $user. Arias vous promet une assistance support le plus rapidement possible.'
                            : 'Bienvenue. Arias vous promet une assistance support le plus rapidement possible.',
                        style: const TextStyle(color: Colors.black54, fontSize: 15.5),
                      ),
                    ),
                    const SizedBox(height: 18),
                    _SupportTile(
                      delay: 900,
                      icon: Icons.confirmation_number_outlined,
                      title: 'Ticket',
                      subtitle: 'Pour toute demande d’intervention',
                      onTap: () =>
                          Navigator.pushNamed(context, CreateTicketPage.routeName),
                    ),
                    _SupportTile(
                      delay: 1100,
                      icon: Icons.home_repair_service_outlined,
                      title: 'Demande de SAV',
                      subtitle: 'Demande de réparation etc…',
                      onTap: () =>
                          Navigator.pushNamed(context, SavRequestPage.routeName),
                    ),
                    _SupportTile(
                      delay: 1300,
                      icon: Icons.question_answer_outlined,
                      title: 'Foire aux Questions',
                      subtitle:
                          'Toutes les questions que vous vous posez le sont également pour d’autres.',
                      onTap: () =>
                          Navigator.pushNamed(context, FaqPage.routeName),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SupportTile extends StatelessWidget {
  final int delay;
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SupportTile({
    required this.delay,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return DelayedAnimations(
      delay: delay,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ListTile(
          leading: Icon(icon, color: kBlue, size: 40),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
          subtitle: Text(subtitle),
          onTap: onTap,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),
    );
  }
}
