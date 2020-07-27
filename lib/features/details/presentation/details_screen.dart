import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_delivery/features/details/bloc/details_bloc.dart';
import 'package:res_delivery/features/details/data/details_data_source.dart';
import 'package:res_delivery/features/details/domain/details_repository.dart';
import '../details_argument.dart';
import 'widgets/details_app_bar.dart';
import 'widgets/details_content.dart';

class DetailsScreen extends StatelessWidget {
  static const routeName = "/details_route_name";

  DetailsArgument args;

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          DetailsAppBar(
            imageUrl: args.imageUrl,
            id: args.id,
          ),
          BlocProvider<DetailsBloc>(
            create: (BuildContext context) => DetailsBloc(
              detailsRepository: DetailsRepository(
                detailsDataSource: DetailsDataSource(),
              ),
            )..add(LoadDetails(id: args.id)),
            child: DetailsContent(
              args: args,
            ),
          )
        ],
      ),
    );
  }
}
