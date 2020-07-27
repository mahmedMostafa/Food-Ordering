part of 'details_bloc.dart';

abstract class DetailsEvent extends Equatable {
  const DetailsEvent();

  @override
  List<Object> get props => [];
}

class LoadDetails extends DetailsEvent {
  final String id;

  LoadDetails({@required this.id});

  @override
  List<Object> get props => [id];
}

class AddToCart extends DetailsEvent {
  final PopularItem popularItem;

  AddToCart({@required this.popularItem});

  @override
  List<Object> get props => [popularItem];
}
