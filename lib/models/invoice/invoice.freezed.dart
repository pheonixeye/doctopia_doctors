// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invoice.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Invoice _$InvoiceFromJson(Map<String, dynamic> json) {
  return _Invoice.fromJson(json);
}

/// @nodoc
mixin _$Invoice {
  String get id => throw _privateConstructorUsedError;
  String get docid => throw _privateConstructorUsedError;
  String get link => throw _privateConstructorUsedError;
  String get issued_at => throw _privateConstructorUsedError;
  int get month => throw _privateConstructorUsedError;
  int get year => throw _privateConstructorUsedError;
  String get payment_reference => throw _privateConstructorUsedError;
  bool get paid => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;
  int get tax => throw _privateConstructorUsedError;
  double get total => throw _privateConstructorUsedError;
  List<String> get clinic_visits => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InvoiceCopyWith<Invoice> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvoiceCopyWith<$Res> {
  factory $InvoiceCopyWith(Invoice value, $Res Function(Invoice) then) =
      _$InvoiceCopyWithImpl<$Res, Invoice>;
  @useResult
  $Res call(
      {String id,
      String docid,
      String link,
      String issued_at,
      int month,
      int year,
      String payment_reference,
      bool paid,
      int amount,
      int tax,
      double total,
      List<String> clinic_visits});
}

/// @nodoc
class _$InvoiceCopyWithImpl<$Res, $Val extends Invoice>
    implements $InvoiceCopyWith<$Res> {
  _$InvoiceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? docid = null,
    Object? link = null,
    Object? issued_at = null,
    Object? month = null,
    Object? year = null,
    Object? payment_reference = null,
    Object? paid = null,
    Object? amount = null,
    Object? tax = null,
    Object? total = null,
    Object? clinic_visits = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      docid: null == docid
          ? _value.docid
          : docid // ignore: cast_nullable_to_non_nullable
              as String,
      link: null == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String,
      issued_at: null == issued_at
          ? _value.issued_at
          : issued_at // ignore: cast_nullable_to_non_nullable
              as String,
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as int,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      payment_reference: null == payment_reference
          ? _value.payment_reference
          : payment_reference // ignore: cast_nullable_to_non_nullable
              as String,
      paid: null == paid
          ? _value.paid
          : paid // ignore: cast_nullable_to_non_nullable
              as bool,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      tax: null == tax
          ? _value.tax
          : tax // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      clinic_visits: null == clinic_visits
          ? _value.clinic_visits
          : clinic_visits // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InvoiceImplCopyWith<$Res> implements $InvoiceCopyWith<$Res> {
  factory _$$InvoiceImplCopyWith(
          _$InvoiceImpl value, $Res Function(_$InvoiceImpl) then) =
      __$$InvoiceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String docid,
      String link,
      String issued_at,
      int month,
      int year,
      String payment_reference,
      bool paid,
      int amount,
      int tax,
      double total,
      List<String> clinic_visits});
}

