import 'dart:async';

import 'package:from_css_color/from_css_color.dart';
import '/backend/algolia/serialization_util.dart';
import '/backend/algolia/algolia_manager.dart';
import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class QuranPerformanceRecord extends FirestoreRecord {
  QuranPerformanceRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "hasanat" field.
  int? _hasanat;
  int get hasanat => _hasanat ?? 0;
  bool hasHasanat() => _hasanat != null;

  // "timeReadSec" field.
  int? _timeReadSec;
  int get timeReadSec => _timeReadSec ?? 0;
  bool hasTimeReadSec() => _timeReadSec != null;

  // "versesRead" field.
  int? _versesRead;
  int get versesRead => _versesRead ?? 0;
  bool hasVersesRead() => _versesRead != null;

  // "user" field.
  String? _user;
  String get user => _user ?? '';
  bool hasUser() => _user != null;

  // "lastmodified" field.
  int? _lastmodified;
  int get lastmodified => _lastmodified ?? 0;
  bool hasLastmodified() => _lastmodified != null;

  void _initializeFields() {
    _hasanat = castToType<int>(snapshotData['hasanat']);
    _timeReadSec = castToType<int>(snapshotData['timeReadSec']);
    _versesRead = castToType<int>(snapshotData['versesRead']);
    _user = snapshotData['user'] as String?;
    _lastmodified = castToType<int>(snapshotData['lastmodified']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('quranPerformance');

  static Stream<QuranPerformanceRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => QuranPerformanceRecord.fromSnapshot(s));

  static Future<QuranPerformanceRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => QuranPerformanceRecord.fromSnapshot(s));

  static QuranPerformanceRecord fromSnapshot(DocumentSnapshot snapshot) =>
      QuranPerformanceRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static QuranPerformanceRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      QuranPerformanceRecord._(reference, mapFromFirestore(data));

  static QuranPerformanceRecord fromAlgolia(AlgoliaObjectSnapshot snapshot) =>
      QuranPerformanceRecord.getDocumentFromData(
        {
          'hasanat': convertAlgoliaParam(
            snapshot.data['hasanat'],
            ParamType.int,
            false,
          ),
          'timeReadSec': convertAlgoliaParam(
            snapshot.data['timeReadSec'],
            ParamType.int,
            false,
          ),
          'versesRead': convertAlgoliaParam(
            snapshot.data['versesRead'],
            ParamType.int,
            false,
          ),
          'user': snapshot.data['user'],
          'lastmodified': convertAlgoliaParam(
            snapshot.data['lastmodified'],
            ParamType.int,
            false,
          ),
        },
        QuranPerformanceRecord.collection.doc(snapshot.objectID),
      );

  static Future<List<QuranPerformanceRecord>> search({
    String? term,
    FutureOr<LatLng>? location,
    int? maxResults,
    double? searchRadiusMeters,
    bool useCache = false,
  }) =>
      FFAlgoliaManager.instance
          .algoliaQuery(
            index: 'quranPerformance',
            term: term,
            maxResults: maxResults,
            location: location,
            searchRadiusMeters: searchRadiusMeters,
            useCache: useCache,
          )
          .then((r) => r.map(fromAlgolia).toList());

  @override
  String toString() =>
      'QuranPerformanceRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is QuranPerformanceRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createQuranPerformanceRecordData({
  int? hasanat,
  int? timeReadSec,
  int? versesRead,
  String? user,
  int? lastmodified,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'hasanat': hasanat,
      'timeReadSec': timeReadSec,
      'versesRead': versesRead,
      'user': user,
      'lastmodified': lastmodified,
    }.withoutNulls,
  );

  return firestoreData;
}

class QuranPerformanceRecordDocumentEquality
    implements Equality<QuranPerformanceRecord> {
  const QuranPerformanceRecordDocumentEquality();

  @override
  bool equals(QuranPerformanceRecord? e1, QuranPerformanceRecord? e2) {
    return e1?.hasanat == e2?.hasanat &&
        e1?.timeReadSec == e2?.timeReadSec &&
        e1?.versesRead == e2?.versesRead &&
        e1?.user == e2?.user &&
        e1?.lastmodified == e2?.lastmodified;
  }

  @override
  int hash(QuranPerformanceRecord? e) => const ListEquality().hash(
      [e?.hasanat, e?.timeReadSec, e?.versesRead, e?.user, e?.lastmodified]);

  @override
  bool isValidKey(Object? o) => o is QuranPerformanceRecord;
}
