import 'package:connectly_app/features/profile/presentation/manager/cubit/user_cubit.dart';
import 'package:connectly_app/features/profile/presentation/views/widgets/bio_section.dart';
import 'package:connectly_app/features/profile/presentation/views/widgets/failure_user_profile_body.dart';
import 'package:connectly_app/features/profile/presentation/views/widgets/initial_user_profile_body.dart';
import 'package:connectly_app/features/profile/presentation/views/widgets/profile_header_section.dart';
import 'package:connectly_app/features/profile/presentation/views/widgets/setting_section.dart';
import 'package:connectly_app/features/profile/presentation/views/widgets/state_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserFailureState) {
          return FailureUserProfileBody(text:'Error: ${state.errMessage}',);
        }
        if (state is UserInitialState) {
          return InitialUserProfileBody();
        }
        if(state is UserSuccessState){
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              ProfileHeaderSection(
                name: state.userModel.name,
                email: state.userModel.email,
                isOnline: true,
              ),
              SizedBox(
                height: 10,
              ),
              BioSection(
                bio: state.userModel.bio ?? "No bio yet",
              ),
              StatsSection(
                chatsCount: 15,
                friendsCount: 14,
                createdAt: state.userModel.createdAt,
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
        }return const SizedBox();
      },
    );
  }
}