/// @nodoc
class __$$InvoiceImplCopyWithImpl<$Res>
    extends _$InvoiceCopyWithImpl<$Res, _$InvoiceImpl>
    implements _$$InvoiceImplCopyWith<$Res> {
  __$$InvoiceImplCopyWithImpl(
      _$InvoiceImpl _value, $Res Function(_$InvoiceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? docid = null,
    Object? link = null,
    Object? issued_at = null,
    Object? month = null,
    Object? year = null,
    Object? payment_reference = null,
    Object? paid = null,
    Object? amount = null,
    Object? tax = null,
    Object? total = null,
    Object? clinic_visits = null,
  }) {
    return _then(_$InvoiceImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      docid: null == docid
          ? _value.docid
          : docid // ignore: cast_nullable_to_non_nullable
              as String,
      link: null == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String,
      issued_at: null == issued_at
          ? _value.issued_at
          : issued_at // ignore: cast_nullable_to_non_nullable
              as String,
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as int,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      payment_reference: null == payment_reference
          ? _value.payment_reference
          : payment_reference // ignore: cast_nullable_to_non_nullable
              as String,
      paid: null == paid
          ? _value.paid
          : paid // ignore: cast_nullable_to_non_nullable
              as bool,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      tax: null == tax
          ? _value.tax
          : tax // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      clinic_visits: null == clinic_visits
          ? _value._clinic_visits
          : clinic_visits // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InvoiceImpl with DiagnosticableTreeMixin implements _Invoice {
  const _$InvoiceImpl(
      {required this.id,
      required this.docid,
      required this.link,
      required this.issued_at,
      required this.month,
      required this.year,
      required this.payment_reference,
      required this.paid,
      required this.amount,
      required this.tax,
      required this.total,
      required final List<String> clinic_visits})
      : _clinic_visits = clinic_visits;

  factory _$InvoiceImpl.fromJson(Map<String, dynamic> json) =>
      _$$InvoiceImplFromJson(json);

  @override
  final String id;
  @override
  final String docid;
  @override
  final String link;
  @override
  final String issued_at;
  @override
  final int month;
  @override
  final int year;
  @override
  final String payment_reference;
  @override
  final bool paid;
  @override
  final int amount;
  @override
  final int tax;
  @override
  final double total;
  final List<String> _clinic_visits;
  @override
  List<String> get clinic_visits {
    if (_clinic_visits is EqualUnmodifiableListView) return _clinic_visits;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_clinic_visits);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Invoice(id: $id, docid: $docid, link: $link, issued_at: $issued_at, month: $month, year: $year, payment_reference: $payment_reference, paid: $paid, amount: $amount, tax: $tax, total: $total, clinic_visits: $clinic_visits)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Invoice'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('docid', docid))
      ..add(DiagnosticsProperty('link', link))
      ..add(DiagnosticsProperty('issued_at', issued_at))
      ..add(DiagnosticsProperty('month', month))
      ..add(DiagnosticsProperty('year', year))
      ..add(DiagnosticsProperty('payment_reference', payment_reference))
      ..add(DiagnosticsProperty('paid', paid))
      ..add(DiagnosticsProperty('amount', amount))
      ..add(DiagnosticsProperty('tax', tax))
      ..add(DiagnosticsProperty('total', total))
      ..add(DiagnosticsProperty('clinic_visits', clinic_visits));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvoiceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.docid, docid) || other.docid == docid) &&
            (identical(other.link, link) || other.link == link) &&
            (identical(other.issued_at, issued_at) ||
                other.issued_at == issued_at) &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.payment_reference, payment_reference) ||
                other.payment_reference == payment_reference) &&
            (identical(other.paid, paid) || other.paid == paid) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.tax, tax) || other.tax == tax) &&
            (identical(other.total, total) || other.total == total) &&
            const DeepCollectionEquality()
                .equals(other._clinic_visits, _clinic_visits));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      docid,
      link,
      issued_at,
      month,
      year,
      payment_reference,
      paid,
      amount,
      tax,
      total,
      const DeepCollectionEquality().hash(_clinic_visits));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InvoiceImplCopyWith<_$InvoiceImpl> get copyWith =>
      __$$InvoiceImplCopyWithImpl<_$InvoiceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InvoiceImplToJson(
      this,
    );
  }
}

abstract class _Invoice implements Invoice {
  const factory _Invoice(
      {required final String id,
      required final String docid,
      required final String link,
      required final String issued_at,
      required final int month,
      required final int year,
      required final String payment_reference,
      required final bool paid,
      required final int amount,
      required final int tax,
      required final double total,
      required final List<String> clinic_visits}) = _$InvoiceImpl;

  factory _Invoice.fromJson(Map<String, dynamic> json) = _$InvoiceImpl.fromJson;

  @override
  String get id;
  @override
  String get docid;
  @override
  String get link;
  @override
  String get issued_at;
  @override
  int get month;
  @override
  int get year;
  @override
  String get payment_reference;
  @override
  bool get paid;
  @override
  int get amount;
  @override
  int get tax;
  @override
  double get total;
  @override
  List<String> get clinic_visits;
  @override
  @JsonKey(ignore: true)
  _$$InvoiceImplCopyWith<_$InvoiceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
