import 'dart:convert';
import 'dart:typed_data';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class VerseAudioCall {
  static Future<ApiCallResponse> call({
    int? surahID = 1,
    int? ayahID = 1,
    int? reciterID = 4,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Verse Audio',
      apiUrl:
          'https://api.quran.com/api/v4/recitations/${reciterID}/by_ayah/${surahID}:${ayahID}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: true,
    );
  }
}

class QuranSearchCall {
  static Future<ApiCallResponse> call({
    String? query = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Quran Search',
      apiUrl:
          'https://api.quran.com/api/v4/search?q=${query}&size=10&language=en',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: true,
    );
  }
}

class VerseKeyCall {
  static Future<ApiCallResponse> call({
    int? chapter = 1,
    int? verse = 1,
    String? lang = 'en',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Verse Key',
      apiUrl:
          'https://api.quran.com/api/v4/verses/by_key/${chapter}:${verse}?language=${lang}&words=true',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: true,
    );
  }
}

class QuranFontImlaeiCall {
  static Future<ApiCallResponse> call({
    int? chapter = 2,
    int? verse = 4,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Quran Font Imlaei',
      apiUrl:
          'https://api.quran.com/api/v4/quran/verses/imlaei?verse_key=${chapter}:${verse}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: true,
    );
  }
}

class QuranTranslationCall {
  static Future<ApiCallResponse> call({
    int? id = 131,
    int? chapter = 1,
    int? verse = 1,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Quran Translation',
      apiUrl:
          'https://api.quran.com/api/v4/quran/translations/${id}?verse_key=${chapter}:${verse}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: true,
    );
  }
}

