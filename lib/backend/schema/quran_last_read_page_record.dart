import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class QuranLastReadPageRecord extends FirestoreRecord {
  QuranLastReadPageRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "user" field.
  String? _user;
  String get user => _user ?? '';
  bool hasUser() => _user != null;

  // "page" field.
  int? _page;
  int get page => _page ?? 0;
  bool hasPage() => _page != null;

  // "lastmodified" field.
  int? _lastmodified;
  int get lastmodified => _lastmodified ?? 0;
  bool hasLastmodified() => _lastmodified != null;

  void _initializeFields() {
    _user = snapshotData['user'] as String?;
    _page = castToType<int>(snapshotData['page']);
    _lastmodified = castToType<int>(snapshotData['lastmodified']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('quranLastReadPage');

  static Stream<QuranLastReadPageRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => QuranLastReadPageRecord.fromSnapshot(s));

  static Future<QuranLastReadPageRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => QuranLastReadPageRecord.fromSnapshot(s));

  static QuranLastReadPageRecord fromSnapshot(DocumentSnapshot snapshot) =>
      QuranLastReadPageRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static QuranLastReadPageRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      QuranLastReadPageRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'QuranLastReadPageRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is QuranLastReadPageRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createQuranLastReadPageRecordData({
  String? user,
  int? page,
  int? lastmodified,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'user': user,
      'page': page,
      'lastmodified': lastmodified,
    }.withoutNulls,
  );

  return firestoreData;
}

class QuranLastReadPageRecordDocumentEquality
    implements Equality<QuranLastReadPageRecord> {
  const QuranLastReadPageRecordDocumentEquality();

  @override
  bool equals(QuranLastReadPageRecord? e1, QuranLastReadPageRecord? e2) {
    return e1?.user == e2?.user &&
        e1?.page == e2?.page &&
        e1?.lastmodified == e2?.lastmodified;
  }

  @override
  int hash(QuranLastReadPageRecord? e) =>
      const ListEquality().hash([e?.user, e?.page, e?.lastmodified]);

  @override
  bool isValidKey(Object? o) => o is QuranLastReadPageRecord;
}
