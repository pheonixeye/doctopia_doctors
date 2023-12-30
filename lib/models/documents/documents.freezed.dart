// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'documents.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Documents _$DocumentsFromJson(Map<String, dynamic> json) {
  return _Documents.fromJson(json);
}

/// @nodoc
mixin _$Documents {
  String get docid => throw _privateConstructorUsedError;
  String get synd_card => throw _privateConstructorUsedError;
  String get permit_cert => throw _privateConstructorUsedError;
  String get specialist_cert => throw _privateConstructorUsedError;
  String get consultant_cert => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DocumentsCopyWith<Documents> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DocumentsCopyWith<$Res> {
  factory $DocumentsCopyWith(Documents value, $Res Function(Documents) then) =
      _$DocumentsCopyWithImpl<$Res, Documents>;
  @useResult
  $Res call(
      {String docid,
      String synd_card,
      String permit_cert,
      String specialist_cert,
      String consultant_cert});
}

/// @nodoc
class _$DocumentsCopyWithImpl<$Res, $Val extends Documents>
    implements $DocumentsCopyWith<$Res> {
  _$DocumentsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? docid = null,
    Object? synd_card = null,
    Object? permit_cert = null,
    Object? specialist_cert = null,
    Object? consultant_cert = null,
  }) {
    return _then(_value.copyWith(
      docid: null == docid
          ? _value.docid
          : docid // ignore: cast_nullable_to_non_nullable
              as String,
      synd_card: null == synd_card
          ? _value.synd_card
          : synd_card // ignore: cast_nullable_to_non_nullable
              as String,
      permit_cert: null == permit_cert
          ? _value.permit_cert
          : permit_cert // ignore: cast_nullable_to_non_nullable
              as String,
      specialist_cert: null == specialist_cert
          ? _value.specialist_cert
          : specialist_cert // ignore: cast_nullable_to_non_nullable
              as String,
      consultant_cert: null == consultant_cert
          ? _value.consultant_cert
          : consultant_cert // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DocumentsImplCopyWith<$Res>
    implements $DocumentsCopyWith<$Res> {
  factory _$$DocumentsImplCopyWith(
          _$DocumentsImpl value, $Res Function(_$DocumentsImpl) then) =
      __$$DocumentsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String docid,
      String synd_card,
      String permit_cert,
      String specialist_cert,
      String consultant_cert});
}

/// @nodoc
class __$$DocumentsImplCopyWithImpl<$Res>
    extends _$DocumentsCopyWithImpl<$Res, _$DocumentsImpl>
    implements _$$DocumentsImplCopyWith<$Res> {
  __$$DocumentsImplCopyWithImpl(
      _$DocumentsImpl _value, $Res Function(_$DocumentsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? docid = null,
    Object? synd_card = null,
    Object? permit_cert = null,
    Object? specialist_cert = null,
    Object? consultant_cert = null,
  }) {
    return _then(_$DocumentsImpl(
      docid: null == docid
          ? _value.docid
          : docid // ignore: cast_nullable_to_non_nullable
              as String,
      synd_card: null == synd_card
          ? _value.synd_card
          : synd_card // ignore: cast_nullable_to_non_nullable
              as String,
      permit_cert: null == permit_cert
          ? _value.permit_cert
          : permit_cert // ignore: cast_nullable_to_non_nullable
              as String,
      specialist_cert: null == specialist_cert
          ? _value.specialist_cert
          : specialist_cert // ignore: cast_nullable_to_non_nullable
              as String,
      consultant_cert: null == consultant_cert
          ? _value.consultant_cert
          : consultant_cert // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DocumentsImpl with DiagnosticableTreeMixin implements _Documents {
  const _$DocumentsImpl(
      {required this.docid,
      required this.synd_card,
      required this.permit_cert,
      required this.specialist_cert,
      required this.consultant_cert});

  factory _$DocumentsImpl.fromJson(Map<String, dynamic> json) =>
      _$$DocumentsImplFromJson(json);

  @override
  final String docid;
  @override
  final String synd_card;
  @override
  final String permit_cert;
  @override
  final String specialist_cert;
  @override
  final String consultant_cert;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Documents(docid: $docid, synd_card: $synd_card, permit_cert: $permit_cert, specialist_cert: $specialist_cert, consultant_cert: $consultant_cert)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Documents'))
      ..add(DiagnosticsProperty('docid', docid))
      ..add(DiagnosticsProperty('synd_card', synd_card))
      ..add(DiagnosticsProperty('permit_cert', permit_cert))
      ..add(DiagnosticsProperty('specialist_cert', specialist_cert))
      ..add(DiagnosticsProperty('consultant_cert', consultant_cert));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DocumentsImpl &&
            (identical(other.docid, docid) || other.docid == docid) &&
            (identical(other.synd_card, synd_card) ||
                other.synd_card == synd_card) &&
            (identical(other.permit_cert, permit_cert) ||
                other.permit_cert == permit_cert) &&
            (identical(other.specialist_cert, specialist_cert) ||
                other.specialist_cert == specialist_cert) &&
            (identical(other.consultant_cert, consultant_cert) ||
                other.consultant_cert == consultant_cert));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, docid, synd_card, permit_cert,
      specialist_cert, consultant_cert);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DocumentsImplCopyWith<_$DocumentsImpl> get copyWith =>
      __$$DocumentsImplCopyWithImpl<_$DocumentsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DocumentsImplToJson(
      this,
    );
  }
}

abstract class _Documents implements Documents {
  const factory _Documents(
      {required final String docid,
      required final String synd_card,
      required final String permit_cert,
      required final String specialist_cert,
      required final String consultant_cert}) = _$DocumentsImpl;

  factory _Documents.fromJson(Map<String, dynamic> json) =
      _$DocumentsImpl.fromJson;

  @override
  String get docid;
  @override
  String get synd_card;
  @override
  String get permit_cert;
  @override
  String get specialist_cert;
  @override
  String get consultant_cert;
  @override
  @JsonKey(ignore: true)
  _$$DocumentsImplCopyWith<_$DocumentsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
