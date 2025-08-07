import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../domain/entities/carta_entity.dart';
import '../atoms/wid_text.dart';
import '../molecules/wid_carta_imagen.dart';

class CartaItem extends StatelessWidget {
  final CartaEntity card;
  final VoidCallback? onTap;

  const CartaItem({super.key, required this.card, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(20),
        shadowColor: Colors.deepPurpleAccent.withOpacity(0.3),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          splashColor: Colors.deepPurpleAccent.withOpacity(0.2),
          highlightColor: Colors.deepPurpleAccent.withOpacity(0.1),
          child: AnimatedContainer(
            duration: 250.ms,
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [
                  Colors.deepPurple.shade50,
                  Colors.deepPurple.shade100.withOpacity(0.7),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.deepPurpleAccent.withOpacity(0.2),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                // Imagen con sombra profunda y animación sutil
                CartaImagen(
                  imageUrl: card.imageUrl,
                  width: isMobile ? 90 : 120,
                  height: isMobile ? 125 : 160,
                  borderRadius: 24,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepPurpleAccent.withOpacity(0.35),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ).animate().scale(delay: 100.ms).fadeIn(duration: 400.ms),

                const SizedBox(width: 24),

                // Info principal con padding responsivo
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                            card.name,
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple.shade900,
                              letterSpacing: 0.8,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )
                          .animate()
                          .slide(delay: 200.ms, begin: const Offset(-0.3, 0))
                          .fadeIn(),

                      const SizedBox(height: 8),

                      CustomText(
                        card.type,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.deepPurple.shade600,
                          fontStyle: FontStyle.italic,
                          letterSpacing: 0.5,
                        ),
                      ).animate().fadeIn(delay: 350.ms),

                      const SizedBox(height: 14),

                      // Descripción con altura fija + scroll con physics suave
                      SizedBox(
                        height: isMobile ? 75 : 90,
                        child: ScrollConfiguration(
                          behavior: const BouncingScrollBehavior(),
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: CustomText(
                              card.description,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: Colors.grey[850],
                                height: 1.5,
                              ),
                            ).animate().fadeIn(delay: 500.ms),
                          ),
                        ),
                      ),
                    ],
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
