import 'package:connectly_app/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class BioSection extends StatelessWidget {
  const BioSection({
    super.key,
    required this.bio,
  });

  final String bio;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),  
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "About",
            style: AppTextStyles.textStyle18.copyWith(
              fontWeight: FontWeight.bold,  
            ),
          ),
          const SizedBox(height: 12),  
          
          Container(
            width: double.infinity,  
            padding: const EdgeInsets.all(16),  
            decoration: BoxDecoration(
              color: Colors.grey.shade100,  
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey.shade300,
                width: 1,
              ),
            ),
            child: Text(
              bio.isEmpty ? "No bio yet" : bio,  
              style: bio.isEmpty
                  ? AppTextStyles.textStyle16.copyWith(
                      color: Colors.grey.shade600,
                      fontStyle: FontStyle.italic,
                    )
                  : AppTextStyles.textStyle16,
            ),
          ),
        ],
      ),
    );
  }
}