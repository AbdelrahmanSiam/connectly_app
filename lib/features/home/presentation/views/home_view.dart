import 'package:connectly_app/core/utils/app_colors.dart';
import 'package:connectly_app/features/home/presentation/views/widgets/create_show_bottom_sheet.dart';
import 'package:connectly_app/features/home/presentation/views/widgets/home_view_body.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          child: Icon(
            Icons.add,
            size: 32,
          ),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (_) => const CreateChatBottomSheet(),
            );
          }),
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0, right: 8, left: 8),
        child: HomeViewBody(),
      ),
    );
  }
}
