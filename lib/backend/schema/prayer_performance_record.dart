import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PrayerPerformanceRecord extends FirestoreRecord {
  PrayerPerformanceRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "user" field.
  String? _user;
  String get user => _user ?? '';
  bool hasUser() => _user != null;

  // "fajr" field.
  bool? _fajr;
  bool get fajr => _fajr ?? false;
  bool hasFajr() => _fajr != null;

  // "duhr" field.
  bool? _duhr;
  bool get duhr => _duhr ?? false;
  bool hasDuhr() => _duhr != null;

  // "asr" field.
  bool? _asr;
  bool get asr => _asr ?? false;
  bool hasAsr() => _asr != null;

  // "maghrib" field.
  bool? _maghrib;
  bool get maghrib => _maghrib ?? false;
  bool hasMaghrib() => _maghrib != null;

  // "isha" field.
  bool? _isha;
  bool get isha => _isha ?? false;
  bool hasIsha() => _isha != null;

  // "day" field.
  int? _day;
  int get day => _day ?? 0;
  bool hasDay() => _day != null;

  void _initializeFields() {
    _user = snapshotData['user'] as String?;
    _fajr = snapshotData['fajr'] as bool?;
    _duhr = snapshotData['duhr'] as bool?;
    _asr = snapshotData['asr'] as bool?;
    _maghrib = snapshotData['maghrib'] as bool?;
    _isha = snapshotData['isha'] as bool?;
    _day = castToType<int>(snapshotData['day']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('prayerPerformance');

  static Stream<PrayerPerformanceRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PrayerPerformanceRecord.fromSnapshot(s));

  static Future<PrayerPerformanceRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => PrayerPerformanceRecord.fromSnapshot(s));

  static PrayerPerformanceRecord fromSnapshot(DocumentSnapshot snapshot) =>
      PrayerPerformanceRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PrayerPerformanceRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PrayerPerformanceRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PrayerPerformanceRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PrayerPerformanceRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPrayerPerformanceRecordData({
  String? user,
  bool? fajr,
  bool? duhr,
  bool? asr,
  bool? maghrib,
  bool? isha,
  int? day,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'user': user,
      'fajr': fajr,
      'duhr': duhr,
      'asr': asr,
      'maghrib': maghrib,
      'isha': isha,
      'day': day,
    }.withoutNulls,
  );

  return firestoreData;
}

class PrayerPerformanceRecordDocumentEquality
    implements Equality<PrayerPerformanceRecord> {
  const PrayerPerformanceRecordDocumentEquality();

  @override
  bool equals(PrayerPerformanceRecord? e1, PrayerPerformanceRecord? e2) {
    return e1?.user == e2?.user &&
        e1?.fajr == e2?.fajr &&
        e1?.duhr == e2?.duhr &&
        e1?.asr == e2?.asr &&
        e1?.maghrib == e2?.maghrib &&
        e1?.isha == e2?.isha &&
        e1?.day == e2?.day;
  }

  @override
  int hash(PrayerPerformanceRecord? e) => const ListEquality()
      .hash([e?.user, e?.fajr, e?.duhr, e?.asr, e?.maghrib, e?.isha, e?.day]);

  @override
  bool isValidKey(Object? o) => o is PrayerPerformanceRecord;
}
