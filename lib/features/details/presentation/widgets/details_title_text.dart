import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {

  final String title;

  const TitleText({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.only(left: 12.0, right: 12.0, top: 6, bottom: 6),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .headline
            .copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
