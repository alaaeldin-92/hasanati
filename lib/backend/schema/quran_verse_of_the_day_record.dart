import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class QuranVerseOfTheDayRecord extends FirestoreRecord {
  QuranVerseOfTheDayRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "chapter" field.
  int? _chapter;
  int get chapter => _chapter ?? 0;
  bool hasChapter() => _chapter != null;

  // "verse" field.
  int? _verse;
  int get verse => _verse ?? 0;
  bool hasVerse() => _verse != null;

  // "claimed" field.
  bool? _claimed;
  bool get claimed => _claimed ?? false;
  bool hasClaimed() => _claimed != null;

  // "nextUpdate" field.
  int? _nextUpdate;
  int get nextUpdate => _nextUpdate ?? 0;
  bool hasNextUpdate() => _nextUpdate != null;

  // "user" field.
  String? _user;
  String get user => _user ?? '';
  bool hasUser() => _user != null;

  void _initializeFields() {
    _chapter = castToType<int>(snapshotData['chapter']);
    _verse = castToType<int>(snapshotData['verse']);
    _claimed = snapshotData['claimed'] as bool?;
    _nextUpdate = castToType<int>(snapshotData['nextUpdate']);
    _user = snapshotData['user'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('quranVerseOfTheDay');

  static Stream<QuranVerseOfTheDayRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => QuranVerseOfTheDayRecord.fromSnapshot(s));

  static Future<QuranVerseOfTheDayRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => QuranVerseOfTheDayRecord.fromSnapshot(s));

  static QuranVerseOfTheDayRecord fromSnapshot(DocumentSnapshot snapshot) =>
      QuranVerseOfTheDayRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static QuranVerseOfTheDayRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      QuranVerseOfTheDayRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'QuranVerseOfTheDayRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is QuranVerseOfTheDayRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createQuranVerseOfTheDayRecordData({
  int? chapter,
  int? verse,
  bool? claimed,
  int? nextUpdate,
  String? user,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'chapter': chapter,
      'verse': verse,
      'claimed': claimed,
      'nextUpdate': nextUpdate,
      'user': user,
    }.withoutNulls,
  );

  return firestoreData;
}

class QuranVerseOfTheDayRecordDocumentEquality
    implements Equality<QuranVerseOfTheDayRecord> {
  const QuranVerseOfTheDayRecordDocumentEquality();

  @override
  bool equals(QuranVerseOfTheDayRecord? e1, QuranVerseOfTheDayRecord? e2) {
    return e1?.chapter == e2?.chapter &&
        e1?.verse == e2?.verse &&
        e1?.claimed == e2?.claimed &&
        e1?.nextUpdate == e2?.nextUpdate &&
        e1?.user == e2?.user;
  }

  @override
  int hash(QuranVerseOfTheDayRecord? e) => const ListEquality()
      .hash([e?.chapter, e?.verse, e?.claimed, e?.nextUpdate, e?.user]);

  @override
  bool isValidKey(Object? o) => o is QuranVerseOfTheDayRecord;
}
