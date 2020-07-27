import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:res_delivery/features/home/bloc/home_bloc.dart';
import 'package:res_delivery/features/home/domain/data/image_slider_data_source.dart';
import 'package:res_delivery/features/items/presentation/items_screen.dart';

class ImageSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) => current is ImageSliderState,
      builder: (BuildContext context, state) {
        if (state is ImageSliderLoaded) {
          return Container(
            child: CarouselSlider(
              items: state.imageSlider.map((item) {
                return SliderItem(
                  item: item,
                );
              }).toList(),
              options: CarouselOptions(
                height: 160,
                aspectRatio: 16 / 9,
                enableInfiniteScroll: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 1200),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                enlargeCenterPage: false,
              ),
            ),
          );
        } else if (state is ImageSliderFailed) {
          return Center(
            child: Text("Failed To Load image Slider"),
          );
        } else {
          return SizedBox(
            height: 160,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
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
            onTap: () {
              Navigator.of(context)
                  .pushNamed(ItemsScreen.routeName, arguments: item.id);
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
