import 'package:connectly_app/core/routing/app_router.dart';
import 'package:connectly_app/core/utils/service_locator.dart';
import 'package:connectly_app/features/home/presentation/manager/create_chat_cubit/create_chat_cubit.dart';
import 'package:connectly_app/features/home/presentation/views/widgets/user_list_tile.dart';
import 'package:connectly_app/features/profile/presentation/views/widgets/failure_user_profile_body.dart';
import 'package:connectly_app/features/profile/presentation/views/widgets/initial_user_profile_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CreateChatBottomSheet extends StatelessWidget {
  const CreateChatBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CreateChatCubit>()..loadUsers(),
      child: BlocConsumer<CreateChatCubit, CreateChatState>(
        listener: (context, state) {
          if (state is CreateChatCreated) {
            Navigator.pop(context);
            context.push(
              AppRouter.chatView,
              extra: state.chatId,
            );
          }
        },
        builder: (context, state) {
          if (state is CreateChatInitialState) {
            return CustomInitialBody(text: 'No Users available yet');
          }
          if (state is CreateChatFailureState) {
            return CustomFailureBody(
              text: 'Error: ${state.errMessage}',
            );
          }
          if (state is CreateChatSucessState) {
            return SizedBox(
              height: 400,
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return UserListTile(
                      otherUserModel: state.userList[index],
                      onTap: () {
                        context
                            .read<CreateChatCubit>()
                            .createChat(state.userList[index].id);
                      },
                    );
                  },
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemCount: state.userList.length),
            );
          } else {
            return const SizedBox(
              height: 300,
              child: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}
