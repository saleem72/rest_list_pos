// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'taxes_bloc.dart';

abstract class TaxesEvent extends Equatable {
  const TaxesEvent();

  @override
  List<Object> get props => [];
}

class TaxesGetData extends TaxesEvent {}

class TaxesFlipKind extends TaxesEvent {
  final TaxViewModel tax;

  const TaxesFlipKind({
    required this.tax,
  });

  @override
  List<Object> get props => [tax];
}

class TaxesUpdateTitle extends TaxesEvent {
  final int index;
  final String value;
  const TaxesUpdateTitle({
    required this.index,
    required this.value,
  });

  @override
  List<Object> get props => [index, value];
}

class TaxesUpdateValue extends TaxesEvent {
  final int index;
  final String value;
  const TaxesUpdateValue({
    required this.index,
    required this.value,
  });

  @override
  List<Object> get props => [index, value];
}

class TaxesAddNewTax extends TaxesEvent {}

class TaxesDeleteTax extends TaxesEvent {
  final int index;
  const TaxesDeleteTax({
    required this.index,
  });

  @override
  List<Object> get props => [index];
}

class TaxesApplyChanges extends TaxesEvent {}
