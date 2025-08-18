import 'package:flutter/material.dart';
import '../delyad_animations.dart';

class SavRequestPage extends StatelessWidget {
  static const routeName = '/sav';
  const SavRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Demande de SAV')),
      body: const Center(
        child: DelayedAnimations(
          delay: 400,
          child: Text('Formulaire SAV — à compléter selon ton backend.'),
        ),
      ),
    );
  }
}
