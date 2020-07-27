import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_delivery/features/home/bloc/home_bloc.dart';
import 'package:res_delivery/shared/foodItem.dart';

class PopularItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>
      current is PopularItemsState && previous is PopularItemsState,
      builder: (BuildContext context, HomeState state) {
        if (state is PopularItemsLoaded) {
          final data = state.popularItems;
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: data.isEmpty ? 0 : data.length,
            itemBuilder: (ctx, index) =>
                FoodItem(
                  item: data[index],
                ),
          );
        } else if (state is PopularItemsFailed) {
          return Center(
            child: Text("Failed to load popular items"),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