class QuranLeaderboardHasanatCall {
  static Future<ApiCallResponse> call({
    int? page = 0,
    int? hitsPerPage = 10,
    String? attributesToHighlight = '[]',
    String? attributesToRetrieve = '[\"hasanat\", \"user\"]',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Quran Leaderboard Hasanat',
      apiUrl:
          'https://E62ISEPBAO-dsn.algolia.net/1/indexes/quranPerformance_hasanat_desc',
      callType: ApiCallType.GET,
      headers: {
        'X-Algolia-API-Key': 'e37a5ca361a51f19ee8d7e3b8669c6ab',
        'X-Algolia-Application-Id': 'E62ISEPBAO',
      },
      params: {
        'page': page,
        'hitsPerPage': hitsPerPage,
        'attributesToHighlight': attributesToHighlight,
        'attributesToRetrieve': attributesToRetrieve,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic thirdUser(dynamic response) => getJsonField(
        response,
        r'''$.hits[2].user''',
        true,
      );
}

class PrayerTimesCall {
  static Future<ApiCallResponse> call({
    String? city = 'Abu Dhabi',
    String? country = 'AE',
    String? date = '06-11-2023',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Prayer Times',
      apiUrl: 'https://api.aladhan.com/v1/timingsByCity',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'city': city,
        'country': country,
        'date': date,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: true,
    );
  }
}

class GEOAddressCall {
  static Future<ApiCallResponse> call({
    String? loc = '37.9103135889261, -109.78788515888873',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GEO Address',
      apiUrl: 'https://maps.googleapis.com/maps/api/geocode/json?latlng=${loc}',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'key': "AIzaSyBlJ0XXj5Lirs0G7ff9dXXisIIAO_ublg4",
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: true,
    );
  }

  static dynamic countryISO(dynamic response) => getJsonField(
        response,
        r'''$.results[-1].address_components[0].short_name''',
      );
  static dynamic city(dynamic response) => getJsonField(
        response,
        r'''$.results[-2].address_components[0].long_name''',
      );
}

class AzkarHisnmuslimCall {
  static Future<ApiCallResponse> call({
    String? lang = 'en',
    int? id = 2,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Azkar Hisnmuslim',
      apiUrl: 'https://hisnmuslim.com/api/${lang}/${id}.json',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: true,
    );
  }
}

class SearchFriendsCall {
  static Future<ApiCallResponse> call({
    String? query = 'Alaa',
    String? filter = 'NOT username:  alaaeldin92',
    String? attributesToHighlight = '[]',
  }) async {
    final ffApiRequestBody = '''
{
  "params": "query=${query}&filters=${filter}&attributesToHighlight=${attributesToHighlight}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Search Friends',
      apiUrl: 'https://E62ISEPBAO-dsn.algolia.net/1/indexes/users/query',
      callType: ApiCallType.POST,
      headers: {
        'X-Algolia-API-Key': 'cea9ec0b843497267fd7e429f148feb3',
        'X-Algolia-Application-Id': 'E62ISEPBAO',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.TEXT,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class QuranFontImlaeiPageCall {
  static Future<ApiCallResponse> call({
    int? page = 1,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Quran Font Imlaei Page',
      apiUrl:
          'https://api.quran.com/api/v4/quran/verses/imlaei?page_number=${page}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class VerseAudioPageCall {
  static Future<ApiCallResponse> call({
    int? reciterID = 4,
    int? page = 1,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Verse Audio Page',
      apiUrl:
          'https://api.quran.com/api/v4/recitations/${reciterID}/by_page/${page}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class QuranTranslationPageCall {
  static Future<ApiCallResponse> call({
    int? page = 1,
    int? translationID = 131,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Quran Translation Page',
      apiUrl:
          'https://api.quran.com/api/v4/verses/by_page/${page}?language=en&words=false&translations=${translationID}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class InAppNotificationCall {
  static Future<ApiCallResponse> call({
    String? fcmToken = '',
    String? username = '',
  }) async {
    final ffApiRequestBody = '''
{
  "to": "${fcmToken}",
  "notification": {
    "body": "${username} just sent you a friend request",
    "title": "Friend Request",
    "imageUrl": "https://static-cse.canva.com/blob/1207447/1600w-HdnNPtnguw4.bd60dcfd.jpg"
  },
  "initial_page_name": "Notification"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'In App Notification',
      apiUrl: 'https://fcm.googleapis.com/fcm/send',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class QuranLeaderboardVersesCall {
  static Future<ApiCallResponse> call({
    int? page = 0,
    int? hitsPerPage = 10,
    String? attributesToHighlight = '[]',
    String? attributesToRetrieve = '[\"versesRead\", \"user\"]',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Quran Leaderboard Verses',
      apiUrl:
          'https://E62ISEPBAO-dsn.algolia.net/1/indexes/quranPerformance_versesRead_desc',
      callType: ApiCallType.GET,
      headers: {
        'X-Algolia-API-Key': 'e37a5ca361a51f19ee8d7e3b8669c6ab',
        'X-Algolia-Application-Id': 'E62ISEPBAO',
      },
      params: {
        'page': page,
        'hitsPerPage': hitsPerPage,
        'attributesToHighlight': attributesToHighlight,
        'attributesToRetrieve': attributesToRetrieve,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class QuranLeaderboardTimeCall {
  static Future<ApiCallResponse> call({
    int? page = 0,
    int? hitsPerPage = 10,
    String? attributesToHighlight = '[]',
    String? attributesToRetrieve = '[\"timeReadSec\", \"user\"]',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Quran Leaderboard Time',
      apiUrl:
          'https://E62ISEPBAO-dsn.algolia.net/1/indexes/quranPerformance_timeReadSec_desc',
      callType: ApiCallType.GET,
      headers: {
        'X-Algolia-API-Key': 'e37a5ca361a51f19ee8d7e3b8669c6ab',
        'X-Algolia-Application-Id': 'E62ISEPBAO',
      },
      params: {
        'page': page,
        'hitsPerPage': hitsPerPage,
        'attributesToHighlight': attributesToHighlight,
        'attributesToRetrieve': attributesToRetrieve,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class QuranVerseTafsirCall {
  static Future<ApiCallResponse> call({
    int? tafsirID = 14,
    int? chapter = 1,
    int? verse = 1,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Quran Verse Tafsir',
      apiUrl:
          'https://api.quran.com/api/v4/quran/tafsirs/${tafsirID}?verse_key=${chapter}:${verse}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class QuranPageTafsirCall {
  static Future<ApiCallResponse> call({
    int? verseID = 169,
    int? page = 1,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Quran Page Tafsir',
      apiUrl:
          'https://api.quran.com/api/v4/quran/tafsirs/${verseID}?page_number=${page}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list);
  } catch (_) {
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar);
  } catch (_) {
    return isList ? '[]' : '{}';
  }
}
