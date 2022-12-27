// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'taxes_bloc.dart';

class TaxesState extends Equatable {
  const TaxesState({
    this.taxes = const [],
    this.failure,
    this.version = 1,
    this.isFetching = false,
  });

  final List<TaxViewModel> taxes;
  final Failure? failure;
  final int version;
  final bool isFetching;

  @override
  List<Object?> get props => [taxes, failure, version, isFetching];

  TaxesState copyWith({
    List<TaxViewModel>? taxes,
    Failure? failure,
    int? version,
    bool? isFetching,
  }) {
    return TaxesState(
      taxes: taxes ?? this.taxes,
      failure: failure ?? this.failure,
      version: version ?? this.version,
      isFetching: isFetching ?? this.isFetching,
    );
  }
}
