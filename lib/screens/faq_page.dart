import 'package:flutter/material.dart';
import '../delyad_animations.dart';

class FaqPage extends StatelessWidget {
  static const routeName = '/faq';
  const FaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Foire aux Questions')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: const [
          DelayedAnimations(
            delay: 300,
            child: ListTile(
              title: Text('Comment créer un ticket ?'),
              subtitle: Text('Depuis Support > Ticket, remplissez le formulaire.'),
            ),
          ),
          DelayedAnimations(
            delay: 600,
            child: ListTile(
              title: Text('Qu’est-ce qui est facturé ?'),
              subtitle: Text('Selon votre contrat, certaines actions peuvent l’être.'),
            ),
          ),
        ],
      ),
    );
  }
}
