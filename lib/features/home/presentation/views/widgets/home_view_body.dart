import 'package:connectly_app/features/auth/presentation/views/widgets/custom_text_form_field.dart';
import 'package:connectly_app/features/home/presentation/manager/chats_cubit/chats_cubit.dart';
import 'package:connectly_app/features/home/presentation/views/widgets/custom_chat_list_tile.dart';
import 'package:connectly_app/features/home/presentation/views/widgets/home_view_app_bar.dart';
import 'package:connectly_app/features/profile/presentation/views/widgets/failure_user_profile_body.dart';
import 'package:connectly_app/features/profile/presentation/views/widgets/initial_user_profile_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        HomeViewAppBar(),
        SizedBox(
          height: 10,
        ),
        CustomTextFormField(
            icon: Icons.search, labelText: "Search", controller: search),
        BlocBuilder<ChatsCubit, ChatsState>(
          builder: (context, state) {
            if (state is ChatsSuccessState && state.chats.isEmpty) {
              return CustomInitialBody(text: 'No chats yet');
            }

            if (state is ChatsFailureState) {
              return CustomFailureBody(
                text: 'Error: ${state.errMessage}',
              );
            }
            if (state is ChatsSuccessState) {
              return Expanded(
                child: ListView.builder(
                    itemCount: state.chats.length,
                    itemBuilder: (context, index) => CustomChatListTile(
                          chatModel: state.chats[index].chatModel,
                          userModel: state.chats[index].userModel,
                        )),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ],
    );
  }
}
