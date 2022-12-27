import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../models/failure.dart';
import '../../../../../models/tax_view_model.dart';
import '../taxes_repository/taxes_repository.dart';

part 'taxes_event.dart';
part 'taxes_state.dart';

class TaxesBloc extends Bloc<TaxesEvent, TaxesState> {
  final TaxesRepository _repository;
  final int resturantId;

  TaxesBloc({
    required this.resturantId,
    required TaxesRepository repository,
  })  : _repository = repository,
        super(const TaxesState()) {
    on<TaxesGetData>(_onGetData);
    on<TaxesFlipKind>(_onFlipKind);
    on<TaxesUpdateTitle>(_onUpdateTitle);
    on<TaxesUpdateValue>(_onUpdateValue);
    on<TaxesAddNewTax>(_onAddNewTax);
    on<TaxesDeleteTax>(_onDeleteTax);
    on<TaxesApplyChanges>(_onApplyChanges);
  }
  _onGetData(TaxesGetData event, Emitter<TaxesState> emit) async {
    emit(state.copyWith(isFetching: true));
    final result = await _repository.getTaxes(resturantId);
    result.fold(
      (failure) {
        emit(state.copyWith(isFetching: false, failure: failure));
      },
      (list) {
        emit(state.copyWith(
            isFetching: false,
            taxes: list.map((e) => TaxViewModel.fromModel(e)).toList()));
      },
    );
  }

  _onFlipKind(TaxesFlipKind event, Emitter<TaxesState> emit) {
    final idx = state.taxes.indexWhere((element) => element.id == event.tax.id);
    final taxes = state.taxes;
    final newTax = taxes[idx].flipKind();
    taxes[idx] = newTax;
    emit(state.copyWith(taxes: taxes, version: state.version + 1));
  }

  _onUpdateTitle(TaxesUpdateTitle event, Emitter<TaxesState> emit) {
    final idx = event
        .index; // state.taxes.indexWhere((element) => element.id == event.tax.id);
    final taxes = state.taxes;
    final newTax = taxes[idx].copyWith(name: event.value);
    taxes[idx] = newTax;
    emit(state.copyWith(taxes: taxes));
  }

  _onUpdateValue(TaxesUpdateValue event, Emitter<TaxesState> emit) {
    final idx = event
        .index; // state.taxes.indexWhere((element) => element.id == event.tax.id);
    final taxes = state.taxes;
    if (event.value.isEmpty) {
      final newTax = taxes[idx].copyWith(value: 0);
      taxes[idx] = newTax;
      emit(state.copyWith(taxes: taxes));
    } else if (event.value.isNumeric()) {
      final newTax = taxes[idx].copyWith(value: int.parse(event.value));
      taxes[idx] = newTax;
      emit(state.copyWith(taxes: taxes));
    } else {
      emit(state.copyWith(version: state.version + 1));
    }
  }

  _onAddNewTax(TaxesAddNewTax event, Emitter<TaxesState> emit) {
    final newTax = TaxViewModel();
    state.taxes.add(newTax);
    emit(state.copyWith(taxes: state.taxes, version: state.version + 1));
  }

  _onDeleteTax(TaxesDeleteTax event, Emitter<TaxesState> emit) {
    state.taxes.removeAt(event.index);
    emit(state.copyWith(taxes: state.taxes, version: state.version + 1));
  }

  _onApplyChanges(TaxesApplyChanges event, Emitter<TaxesState> emit) {
    print(state.taxes);
  }
}

extension on String {
  bool isNumeric() {
    try {
      if (isEmpty) {
        return true;
      } else {
        return double.tryParse(this) != null;
      }
    } on Exception {
      return false;
    }
  }
}
