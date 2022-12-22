//

import 'dart:convert' as convert;

enum TaxType {
  percentage,
  value;

  String get title {
    switch (this) {
      case TaxType.percentage:
        return 'Percentage';
      case TaxType.value:
        return 'Value';
    }
  }

  static TaxType fromString(String title) {
    switch (title) {
      case 'percentage':
        return TaxType.percentage;
      case 'value':
        return TaxType.value;
      default:
        return TaxType.value;
    }
  }
}

class Tax {
  final int id;
  final String name;
  final TaxType type;
  final int value;
  Tax({
    required this.id,
    required this.name,
    required this.type,
    required this.value,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'type': type.toString(),
      'value': value,
    };
  }

  factory Tax.fromMap(Map<String, dynamic> map) {
    return Tax(
      id: map['id'] as int,
      name: map['name'] as String,
      type: TaxType.fromString(map['type'] as String),
      value: map['value'] as int,
    );
  }

  String toJson() => convert.json.encode(toMap());

  factory Tax.fromJson(String source) =>
      Tax.fromMap(convert.json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Tax(name: $name, type: ${type.title}, value: $value)';
  }
}
