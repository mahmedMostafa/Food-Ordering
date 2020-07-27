part of 'items_bloc.dart';

abstract class ItemsState extends Equatable {
  const ItemsState();

  @override
  List<Object> get props => [];
}

class ItemsInitial extends ItemsState {}

class ItemsLoaded extends ItemsState {
  final List<PopularItem> items;
  final bool hasReachedMax;

  ItemsLoaded({@required this.items, @required this.hasReachedMax});

  ItemsLoaded copyWith({List<PopularItem> items, bool hasReachedMax}) {
    return ItemsLoaded(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [items, hasReachedMax];
}

class ItemsFailed extends ItemsState {}

class ItemsInProgress extends ItemsState {}
