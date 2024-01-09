import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dart_appwrite/models.dart';

Future<Model> createAttribute({
  required Type type,
  required Databases databases,
  required String databaseId,
  required String collectionId,
  required String key,
  required int size,
  required bool xrequired,
  dynamic xdefault,
  bool? array,
  bool? encrypt,
  dynamic min,
  dynamic max,
}) async {
  switch (type) {
    case String:
      assertFns(xdefault, type);
      return databases.createStringAttribute(
        databaseId: databaseId,
        collectionId: collectionId,
        key: key,
        size: size,
        xrequired: xrequired,
        xdefault: xdefault,
        array: array,
        encrypt: encrypt,
      );
    case int:
      assertFns(xdefault, type);
      assertFns(min, type);
      assertFns(max, type);

      return databases.createIntegerAttribute(
        databaseId: databaseId,
        collectionId: collectionId,
        key: key,
        xrequired: xrequired,
        xdefault: xdefault,
        array: array,
        max: max,
        min: min,
      );
    case bool:
      assertFns(xdefault, type);
      return databases.createBooleanAttribute(
        databaseId: databaseId,
        collectionId: collectionId,
        key: key,
        xrequired: xrequired,
        xdefault: xdefault,
        array: array,
      );
    case double:
      assertFns(xdefault, type);
      assertFns(min, type);
      assertFns(max, type);
      return databases.createFloatAttribute(
        databaseId: databaseId,
        collectionId: collectionId,
        key: key,
        xrequired: xrequired,
        xdefault: xdefault,
        array: array,
        min: min,
        max: max,
      );
    default:
      throw UnimplementedError();
  }
}

void assertFns(dynamic value, Type type) {
  if (value != null) {
    assert(value.runtimeType == type);
  }
}
