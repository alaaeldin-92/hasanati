import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class QuranVersesMemorizeRecord extends FirestoreRecord {
  QuranVersesMemorizeRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "user" field.
  String? _user;
  String get user => _user ?? '';
  bool hasUser() => _user != null;

  // "verse" field.
  List<String>? _verse;
  List<String> get verse => _verse ?? const [];
  bool hasVerse() => _verse != null;

  void _initializeFields() {
    _user = snapshotData['user'] as String?;
    _verse = getDataList(snapshotData['verse']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('quranVersesMemorize');

  static Stream<QuranVersesMemorizeRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => QuranVersesMemorizeRecord.fromSnapshot(s));

  static Future<QuranVersesMemorizeRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => QuranVersesMemorizeRecord.fromSnapshot(s));

  static QuranVersesMemorizeRecord fromSnapshot(DocumentSnapshot snapshot) =>
      QuranVersesMemorizeRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static QuranVersesMemorizeRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      QuranVersesMemorizeRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'QuranVersesMemorizeRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is QuranVersesMemorizeRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createQuranVersesMemorizeRecordData({
  String? user,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'user': user,
    }.withoutNulls,
  );

  return firestoreData;
}

class QuranVersesMemorizeRecordDocumentEquality
    implements Equality<QuranVersesMemorizeRecord> {
  const QuranVersesMemorizeRecordDocumentEquality();

  @override
  bool equals(QuranVersesMemorizeRecord? e1, QuranVersesMemorizeRecord? e2) {
    const listEquality = ListEquality();
    return e1?.user == e2?.user && listEquality.equals(e1?.verse, e2?.verse);
  }

  @override
  int hash(QuranVersesMemorizeRecord? e) =>
      const ListEquality().hash([e?.user, e?.verse]);

  @override
  bool isValidKey(Object? o) => o is QuranVersesMemorizeRecord;
}
