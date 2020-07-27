import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:res_delivery/features/details/domain/details_repository.dart';
import 'package:res_delivery/features/home/bloc/home_bloc.dart';
import 'package:res_delivery/models/PopularItem.dart';

part 'details_event.dart';

part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final DetailsRepository detailsRepository;

  DetailsBloc({@required this.detailsRepository}) : super(DetailsInitial());

  @override
  Stream<DetailsState> mapEventToState(
    DetailsEvent event,
  ) async* {
    if (event is LoadDetails) {
      yield* _mapLoadDetailsToState(event.id);
    } else if (event is AddToCart) {
      yield* _mapAddToCartToState(event.popularItem);
    }
  }

  Stream<DetailsState> _mapAddToCartToState(PopularItem popularItem) async* {
    yield AddToCartInProgress();
    try {
      final result = await detailsRepository.addToCart(popularItem);
      yield AddToCartLoaded();
    } catch (error) {
      yield AddToCartFailed();
    }
  }

  Stream<DetailsState> _mapLoadDetailsToState(String id) async* {
    yield DetailsInProgress();
    try {
      final details = await detailsRepository.getDetails(id);
      yield DetailsLoaded(popularItem: details);
    } catch (error) {
      yield DetailsFailed(errorMessage: "Failed to load details");
    }
  }
}
