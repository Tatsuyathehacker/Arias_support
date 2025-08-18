import 'package:flutter/material.dart';
import '../delyad_animations.dart';

const kBlue = Color(0xFF2E8BD8);

enum TicketCategory { reseau, logiciel, materiel, securite, autre }
enum TicketUrgency { basse, normale, haute, urgente }

class CreateTicketPage extends StatefulWidget {
  static const routeName = '/create-ticket';
  const CreateTicketPage({super.key});

  @override
  State<CreateTicketPage> createState() => _CreateTicketPageState();
}

class _CreateTicketPageState extends State<CreateTicketPage> {
  final _formKey = GlobalKey<FormState>();
  final _subjectCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  TicketCategory? _category = TicketCategory.reseau;
  TicketUrgency? _urgency = TicketUrgency.normale;

  @override
  void dispose() {
    _subjectCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBlue,
        foregroundColor: Colors.white,
        title: const Text('Nouveau ticket'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 18, 24, 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DelayedAnimations(
                  delay: 300,
                  child: const Text('Sujet :',
                      style: TextStyle(color: Colors.black54, fontSize: 16)),
                ),
                const SizedBox(height: 8),
                DelayedAnimations(
                  delay: 500,
                  child: TextFormField(
                    controller: _subjectCtrl,
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? 'Obligatoire' : null,
                  ),
                ),
                const SizedBox(height: 20),
                DelayedAnimations(
                  delay: 700,
                  child: const Text('Catégorie :',
                      style: TextStyle(color: Colors.black54, fontSize: 16)),
                ),
                const SizedBox(height: 8),
                DelayedAnimations(
                  delay: 900,
                  child: DropdownButtonFormField<TicketCategory>(
                    value: _category,
                    items: const [
                      DropdownMenuItem(
                          value: TicketCategory.reseau, child: Text('Réseau')),
                      DropdownMenuItem(
                          value: TicketCategory.logiciel, child: Text('Logiciel')),
                      DropdownMenuItem(
                          value: TicketCategory.materiel, child: Text('Matériel')),
                      DropdownMenuItem(
                          value: TicketCategory.securite, child: Text('Sécurité')),
                      DropdownMenuItem(
                          value: TicketCategory.autre, child: Text('Autre')),
                    ],
                    onChanged: (v) => setState(() => _category = v),
                  ),
                ),
                const SizedBox(height: 20),
                DelayedAnimations(
                  delay: 1100,
                  child: const Text('Urgence du traitement :',
                      style: TextStyle(color: Colors.black54, fontSize: 16)),
                ),
                const SizedBox(height: 8),
                DelayedAnimations(
                  delay: 1300,
                  child: DropdownButtonFormField<TicketUrgency>(
                    value: _urgency,
                    items: const [
                      DropdownMenuItem(
                          value: TicketUrgency.basse, child: Text('Basse')),
                      DropdownMenuItem(
                          value: TicketUrgency.normale, child: Text('Normale')),
                      DropdownMenuItem(
                          value: TicketUrgency.haute, child: Text('Haute')),
                      DropdownMenuItem(
                          value: TicketUrgency.urgente, child: Text('Urgente')),
                    ],
                    onChanged: (v) => setState(() => _urgency = v),
                  ),
                ),
                const SizedBox(height: 20),
                DelayedAnimations(
                  delay: 1500,
                  child: const Text('Description :',
                      style: TextStyle(color: Colors.black54, fontSize: 16)),
                ),
                const SizedBox(height: 8),
                DelayedAnimations(
                  delay: 1700,
                  child: TextFormField(
                    controller: _descCtrl,
                    minLines: 6,
                    maxLines: 10,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? 'Obligatoire' : null,
                  ),
                ),
                const SizedBox(height: 28),
                DelayedAnimations(
                  delay: 1900,
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // TODO: appeler ton backend / Firebase
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Ticket envoyé ✔')),
                          );
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Envoyer'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
