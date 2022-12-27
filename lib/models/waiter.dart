// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:equatable/equatable.dart';

import 'app_user/user_subscription.dart';
import 'restaurant/restaurant_currency.dart';
import 'restaurant/restaurant_language.dart';

typedef WaitersList = List<Waiter>;

class Waiter extends Equatable {
  final int id;
  final String fullName;
  final String email;
  final String role;
  final int isActive;
  final DateTime emailVerifiedAt;
  final String plan;
  final UserSubscription? subscription;
  final List<WaitersTable> tables;
  final String? profileImage;
  final int isNotify;
  final ResturantLanguage? defaultLanguage;
  final ResturantCurrency? defaultCurrency;
  const Waiter({
    required this.id,
    required this.fullName,
    required this.email,
    required this.role,
    required this.isActive,
    required this.emailVerifiedAt,
    required this.plan,
    this.subscription,
    required this.tables,
    this.profileImage,
    required this.isNotify,
    this.defaultLanguage,
    this.defaultCurrency,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'full_name': fullName,
      'email': email,
      'role': role,
      'is_active': isActive,
      'email_verified_at': emailVerifiedAt.millisecondsSinceEpoch,
      'plan': plan,
      'subscription': subscription?.toJson(),
      'tables': tables.map((x) => x.toMap()).toList(),
      'profile_image': profileImage,
      'is_notify': isNotify,
      'default_language': defaultLanguage?.toJson(),
      'default_currency': defaultCurrency?.toJson(),
    };
  }

  factory Waiter.fromMap(Map<String, dynamic> map) {
    return Waiter(
      id: map['id'] as int,
      fullName: map['full_name'] as String,
      email: map['email'] as String,
      role: map['role'] as String,
      isActive: map['is_active'] as int,
      emailVerifiedAt: DateTime.parse(map['email_verified_at'] as String),
      plan: map['plan'] as String,
      subscription: map['subscription'] != null
          ? UserSubscription.fromJson(
              map['subscription'] as Map<String, dynamic>)
          : null,
      tables: List<WaitersTable>.from(
        (map['tables'] as List<dynamic>).map<WaitersTable>(
          (x) => WaitersTable.fromMap(x as Map<String, dynamic>),
        ),
      ),
      profileImage:
          map['profile_image'] != null ? map['profile_image'] as String : null,
      isNotify: map['is_notify'] as int,
      defaultLanguage: map['default_language'] != null
          ? ResturantLanguage.fromJson(
              map['default_language'] as Map<String, dynamic>)
          : null,
      defaultCurrency: map['default_currency'] != null
          ? ResturantCurrency.fromJson(
              map['default_currency'] as Map<String, dynamic>)
          : null,
    );
  }

  @override
  List<Object?> get props => [id];

  @override
  String toString() => 'Waiter(name: $fullName)';
}

class WaitersTable extends Equatable {
  final int id;
  final String name;
  const WaitersTable({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory WaitersTable.fromMap(Map<String, dynamic> map) {
    return WaitersTable(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  @override
  List<Object?> get props => [id];
}
