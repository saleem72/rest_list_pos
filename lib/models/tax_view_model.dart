// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'tax.dart';

enum TaxViewModelStatus { original, updated, created }

class TaxViewModel {
  final Tax? tax;
  final int id;
  final String name;
  final TaxType type;
  final int value;
  final TaxViewModelStatus status;

  TaxViewModel({
    this.tax,
    this.id = 0,
    this.name = '',
    this.type = TaxType.value,
    this.value = 0,
    this.status = TaxViewModelStatus.created,
  });

  factory TaxViewModel.fromModel(Tax model) {
    return TaxViewModel(
      tax: model,
      id: model.id,
      name: model.name,
      type: model.type,
      value: model.value,
      status: TaxViewModelStatus.original,
    );
  }

  TaxViewModel copyWith({
    int? id,
    String? name,
    TaxType? type,
    int? value,
  }) {
    return TaxViewModel(
      tax: tax,
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      value: value ?? this.value,
      status: status == TaxViewModelStatus.original
          ? TaxViewModelStatus.updated
          : status,
    );
  }

  TaxViewModel flipKind() {
    return TaxViewModel(
      tax: tax,
      id: id,
      name: name,
      type: type == TaxType.percentage ? TaxType.value : TaxType.percentage,
      value: 0,
      status: status == TaxViewModelStatus.original
          ? TaxViewModelStatus.updated
          : status,
    );
  }

  @override
  String toString() {
    return 'TaxViewModel(name: $name, type: ${type.title}, value: $value, status: ${status.toString()})';
  }
}
