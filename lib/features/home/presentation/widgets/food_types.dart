import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:res_delivery/features/home/bloc/home_bloc.dart';
import 'package:res_delivery/features/home/domain/data/meal_type_data_source.dart';
import 'package:res_delivery/features/items/presentation/items_screen.dart';

class FoodTypes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) => current is MealTypeState,
      builder: (BuildContext context, HomeState state) {
        if (state is MealTypeLoaded) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: state.mealTypes.map((item) {
                return _buildFooType(item, context);
              }).toList(),
            ),
          );
        } else if (state is MealTypeFailed) {
          return Center(
            child: Text("Failed to load types"),
          );
        } else {
          return SizedBox(
            height: 120,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

Widget _buildFooType(MealType item, BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.30,
    margin: EdgeInsets.all(6),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Color(0XFFB0CCE1).withOpacity(.32),
          blurRadius: 20,
          offset: Offset(0, 4),
        )
      ],
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          //this is just to get some data from the api since there is no items for desserts and drinks key words
          String query = item.title;
          if (item.title == "Desserts")
            query = "cake";
          else if (item.title == "Drinks")
            query = "juice";
          else if (item.title == "Dinner") query = "burger";
          Navigator.of(context,rootNavigator: true)
              .pushNamed(ItemsScreen.routeName, arguments: query);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor.withOpacity(.32)),
                child: SvgPicture.asset(
                  item.imageUrl,
                  width: MediaQuery.of(context).size.width * .18,
                  height: 60,
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                item.title,
                style: TextStyle(color: Colors.black, fontSize: 16),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
