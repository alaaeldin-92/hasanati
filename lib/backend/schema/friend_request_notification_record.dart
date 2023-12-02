import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class FriendRequestNotificationRecord extends FirestoreRecord {
  FriendRequestNotificationRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "sender" field.
  String? _sender;
  String get sender => _sender ?? '';
  bool hasSender() => _sender != null;

  // "receiver" field.
  String? _receiver;
  String get receiver => _receiver ?? '';
  bool hasReceiver() => _receiver != null;

  // "accepted" field.
  bool? _accepted;
  bool get accepted => _accepted ?? false;
  bool hasAccepted() => _accepted != null;

  // "createdAt" field.
  int? _createdAt;
  int get createdAt => _createdAt ?? 0;
  bool hasCreatedAt() => _createdAt != null;

  void _initializeFields() {
    _sender = snapshotData['sender'] as String?;
    _receiver = snapshotData['receiver'] as String?;
    _accepted = snapshotData['accepted'] as bool?;
    _createdAt = castToType<int>(snapshotData['createdAt']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('friendRequestNotification');

  static Stream<FriendRequestNotificationRecord> getDocument(
          DocumentReference ref) =>
      ref
          .snapshots()
          .map((s) => FriendRequestNotificationRecord.fromSnapshot(s));

  static Future<FriendRequestNotificationRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => FriendRequestNotificationRecord.fromSnapshot(s));

  static FriendRequestNotificationRecord fromSnapshot(
          DocumentSnapshot snapshot) =>
      FriendRequestNotificationRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static FriendRequestNotificationRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      FriendRequestNotificationRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'FriendRequestNotificationRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is FriendRequestNotificationRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createFriendRequestNotificationRecordData({
  String? sender,
  String? receiver,
  bool? accepted,
  int? createdAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'sender': sender,
      'receiver': receiver,
      'accepted': accepted,
      'createdAt': createdAt,
    }.withoutNulls,
  );

  return firestoreData;
}

class FriendRequestNotificationRecordDocumentEquality
    implements Equality<FriendRequestNotificationRecord> {
  const FriendRequestNotificationRecordDocumentEquality();

  @override
  bool equals(FriendRequestNotificationRecord? e1,
      FriendRequestNotificationRecord? e2) {
    return e1?.sender == e2?.sender &&
        e1?.receiver == e2?.receiver &&
        e1?.accepted == e2?.accepted &&
        e1?.createdAt == e2?.createdAt;
  }

  @override
  int hash(FriendRequestNotificationRecord? e) => const ListEquality()
      .hash([e?.sender, e?.receiver, e?.accepted, e?.createdAt]);

  @override
  bool isValidKey(Object? o) => o is FriendRequestNotificationRecord;
}
