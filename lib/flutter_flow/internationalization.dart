import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en', 'ar'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? arText = '',
  }) =>
      [enText, arText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    final language = locale.toString();
    return FFLocalizations.languages().contains(
      language.endsWith('_')
          ? language.substring(0, language.length - 1)
          : language,
    );
  }

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // Home
  {
    'q2b5pj07': {
      'en': 'Assalamualaikum,',
      'ar': '',
    },
    '7vnikd59': {
      'en': 'Quran Completion',
      'ar': '',
    },
    '9r3kcesq': {
      'en': '',
      'ar': '',
    },
    'bhcbo2e5': {
      'en': 'Friends',
      'ar': '',
    },
    'l6dlh2o8': {
      'en': 'Quran Chapters',
      'ar': '',
    },
    'k7gd2jmu': {
      'en': '',
      'ar': '',
    },
    '3p25hoy9': {
      'en': 'Today\'s Verse',
      'ar': '',
    },
    'nvt4ylox': {
      'en': 'Quran',
      'ar': 'القرآن',
    },
  },
  // QuranAyah
  {
    'ec79bx73': {
      'en': 'Verse',
      'ar': '',
    },
    'gzuyc536': {
      'en': 'Page',
      'ar': '',
    },
    'nwqn8yf9': {
      'en': 'Home',
      'ar': 'بيت',
    },
  },
  // SearchQuran
  {
    's88aebgs': {
      'en': 'Surah, verse, translation, tafseer',
      'ar': 'سورة، آية، ترجمة، تفسير',
    },
    '8nlv2qo3': {
      'en': 'Recent Search',
      'ar': 'البحث الأخير',
    },
    'nz5kr5ga': {
      'en': 'Cafe',
      'ar': 'كافيه',
    },
    'ldjvocsk': {
      'en': 'Hello World',
      'ar': 'مرحبا بالعالم',
    },
    'eogiz046': {
      'en': 'Trending',
      'ar': 'الشائع',
    },
    'q2uw09xb': {
      'en': 'Cafe',
      'ar': 'كافيه',
    },
    '9n752nyz': {
      'en': 'No results found',
      'ar': 'لم يتم العثور على نتائج',
    },
    'otg0iy1k': {
      'en': 'Try searching for something else',
      'ar': 'حاول البحث عن شيء آخر',
    },
    'xx6ya09d': {
      'en': 'Back Home',
      'ar': 'العودة إلى المنزل',
    },
    'talo2ig1': {
      'en': 'Home',
      'ar': 'بيت',
    },
  },
  // Settings
  {
    'o7rt9ub9': {
      'en': 'Language',
      'ar': 'لغة',
    },
    'nb5dpxl7': {
      'en': 'Primary Color',
      'ar': 'لون الأساسي',
    },
    '5q0pm5wo': {
      'en': 'Upgrade to Pro',
      'ar': 'قيم التطبيق',
    },
    'k7sn45jc': {
      'en': 'View Profile',
      'ar': 'قيم التطبيق',
    },
    '3hrx4l26': {
      'en': 'Dark Mode',
      'ar': 'الوضع المظلم',
    },
    '1480gxz6': {
      'en': 'Rate the App',
      'ar': 'قيم التطبيق',
    },
    'gom8rw6e': {
      'en': 'Share the App',
      'ar': 'مشاركة التطبيق',
    },
    '94ng44cg': {
      'en': 'Provide Feedback',
      'ar': 'دعم العملاء',
    },
    '2bis0pnd': {
      'en': 'App Version',
      'ar': 'نسخة التطبيق',
    },
    'je0uruft': {
      'en': 'v.1.1.9',
      'ar': 'v.1.1.9',
    },
    '27khmxwt': {
      'en': 'Logout',
      'ar': 'تسجيل خروج',
    },
    'ggh08ca5': {
      'en': 'Close Account',
      'ar': '',
    },
    '39o01g34': {
      'en': 'Account',
      'ar': 'حساب',
    },
  },
  // Leaderboard
  {
    'bb9e0s5e': {
      'en': 'Leaderboard',
      'ar': '',
    },
    '8ams2529': {
      'en': 'Prayer',
      'ar': '',
    },
    '4s408h0v': {
      'en': 'Quran',
      'ar': '',
    },
    '81igj7hp': {
      'en': 'Hasanat',
      'ar': '',
    },
    'hypcgke3': {
      'en': 'Verses',
      'ar': '',
    },
    'seo1tg9v': {
      'en': 'Time',
      'ar': '',
    },
    'eoj004gv': {
      'en': 'Total Avg',
      'ar': '',
    },
    '5nfurfbs': {
      'en': 'Streak',
      'ar': '',
    },
    '9fideae4': {
      'en': 'Completed',
      'ar': '',
    },
    'grirlk0g': {
      'en': 'Home',
      'ar': '',
    },
  },
  // AuthMain2
  {
    'nmgio77a': {
      'en': 'Sign Up',
      'ar': '',
    },
    'tr6cjd6k': {
      'en': 'Sign in',
      'ar': '',
    },
    'ovzlrna8': {
      'en': 'Email',
      'ar': '',
    },
    'twtv8vez': {
      'en': 'Password',
      'ar': '',
    },
    '40f0pet5': {
      'en': 'Remember Me?',
      'ar': '',
    },
    'twlxfy1f': {
      'en': 'Forgot Password?',
      'ar': '',
    },
    'a09of6fg': {
      'en': 'Next',
      'ar': '',
    },
    'lmwbsin1': {
      'en': 'Field is required',
      'ar': '',
    },
    'ewl36bsd': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    'wgxww8a2': {
      'en': 'Field is required',
      'ar': '',
    },
    '2u2zjodq': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    'uqjjed26': {
      'en': 'or',
      'ar': '',
    },
    't8uvioqx': {
      'en': 'Continue with Facebook',
      'ar': '',
    },
    'pc9nxo8n': {
      'en': 'Continue with Google',
      'ar': '',
    },
    'juvr9ow6': {
      'en': 'Continue with Google',
      'ar': '',
    },
    'plzno0fa': {
      'en': 'Don\'t have an account? Sign Up',
      'ar': '',
    },
    '2goafkt6': {
      'en': 'Home',
      'ar': '',
    },
  },
  // AuthVerifyEmail
  {
    'nqfukicn': {
      'en': 'Back',
      'ar': '',
    },
    'n1nlgikb': {
      'en': 'Confirm your email',
      'ar': '',
    },
    'ywezx9ui': {
      'en':
          'You have not verified your email. Please, check your inbox or junk to confirm your account.',
      'ar': '',
    },
    'ymmjuhvr': {
      'en': 'Done',
      'ar': '',
    },
    'kxdsprmu': {
      'en': 'Did not get an email? Resend email',
      'ar': '',
    },
    'tfqrqon8': {
      'en': 'Field is required',
      'ar': '',
    },
    '7ifqjevn': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    'diouzen1': {
      'en': 'Home',
      'ar': '',
    },
  },
  // AuthCompleteProfile2
  {
    'xgxgdj1g': {
      'en': 'Complete your profile (2/2)',
      'ar': '',
    },
    '9d09g087': {
      'en': 'Full Name',
      'ar': '',
    },
    'cj03n2cf': {
      'en': 'Age',
      'ar': '',
    },
    '60v8algp': {
      'en': 'Male',
      'ar': '',
    },
    'w4khm4lu': {
      'en': 'Female',
      'ar': '',
    },
    'pxtp0aoz': {
      'en': 'Submit',
      'ar': '',
    },
    'jy8ury0j': {
      'en':
          'By submitting, you agree to our Privacy Policy and Terms of Conditions.',
      'ar': '',
    },
    'xmxu3jpw': {
      'en': 'Field is required',
      'ar': '',
    },
    '3h95c67e': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    'jpzkefbh': {
      'en': 'Field is required',
      'ar': '',
    },
    '5ih5jb9x': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    '56m581ql': {
      'en': 'Search Country',
      'ar': '',
    },
    '0wzsqawy': {
      'en': 'No items match your search',
      'ar': '',
    },
    'jyggxmd5': {
      'en': 'Home',
      'ar': '',
    },
  },
  // PrayerStrict
  {
    'nghgfbus': {
      'en': 'November 3, 2023',
      'ar': '',
    },
    '5ds8z2h3': {
      'en': '56% Achieved',
      'ar': '',
    },
    'y2xgthar': {
      'en': 'Online Friends',
      'ar': '',
    },
    'edqvjma2': {
      'en': '20/30 Online',
      'ar': '',
    },
    'f3sb53du': {
      'en': 'See All',
      'ar': '',
    },
    'd5rreoq3': {
      'en': 'Week',
      'ar': '',
    },
    '51icp97q': {
      'en': 'Month',
      'ar': '',
    },
    'of3hqtme': {
      'en': 'Year',
      'ar': '',
    },
    'l4knq8rc': {
      'en': 'All Time',
      'ar': '',
    },
    'vk4v720l': {
      'en': 'M',
      'ar': '',
    },
    'g8z9agn3': {
      'en': 'T',
      'ar': '',
    },
    'dile87rk': {
      'en': 'W',
      'ar': '',
    },
    'fpspj53u': {
      'en': 'T',
      'ar': '',
    },
    'bdxig6k5': {
      'en': 'F',
      'ar': '',
    },
    'tj1pacj4': {
      'en': 'S',
      'ar': '',
    },
    '85i3ks1a': {
      'en': 'S',
      'ar': '',
    },
    'oz4w41qi': {
      'en': 'Home',
      'ar': '',
    },
  },
  // Prayer
  {
    '66w7g1i5': {
      'en': 'Online Friends',
      'ar': '',
    },
    'ok0d2aqd': {
      'en': '20/30 Online',
      'ar': '',
    },
    'isjnbh0i': {
      'en': 'See All',
      'ar': '',
    },
    'lbr2qc65': {
      'en': 'Week',
      'ar': '',
    },
    'grhwh6l1': {
      'en': 'Month',
      'ar': '',
    },
    'ztyc5yq2': {
      'en': 'Year',
      'ar': '',
    },
    '6a9si11i': {
      'en': 'All Time',
      'ar': '',
    },
    '3ox3undh': {
      'en': 'M',
      'ar': '',
    },
    'bmgq734r': {
      'en': 'T',
      'ar': '',
    },
    'fb9m09sh': {
      'en': 'W',
      'ar': '',
    },
    'f0llgg7a': {
      'en': 'T',
      'ar': '',
    },
    'gans2e01': {
      'en': 'F',
      'ar': '',
    },
    'l5b6o6zp': {
      'en': 'S',
      'ar': '',
    },
    '126w5zq5': {
      'en': 'S',
      'ar': '',
    },
    '0jxp7j5c': {
      'en': 'Jan',
      'ar': '',
    },
    'lxzytl5i': {
      'en': 'Feb',
      'ar': '',
    },
    'fhs9m8e6': {
      'en': 'Mar',
      'ar': '',
    },
    'd98n4n77': {
      'en': 'Apr',
      'ar': '',
    },
    't9h5s4ja': {
      'en': 'May',
      'ar': '',
    },
    'w65vgwo3': {
      'en': 'Jun',
      'ar': '',
    },
    '8y5wkh75': {
      'en': 'Jul',
      'ar': '',
    },
    'xs80oxki': {
      'en': 'Aug',
      'ar': '',
    },
    '631snjxg': {
      'en': 'Sep',
      'ar': '',
    },
    '2w7ar2hs': {
      'en': 'Oct',
      'ar': '',
    },
    't1t83fle': {
      'en': 'Nov',
      'ar': '',
    },
    'kkk7s4jz': {
      'en': 'Dec',
      'ar': '',
    },
    'g2gy8icv': {
      'en': 'Home',
      'ar': '',
    },
  },
  // Azkar
  {
    'xp6y13d7': {
      'en': 'Next',
      'ar': '',
    },
    'q13suwwp': {
      'en': 'x',
      'ar': '',
    },
    'dkprpvzr': {
      'en': 'Play Audio',
      'ar': '',
    },
    'a5mj1g1h': {
      'en': '10',
      'ar': '',
    },
    'dmakanpk': {
      'en': 'Home',
      'ar': '',
    },
  },
  // Welcome
  {
    'u3clryrm': {
      'en': 'Home',
      'ar': '',
    },
  },
  // Friends
  {
    '54wyphyw': {
      'en': 'Search for username',
      'ar': 'سورة، آية، ترجمة، تفسير',
    },
    'vbhqiyxr': {
      'en': 'Friends',
      'ar': '',
    },
    'wl7cuwpy': {
      'en': 'Add Friend',
      'ar': '',
    },
    'vxuggf1k': {
      'en': 'Request Sent',
      'ar': '',
    },
    'l1bfjt8w': {
      'en': 'No results found',
      'ar': 'لم يتم العثور على نتائج',
    },
    'lbqosu86': {
      'en': 'Try searching for something else or return back home.',
      'ar': 'حاول البحث عن شيء آخر',
    },
    'c6ffzpil': {
      'en': 'Back Home',
      'ar': 'العودة إلى المنزل',
    },
    'uul1cb38': {
      'en': 'Search for a friend',
      'ar': 'لم يتم العثور على نتائج',
    },
    'inkyq97g': {
      'en': 'Build your own community and compete for good deeds',
      'ar': 'حاول البحث عن شيء آخر',
    },
    'ta1tu2zj': {
      'en': 'Home',
      'ar': '',
    },
  },
  // Later
  {
    'dqz57h9j': {
      'en': 'Rememberance',
      'ar': '',
    },
    '4702f2p6': {
      'en': 'See All',
      'ar': '',
    },
    'nvrya1i5': {
      'en': 'What to say before sleeping',
      'ar': '',
    },
    '9ax3yfcq': {
      'en': '13 items',
      'ar': '',
    },
    'snonzu30': {
      'en': '600',
      'ar': '',
    },
    'wu7qaffu': {
      'en': '1.2k',
      'ar': '',
    },
    '060kglrg': {
      'en': 'What to say before performing ablution',
      'ar': '',
    },
    'iv4aswpw': {
      'en': '1.2k',
      'ar': '',
    },
    '2z3c2lzc': {
      'en': 'Categories',
      'ar': '',
    },
    'eig5zr5j': {
      'en': 'See All',
      'ar': '',
    },
    'kitjxdpv': {
      'en': 'What to say before sleeping',
      'ar': '',
    },
    'nwowjjkl': {
      'en': '13 items',
      'ar': '',
    },
    '09fjm15u': {
      'en': '600',
      'ar': '',
    },
    'x0y9qvi3': {
      'en': '1.2k',
      'ar': '',
    },
    '3vm4ii86': {
      'en': 'What to say before performing ablution',
      'ar': '',
    },
    'zk1uq9kn': {
      'en': '1.2k',
      'ar': '',
    },
    '9d8rfrgn': {
      'en': 'Play Audio',
      'ar': '',
    },
    'ohojzu1t': {
      'en': 'Friends',
      'ar': '',
    },
    'yizsw8up': {
      'en': 'See All',
      'ar': '',
    },
    'af6eryca': {
      'en': 'Cody',
      'ar': '',
    },
    'za79zpwd': {
      'en': 'Nick',
      'ar': '',
    },
    'utx3c0ab': {
      'en': 'Zack',
      'ar': '',
    },
    'xyeei8ww': {
      'en': 'Alan',
      'ar': '',
    },
    '1z4e3gio': {
      'en': 'Zain',
      'ar': '',
    },
    '01h36t0t': {
      'en': 'Adam',
      'ar': '',
    },
    '3iic1fi3': {
      'en': 'Josh',
      'ar': '',
    },
    '3144k78h': {
      'en': 'Rememberance',
      'ar': '',
    },
    'u7jfjukw': {
      'en': 'Next',
      'ar': '',
    },
    '3cu4n344': {
      'en': 'Play Audio',
      'ar': '',
    },
    'fm2a9u5h': {
      'en': 'Muslims reading now',
      'ar': '',
    },
    'adj4er33': {
      'en': 'Search for a friend',
      'ar': 'لم يتم العثور على نتائج',
    },
    'ngqbo242': {
      'en': 'Build your own community and compete for good deeds',
      'ar': 'حاول البحث عن شيء آخر',
    },
    'g28srm2j': {
      'en': 'You have schedule for read Al Waqiah',
      'ar': '',
    },
    'lamk2tel': {
      'en': 'Online Friends',
      'ar': '',
    },
    'uf4d3xxg': {
      'en': '20/30 Online',
      'ar': '',
    },
    'uesg9a0r': {
      'en': 'See All',
      'ar': '',
    },
    'ylsoyux1': {
      'en': 'Qur\'an Tracking',
      'ar': '',
    },
    'serb6kxk': {
      'en': 'Total: 2 min',
      'ar': '',
    },
    'tfqy7f6t': {
      'en': '0',
      'ar': '',
    },
    'l3zvqlt0': {
      'en': '0',
      'ar': '',
    },
    'xj664owp': {
      'en': ':',
      'ar': '',
    },
    'lvlra6ay': {
      'en': '0',
      'ar': '',
    },
    'kkymj7sy': {
      'en': '0',
      'ar': '',
    },
    'x0f46geu': {
      'en': '',
      'ar': '',
    },
    'b4vceu9n': {
      'en': '5/10',
      'ar': '',
    },
    '2bkcnpog': {
      'en': '5 verses left',
      'ar': '',
    },
    'qrnzilom': {
      'en': 'Hello World',
      'ar': '',
    },
    'bcpm8t8y': {
      'en': 'Online Friends',
      'ar': '',
    },
    '9t6lv6i2': {
      'en': 'See All',
      'ar': '',
    },
    'dz6rgo8v': {
      'en': 'Home',
      'ar': '',
    },
  },
  // Profile
  {
    '3p4t7e9y': {
      'en': 'Points',
      'ar': '',
    },
    'dvadv5yu': {
      'en': 'Verses',
      'ar': '',
    },
    '63yir6ic': {
      'en': 'Time',
      'ar': '',
    },
    '4v2aefqp': {
      'en': 'Friends',
      'ar': '',
    },
    'ijd9lpd1': {
      'en': 'Favorites',
      'ar': '',
    },
    'ngba93ek': {
      'en': 'Stats',
      'ar': '',
    },
    's72ieuhi': {
      'en': 'Home',
      'ar': '',
    },
  },
  // Subscribe
  {
    'w2dil64l': {
      'en': 'Home',
      'ar': '',
    },
  },
  // Onboarding
  {
    'o9abl4g1': {
      'en': 'Make Quran a \nDaily Habit',
      'ar': '',
    },
    'a45ekigk': {
      'en': 'You can read verse by verse and keep track of your hasanat ',
      'ar': '',
    },
    'r6l8qgpt': {
      'en': 'Skip',
      'ar': '',
    },
    '9p292r52': {
      'en': 'Next',
      'ar': '',
    },
    'fml0tsih': {
      'en': 'Home',
      'ar': '',
    },
  },
  // OnboardingTwo
  {
    '65u087k3': {
      'en': 'Back',
      'ar': '',
    },
    '6gcili1n': {
      'en': 'Compete in global\nranking',
      'ar': '',
    },
    '23zypwio': {
      'en': 'See where you rank compared to\nother muslims worldwide',
      'ar': '',
    },
    'syza7hhc': {
      'en': 'Skip',
      'ar': '',
    },
    '7tcrf1yj': {
      'en': 'Next',
      'ar': '',
    },
    'fdeq1fq5': {
      'en': 'Home',
      'ar': '',
    },
  },
  // Introduction
  {
    'escbyimt': {
      'en': 'Home',
      'ar': '',
    },
  },
  // AuthMain
  {
    'cn1vr28s': {
      'en': 'Sign In',
      'ar': '',
    },
    'cma91y56': {
      'en': 'Sign Up',
      'ar': '',
    },
    'bi116evq': {
      'en': 'Sign in',
      'ar': '',
    },
    'oarwzuf5': {
      'en': 'Email',
      'ar': '',
    },
    '8chu4l70': {
      'en': 'Password',
      'ar': '',
    },
    'vxshsp1p': {
      'en': 'Remember Me',
      'ar': '',
    },
    'uju7vc0n': {
      'en': 'Forgot Password?',
      'ar': '',
    },
    '42px2vu5': {
      'en': 'Next',
      'ar': '',
    },
    '82tbe9qi': {
      'en': 'Field is required',
      'ar': '',
    },
    '6g0fl8zt': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    'bt1az9xx': {
      'en': 'Field is required',
      'ar': '',
    },
    'd5fr6dzi': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    'mcgkyfjd': {
      'en': 'Don\'t have an account? Sign Up',
      'ar': '',
    },
    't0b1hr5j': {
      'en': 'Sign Up',
      'ar': '',
    },
    'wnx8yfe6': {
      'en': 'Email',
      'ar': '',
    },
    'o73d72b4': {
      'en': 'Password',
      'ar': '',
    },
    'y48f8nnr': {
      'en': 'Confirm Password',
      'ar': '',
    },
    'aw9v8yra': {
      'en': 'Remember Me',
      'ar': '',
    },
    'm3egzswh': {
      'en': 'Next',
      'ar': '',
    },
    'va933n53': {
      'en': 'Field is required',
      'ar': '',
    },
    'ge79fsth': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    'r8ernly9': {
      'en': 'Field is required',
      'ar': '',
    },
    'ajdqbppz': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    'i7ehv3f6': {
      'en': 'Field is required',
      'ar': '',
    },
    'kwlu2s39': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    'g7o705qc': {
      'en': 'Already have an account? Sign In',
      'ar': '',
    },
    '0eur4woq': {
      'en': 'Home',
      'ar': '',
    },
  },
  // AuthCompleteProfile2Copy
  {
    'mxxdrd42': {
      'en': 'Complete your profile (2/2)',
      'ar': '',
    },
    '3vhfkma2': {
      'en': 'Full Name',
      'ar': '',
    },
    'o37ap9ri': {
      'en': 'Age',
      'ar': '',
    },
    'bbt9c9tw': {
      'en': 'Nationality',
      'ar': '',
    },
    'twditd1q': {
      'en': 'Male',
      'ar': '',
    },
    'e434qy7c': {
      'en': 'Female',
      'ar': '',
    },
    'axdf6zqu': {
      'en': 'Submit',
      'ar': '',
    },
    'arg0q69j': {
      'en':
          'By submitting, you agree to our Privacy Policy and Terms of Conditions.',
      'ar': '',
    },
    'dgurvy2j': {
      'en': 'Field is required',
      'ar': '',
    },
    'gqlvxk5y': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    'x13yj2xo': {
      'en': 'Field is required',
      'ar': '',
    },
    '0iqsoqta': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    '6xjzpyq0': {
      'en': 'Field is required',
      'ar': '',
    },
    '4c6q6865': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    'sf7hc0fm': {
      'en': 'Home',
      'ar': '',
    },
  },
  // AuthCompleteProfile1
  {
    'uqdkyq10': {
      'en': 'Complete your profile (1/2)',
      'ar': '',
    },
    'eyyx7pp8': {
      'en': 'Username',
      'ar': '',
    },
    '6yryhzi3': {
      'en': 'Username is already taken.',
      'ar': '',
    },
    'gl1cr3pw': {
      'en': 'Next',
      'ar': '',
    },
    '84r0bkfj': {
      'en':
          'By submitting, you agree to our Privacy Policy and Terms of Conditions.',
      'ar': '',
    },
    'ejcw98nx': {
      'en': 'Field is required',
      'ar': '',
    },
    'ih8w08zr': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    'zo5bf2th': {
      'en': 'Home',
      'ar': '',
    },
  },
  // AuthForgotPassword
  {
    '1l84197e': {
      'en': 'Back',
      'ar': '',
    },
    'l0ilcm3u': {
      'en': 'Password Reset',
      'ar': '',
    },
    'caww5jk7': {
      'en': 'Email',
      'ar': '',
    },
    'o3hprn1q': {
      'en': 'Next',
      'ar': '',
    },
    'rya1qdfm': {
      'en':
          'By submitting, you agree to our Privacy Policy and Terms of Conditions.',
      'ar': '',
    },
    'ibbq45a5': {
      'en': 'Field is required',
      'ar': '',
    },
    'w6pia4sw': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    'rtk5rb4m': {
      'en': 'Home',
      'ar': '',
    },
  },
  // QuranPage
  {
    'zve0y5zc': {
      'en': 'Verse',
      'ar': '',
    },
    'v6lv8ne4': {
      'en': 'Page',
      'ar': '',
    },
    '1j8eenjc': {
      'en': 'Home',
      'ar': 'بيت',
    },
  },
  // Notification
  {
    'rn6qiaox': {
      'en': 'Notifications',
      'ar': '',
    },
    'my9glv45': {
      'en': 'LAST 7 DAYS',
      'ar': '',
    },
    'jai0avex': {
      'en': ' has',
      'ar': '',
    },
    'qyhfqte8': {
      'en': ' sent',
      'ar': '',
    },
    'v6bkvu5a': {
      'en': ' you',
      'ar': '',
    },
    'hgwty04k': {
      'en': ' a',
      'ar': '',
    },
    '8yqpggou': {
      'en': ' friend',
      'ar': '',
    },
    '2jyi4v60': {
      'en': ' request',
      'ar': '',
    },
    '37mikjdi': {
      'en': 'Accept',
      'ar': '',
    },
    'vom3e54p': {
      'en': 'No Notifications',
      'ar': '',
    },
    '0a5529be': {
      'en':
          'You currently have no notifications. Come back again some other time.',
      'ar': '',
    },
    '97vd0np7': {
      'en': 'Home',
      'ar': '',
    },
  },
  // Navbar
  {
    'udp76wvq': {
      'en': 'Home',
      'ar': '',
    },
    'i588fetq': {
      'en': 'Friends',
      'ar': '',
    },
    'hksep5su': {
      'en': 'Ranking',
      'ar': '',
    },
    'pa68ha39': {
      'en': 'Settings',
      'ar': '',
    },
  },
  // HomeSkeleton
  {
    '711ss79c': {
      'en': 'Assalamualaikum,',
      'ar': '',
    },
    'c7bhzcbl': {
      'en': 'Quran Completion',
      'ar': '',
    },
    'vnna15m0': {
      'en': 'Friends',
      'ar': '',
    },
    '2dfzja8e': {
      'en': 'Quran Chapters',
      'ar': '',
    },
    'kuswdsfy': {
      'en': 'Today\'s Verse',
      'ar': '',
    },
  },
  // Reciter
  {
    'fc5g0wgi': {
      'en': 'Choose A Reciter',
      'ar': '',
    },
    'flteu4zp': {
      'en': 'Al-Minshawi\n(Murattal)',
      'ar': '',
    },
    'hivi8p91': {
      'en': 'Mishary\nAl-Afasy',
      'ar': '',
    },
    'rz7srozl': {
      'en': 'Abu Bakr\nAl-Shatri',
      'ar': '',
    },
    'f8hmy6dw': {
      'en': 'Abdurahm-\nan Sudais',
      'ar': '',
    },
    '73rr9g0c': {
      'en': 'Al-Husary\n(Muallim)',
      'ar': '',
    },
    '1pu13jva': {
      'en': 'Al-Minshawi\n(Mujawwad)',
      'ar': '',
    },
    'ox200fku': {
      'en': 'Al-Husary\n(Muallim)',
      'ar': '',
    },
    'y73amskl': {
      'en': 'Hani \nAr-Rifai',
      'ar': '',
    },
    'j2znixzi': {
      'en': 'Saud Ash-\nShuraym',
      'ar': '',
    },
    'v9lldci9': {
      'en': 'Mohamed \nAl-Tablawi',
      'ar': '',
    },
  },
  // Miscellaneous
  {
    'crf9sbfs': {
      'en': '',
      'ar': '',
    },
    'uyuhjzoo': {
      'en': '',
      'ar': '',
    },
    'pr4bz96k': {
      'en': '',
      'ar': '',
    },
    'cdyb2p9q': {
      'en': '',
      'ar': '',
    },
    '57dsk2ba': {
      'en': '',
      'ar': '',
    },
    'y17foiy0': {
      'en': '',
      'ar': '',
    },
    '3rswxsov': {
      'en': '',
      'ar': '',
    },
    'yxol58a3': {
      'en': '',
      'ar': '',
    },
    'pyt6lbfj': {
      'en': '',
      'ar': '',
    },
    '0msa4fut': {
      'en': '',
      'ar': '',
    },
    'ukkaa23p': {
      'en': '',
      'ar': '',
    },
    'uapp66l0': {
      'en': '',
      'ar': '',
    },
    'txcp7zfz': {
      'en': '',
      'ar': '',
    },
    'yqxj8ef7': {
      'en': '',
      'ar': '',
    },
    'd5l2jnh1': {
      'en': '',
      'ar': '',
    },
    '2bris7lo': {
      'en': '',
      'ar': '',
    },
    'etnyy4rv': {
      'en': '',
      'ar': '',
    },
    'm74irsfn': {
      'en': '',
      'ar': '',
    },
    'wch4m8sk': {
      'en': '',
      'ar': '',
    },
    'i21hv8fb': {
      'en': '',
      'ar': '',
    },
    'eia58nv5': {
      'en': '',
      'ar': '',
    },
    'mdpgr775': {
      'en': '',
      'ar': '',
    },
    '2tv9y2wd': {
      'en': '',
      'ar': '',
    },
    'fzwmwgzj': {
      'en': '',
      'ar': '',
    },
  },
].reduce((a, b) => a..addAll(b));
