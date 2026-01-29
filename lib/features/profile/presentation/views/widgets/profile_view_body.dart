import 'package:connectly_app/features/profile/presentation/views/widgets/bio_section.dart';
import 'package:connectly_app/features/profile/presentation/views/widgets/profile_header_section.dart';
import 'package:connectly_app/features/profile/presentation/views/widgets/setting_section.dart';
import 'package:connectly_app/features/profile/presentation/views/widgets/state_section.dart';
import 'package:flutter/material.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20,),
          ProfileHeaderSection(name: "Abdulrahman",email:"email@gmail.com",isOnline: true,),
          SizedBox(height: 10,),
          BioSection(bio: "No bio yet",),
          StatsSection(
              chatsCount: 15,
              friendsCount: 14,
              createdAt: DateTime(2024, 1, 15),
            ),
            const SizedBox(height: 24),
            SettingsSection(
              onEditProfile: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Edit Profile - Coming soon")),
                );
              },
            ),

            const SizedBox(height: 24),
        ],
          ),
    );
  }
}
