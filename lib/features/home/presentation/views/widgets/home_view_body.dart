import 'package:connectly_app/core/routing/app_router.dart';
import 'package:connectly_app/features/auth/presentation/views/widgets/custom_text_form_field.dart';
import 'package:connectly_app/features/chat/data/model/chat_arguments_model.dart';
import 'package:connectly_app/features/home/presentation/manager/chats_cubit/chats_cubit.dart';
import 'package:connectly_app/features/home/presentation/views/widgets/custom_chat_list_tile.dart';
import 'package:connectly_app/features/home/presentation/views/widgets/home_view_app_bar.dart';
import 'package:connectly_app/core/widgets/custom_failure_body.dart';
import 'package:connectly_app/core/widgets/custom_initial_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  TextEditingController search = TextEditingController();
  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  @override
Widget build(BuildContext context) {
  return Column(
    children: [
      const HomeViewAppBar(),
      const SizedBox(height: 10),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: CustomTextFormField(
          icon: Icons.search,
          labelText: "Search by name or message",
          controller: search,
          onChanged: (query) {
            context.read<ChatsCubit>().searchChat(query: query);
          },
        ),
      ),
      const SizedBox(height: 10),
      
      Expanded(
        child: BlocBuilder<ChatsCubit, ChatsState>(
          builder: (context, state) {
            if (state is ChatsSuccessState && state.chats.isEmpty) {
              return const CustomInitialBody(text: 'No chats yet');
            }

            if (state is ChatsFailureState) {
              return CustomFailureBody(
                text: 'Error: ${state.errMessage}',
              );
            }

            if (state is ChatsSuccessState) {
              // ✅ إضافة RefreshIndicator للـ pull to refresh
              return RefreshIndicator(
                onRefresh: () async {
                  // Reload chats
                  context.read<ChatsCubit>().loadChats();
                },
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(), 
                  itemCount: state.chats.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      GoRouter.of(context).push(
                        AppRouter.chatView,
                        extra: ChatArgumentsModel(
                          chatId: state.chats[index].chatModel.chatId,
                          otherUser: state.chats[index].userModel,
                        ),
                      );
                    },
                    child: CustomChatListTile(
                      chatModel: state.chats[index].chatModel,
                      userModel: state.chats[index].userModel,
                    ),
                  ),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    ],
  );
}
}
