import 'package:connectly_app/features/auth/presentation/views/widgets/custom_text_form_field.dart';
import 'package:connectly_app/features/home/presentation/views/widgets/custom_chat_list_tile.dart';
import 'package:connectly_app/features/home/presentation/views/widgets/home_view_app_bar.dart';
import 'package:flutter/material.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeViewAppBar(),
        SizedBox(height: 10,),
        CustomTextFormField(icon: Icons.search,labelText: "Search", controller: search),
        Expanded(
          child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) => CustomChatListTile()),
        ),
      ],
    );
  }
}
