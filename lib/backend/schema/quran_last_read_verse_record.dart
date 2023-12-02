import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class QuranLastReadVerseRecord extends FirestoreRecord {
  QuranLastReadVerseRecord._(
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
  String? _verse;
  String get verse => _verse ?? '';
  bool hasVerse() => _verse != null;

  // "lastmodified" field.
  int? _lastmodified;
  int get lastmodified => _lastmodified ?? 0;
  bool hasLastmodified() => _lastmodified != null;

  void _initializeFields() {
    _user = snapshotData['user'] as String?;
    _verse = snapshotData['verse'] as String?;
    _lastmodified = castToType<int>(snapshotData['lastmodified']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('quranLastReadVerse');

  static Stream<QuranLastReadVerseRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => QuranLastReadVerseRecord.fromSnapshot(s));

  static Future<QuranLastReadVerseRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => QuranLastReadVerseRecord.fromSnapshot(s));

  static QuranLastReadVerseRecord fromSnapshot(DocumentSnapshot snapshot) =>
      QuranLastReadVerseRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static QuranLastReadVerseRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      QuranLastReadVerseRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'QuranLastReadVerseRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is QuranLastReadVerseRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createQuranLastReadVerseRecordData({
  String? user,
  String? verse,
  int? lastmodified,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'user': user,
      'verse': verse,
      'lastmodified': lastmodified,
    }.withoutNulls,
  );

  return firestoreData;
}

class QuranLastReadVerseRecordDocumentEquality
    implements Equality<QuranLastReadVerseRecord> {
  const QuranLastReadVerseRecordDocumentEquality();

  @override
  bool equals(QuranLastReadVerseRecord? e1, QuranLastReadVerseRecord? e2) {
    return e1?.user == e2?.user &&
        e1?.verse == e2?.verse &&
        e1?.lastmodified == e2?.lastmodified;
  }

  @override
  int hash(QuranLastReadVerseRecord? e) =>
      const ListEquality().hash([e?.user, e?.verse, e?.lastmodified]);

  @override
  bool isValidKey(Object? o) => o is QuranLastReadVerseRecord;
}
