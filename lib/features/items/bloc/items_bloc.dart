import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:res_delivery/features/items/domain/items_repository.dart';
import 'package:res_delivery/models/PopularItem.dart';
part 'items_event.dart';

part 'items_state.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  final AllItemsRepository allItemsRepository;
  var currentPageNumber = 1;

  ItemsBloc({@required this.allItemsRepository}) : super(ItemsInitial());

  @override
  Stream<ItemsState> mapEventToState(
    ItemsEvent event,
  ) async* {
    if (event is LoadItems) {
      yield* _mapLoadItemsEventToState(event.query, state);
    }
  }

  bool _hasReachedMax(ItemsState state) =>
      state is ItemsLoaded && state.hasReachedMax;

  Stream<ItemsState> _mapLoadItemsEventToState(
      String query, ItemsState currentState) async* {
    if (!_hasReachedMax(currentState)) {
//      yield ItemsInProgress();
      try {
        final result =
            await allItemsRepository.getAllItems(query, currentPageNumber);
        if (result.length > 0) {
          if (currentState is ItemsInitial) {
            yield ItemsLoaded(
              items: result,
              hasReachedMax: false,
            );
          } else if (currentState is ItemsLoaded) {
            yield ItemsLoaded(
              items: (currentState.items ?? []) + result,
              hasReachedMax: false,
            );
          }
          currentPageNumber++;
        } else {
          yield (currentState as ItemsLoaded).copyWith(hasReachedMax: true);
        }
      } catch (error) {
        print("Error is ${error.toString()}");
        yield ItemsFailed();
      }
    }
  }
}
