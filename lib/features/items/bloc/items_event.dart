part of 'items_bloc.dart';

abstract class ItemsEvent extends Equatable {
  const ItemsEvent();

  @override
  List<Object> get props => [];
}

class LoadItems extends ItemsEvent {
  final String query;

  LoadItems({@required this.query});

  @override
  List<Object> get props => [query];
}
