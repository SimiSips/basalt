import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:basalt/models/stock_model.dart';

@immutable
abstract class StockState extends Equatable {}
// data loading state
class StockLoadingState extends StockState {
  @override
  List<Object?> get props => [];
}

// data loaded state
class StockLoadedState extends StockState {
  StockLoadedState(this.stocks);
  final List<StockModel> stocks;

  @override
  List<Object?> get props => [stocks];
}

// data error on loading state
class StockErrorState extends StockState {
  StockErrorState(this.error);
  final String error;

  @override
  List<Object?> get props => [error];
}




