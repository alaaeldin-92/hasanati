import '/custom_code/actions/index.dart' as actions;
import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth/firebase_auth/firebase_user_provider.dart';
import 'auth/firebase_auth/auth_util.dart';

import 'package:flutter/services.dart';
import 'package:hasanati/backend/backend.dart'; 
import 'backend/push_notifications/push_notifications_util.dart';
import 'backend/firebase/firebase_config.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/internationalization.dart';
import 'flutter_flow/nav/nav.dart';
import 'index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  await initFirebase(); 

  // Start initial custom actions code
  await actions.oneSignal();
  // End initial custom actions code

  await FlutterFlowTheme.initialize();

  await FFLocalizations.initialize();

  final appState = FFAppState(); // Initialize FFAppState
  await appState.initializePersistedState();

  runApp(ChangeNotifierProvider(
    create: (context) => appState,
    child: MyApp(),
  ));
  
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);

}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver{
  Locale? _locale = FFLocalizations.getStoredLocale();
  ThemeMode _themeMode = FlutterFlowTheme.themeMode;

  late Stream<BaseAuthUser> userStream;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;

  final authUserSub = authenticatedUserStream.listen((_) {});
  final fcmTokenSub = fcmTokenUserStream.listen((_) {});

  @override
  void initState() {
    super.initState();
WidgetsBinding.instance.addObserver(this);
    _appStateNotifier = AppStateNotifier.instance;
    _router = createRouter(_appStateNotifier);
    userStream = hasanatiFirebaseUserStream()
      ..listen((user) => _appStateNotifier.update(user));
    jwtTokenStream.listen((_) {});
    Future.delayed(
      Duration(milliseconds: 1000),
      () => _appStateNotifier.stopShowingSplashImage(),
    );
  }

  @override
  void dispose() {
    authUserSub.cancel();
    fcmTokenSub.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void setLocale(String language) {
    setState(() => _locale = createLocale(language));
    FFLocalizations.storeLocale(language);
  }

  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = mode;
        FlutterFlowTheme.saveThemeMode(mode);
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Hasanati',
      localizationsDelegates: [
        FFLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      theme: ThemeData(
        brightness: Brightness.light,
        scrollbarTheme: ScrollbarThemeData(),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scrollbarTheme: ScrollbarThemeData(),
      ),
      themeMode: _themeMode,
      routerConfig: _router,
    );
  }

   void checkAndUpdateDB() async{
    final firestore = FirebaseFirestore.instance;

    if (FFAppState().quranVerseTraverseUpdated) {
      // Sync Quran Performance ****************************************
      QuerySnapshot querySnapshotQuranPerf = await firestore
          .collection('quranPerformance')
          .where('user', isEqualTo: currentUser?.uid)
          .get();
      await querySnapshotQuranPerf.docs.first.reference.update({
        'hasanat': FFAppState().quranHasanat,
        'timeReadSec': FFAppState().quranTimeReadSec,
        'versesRead': FFAppState().quranVersesRead,
        'lastmodified':  DateTime.now().millisecondsSinceEpoch ~/ 1000,
        // Add other fields you want to update
      });

      // Sync Quran Last Read Verse **************************************
      QuerySnapshot querySnapshotQuranLastReadVerse = await firestore
          .collection('quranLastReadVerse')
          .where('user', isEqualTo: currentUser?.uid)
          .get();
      await querySnapshotQuranLastReadVerse.docs.first.reference.update(
          {
            'verse': FFAppState().quranLastReadVerse,
            'lastmodified':  DateTime.now().millisecondsSinceEpoch ~/ 1000,
            // Add other fields you want to update
          });


      // Sync Quran Last Read Page **************************************
      QuerySnapshot querySnapshotQuranLastReadPage = await firestore
          .collection('quranLastReadPage')
          .where('user', isEqualTo: currentUser?.uid)
          .get();
      await querySnapshotQuranLastReadPage.docs.first.reference.update(
          {
            'page': FFAppState().quranLastReadPage,
            'lastmodified':  DateTime.now().millisecondsSinceEpoch ~/ 1000,
            // Add other fields you want to update
          });

      FFAppState().quranVerseTraverseUpdated = false;
    }


    // Sync Quran Verses Memorized **************************************
    if (!FFAppState().quranVersesMemorizedAddSession.isEmpty) {
      QuerySnapshot quranVersesMemorizedAddSession = await firestore
          .collection('quranVersesMemorize')
          .where('user', isEqualTo: currentUser?.uid)
          .get();
      await quranVersesMemorizedAddSession.docs.first.reference.update(
          {
            'verse': FieldValue.arrayUnion(FFAppState().quranVersesMemorizedAddSession),
            // Add other fields you want to update
          });
      FFAppState().quranVersesMemorizedAddSession.clear();
    }
    if (!FFAppState().quranVersesMemorizedRemoveSession.isEmpty) {
      QuerySnapshot quranVersesMemorizedRemoveSession = await firestore
          .collection('quranVersesMemorize')
          .where('user', isEqualTo: currentUser?.uid)
          .get();
      await quranVersesMemorizedRemoveSession.docs.first.reference.update(
          {
            'verse': FieldValue.arrayRemove(FFAppState().quranVersesMemorizedRemoveSession),
            // Add other fields you want to update
          });
      FFAppState().quranVersesMemorizedRemoveSession.clear();
    }


    // Sync Quran Verses Favorite **************************************
    if (!FFAppState().quranVersesFavoriteAddSession.isEmpty) {
      QuerySnapshot quranVersesFavoriteAddSession = await firestore
          .collection('quranVersesFavorite')
          .where('user', isEqualTo: currentUser?.uid)
          .get();
      await quranVersesFavoriteAddSession.docs.first.reference.update(
          {
            'verse': FieldValue.arrayUnion(FFAppState().quranVersesFavoriteAddSession),
            // Add other fields you want to update
          });
      FFAppState().quranVersesFavoriteAddSession.clear();
    }
    if (!FFAppState().quranVersesFavoriteRemoveSession.isEmpty) {
      QuerySnapshot quranVersesFavoriteRemoveSession = await firestore
          .collection('quranVersesFavorite')
          .where('user', isEqualTo: currentUser?.uid)
          .get();
      await quranVersesFavoriteRemoveSession.docs.first.reference.update(
          {
            'verse': FieldValue.arrayRemove(FFAppState().quranVersesFavoriteRemoveSession),
            // Add other fields you want to update
          });
      FFAppState().quranVersesFavoriteRemoveSession.clear();
    }

  }

  @override
  Future < void > didChangeAppLifecycleState(AppLifecycleState state) async {
    if (currentUser?.loggedIn == true) {

// latest one

      final firestore = FirebaseFirestore.instance;
      switch (state) {
        case AppLifecycleState.resumed:
        //Execute code here when user come back to the app.
         FFAppState().stopTimers=false;
          await firestore.collection('users').doc(currentUser?.uid).update({
            'online': true,
          });
          break;

        case AppLifecycleState.paused:
        //Execute code when user leave the app
          FFAppState().stopTimers=true;
          await firestore.collection('users').doc(currentUser?.uid).update({
            'online': false,
          });
          checkAndUpdateDB();
          break;
        default:
          break;
      };
    }
  }

}
