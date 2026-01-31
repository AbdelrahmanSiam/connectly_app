import 'package:connectly_app/core/routing/app_router.dart';
import 'package:connectly_app/features/profile/presentation/manager/cubit/user_cubit.dart';
import 'package:connectly_app/features/profile/presentation/views/widgets/bio_section.dart';
import 'package:connectly_app/features/profile/presentation/views/widgets/failure_user_profile_body.dart';
import 'package:connectly_app/features/profile/presentation/views/widgets/initial_user_profile_body.dart';
import 'package:connectly_app/features/profile/presentation/views/widgets/profile_header_section.dart';
import 'package:connectly_app/features/profile/presentation/views/widgets/setting_section.dart';
import 'package:connectly_app/features/profile/presentation/views/widgets/state_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  Map<String, int>? stats;
  @override
  void initState() {
    super.initState();
    _loadStats();  // fetch states first
  }
  Future<void> _loadStats() async {
    final userCubit = context.read<UserCubit>();
    final userId = userCubit.currentUser?.id;
    
    if (userId != null) {
      final loadedStats = await userCubit.getUserStats(userId: userId);
      setState(() {
        stats = loadedStats;
      });
    }
  }
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
              ProfileHeaderSection(
                name: state.userModel.name,
                email: state.userModel.email,
                isOnline: state.userModel.isOnline,
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    BioSection(
                      bio: state.userModel.bio ,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    StatsSection(
                      chatsCount: stats?['chats'] ?? 0,
                      createdAt: state.userModel.createdAt,
                    ),
                    const SizedBox(height: 24),
                    SettingsSection(
                      onEditProfile: () {
                        context.push(AppRouter.editProfileView);
                      },
                    ),
                  ],
                ),
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