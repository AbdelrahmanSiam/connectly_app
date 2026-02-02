import 'package:connectly_app/features/home/presentation/views/widgets/home_view_body.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0,right: 8,left: 8),
        child: HomeViewBody(),
      ),
    );
  }
}