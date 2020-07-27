part of 'details_bloc.dart';

abstract class DetailsState extends Equatable {
  const DetailsState();

  @override
  List<Object> get props => [];
}

class DetailsInitial extends DetailsState {}

/*
    details info states
 */
class DetailsInfoState extends DetailsState {}

class DetailsInProgress extends DetailsInfoState {}

class DetailsLoaded extends DetailsInfoState {
  final PopularItem popularItem;

  DetailsLoaded({@required this.popularItem});

  @override
  List<Object> get props => [popularItem];
}

class DetailsFailed extends DetailsInfoState {
  final String errorMessage;

  DetailsFailed({@required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

/*
    add to cart states
 */
class AddToCartState extends DetailsState {}

class AddToCartInProgress extends AddToCartState {}

class AddToCartLoaded extends AddToCartState {}

class AddToCartFailed extends AddToCartState {}
