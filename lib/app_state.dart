import 'package:flutter/material.dart';
import '/backend/backend.dart';
import 'backend/api_requests/api_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:csv/csv.dart';
import 'package:synchronized/synchronized.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    secureStorage = FlutterSecureStorage();
    await _safeInitAsync(() async {
      _language = await secureStorage.getString('ff_language') ?? _language;
    });
    await _safeInitAsync(() async {
      _LightPrimary =
          _colorFromIntValue(await secureStorage.getInt('ff_LightPrimary')) ??
              _LightPrimary;
    });
    await _safeInitAsync(() async {
      _LightPrimaryText = _colorFromIntValue(
              await secureStorage.getInt('ff_LightPrimaryText')) ??
          _LightPrimaryText;
    });
    await _safeInitAsync(() async {
      _email = await secureStorage.getString('ff_email') ?? _email;
    });
    await _safeInitAsync(() async {
      _password = await secureStorage.getString('ff_password') ?? _password;
    });
    await _safeInitAsync(() async {
      _quranHasanat =
          await secureStorage.getInt('ff_quranHasanat') ?? _quranHasanat;
    });
    await _safeInitAsync(() async {
      _quranVersesRead =
          await secureStorage.getInt('ff_quranVersesRead') ?? _quranVersesRead;
    });
    await _safeInitAsync(() async {
      _quranTimeReadSec = await secureStorage.getInt('ff_quranTimeReadSec') ??
          _quranTimeReadSec;
    });
    await _safeInitAsync(() async {
      _quranLastReadVerse =
          await secureStorage.getString('ff_quranLastReadVerse') ??
              _quranLastReadVerse;
    });
    await _safeInitAsync(() async {
      _quranVersesMemorized =
          await secureStorage.getStringList('ff_quranVersesMemorized') ??
              _quranVersesMemorized;
    });
    await _safeInitAsync(() async {
      _quranVersesFavorites =
          await secureStorage.getStringList('ff_quranVersesFavorites') ??
              _quranVersesFavorites;
    });
    await _safeInitAsync(() async {
      _quranVerseTraverseUpdated =
          await secureStorage.getBool('ff_quranVerseTraverseUpdated') ??
              _quranVerseTraverseUpdated;
    });
    await _safeInitAsync(() async {
      _quranVersesMemorizedAddSession = await secureStorage
              .getStringList('ff_quranVersesMemorizedAddSession') ??
          _quranVersesMemorizedAddSession;
    });
    await _safeInitAsync(() async {
      _quranVersesMemorizedRemoveSession = await secureStorage
              .getStringList('ff_quranVersesMemorizedRemoveSession') ??
          _quranVersesMemorizedRemoveSession;
    });
    await _safeInitAsync(() async {
      _quranVersesFavoriteAddSession = await secureStorage
              .getStringList('ff_quranVersesFavoriteAddSession') ??
          _quranVersesFavoriteAddSession;
    });
    await _safeInitAsync(() async {
      _quranVersesFavoriteRemoveSession = await secureStorage
              .getStringList('ff_quranVersesFavoriteRemoveSession') ??
          _quranVersesFavoriteRemoveSession;
    });
    await _safeInitAsync(() async {
      _quranLastReadPage = await secureStorage.getInt('ff_quranLastReadPage') ??
          _quranLastReadPage;
    });
    await _safeInitAsync(() async {
      _stopTimers = await secureStorage.getBool('ff_stopTimers') ?? _stopTimers;
    });
    await _safeInitAsync(() async {
      _quranPageTraverseUpdated =
          await secureStorage.getBool('ff_quranPageTraverseUpdated') ??
              _quranPageTraverseUpdated;
    });
    await _safeInitAsync(() async {
      _reciterID = await secureStorage.getInt('ff_reciterID') ?? _reciterID;
    });
    await _safeInitAsync(() async {
      _seenUpdateScreen = await secureStorage.getBool('ff_seenUpdateScreen') ??
          _seenUpdateScreen;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late FlutterSecureStorage secureStorage;

  String _language = 'English';
  String get language => _language;
  set language(String _value) {
    _language = _value;
    secureStorage.setString('ff_language', _value);
  }

  void deleteLanguage() {
    secureStorage.delete(key: 'ff_language');
  }

  Color _LightPrimary = Color(4278940413);
  Color get LightPrimary => _LightPrimary;
  set LightPrimary(Color _value) {
    _LightPrimary = _value;
    secureStorage.setInt('ff_LightPrimary', _value.value);
  }

  void deleteLightPrimary() {
    secureStorage.delete(key: 'ff_LightPrimary');
  }

  Color _LightPrimaryText = Color(4279506971);
  Color get LightPrimaryText => _LightPrimaryText;
  set LightPrimaryText(Color _value) {
    _LightPrimaryText = _value;
    secureStorage.setInt('ff_LightPrimaryText', _value.value);
  }

  void deleteLightPrimaryText() {
    secureStorage.delete(key: 'ff_LightPrimaryText');
  }

  String _email = '';
  String get email => _email;
  set email(String _value) {
    _email = _value;
    secureStorage.setString('ff_email', _value);
  }

  void deleteEmail() {
    secureStorage.delete(key: 'ff_email');
  }

  String _password = '';
  String get password => _password;
  set password(String _value) {
    _password = _value;
    secureStorage.setString('ff_password', _value);
  }

  void deletePassword() {
    secureStorage.delete(key: 'ff_password');
  }

  int _quranHasanat = 0;
  int get quranHasanat => _quranHasanat;
  set quranHasanat(int _value) {
    _quranHasanat = _value;
    secureStorage.setInt('ff_quranHasanat', _value);
  }

  void deleteQuranHasanat() {
    secureStorage.delete(key: 'ff_quranHasanat');
  }

  int _quranVersesRead = 0;
  int get quranVersesRead => _quranVersesRead;
  set quranVersesRead(int _value) {
    _quranVersesRead = _value;
    secureStorage.setInt('ff_quranVersesRead', _value);
  }

  void deleteQuranVersesRead() {
    secureStorage.delete(key: 'ff_quranVersesRead');
  }

  int _quranTimeReadSec = 0;
  int get quranTimeReadSec => _quranTimeReadSec;
  set quranTimeReadSec(int _value) {
    _quranTimeReadSec = _value;
    secureStorage.setInt('ff_quranTimeReadSec', _value);
  }

  void deleteQuranTimeReadSec() {
    secureStorage.delete(key: 'ff_quranTimeReadSec');
  }

  String _quranLastReadVerse = '';
  String get quranLastReadVerse => _quranLastReadVerse;
  set quranLastReadVerse(String _value) {
    _quranLastReadVerse = _value;
    secureStorage.setString('ff_quranLastReadVerse', _value);
  }

  void deleteQuranLastReadVerse() {
    secureStorage.delete(key: 'ff_quranLastReadVerse');
  }

  List<String> _quranVersesMemorized = [];
  List<String> get quranVersesMemorized => _quranVersesMemorized;
  set quranVersesMemorized(List<String> _value) {
    _quranVersesMemorized = _value;
    secureStorage.setStringList('ff_quranVersesMemorized', _value);
  }

  void deleteQuranVersesMemorized() {
    secureStorage.delete(key: 'ff_quranVersesMemorized');
  }

  void addToQuranVersesMemorized(String _value) {
    _quranVersesMemorized.add(_value);
    secureStorage.setStringList(
        'ff_quranVersesMemorized', _quranVersesMemorized);
  }

  void removeFromQuranVersesMemorized(String _value) {
    _quranVersesMemorized.remove(_value);
    secureStorage.setStringList(
        'ff_quranVersesMemorized', _quranVersesMemorized);
  }

  void removeAtIndexFromQuranVersesMemorized(int _index) {
    _quranVersesMemorized.removeAt(_index);
    secureStorage.setStringList(
        'ff_quranVersesMemorized', _quranVersesMemorized);
  }

  void updateQuranVersesMemorizedAtIndex(
    int _index,
    String Function(String) updateFn,
  ) {
    _quranVersesMemorized[_index] = updateFn(_quranVersesMemorized[_index]);
    secureStorage.setStringList(
        'ff_quranVersesMemorized', _quranVersesMemorized);
  }

  void insertAtIndexInQuranVersesMemorized(int _index, String _value) {
    _quranVersesMemorized.insert(_index, _value);
    secureStorage.setStringList(
        'ff_quranVersesMemorized', _quranVersesMemorized);
  }

  List<String> _quranVersesFavorites = [];
  List<String> get quranVersesFavorites => _quranVersesFavorites;
  set quranVersesFavorites(List<String> _value) {
    _quranVersesFavorites = _value;
    secureStorage.setStringList('ff_quranVersesFavorites', _value);
  }

  void deleteQuranVersesFavorites() {
    secureStorage.delete(key: 'ff_quranVersesFavorites');
  }

  void addToQuranVersesFavorites(String _value) {
    _quranVersesFavorites.add(_value);
    secureStorage.setStringList(
        'ff_quranVersesFavorites', _quranVersesFavorites);
  }

  void removeFromQuranVersesFavorites(String _value) {
    _quranVersesFavorites.remove(_value);
    secureStorage.setStringList(
        'ff_quranVersesFavorites', _quranVersesFavorites);
  }

  void removeAtIndexFromQuranVersesFavorites(int _index) {
    _quranVersesFavorites.removeAt(_index);
    secureStorage.setStringList(
        'ff_quranVersesFavorites', _quranVersesFavorites);
  }

  void updateQuranVersesFavoritesAtIndex(
    int _index,
    String Function(String) updateFn,
  ) {
    _quranVersesFavorites[_index] = updateFn(_quranVersesFavorites[_index]);
    secureStorage.setStringList(
        'ff_quranVersesFavorites', _quranVersesFavorites);
  }

  void insertAtIndexInQuranVersesFavorites(int _index, String _value) {
    _quranVersesFavorites.insert(_index, _value);
    secureStorage.setStringList(
        'ff_quranVersesFavorites', _quranVersesFavorites);
  }

  bool _quranVerseTraverseUpdated = false;
  bool get quranVerseTraverseUpdated => _quranVerseTraverseUpdated;
  set quranVerseTraverseUpdated(bool _value) {
    _quranVerseTraverseUpdated = _value;
    secureStorage.setBool('ff_quranVerseTraverseUpdated', _value);
  }

  void deleteQuranVerseTraverseUpdated() {
    secureStorage.delete(key: 'ff_quranVerseTraverseUpdated');
  }

  List<String> _quranVersesMemorizedAddSession = [];
  List<String> get quranVersesMemorizedAddSession =>
      _quranVersesMemorizedAddSession;
  set quranVersesMemorizedAddSession(List<String> _value) {
    _quranVersesMemorizedAddSession = _value;
    secureStorage.setStringList('ff_quranVersesMemorizedAddSession', _value);
  }

  void deleteQuranVersesMemorizedAddSession() {
    secureStorage.delete(key: 'ff_quranVersesMemorizedAddSession');
  }

  void addToQuranVersesMemorizedAddSession(String _value) {
    _quranVersesMemorizedAddSession.add(_value);
    secureStorage.setStringList(
        'ff_quranVersesMemorizedAddSession', _quranVersesMemorizedAddSession);
  }

  void removeFromQuranVersesMemorizedAddSession(String _value) {
    _quranVersesMemorizedAddSession.remove(_value);
    secureStorage.setStringList(
        'ff_quranVersesMemorizedAddSession', _quranVersesMemorizedAddSession);
  }

  void removeAtIndexFromQuranVersesMemorizedAddSession(int _index) {
    _quranVersesMemorizedAddSession.removeAt(_index);
    secureStorage.setStringList(
        'ff_quranVersesMemorizedAddSession', _quranVersesMemorizedAddSession);
  }

  void updateQuranVersesMemorizedAddSessionAtIndex(
    int _index,
    String Function(String) updateFn,
  ) {
    _quranVersesMemorizedAddSession[_index] =
        updateFn(_quranVersesMemorizedAddSession[_index]);
    secureStorage.setStringList(
        'ff_quranVersesMemorizedAddSession', _quranVersesMemorizedAddSession);
  }

  void insertAtIndexInQuranVersesMemorizedAddSession(
      int _index, String _value) {
    _quranVersesMemorizedAddSession.insert(_index, _value);
    secureStorage.setStringList(
        'ff_quranVersesMemorizedAddSession', _quranVersesMemorizedAddSession);
  }

  List<String> _quranVersesMemorizedRemoveSession = [];
  List<String> get quranVersesMemorizedRemoveSession =>
      _quranVersesMemorizedRemoveSession;
  set quranVersesMemorizedRemoveSession(List<String> _value) {
    _quranVersesMemorizedRemoveSession = _value;
    secureStorage.setStringList('ff_quranVersesMemorizedRemoveSession', _value);
  }

  void deleteQuranVersesMemorizedRemoveSession() {
    secureStorage.delete(key: 'ff_quranVersesMemorizedRemoveSession');
  }

  void addToQuranVersesMemorizedRemoveSession(String _value) {
    _quranVersesMemorizedRemoveSession.add(_value);
    secureStorage.setStringList('ff_quranVersesMemorizedRemoveSession',
        _quranVersesMemorizedRemoveSession);
  }

  void removeFromQuranVersesMemorizedRemoveSession(String _value) {
    _quranVersesMemorizedRemoveSession.remove(_value);
    secureStorage.setStringList('ff_quranVersesMemorizedRemoveSession',
        _quranVersesMemorizedRemoveSession);
  }

  void removeAtIndexFromQuranVersesMemorizedRemoveSession(int _index) {
    _quranVersesMemorizedRemoveSession.removeAt(_index);
    secureStorage.setStringList('ff_quranVersesMemorizedRemoveSession',
        _quranVersesMemorizedRemoveSession);
  }

  void updateQuranVersesMemorizedRemoveSessionAtIndex(
    int _index,
    String Function(String) updateFn,
  ) {
    _quranVersesMemorizedRemoveSession[_index] =
        updateFn(_quranVersesMemorizedRemoveSession[_index]);
    secureStorage.setStringList('ff_quranVersesMemorizedRemoveSession',
        _quranVersesMemorizedRemoveSession);
  }

  void insertAtIndexInQuranVersesMemorizedRemoveSession(
      int _index, String _value) {
    _quranVersesMemorizedRemoveSession.insert(_index, _value);
    secureStorage.setStringList('ff_quranVersesMemorizedRemoveSession',
        _quranVersesMemorizedRemoveSession);
  }

  List<String> _quranVersesFavoriteAddSession = [];
  List<String> get quranVersesFavoriteAddSession =>
      _quranVersesFavoriteAddSession;
  set quranVersesFavoriteAddSession(List<String> _value) {
    _quranVersesFavoriteAddSession = _value;
    secureStorage.setStringList('ff_quranVersesFavoriteAddSession', _value);
  }

  void deleteQuranVersesFavoriteAddSession() {
    secureStorage.delete(key: 'ff_quranVersesFavoriteAddSession');
  }

  void addToQuranVersesFavoriteAddSession(String _value) {
    _quranVersesFavoriteAddSession.add(_value);
    secureStorage.setStringList(
        'ff_quranVersesFavoriteAddSession', _quranVersesFavoriteAddSession);
  }

  void removeFromQuranVersesFavoriteAddSession(String _value) {
    _quranVersesFavoriteAddSession.remove(_value);
    secureStorage.setStringList(
        'ff_quranVersesFavoriteAddSession', _quranVersesFavoriteAddSession);
  }

  void removeAtIndexFromQuranVersesFavoriteAddSession(int _index) {
    _quranVersesFavoriteAddSession.removeAt(_index);
    secureStorage.setStringList(
        'ff_quranVersesFavoriteAddSession', _quranVersesFavoriteAddSession);
  }

  void updateQuranVersesFavoriteAddSessionAtIndex(
    int _index,
    String Function(String) updateFn,
  ) {
    _quranVersesFavoriteAddSession[_index] =
        updateFn(_quranVersesFavoriteAddSession[_index]);
    secureStorage.setStringList(
        'ff_quranVersesFavoriteAddSession', _quranVersesFavoriteAddSession);
  }

  void insertAtIndexInQuranVersesFavoriteAddSession(int _index, String _value) {
    _quranVersesFavoriteAddSession.insert(_index, _value);
    secureStorage.setStringList(
        'ff_quranVersesFavoriteAddSession', _quranVersesFavoriteAddSession);
  }

  List<String> _quranVersesFavoriteRemoveSession = [];
  List<String> get quranVersesFavoriteRemoveSession =>
      _quranVersesFavoriteRemoveSession;
  set quranVersesFavoriteRemoveSession(List<String> _value) {
    _quranVersesFavoriteRemoveSession = _value;
    secureStorage.setStringList('ff_quranVersesFavoriteRemoveSession', _value);
  }

  void deleteQuranVersesFavoriteRemoveSession() {
    secureStorage.delete(key: 'ff_quranVersesFavoriteRemoveSession');
  }

  void addToQuranVersesFavoriteRemoveSession(String _value) {
    _quranVersesFavoriteRemoveSession.add(_value);
    secureStorage.setStringList('ff_quranVersesFavoriteRemoveSession',
        _quranVersesFavoriteRemoveSession);
  }

  void removeFromQuranVersesFavoriteRemoveSession(String _value) {
    _quranVersesFavoriteRemoveSession.remove(_value);
    secureStorage.setStringList('ff_quranVersesFavoriteRemoveSession',
        _quranVersesFavoriteRemoveSession);
  }

  void removeAtIndexFromQuranVersesFavoriteRemoveSession(int _index) {
    _quranVersesFavoriteRemoveSession.removeAt(_index);
    secureStorage.setStringList('ff_quranVersesFavoriteRemoveSession',
        _quranVersesFavoriteRemoveSession);
  }

  void updateQuranVersesFavoriteRemoveSessionAtIndex(
    int _index,
    String Function(String) updateFn,
  ) {
    _quranVersesFavoriteRemoveSession[_index] =
        updateFn(_quranVersesFavoriteRemoveSession[_index]);
    secureStorage.setStringList('ff_quranVersesFavoriteRemoveSession',
        _quranVersesFavoriteRemoveSession);
  }

  void insertAtIndexInQuranVersesFavoriteRemoveSession(
      int _index, String _value) {
    _quranVersesFavoriteRemoveSession.insert(_index, _value);
    secureStorage.setStringList('ff_quranVersesFavoriteRemoveSession',
        _quranVersesFavoriteRemoveSession);
  }

  int _quranLastReadPage = 0;
  int get quranLastReadPage => _quranLastReadPage;
  set quranLastReadPage(int _value) {
    _quranLastReadPage = _value;
    secureStorage.setInt('ff_quranLastReadPage', _value);
  }

  void deleteQuranLastReadPage() {
    secureStorage.delete(key: 'ff_quranLastReadPage');
  }

  bool _stopTimers = false;
  bool get stopTimers => _stopTimers;
  set stopTimers(bool _value) {
    _stopTimers = _value;
    secureStorage.setBool('ff_stopTimers', _value);
  }

  void deleteStopTimers() {
    secureStorage.delete(key: 'ff_stopTimers');
  }

  bool _quranPageTraverseUpdated = false;
  bool get quranPageTraverseUpdated => _quranPageTraverseUpdated;
  set quranPageTraverseUpdated(bool _value) {
    _quranPageTraverseUpdated = _value;
    secureStorage.setBool('ff_quranPageTraverseUpdated', _value);
  }

  void deleteQuranPageTraverseUpdated() {
    secureStorage.delete(key: 'ff_quranPageTraverseUpdated');
  }

  int _reciterID = 4;
  int get reciterID => _reciterID;
  set reciterID(int _value) {
    _reciterID = _value;
    secureStorage.setInt('ff_reciterID', _value);
  }

  void deleteReciterID() {
    secureStorage.delete(key: 'ff_reciterID');
  }

  bool _seenUpdateScreen = false;
  bool get seenUpdateScreen => _seenUpdateScreen;
  set seenUpdateScreen(bool _value) {
    _seenUpdateScreen = _value;
    secureStorage.setBool('ff_seenUpdateScreen', _value);
  }

  void deleteSeenUpdateScreen() {
    secureStorage.delete(key: 'ff_seenUpdateScreen');
  }
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}

Color? _colorFromIntValue(int? val) {
  if (val == null) {
    return null;
  }
  return Color(val);
}

extension FlutterSecureStorageExtensions on FlutterSecureStorage {
  static final _lock = Lock();

  Future<void> writeSync({required String key, String? value}) async =>
      await _lock.synchronized(() async {
        await write(key: key, value: value);
      });

  void remove(String key) => delete(key: key);

  Future<String?> getString(String key) async => await read(key: key);
  Future<void> setString(String key, String value) async =>
      await writeSync(key: key, value: value);

  Future<bool?> getBool(String key) async => (await read(key: key)) == 'true';
  Future<void> setBool(String key, bool value) async =>
      await writeSync(key: key, value: value.toString());

  Future<int?> getInt(String key) async =>
      int.tryParse(await read(key: key) ?? '');
  Future<void> setInt(String key, int value) async =>
      await writeSync(key: key, value: value.toString());

  Future<double?> getDouble(String key) async =>
      double.tryParse(await read(key: key) ?? '');
  Future<void> setDouble(String key, double value) async =>
      await writeSync(key: key, value: value.toString());

  Future<List<String>?> getStringList(String key) async =>
      await read(key: key).then((result) {
        if (result == null || result.isEmpty) {
          return null;
        }
        return CsvToListConverter()
            .convert(result)
            .first
            .map((e) => e.toString())
            .toList();
      });
  Future<void> setStringList(String key, List<String> value) async =>
      await writeSync(key: key, value: ListToCsvConverter().convert([value]));
}
