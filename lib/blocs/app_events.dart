import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class StockEvent extends Equatable {
  const StockEvent();
}

class LoadStockEvent extends StockEvent {
  @override
  List<Object> get props => [];
}