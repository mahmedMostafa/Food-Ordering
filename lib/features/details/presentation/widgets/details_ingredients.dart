import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_delivery/features/details/bloc/details_bloc.dart';

class DetailsIngredients extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 12.0, right: 12.0, top: 6, bottom: 6),
      child: BlocBuilder<DetailsBloc, DetailsState>(
        buildWhen: (previous, current) => current is DetailsInfoState,
        builder: (context, state) {
          if (state is DetailsLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: state.popularItem.ingredients.map((item) {
                return Text(
                  item.toString(),
                  style: TextStyle(fontSize: 18, color: Colors.grey[800]),
                );
              }).toList(),
            );
          } else if (state is DetailsFailed) {
            return Center(
              child: Text("Failed to load ingredients"),
            );
          } else {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
