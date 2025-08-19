import 'package:flutter/material.dart';
import '../delyad_animations.dart';
import 'package:signature/signature.dart';
import 'dart:typed_data';

const kBlue = Color(0xFF2E8BD8);
const kBg = Color(0xFFF6F7FA);

class InterventionFormPage extends StatefulWidget {
  static const routeName = '/intervention-form';
  const InterventionFormPage({super.key});

  @override
  State<InterventionFormPage> createState() => _InterventionFormPageState();
}

class _InterventionFormPageState extends State<InterventionFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _addrCtrl = TextEditingController();
  final _interCtrl = TextEditingController();

  // Signature
  late final SignatureController _sigCtrl;
  Uint8List? _signaturePng;

  String? _clientName;

  @override
  void initState() {
    super.initState();
    _sigCtrl = SignatureController(
      penStrokeWidth: 3,
      penColor: Colors.black87,
      exportBackgroundColor: const Color(0xFFEDEFF3),
    );
  }

  @override
  void dispose() {
    _sigCtrl.dispose();
    _addrCtrl.dispose();
    _interCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlue,
      body: SafeArea(
        child: Stack(
          children: [
            // Panneau blanc « coupé » en diagonale
            Positioned.fill(
              child: ClipPath(
                clipper: _LeftDiagonalClipper(),
                child: Container(color: Colors.white),
              ),
            ),

            // Contenu
            Positioned.fill(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Ligne du haut : logo + bouton Envoyer
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/original_logo.jpg',
                            height: 48,
                            fit: BoxFit.contain,
                          ),
                          const Spacer(),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: kBlue,
                              shape: const StadiumBorder(),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              elevation: 0,
                            ),
                            onPressed: _onSubmit,
                            child: const Text('Envoyer'),
                          ),
                        ],
                      ),

                      const SizedBox(height: 18),

                      // Titre section
                      const Text(
                        'information client :',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 14),

                      // NOM (dropdown)
                      const Text('Nom :',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 6),
                      _RoundedField(
                        child: DropdownButtonFormField<String>(
                          value: _clientName,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                          items: const [
                            DropdownMenuItem(value: 'Client 1', child: Text('Client 1')),
                            DropdownMenuItem(value: 'Client 2', child: Text('Client 2')),
                            DropdownMenuItem(value: 'Client 3', child: Text('Client 3')),
                          ],
                          onChanged: (v) => setState(() => _clientName = v),
                          validator: (v) =>
                              v == null || v.isEmpty ? 'Sélectionne un nom' : null,
                        ),
                      ),

                      const SizedBox(height: 14),

                      // ADRESSE
                      const Text('Adresse :',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 6),
                      _RoundedField(
                        child: TextFormField(
                          controller: _addrCtrl,
                          decoration: const InputDecoration(
                            hintText: 'Adresse du site',
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                          validator: (v) =>
                              (v == null || v.trim().isEmpty) ? 'Obligatoire' : null,
                        ),
                      ),

                      const SizedBox(height: 18),

                      // INTERVENTION (grande zone)
                      const Text('Intervention :',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 6),
                      _BoxArea(
                        child: TextFormField(
                          controller: _interCtrl,
                          minLines: 6,
                          maxLines: 10,
                          decoration: const InputDecoration(
                            hintText: 'Décris l’intervention...',
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                          ),
                          validator: (v) =>
                              (v == null || v.trim().isEmpty) ? 'Obligatoire' : null,
                        ),
                      ),

                      const SizedBox(height: 18),

                      // SIGNATURE (fonctionnelle)
                      const Text('Signature :',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 6),
                      Container(
                        height: 160,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEDEFF3),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: const Color(0xFF333333)),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Signature(
                            controller: _sigCtrl,
                            backgroundColor: const Color(0xFFEDEFF3),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              _sigCtrl.clear();
                              setState(() => _signaturePng = null);
                            },
                            child: const Text('Effacer'),
                          ),
                          const SizedBox(width: 12),
                          OutlinedButton(
                            onPressed: () async {
                              if (_sigCtrl.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Aucune signature à enregistrer')),
                                );
                                return;
                              }
                              final bytes = await _sigCtrl.toPngBytes();
                              if (bytes != null) {
                                setState(() => _signaturePng = bytes);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Signature capturée ✔')),
                                );
                              }
                            },
                            child: const Text('Capturer'),
                          ),
                        ],
                      ),

                      if (_signaturePng != null) ...[
                        const SizedBox(height: 12),
                        const Text('Aperçu signature :',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        const SizedBox(height: 6),
                        Image.memory(_signaturePng!, height: 120),
                      ],

                      const SizedBox(height: 24),

                      // Bouton envoyer bas de page (optionnel)
                    //   Center(
                    //     child: DelayedAnimations(
                    //       delay: 600,
                    //       child: ElevatedButton(
                    //         style: ElevatedButton.styleFrom(
                    //           backgroundColor: kBlue,
                    //           foregroundColor: Colors.white,
                    //           shape: const StadiumBorder(),
                    //           padding: const EdgeInsets.symmetric(
                    //               horizontal: 28, vertical: 14),
                    //         ),
                    //         onPressed: _onSubmit,
                    //         child: const Text('Envoyer'),
                    //       ),
                    //     ),
                    //   ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    // Vérifie qu'on a une signature
    if (_sigCtrl.isEmpty && _signaturePng == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Merci de signer avant d’envoyer')),
      );
      return;
    }

    // Si pas encore capturée, exporte maintenant
    final sigBytes = _signaturePng ?? await _sigCtrl.toPngBytes();

    // TODO: envoie _clientName, _addrCtrl.text, _interCtrl.text et sigBytes à ton backend
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Formulaire envoyé ✔')),
    );
  }
}

/// Clippe un panneau blanc sur la gauche avec une diagonale vers le haut-droit.
class _LeftDiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final p = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width * 0.68, 0)
      ..lineTo(size.width * 0.52, size.height * 0.28)
      ..lineTo(0, size.height)
      ..close();
    return p;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

/// Champ arrondi style "capsule" (adresse / dropdown).
class _RoundedField extends StatelessWidget {
  final Widget child;
  const _RoundedField({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const ShapeDecoration(
        color: kBg,
        shape: StadiumBorder(
          side: BorderSide(color: Color(0xFFBFC7D2)),
        ),
      ),
      child: child,
    );
  }
}

/// Grande zone à bordure fine (Intervention / Signature).
class _BoxArea extends StatelessWidget {
  final Widget child;
  const _BoxArea({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        color: const Color(0xFFEDEFF3),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: const Color(0xFF333333)),
      ),
      child: child,
    );
  }
}
