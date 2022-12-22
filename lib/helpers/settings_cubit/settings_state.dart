// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'settings_cubit.dart';

@immutable
class SettingsState extends Equatable {
  final SettingsItem item;
  final Offset position;
  final bool shouldHighlighted;

  const SettingsState(
      {this.item = SettingsItem.account,
      this.position = Offset.zero,
      this.shouldHighlighted = false});

  @override
  List<Object> get props => [item, position];

  SettingsState copyWith({
    SettingsItem? item,
    Offset? position,
    bool? shouldHighlighted,
  }) {
    return SettingsState(
      item: item ?? this.item,
      position: position ?? this.position,
      shouldHighlighted: shouldHighlighted ?? this.shouldHighlighted,
    );
  }
}
