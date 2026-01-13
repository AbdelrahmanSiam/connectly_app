import 'package:connectly/features/home/presentation/views/widgets/home_list_tile_.dart';
import 'package:connectly/features/home/presentation/views/widgets/home_view_app_bar.dart';
import 'package:connectly/features/home/presentation/views/widgets/home_view_search_bar.dart';
import 'package:flutter/material.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              HomeViewAppBar(),
              SizedBox(
                height: 15,
              ),
              HomeViewSearchBar(),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return HomeListTileWidget();
            },
            childCount: 10,
          ),
        ),
      ],
    );
  }
}
