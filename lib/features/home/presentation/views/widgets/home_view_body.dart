import 'package:connectly/core/utils/app_text_styles.dart';
import 'package:connectly/core/widgets/custom_error_widget.dart';
import 'package:connectly/core/widgets/custom_snackbar.dart';
import 'package:connectly/features/home/presentation/manager/cubit/home_cubit.dart';
import 'package:connectly/features/home/presentation/views/widgets/home_empty_state.dart';
import 'package:connectly/features/home/presentation/views/widgets/home_list_tile_.dart';
import 'package:connectly/features/home/presentation/views/widgets/home_view_app_bar.dart';
import 'package:connectly/features/home/presentation/views/widgets/home_view_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeSuccessState) {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    HomeViewAppBar(),
                    SizedBox(
                      height: 15,
                    ),
                    HomeViewSearchBar(onChanged: (value) {
                      BlocProvider.of<HomeCubit>(context).filteredUsers(value);
                    }),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              if (state.userModelList.isEmpty)
                const HomeEmptyState()
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return HomeListTileWidget(
                        userModel: state.userModelList[index],
                      );
                    },
                    childCount: state.userModelList.length,
                  ),
                ),
            ],
          );
        } else if (state is HomeFailureState) {
          return CustomErrorWidget(message: state.errMessage,);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
