import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:res_delivery/features/items/presentation/items_screen.dart';

class SearchEditText extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final Function(String query) onQuerySubmitted;
  final _controller = TextEditingController();

  SearchEditText({Key key, this.onChanged, this.onQuerySubmitted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: TextField(
        controller: _controller,
        textInputAction: TextInputAction.search,
        keyboardType: TextInputType.text,
        onChanged: onChanged,
        decoration: InputDecoration(
          icon: SvgPicture.asset(
            "assets/icons/search.svg",
            color: Colors.grey,
          ),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.only(bottom: 11, top: 11, right: 15),
          hintText: "Search Here...",
        ),
        onSubmitted: (value) {
          Navigator.of(context, rootNavigator: true)
              .pushNamed(ItemsScreen.routeName, arguments: value);
          _controller.clear();
          onQuerySubmitted(value);
        },
      ),
    );
  }
}
