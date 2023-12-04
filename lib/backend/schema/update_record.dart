import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UpdateRecord extends FirestoreRecord {
  UpdateRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "status" field.
  bool? _status;
  bool get status => _status ?? false;
  bool hasStatus() => _status != null;

  // "image_url" field.
  String? _imageUrl;
  String get imageUrl => _imageUrl ?? '';
  bool hasImageUrl() => _imageUrl != null;

  void _initializeFields() {
    _status = snapshotData['status'] as bool?;
    _imageUrl = snapshotData['image_url'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('update');

  static Stream<UpdateRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UpdateRecord.fromSnapshot(s));

  static Future<UpdateRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UpdateRecord.fromSnapshot(s));

  static UpdateRecord fromSnapshot(DocumentSnapshot snapshot) => UpdateRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UpdateRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UpdateRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UpdateRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UpdateRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUpdateRecordData({
  bool? status,
  String? imageUrl,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'status': status,
      'image_url': imageUrl,
    }.withoutNulls,
  );

  return firestoreData;
}

class UpdateRecordDocumentEquality implements Equality<UpdateRecord> {
  const UpdateRecordDocumentEquality();

  @override
  bool equals(UpdateRecord? e1, UpdateRecord? e2) {
    return e1?.status == e2?.status && e1?.imageUrl == e2?.imageUrl;
  }

  @override
  int hash(UpdateRecord? e) =>
      const ListEquality().hash([e?.status, e?.imageUrl]);

  @override
  bool isValidKey(Object? o) => o is UpdateRecord;
}
