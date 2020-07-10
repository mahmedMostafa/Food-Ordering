import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:res_delivery/features/home/providers/meal_type_provider.dart';
import 'package:res_delivery/features/items/items_screen.dart';

class FoodTypes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MealTypeProvider>(context, listen: false);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: provider.foodTypes.map((item) {
          return _buildFooType(item, context);
        }).toList(),
      ),
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
          Navigator.of(context)
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
