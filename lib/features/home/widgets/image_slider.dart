import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:res_delivery/features/home/providers/image_slider_provider.dart';
import 'package:res_delivery/features/items/items_screen.dart';

class ImageSlider extends StatefulWidget {
  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ImageSliderProvider>(context, listen: false);
    return Container(
      child: CarouselSlider(
        items: provider.sliders.map((item) {
          return SliderItem(
            item: item,
          );
        }).toList(),
        options: CarouselOptions(
          height: 160,
          aspectRatio: 16 / 9,
          enableInfiniteScroll: false,
          autoPlay: false,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 1200),
          autoPlayCurve: Curves.fastOutSlowIn,
          scrollDirection: Axis.horizontal,
          enlargeCenterPage: false,
        ),
      ),
    );
  }
}

class SliderItem extends StatelessWidget {
  final ImageSliderItem item;

  const SliderItem({
    Key key,
    this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: (){
              Navigator.of(context).pushNamed(ItemsScreen.routeName,arguments: item.id);
            },
            child: Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(right: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: AssetImage(item.imageUrl),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Text(
                    item.title,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
