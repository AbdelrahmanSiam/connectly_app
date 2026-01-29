import 'package:connectly_app/features/profile/presentation/views/widgets/bio_section.dart';
import 'package:connectly_app/features/profile/presentation/views/widgets/profile_header_section.dart';
import 'package:flutter/material.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ProfileViewBody> {
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
        ],
          ),
    );
  }
}
