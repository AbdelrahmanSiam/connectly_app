import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:connectly_app/core/utils/app_text_styles.dart';

class BioSection extends StatelessWidget {
  const BioSection({
    super.key,
    required this.bio,
  });

  final String bio;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Row(
          children: [
            Icon(
              Icons.info_outline,
              size: 20,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(width: 8),
            Text(
              "About",
              style: AppTextStyles.textStyle18.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
    
        const SizedBox(height: 12),
    
    
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.8),
                    Colors.white.withOpacity(0.6),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: bio.isEmpty
                  ? Row(
                      children: [
                        Icon(
                          Icons.edit_note,
                          color: Colors.grey.shade400,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "No bio yet",
                          style: AppTextStyles.textStyle16.copyWith(
                            color: Colors.grey.shade500,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      bio,
                      style: AppTextStyles.textStyle16.copyWith(
                        height: 1.5,
                        color: Colors.black87,
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}