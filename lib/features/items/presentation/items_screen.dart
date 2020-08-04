import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_delivery/features/items/bloc/items_bloc.dart';
import 'package:res_delivery/features/items/data/all_items_data_source.dart';
import 'package:res_delivery/features/items/domain/items_repository.dart';
import 'package:res_delivery/shared/foodItem.dart';

class ItemsScreen extends StatelessWidget {
  static const routeName = "/item_screen_route";

  final String query;

  const ItemsScreen({Key key, @required this.query}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Query is $query");
    return Scaffold(
      appBar: AppBar(
        title: Text(query),
      ),
      body: BlocProvider<ItemsBloc>(
        create: (context) => ItemsBloc(
          allItemsRepository: AllItemsRepository(
            allItemsDataSource: AllItemsDataSource(),
          ),
        )..add(LoadItems(query: query)),
        child: AllItems(query: query),
      ),
    );
  }
}

class AllItems extends StatefulWidget {
  final String query;

  const AllItems({Key key, this.query}) : super(key: key);

  @override
  _AllItemsState createState() => _AllItemsState();
}

class _AllItemsState extends State<AllItems> {
  ScrollController _scrollController;
  final _scrollThreshold = 200;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemsBloc, ItemsState>(
      builder: (context, state) {
        if (state is ItemsInitial) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ItemsLoaded) {
          final items = state.items;
          return ListView.builder(
            itemBuilder: (ctx, index) {
              return index >= items.length
                  ? PaginationLoader()
                  : FoodItem(item: items[index]);
            },
            controller: _scrollController,
            itemCount: state.hasReachedMax ? items.length : items.length + 1,
          );
        } else {
          return Center(
            child: Text("Something went wrong"),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    print("onScroll CALLED");
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      BlocProvider.of<ItemsBloc>(context).add(LoadItems(query: widget.query));
    }
  }
}

class PaginationLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: EdgeInsets.all(10),
        alignment: Alignment.center,
        child: Center(
          child: SizedBox(
            width: 33,
            height: 33,
            child: CircularProgressIndicator(
              strokeWidth: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
