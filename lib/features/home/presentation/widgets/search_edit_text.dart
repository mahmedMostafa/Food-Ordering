import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchEditText extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const SearchEditText({Key key, this.onChanged}) : super(key: key);

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
        onChanged: onChanged,
        decoration: InputDecoration(
          icon: SvgPicture.asset("assets/icons/search.svg",color: Colors.grey,),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.only(bottom: 11, top: 11, right: 15),
          hintText: "Search Here...",
        ),
      ),
    );
  }
}
