import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../domain/entities/carta_entity.dart';
import '../../widgets/atoms/custom_text.dart';
import '../../widgets/molecules/carta_imagen.dart';

class DetalleCartaDialog extends StatelessWidget {
  final CartaEntity card;

  const DetalleCartaDialog({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 20,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 680),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
                gradient: LinearGradient(
                  colors: [
                    Colors.deepPurpleAccent.shade200,
                    Colors.indigo.shade400,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.indigo.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              width: double.infinity,
              child: Column(
                children: [
                  CartaImagen(
                    imageUrl: card.imageUrl,
                    width: 160,
                    height: 240,
                    borderRadius: 16,
                    boxShadow: [],
                  ).animate().fadeIn(duration: 500.ms).scale(),
                  const SizedBox(height: 16),
                  CustomText(
                    card.name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ).animate().fadeIn(duration: 300.ms),
                  const SizedBox(height: 8),
                  Chip(
                    label: Text(
                      card.type,
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.deepPurpleAccent.withOpacity(0.4),
                    side: const BorderSide(color: Colors.white24),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                  ).animate().fadeIn(duration: 200.ms),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        "Descripción",
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.indigo,
                            ),
                      ),
                      const SizedBox(height: 8),
                      CustomText(
                        card.description,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey[800],
                          height: 1.5,
                        ),
                      ).animate().fadeIn(duration: 350.ms),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigoAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    elevation: 4,
                    shadowColor: Colors.indigo.withOpacity(0.5),
                  ),
                  icon: const Icon(Icons.close),
                  label: const Text('Cerrar'),
                ).animate().fadeIn(duration: 250.ms),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
