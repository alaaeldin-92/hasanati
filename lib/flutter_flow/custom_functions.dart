import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';

dynamic quranSurahEN() {
  return {
    "chapters": [
      {
        "id": 1,
        "revelation_place": "makkah",
        "revelation_order": 5,
        "bismillah_pre": false,
        "name_simple": "Al-Fatihah",
        "name_complex": "Al-Fātiĥah",
        "name_arabic": "الفاتحة",
        "verses_count": 7,
        "pages": [1, 1],
        "translated_name": {"language_name": "english", "name": "The Opener"}
      },
      {
        "id": 2,
        "revelation_place": "madinah",
        "revelation_order": 87,
        "bismillah_pre": true,
        "name_simple": "Al-Baqarah",
        "name_complex": "Al-Baqarah",
        "name_arabic": "البقرة",
        "verses_count": 286,
        "pages": [2, 49],
        "translated_name": {"language_name": "english", "name": "The Cow"}
      },
      {
        "id": 3,
        "revelation_place": "madinah",
        "revelation_order": 89,
        "bismillah_pre": true,
        "name_simple": "Ali 'Imran",
        "name_complex": "Āli `Imrān",
        "name_arabic": "آل عمران",
        "verses_count": 200,
        "pages": [50, 76],
        "translated_name": {
          "language_name": "english",
          "name": "Family of Imran"
        }
      },
      {
        "id": 4,
        "revelation_place": "madinah",
        "revelation_order": 92,
        "bismillah_pre": true,
        "name_simple": "An-Nisa",
        "name_complex": "An-Nisā",
        "name_arabic": "النساء",
        "verses_count": 176,
        "pages": [77, 106],
        "translated_name": {"language_name": "english", "name": "The Women"}
      },
      {
        "id": 5,
        "revelation_place": "madinah",
        "revelation_order": 112,
        "bismillah_pre": true,
        "name_simple": "Al-Ma'idah",
        "name_complex": "Al-Mā'idah",
        "name_arabic": "المائدة",
        "verses_count": 120,
        "pages": [106, 127],
        "translated_name": {
          "language_name": "english",
          "name": "The Table Spread"
        }
      },
      {
        "id": 6,
        "revelation_place": "makkah",
        "revelation_order": 55,
        "bismillah_pre": true,
        "name_simple": "Al-An'am",
        "name_complex": "Al-'An`ām",
        "name_arabic": "الأنعام",
        "verses_count": 165,
        "pages": [128, 150],
        "translated_name": {"language_name": "english", "name": "The Cattle"}
      },
      {
        "id": 7,
        "revelation_place": "makkah",
        "revelation_order": 39,
        "bismillah_pre": true,
        "name_simple": "Al-A'raf",
        "name_complex": "Al-'A`rāf",
        "name_arabic": "الأعراف",
        "verses_count": 206,
        "pages": [151, 176],
        "translated_name": {"language_name": "english", "name": "The Heights"}
      },
      {
        "id": 8,
        "revelation_place": "madinah",
        "revelation_order": 88,
        "bismillah_pre": true,
        "name_simple": "Al-Anfal",
        "name_complex": "Al-'Anfāl",
        "name_arabic": "الأنفال",
        "verses_count": 75,
        "pages": [177, 186],
        "translated_name": {
          "language_name": "english",
          "name": "The Spoils of War"
        }
      },
      {
        "id": 9,
        "revelation_place": "madinah",
        "revelation_order": 113,
        "bismillah_pre": false,
        "name_simple": "At-Tawbah",
        "name_complex": "At-Tawbah",
        "name_arabic": "التوبة",
        "verses_count": 129,
        "pages": [187, 207],
        "translated_name": {
          "language_name": "english",
          "name": "The Repentance"
        }
      },
      {
        "id": 10,
        "revelation_place": "makkah",
        "revelation_order": 51,
        "bismillah_pre": true,
        "name_simple": "Yunus",
        "name_complex": "Yūnus",
        "name_arabic": "يونس",
        "verses_count": 109,
        "pages": [208, 221],
        "translated_name": {"language_name": "english", "name": "Jonah"}
      },
      {
        "id": 11,
        "revelation_place": "makkah",
        "revelation_order": 52,
        "bismillah_pre": true,
        "name_simple": "Hud",
        "name_complex": "Hūd",
        "name_arabic": "هود",
        "verses_count": 123,
        "pages": [221, 235],
        "translated_name": {"language_name": "english", "name": "Hud"}
      },
      {
        "id": 12,
        "revelation_place": "makkah",
        "revelation_order": 53,
        "bismillah_pre": true,
        "name_simple": "Yusuf",
        "name_complex": "Yūsuf",
        "name_arabic": "يوسف",
        "verses_count": 111,
        "pages": [235, 248],
        "translated_name": {"language_name": "english", "name": "Joseph"}
      },
      {
        "id": 13,
        "revelation_place": "madinah",
        "revelation_order": 96,
        "bismillah_pre": true,
        "name_simple": "Ar-Ra'd",
        "name_complex": "Ar-Ra`d",
        "name_arabic": "الرعد",
        "verses_count": 43,
        "pages": [249, 255],
        "translated_name": {"language_name": "english", "name": "The Thunder"}
      },
      {
        "id": 14,
        "revelation_place": "makkah",
        "revelation_order": 72,
        "bismillah_pre": true,
        "name_simple": "Ibrahim",
        "name_complex": "Ibrāhīm",
        "name_arabic": "ابراهيم",
        "verses_count": 52,
        "pages": [255, 261],
        "translated_name": {"language_name": "english", "name": "Abraham"}
      },
      {
        "id": 15,
        "revelation_place": "makkah",
        "revelation_order": 54,
        "bismillah_pre": true,
        "name_simple": "Al-Hijr",
        "name_complex": "Al-Ĥijr",
        "name_arabic": "الحجر",
        "verses_count": 99,
        "pages": [262, 267],
        "translated_name": {
          "language_name": "english",
          "name": "The Rocky Tract"
        }
      },
      {
        "id": 16,
        "revelation_place": "makkah",
        "revelation_order": 70,
        "bismillah_pre": true,
        "name_simple": "An-Nahl",
        "name_complex": "An-Naĥl",
        "name_arabic": "النحل",
        "verses_count": 128,
        "pages": [267, 281],
        "translated_name": {"language_name": "english", "name": "The Bee"}
      },
      {
        "id": 17,
        "revelation_place": "makkah",
        "revelation_order": 50,
        "bismillah_pre": true,
        "name_simple": "Al-Isra",
        "name_complex": "Al-'Isrā",
        "name_arabic": "الإسراء",
        "verses_count": 111,
        "pages": [282, 293],
        "translated_name": {
          "language_name": "english",
          "name": "The Night Journey"
        }
      },
      {
        "id": 18,
        "revelation_place": "makkah",
        "revelation_order": 69,
        "bismillah_pre": true,
        "name_simple": "Al-Kahf",
        "name_complex": "Al-Kahf",
        "name_arabic": "الكهف",
        "verses_count": 110,
        "pages": [293, 304],
        "translated_name": {"language_name": "english", "name": "The Cave"}
      },
      {
        "id": 19,
        "revelation_place": "makkah",
        "revelation_order": 44,
        "bismillah_pre": true,
        "name_simple": "Maryam",
        "name_complex": "Maryam",
        "name_arabic": "مريم",
        "verses_count": 98,
        "pages": [305, 312],
        "translated_name": {"language_name": "english", "name": "Mary"}
      },
      {
        "id": 20,
        "revelation_place": "makkah",
        "revelation_order": 45,
        "bismillah_pre": true,
        "name_simple": "Taha",
        "name_complex": "Ţāhā",
        "name_arabic": "طه",
        "verses_count": 135,
        "pages": [312, 321],
        "translated_name": {"language_name": "english", "name": "Ta-Ha"}
      },
      {
        "id": 21,
        "revelation_place": "makkah",
        "revelation_order": 73,
        "bismillah_pre": true,
        "name_simple": "Al-Anbya",
        "name_complex": "Al-'Anbyā",
        "name_arabic": "الأنبياء",
        "verses_count": 112,
        "pages": [322, 331],
        "translated_name": {"language_name": "english", "name": "The Prophets"}
      },
      {
        "id": 22,
        "revelation_place": "madinah",
        "revelation_order": 103,
        "bismillah_pre": true,
        "name_simple": "Al-Hajj",
        "name_complex": "Al-Ĥajj",
        "name_arabic": "الحج",
        "verses_count": 78,
        "pages": [332, 341],
        "translated_name": {
          "language_name": "english",
          "name": "The Pilgrimage"
        }
      },
      {
        "id": 23,
        "revelation_place": "makkah",
        "revelation_order": 74,
        "bismillah_pre": true,
        "name_simple": "Al-Mu'minun",
        "name_complex": "Al-Mu'minūn",
        "name_arabic": "المؤمنون",
        "verses_count": 118,
        "pages": [342, 349],
        "translated_name": {"language_name": "english", "name": "The Believers"}
      },
      {
        "id": 24,
        "revelation_place": "madinah",
        "revelation_order": 102,
        "bismillah_pre": true,
        "name_simple": "An-Nur",
        "name_complex": "An-Nūr",
        "name_arabic": "النور",
        "verses_count": 64,
        "pages": [350, 359],
        "translated_name": {"language_name": "english", "name": "The Light"}
      },
      {
        "id": 25,
        "revelation_place": "makkah",
        "revelation_order": 42,
        "bismillah_pre": true,
        "name_simple": "Al-Furqan",
        "name_complex": "Al-Furqān",
        "name_arabic": "الفرقان",
        "verses_count": 77,
        "pages": [359, 366],
        "translated_name": {"language_name": "english", "name": "The Criterion"}
      },
      {
        "id": 26,
        "revelation_place": "makkah",
        "revelation_order": 47,
        "bismillah_pre": true,
        "name_simple": "Ash-Shu'ara",
        "name_complex": "Ash-Shu`arā",
        "name_arabic": "الشعراء",
        "verses_count": 227,
        "pages": [367, 376],
        "translated_name": {"language_name": "english", "name": "The Poets"}
      },
      {
        "id": 27,
        "revelation_place": "makkah",
        "revelation_order": 48,
        "bismillah_pre": true,
        "name_simple": "An-Naml",
        "name_complex": "An-Naml",
        "name_arabic": "النمل",
        "verses_count": 93,
        "pages": [377, 385],
        "translated_name": {"language_name": "english", "name": "The Ant"}
      },
      {
        "id": 28,
        "revelation_place": "makkah",
        "revelation_order": 49,
        "bismillah_pre": true,
        "name_simple": "Al-Qasas",
        "name_complex": "Al-Qaşaş",
        "name_arabic": "القصص",
        "verses_count": 88,
        "pages": [385, 396],
        "translated_name": {"language_name": "english", "name": "The Stories"}
      },
      {
        "id": 29,
        "revelation_place": "makkah",
        "revelation_order": 85,
        "bismillah_pre": true,
        "name_simple": "Al-'Ankabut",
        "name_complex": "Al-`Ankabūt",
        "name_arabic": "العنكبوت",
        "verses_count": 69,
        "pages": [396, 404],
        "translated_name": {"language_name": "english", "name": "The Spider"}
      },
      {
        "id": 30,
        "revelation_place": "makkah",
        "revelation_order": 84,
        "bismillah_pre": true,
        "name_simple": "Ar-Rum",
        "name_complex": "Ar-Rūm",
        "name_arabic": "الروم",
        "verses_count": 60,
        "pages": [404, 410],
        "translated_name": {"language_name": "english", "name": "The Romans"}
      },
      {
        "id": 31,
        "revelation_place": "makkah",
        "revelation_order": 57,
        "bismillah_pre": true,
        "name_simple": "Luqman",
        "name_complex": "Luqmān",
        "name_arabic": "لقمان",
        "verses_count": 34,
        "pages": [411, 414],
        "translated_name": {"language_name": "english", "name": "Luqman"}
      },
      {
        "id": 32,
        "revelation_place": "makkah",
        "revelation_order": 75,
        "bismillah_pre": true,
        "name_simple": "As-Sajdah",
        "name_complex": "As-Sajdah",
        "name_arabic": "السجدة",
        "verses_count": 30,
        "pages": [415, 417],
        "translated_name": {
          "language_name": "english",
          "name": "The Prostration"
        }
      },
      {
        "id": 33,
        "revelation_place": "madinah",
        "revelation_order": 90,
        "bismillah_pre": true,
        "name_simple": "Al-Ahzab",
        "name_complex": "Al-'Aĥzāb",
        "name_arabic": "الأحزاب",
        "verses_count": 73,
        "pages": [418, 427],
        "translated_name": {
          "language_name": "english",
          "name": "The Combined Forces"
        }
      },
      {
        "id": 34,
        "revelation_place": "makkah",
        "revelation_order": 58,
        "bismillah_pre": true,
        "name_simple": "Saba",
        "name_complex": "Saba",
        "name_arabic": "سبإ",
        "verses_count": 54,
        "pages": [428, 434],
        "translated_name": {"language_name": "english", "name": "Sheba"}
      },
      {
        "id": 35,
        "revelation_place": "makkah",
        "revelation_order": 43,
        "bismillah_pre": true,
        "name_simple": "Fatir",
        "name_complex": "Fāţir",
        "name_arabic": "فاطر",
        "verses_count": 45,
        "pages": [434, 440],
        "translated_name": {"language_name": "english", "name": "Originator"}
      },
      {
        "id": 36,
        "revelation_place": "makkah",
        "revelation_order": 41,
        "bismillah_pre": true,
        "name_simple": "Ya-Sin",
        "name_complex": "Yā-Sīn",
        "name_arabic": "يس",
        "verses_count": 83,
        "pages": [440, 445],
        "translated_name": {"language_name": "english", "name": "Ya Sin"}
      },
      {
        "id": 37,
        "revelation_place": "makkah",
        "revelation_order": 56,
        "bismillah_pre": true,
        "name_simple": "As-Saffat",
        "name_complex": "Aş-Şāffāt",
        "name_arabic": "الصافات",
        "verses_count": 182,
        "pages": [446, 452],
        "translated_name": {
          "language_name": "english",
          "name": "Those who set the Ranks"
        }
      },
      {
        "id": 38,
        "revelation_place": "makkah",
        "revelation_order": 38,
        "bismillah_pre": true,
        "name_simple": "Sad",
        "name_complex": "Şād",
        "name_arabic": "ص",
        "verses_count": 88,
        "pages": [453, 458],
        "translated_name": {
          "language_name": "english",
          "name": "The Letter \"Saad\""
        }
      },
      {
        "id": 39,
        "revelation_place": "makkah",
        "revelation_order": 59,
        "bismillah_pre": true,
        "name_simple": "Az-Zumar",
        "name_complex": "Az-Zumar",
        "name_arabic": "الزمر",
        "verses_count": 75,
        "pages": [458, 467],
        "translated_name": {"language_name": "english", "name": "The Troops"}
      },
      {
        "id": 40,
        "revelation_place": "makkah",
        "revelation_order": 60,
        "bismillah_pre": true,
        "name_simple": "Ghafir",
        "name_complex": "Ghāfir",
        "name_arabic": "غافر",
        "verses_count": 85,
        "pages": [467, 476],
        "translated_name": {"language_name": "english", "name": "The Forgiver"}
      },
      {
        "id": 41,
        "revelation_place": "makkah",
        "revelation_order": 61,
        "bismillah_pre": true,
        "name_simple": "Fussilat",
        "name_complex": "Fuşşilat",
        "name_arabic": "فصلت",
        "verses_count": 54,
        "pages": [477, 482],
        "translated_name": {
          "language_name": "english",
          "name": "Explained in Detail"
        }
      },
      {
        "id": 42,
        "revelation_place": "makkah",
        "revelation_order": 62,
        "bismillah_pre": true,
        "name_simple": "Ash-Shuraa",
        "name_complex": "Ash-Shūraá",
        "name_arabic": "الشورى",
        "verses_count": 53,
        "pages": [483, 489],
        "translated_name": {
          "language_name": "english",
          "name": "The Consultation"
        }
      },
      {
        "id": 43,
        "revelation_place": "makkah",
        "revelation_order": 63,
        "bismillah_pre": true,
        "name_simple": "Az-Zukhruf",
        "name_complex": "Az-Zukhruf",
        "name_arabic": "الزخرف",
        "verses_count": 89,
        "pages": [489, 495],
        "translated_name": {
          "language_name": "english",
          "name": "The Ornaments of Gold"
        }
      },
      {
        "id": 44,
        "revelation_place": "makkah",
        "revelation_order": 64,
        "bismillah_pre": true,
        "name_simple": "Ad-Dukhan",
        "name_complex": "Ad-Dukhān",
        "name_arabic": "الدخان",
        "verses_count": 59,
        "pages": [496, 498],
        "translated_name": {"language_name": "english", "name": "The Smoke"}
      },
      {
        "id": 45,
        "revelation_place": "makkah",
        "revelation_order": 65,
        "bismillah_pre": true,
        "name_simple": "Al-Jathiyah",
        "name_complex": "Al-Jāthiyah",
        "name_arabic": "الجاثية",
        "verses_count": 37,
        "pages": [499, 502],
        "translated_name": {"language_name": "english", "name": "The Crouching"}
      },
      {
        "id": 46,
        "revelation_place": "makkah",
        "revelation_order": 66,
        "bismillah_pre": true,
        "name_simple": "Al-Ahqaf",
        "name_complex": "Al-'Aĥqāf",
        "name_arabic": "الأحقاف",
        "verses_count": 35,
        "pages": [502, 506],
        "translated_name": {
          "language_name": "english",
          "name": "The Wind-Curved Sandhills"
        }
      },
      {
        "id": 47,
        "revelation_place": "madinah",
        "revelation_order": 95,
        "bismillah_pre": true,
        "name_simple": "Muhammad",
        "name_complex": "Muĥammad",
        "name_arabic": "محمد",
        "verses_count": 38,
        "pages": [507, 510],
        "translated_name": {"language_name": "english", "name": "Muhammad"}
      },
      {
        "id": 48,
        "revelation_place": "madinah",
        "revelation_order": 111,
        "bismillah_pre": true,
        "name_simple": "Al-Fath",
        "name_complex": "Al-Fatĥ",
        "name_arabic": "الفتح",
        "verses_count": 29,
        "pages": [511, 515],
        "translated_name": {"language_name": "english", "name": "The Victory"}
      },
      {
        "id": 49,
        "revelation_place": "madinah",
        "revelation_order": 106,
        "bismillah_pre": true,
        "name_simple": "Al-Hujurat",
        "name_complex": "Al-Ĥujurāt",
        "name_arabic": "الحجرات",
        "verses_count": 18,
        "pages": [515, 517],
        "translated_name": {"language_name": "english", "name": "The Rooms"}
      },
      {
        "id": 50,
        "revelation_place": "makkah",
        "revelation_order": 34,
        "bismillah_pre": true,
        "name_simple": "Qaf",
        "name_complex": "Qāf",
        "name_arabic": "ق",
        "verses_count": 45,
        "pages": [518, 520],
        "translated_name": {
          "language_name": "english",
          "name": "The Letter \"Qaf\""
        }
      },
      {
        "id": 51,
        "revelation_place": "makkah",
        "revelation_order": 67,
        "bismillah_pre": true,
        "name_simple": "Adh-Dhariyat",
        "name_complex": "Adh-Dhāriyāt",
        "name_arabic": "الذاريات",
        "verses_count": 60,
        "pages": [520, 523],
        "translated_name": {
          "language_name": "english",
          "name": "The Winnowing Winds"
        }
      },
      {
        "id": 52,
        "revelation_place": "makkah",
        "revelation_order": 76,
        "bismillah_pre": true,
        "name_simple": "At-Tur",
        "name_complex": "Aţ-Ţūr",
        "name_arabic": "الطور",
        "verses_count": 49,
        "pages": [523, 525],
        "translated_name": {"language_name": "english", "name": "The Mount"}
      },
      {
        "id": 53,
        "revelation_place": "makkah",
        "revelation_order": 23,
        "bismillah_pre": true,
        "name_simple": "An-Najm",
        "name_complex": "An-Najm",
        "name_arabic": "النجم",
        "verses_count": 62,
        "pages": [526, 528],
        "translated_name": {"language_name": "english", "name": "The Star"}
      },
      {
        "id": 54,
        "revelation_place": "makkah",
        "revelation_order": 37,
        "bismillah_pre": true,
        "name_simple": "Al-Qamar",
        "name_complex": "Al-Qamar",
        "name_arabic": "القمر",
        "verses_count": 55,
        "pages": [528, 531],
        "translated_name": {"language_name": "english", "name": "The Moon"}
      },
      {
        "id": 55,
        "revelation_place": "madinah",
        "revelation_order": 97,
        "bismillah_pre": true,
        "name_simple": "Ar-Rahman",
        "name_complex": "Ar-Raĥmān",
        "name_arabic": "الرحمن",
        "verses_count": 78,
        "pages": [531, 534],
        "translated_name": {
          "language_name": "english",
          "name": "The Beneficent"
        }
      },
      {
        "id": 56,
        "revelation_place": "makkah",
        "revelation_order": 46,
        "bismillah_pre": true,
        "name_simple": "Al-Waqi'ah",
        "name_complex": "Al-Wāqi`ah",
        "name_arabic": "الواقعة",
        "verses_count": 96,
        "pages": [534, 537],
        "translated_name": {
          "language_name": "english",
          "name": "The Inevitable"
        }
      },
      {
        "id": 57,
        "revelation_place": "madinah",
        "revelation_order": 94,
        "bismillah_pre": true,
        "name_simple": "Al-Hadid",
        "name_complex": "Al-Ĥadīd",
        "name_arabic": "الحديد",
        "verses_count": 29,
        "pages": [537, 541],
        "translated_name": {"language_name": "english", "name": "The Iron"}
      },
      {
        "id": 58,
        "revelation_place": "madinah",
        "revelation_order": 105,
        "bismillah_pre": true,
        "name_simple": "Al-Mujadila",
        "name_complex": "Al-Mujādila",
        "name_arabic": "المجادلة",
        "verses_count": 22,
        "pages": [542, 545],
        "translated_name": {
          "language_name": "english",
          "name": "The Pleading Woman"
        }
      },
      {
        "id": 59,
        "revelation_place": "madinah",
        "revelation_order": 101,
        "bismillah_pre": true,
        "name_simple": "Al-Hashr",
        "name_complex": "Al-Ĥashr",
        "name_arabic": "الحشر",
        "verses_count": 24,
        "pages": [545, 548],
        "translated_name": {"language_name": "english", "name": "The Exile"}
      },
      {
        "id": 60,
        "revelation_place": "madinah",
        "revelation_order": 91,
        "bismillah_pre": true,
        "name_simple": "Al-Mumtahanah",
        "name_complex": "Al-Mumtaĥanah",
        "name_arabic": "الممتحنة",
        "verses_count": 13,
        "pages": [549, 551],
        "translated_name": {
          "language_name": "english",
          "name": "She that is to be examined"
        }
      },
      {
        "id": 61,
        "revelation_place": "madinah",
        "revelation_order": 109,
        "bismillah_pre": true,
        "name_simple": "As-Saf",
        "name_complex": "Aş-Şaf",
        "name_arabic": "الصف",
        "verses_count": 14,
        "pages": [551, 552],
        "translated_name": {"language_name": "english", "name": "The Ranks"}
      },
      {
        "id": 62,
        "revelation_place": "madinah",
        "revelation_order": 110,
        "bismillah_pre": true,
        "name_simple": "Al-Jumu'ah",
        "name_complex": "Al-Jumu`ah",
        "name_arabic": "الجمعة",
        "verses_count": 11,
        "pages": [553, 554],
        "translated_name": {
          "language_name": "english",
          "name": "The Congregation, Friday"
        }
      },
      {
        "id": 63,
        "revelation_place": "madinah",
        "revelation_order": 104,
        "bismillah_pre": true,
        "name_simple": "Al-Munafiqun",
        "name_complex": "Al-Munāfiqūn",
        "name_arabic": "المنافقون",
        "verses_count": 11,
        "pages": [554, 555],
        "translated_name": {
          "language_name": "english",
          "name": "The Hypocrites"
        }
      },
      {
        "id": 64,
        "revelation_place": "madinah",
        "revelation_order": 108,
        "bismillah_pre": true,
        "name_simple": "At-Taghabun",
        "name_complex": "At-Taghābun",
        "name_arabic": "التغابن",
        "verses_count": 18,
        "pages": [556, 557],
        "translated_name": {
          "language_name": "english",
          "name": "The Mutual Disillusion"
        }
      },
      {
        "id": 65,
        "revelation_place": "madinah",
        "revelation_order": 99,
        "bismillah_pre": true,
        "name_simple": "At-Talaq",
        "name_complex": "Aţ-Ţalāq",
        "name_arabic": "الطلاق",
        "verses_count": 12,
        "pages": [558, 559],
        "translated_name": {"language_name": "english", "name": "The Divorce"}
      },
      {
        "id": 66,
        "revelation_place": "madinah",
        "revelation_order": 107,
        "bismillah_pre": true,
        "name_simple": "At-Tahrim",
        "name_complex": "At-Taĥrīm",
        "name_arabic": "التحريم",
        "verses_count": 12,
        "pages": [560, 561],
        "translated_name": {
          "language_name": "english",
          "name": "The Prohibition"
        }
      },
      {
        "id": 67,
        "revelation_place": "makkah",
        "revelation_order": 77,
        "bismillah_pre": true,
        "name_simple": "Al-Mulk",
        "name_complex": "Al-Mulk",
        "name_arabic": "الملك",
        "verses_count": 30,
        "pages": [562, 564],
        "translated_name": {
          "language_name": "english",
          "name": "The Sovereignty"
        }
      },
      {
        "id": 68,
        "revelation_place": "makkah",
        "revelation_order": 2,
        "bismillah_pre": true,
        "name_simple": "Al-Qalam",
        "name_complex": "Al-Qalam",
        "name_arabic": "القلم",
        "verses_count": 52,
        "pages": [564, 566],
        "translated_name": {"language_name": "english", "name": "The Pen"}
      },
      {
        "id": 69,
        "revelation_place": "makkah",
        "revelation_order": 78,
        "bismillah_pre": true,
        "name_simple": "Al-Haqqah",
        "name_complex": "Al-Ĥāqqah",
        "name_arabic": "الحاقة",
        "verses_count": 52,
        "pages": [566, 568],
        "translated_name": {"language_name": "english", "name": "The Reality"}
      },
      {
        "id": 70,
        "revelation_place": "makkah",
        "revelation_order": 79,
        "bismillah_pre": true,
        "name_simple": "Al-Ma'arij",
        "name_complex": "Al-Ma`ārij",
        "name_arabic": "المعارج",
        "verses_count": 44,
        "pages": [568, 570],
        "translated_name": {
          "language_name": "english",
          "name": "The Ascending Stairways"
        }
      },
      {
        "id": 71,
        "revelation_place": "makkah",
        "revelation_order": 71,
        "bismillah_pre": true,
        "name_simple": "Nuh",
        "name_complex": "Nūĥ",
        "name_arabic": "نوح",
        "verses_count": 28,
        "pages": [570, 571],
        "translated_name": {"language_name": "english", "name": "Noah"}
      },
      {
        "id": 72,
        "revelation_place": "makkah",
        "revelation_order": 40,
        "bismillah_pre": true,
        "name_simple": "Al-Jinn",
        "name_complex": "Al-Jinn",
        "name_arabic": "الجن",
        "verses_count": 28,
        "pages": [572, 573],
        "translated_name": {"language_name": "english", "name": "The Jinn"}
      },
      {
        "id": 73,
        "revelation_place": "makkah",
        "revelation_order": 3,
        "bismillah_pre": true,
        "name_simple": "Al-Muzzammil",
        "name_complex": "Al-Muzzammil",
        "name_arabic": "المزمل",
        "verses_count": 20,
        "pages": [574, 575],
        "translated_name": {
          "language_name": "english",
          "name": "The Enshrouded One"
        }
      },
      {
        "id": 74,
        "revelation_place": "makkah",
        "revelation_order": 4,
        "bismillah_pre": true,
        "name_simple": "Al-Muddaththir",
        "name_complex": "Al-Muddaththir",
        "name_arabic": "المدثر",
        "verses_count": 56,
        "pages": [575, 577],
        "translated_name": {
          "language_name": "english",
          "name": "The Cloaked One"
        }
      },
      {
        "id": 75,
        "revelation_place": "makkah",
        "revelation_order": 31,
        "bismillah_pre": true,
        "name_simple": "Al-Qiyamah",
        "name_complex": "Al-Qiyāmah",
        "name_arabic": "القيامة",
        "verses_count": 40,
        "pages": [577, 578],
        "translated_name": {
          "language_name": "english",
          "name": "The Resurrection"
        }
      },
      {
        "id": 76,
        "revelation_place": "madinah",
        "revelation_order": 98,
        "bismillah_pre": true,
        "name_simple": "Al-Insan",
        "name_complex": "Al-'Insān",
        "name_arabic": "الانسان",
        "verses_count": 31,
        "pages": [578, 580],
        "translated_name": {"language_name": "english", "name": "The Man"}
      },
      {
        "id": 77,
        "revelation_place": "makkah",
        "revelation_order": 33,
        "bismillah_pre": true,
        "name_simple": "Al-Mursalat",
        "name_complex": "Al-Mursalāt",
        "name_arabic": "المرسلات",
        "verses_count": 50,
        "pages": [580, 581],
        "translated_name": {
          "language_name": "english",
          "name": "The Emissaries"
        }
      },
      {
        "id": 78,
        "revelation_place": "makkah",
        "revelation_order": 80,
        "bismillah_pre": true,
        "name_simple": "An-Naba",
        "name_complex": "An-Naba",
        "name_arabic": "النبإ",
        "verses_count": 40,
        "pages": [582, 583],
        "translated_name": {"language_name": "english", "name": "The Tidings"}
      },
      {
        "id": 79,
        "revelation_place": "makkah",
        "revelation_order": 81,
        "bismillah_pre": true,
        "name_simple": "An-Nazi'at",
        "name_complex": "An-Nāzi`āt",
        "name_arabic": "النازعات",
        "verses_count": 46,
        "pages": [583, 584],
        "translated_name": {
          "language_name": "english",
          "name": "Those who drag forth"
        }
      },
      {
        "id": 80,
        "revelation_place": "makkah",
        "revelation_order": 24,
        "bismillah_pre": true,
        "name_simple": "'Abasa",
        "name_complex": "`Abasa",
        "name_arabic": "عبس",
        "verses_count": 42,
        "pages": [585, 585],
        "translated_name": {"language_name": "english", "name": "He Frowned"}
      },
      {
        "id": 81,
        "revelation_place": "makkah",
        "revelation_order": 7,
        "bismillah_pre": true,
        "name_simple": "At-Takwir",
        "name_complex": "At-Takwīr",
        "name_arabic": "التكوير",
        "verses_count": 29,
        "pages": [586, 586],
        "translated_name": {
          "language_name": "english",
          "name": "The Overthrowing"
        }
      },
      {
        "id": 82,
        "revelation_place": "makkah",
        "revelation_order": 82,
        "bismillah_pre": true,
        "name_simple": "Al-Infitar",
        "name_complex": "Al-'Infiţār",
        "name_arabic": "الإنفطار",
        "verses_count": 19,
        "pages": [587, 587],
        "translated_name": {"language_name": "english", "name": "The Cleaving"}
      },
      {
        "id": 83,
        "revelation_place": "makkah",
        "revelation_order": 86,
        "bismillah_pre": true,
        "name_simple": "Al-Mutaffifin",
        "name_complex": "Al-Muţaffifīn",
        "name_arabic": "المطففين",
        "verses_count": 36,
        "pages": [587, 589],
        "translated_name": {
          "language_name": "english",
          "name": "The Defrauding"
        }
      },
      {
        "id": 84,
        "revelation_place": "makkah",
        "revelation_order": 83,
        "bismillah_pre": true,
        "name_simple": "Al-Inshiqaq",
        "name_complex": "Al-'Inshiqāq",
        "name_arabic": "الإنشقاق",
        "verses_count": 25,
        "pages": [589, 589],
        "translated_name": {"language_name": "english", "name": "The Sundering"}
      },
      {
        "id": 85,
        "revelation_place": "makkah",
        "revelation_order": 27,
        "bismillah_pre": true,
        "name_simple": "Al-Buruj",
        "name_complex": "Al-Burūj",
        "name_arabic": "البروج",
        "verses_count": 22,
        "pages": [590, 590],
        "translated_name": {
          "language_name": "english",
          "name": "The Mansions of the Stars"
        }
      },
      {
        "id": 86,
        "revelation_place": "makkah",
        "revelation_order": 36,
        "bismillah_pre": true,
        "name_simple": "At-Tariq",
        "name_complex": "Aţ-Ţāriq",
        "name_arabic": "الطارق",
        "verses_count": 17,
        "pages": [591, 591],
        "translated_name": {
          "language_name": "english",
          "name": "The Nightcommer"
        }
      },
      {
        "id": 87,
        "revelation_place": "makkah",
        "revelation_order": 8,
        "bismillah_pre": true,
        "name_simple": "Al-A'la",
        "name_complex": "Al-'A`lá",
        "name_arabic": "الأعلى",
        "verses_count": 19,
        "pages": [591, 592],
        "translated_name": {"language_name": "english", "name": "The Most High"}
      },
      {
        "id": 88,
        "revelation_place": "makkah",
        "revelation_order": 68,
        "bismillah_pre": true,
        "name_simple": "Al-Ghashiyah",
        "name_complex": "Al-Ghāshiyah",
        "name_arabic": "الغاشية",
        "verses_count": 26,
        "pages": [592, 592],
        "translated_name": {
          "language_name": "english",
          "name": "The Overwhelming"
        }
      },
      {
        "id": 89,
        "revelation_place": "makkah",
        "revelation_order": 10,
        "bismillah_pre": true,
        "name_simple": "Al-Fajr",
        "name_complex": "Al-Fajr",
        "name_arabic": "الفجر",
        "verses_count": 30,
        "pages": [593, 594],
        "translated_name": {"language_name": "english", "name": "The Dawn"}
      },
      {
        "id": 90,
        "revelation_place": "makkah",
        "revelation_order": 35,
        "bismillah_pre": true,
        "name_simple": "Al-Balad",
        "name_complex": "Al-Balad",
        "name_arabic": "البلد",
        "verses_count": 20,
        "pages": [594, 594],
        "translated_name": {"language_name": "english", "name": "The City"}
      },
      {
        "id": 91,
        "revelation_place": "makkah",
        "revelation_order": 26,
        "bismillah_pre": true,
        "name_simple": "Ash-Shams",
        "name_complex": "Ash-Shams",
        "name_arabic": "الشمس",
        "verses_count": 15,
        "pages": [595, 595],
        "translated_name": {"language_name": "english", "name": "The Sun"}
      },
      {
        "id": 92,
        "revelation_place": "makkah",
        "revelation_order": 9,
        "bismillah_pre": true,
        "name_simple": "Al-Layl",
        "name_complex": "Al-Layl",
        "name_arabic": "الليل",
        "verses_count": 21,
        "pages": [595, 596],
        "translated_name": {"language_name": "english", "name": "The Night"}
      },
      {
        "id": 93,
        "revelation_place": "makkah",
        "revelation_order": 11,
        "bismillah_pre": true,
        "name_simple": "Ad-Duhaa",
        "name_complex": "Ađ-Đuĥaá",
        "name_arabic": "الضحى",
        "verses_count": 11,
        "pages": [596, 596],
        "translated_name": {
          "language_name": "english",
          "name": "The Morning Hours"
        }
      },
      {
        "id": 94,
        "revelation_place": "makkah",
        "revelation_order": 12,
        "bismillah_pre": true,
        "name_simple": "Ash-Sharh",
        "name_complex": "Ash-Sharĥ",
        "name_arabic": "الشرح",
        "verses_count": 8,
        "pages": [596, 596],
        "translated_name": {"language_name": "english", "name": "The Relief"}
      },
      {
        "id": 95,
        "revelation_place": "makkah",
        "revelation_order": 28,
        "bismillah_pre": true,
        "name_simple": "At-Tin",
        "name_complex": "At-Tīn",
        "name_arabic": "التين",
        "verses_count": 8,
        "pages": [597, 597],
        "translated_name": {"language_name": "english", "name": "The Fig"}
      },
      {
        "id": 96,
        "revelation_place": "makkah",
        "revelation_order": 1,
        "bismillah_pre": true,
        "name_simple": "Al-'Alaq",
        "name_complex": "Al-`Alaq",
        "name_arabic": "العلق",
        "verses_count": 19,
        "pages": [597, 597],
        "translated_name": {"language_name": "english", "name": "The Clot"}
      },
      {
        "id": 97,
        "revelation_place": "makkah",
        "revelation_order": 25,
        "bismillah_pre": true,
        "name_simple": "Al-Qadr",
        "name_complex": "Al-Qadr",
        "name_arabic": "القدر",
        "verses_count": 5,
        "pages": [598, 598],
        "translated_name": {"language_name": "english", "name": "The Power"}
      },
      {
        "id": 98,
        "revelation_place": "madinah",
        "revelation_order": 100,
        "bismillah_pre": true,
        "name_simple": "Al-Bayyinah",
        "name_complex": "Al-Bayyinah",
        "name_arabic": "البينة",
        "verses_count": 8,
        "pages": [598, 599],
        "translated_name": {
          "language_name": "english",
          "name": "The Clear Proof"
        }
      },
      {
        "id": 99,
        "revelation_place": "madinah",
        "revelation_order": 93,
        "bismillah_pre": true,
        "name_simple": "Az-Zalzalah",
        "name_complex": "Az-Zalzalah",
        "name_arabic": "الزلزلة",
        "verses_count": 8,
        "pages": [599, 599],
        "translated_name": {
          "language_name": "english",
          "name": "The Earthquake"
        }
      },
      {
        "id": 100,
        "revelation_place": "makkah",
        "revelation_order": 14,
        "bismillah_pre": true,
        "name_simple": "Al-'Adiyat",
        "name_complex": "Al-`Ādiyāt",
        "name_arabic": "العاديات",
        "verses_count": 11,
        "pages": [599, 600],
        "translated_name": {"language_name": "english", "name": "The Courser"}
      },
      {
        "id": 101,
        "revelation_place": "makkah",
        "revelation_order": 30,
        "bismillah_pre": true,
        "name_simple": "Al-Qari'ah",
        "name_complex": "Al-Qāri`ah",
        "name_arabic": "القارعة",
        "verses_count": 11,
        "pages": [600, 600],
        "translated_name": {"language_name": "english", "name": "The Calamity"}
      },
      {
        "id": 102,
        "revelation_place": "makkah",
        "revelation_order": 16,
        "bismillah_pre": true,
        "name_simple": "At-Takathur",
        "name_complex": "At-Takāthur",
        "name_arabic": "التكاثر",
        "verses_count": 8,
        "pages": [600, 600],
        "translated_name": {
          "language_name": "english",
          "name": "The Rivalry in world increase"
        }
      },
      {
        "id": 103,
        "revelation_place": "makkah",
        "revelation_order": 13,
        "bismillah_pre": true,
        "name_simple": "Al-'Asr",
        "name_complex": "Al-`Aşr",
        "name_arabic": "العصر",
        "verses_count": 3,
        "pages": [601, 601],
        "translated_name": {
          "language_name": "english",
          "name": "The Declining Day"
        }
      },
      {
        "id": 104,
        "revelation_place": "makkah",
        "revelation_order": 32,
        "bismillah_pre": true,
        "name_simple": "Al-Humazah",
        "name_complex": "Al-Humazah",
        "name_arabic": "الهمزة",
        "verses_count": 9,
        "pages": [601, 601],
        "translated_name": {"language_name": "english", "name": "The Traducer"}
      },
      {
        "id": 105,
        "revelation_place": "makkah",
        "revelation_order": 19,
        "bismillah_pre": true,
        "name_simple": "Al-Fil",
        "name_complex": "Al-Fīl",
        "name_arabic": "الفيل",
        "verses_count": 5,
        "pages": [601, 601],
        "translated_name": {"language_name": "english", "name": "The Elephant"}
      },
      {
        "id": 106,
        "revelation_place": "makkah",
        "revelation_order": 29,
        "bismillah_pre": true,
        "name_simple": "Quraysh",
        "name_complex": "Quraysh",
        "name_arabic": "قريش",
        "verses_count": 4,
        "pages": [602, 602],
        "translated_name": {"language_name": "english", "name": "Quraysh"}
      },
      {
        "id": 107,
        "revelation_place": "makkah",
        "revelation_order": 17,
        "bismillah_pre": true,
        "name_simple": "Al-Ma'un",
        "name_complex": "Al-Mā`ūn",
        "name_arabic": "الماعون",
        "verses_count": 7,
        "pages": [602, 602],
        "translated_name": {
          "language_name": "english",
          "name": "The Small kindnesses"
        }
      },
      {
        "id": 108,
        "revelation_place": "makkah",
        "revelation_order": 15,
        "bismillah_pre": true,
        "name_simple": "Al-Kawthar",
        "name_complex": "Al-Kawthar",
        "name_arabic": "الكوثر",
        "verses_count": 3,
        "pages": [602, 602],
        "translated_name": {"language_name": "english", "name": "The Abundance"}
      },
      {
        "id": 109,
        "revelation_place": "makkah",
        "revelation_order": 18,
        "bismillah_pre": true,
        "name_simple": "Al-Kafirun",
        "name_complex": "Al-Kāfirūn",
        "name_arabic": "الكافرون",
        "verses_count": 6,
        "pages": [603, 603],
        "translated_name": {
          "language_name": "english",
          "name": "The Disbelievers"
        }
      },
      {
        "id": 110,
        "revelation_place": "madinah",
        "revelation_order": 114,
        "bismillah_pre": true,
        "name_simple": "An-Nasr",
        "name_complex": "An-Naşr",
        "name_arabic": "النصر",
        "verses_count": 3,
        "pages": [603, 603],
        "translated_name": {
          "language_name": "english",
          "name": "The Divine Support"
        }
      },
      {
        "id": 111,
        "revelation_place": "makkah",
        "revelation_order": 6,
        "bismillah_pre": true,
        "name_simple": "Al-Masad",
        "name_complex": "Al-Masad",
        "name_arabic": "المسد",
        "verses_count": 5,
        "pages": [603, 603],
        "translated_name": {
          "language_name": "english",
          "name": "The Palm Fiber"
        }
      },
      {
        "id": 112,
        "revelation_place": "makkah",
        "revelation_order": 22,
        "bismillah_pre": true,
        "name_simple": "Al-Ikhlas",
        "name_complex": "Al-'Ikhlāş",
        "name_arabic": "الإخلاص",
        "verses_count": 4,
        "pages": [604, 604],
        "translated_name": {"language_name": "english", "name": "The Sincerity"}
      },
      {
        "id": 113,
        "revelation_place": "makkah",
        "revelation_order": 20,
        "bismillah_pre": true,
        "name_simple": "Al-Falaq",
        "name_complex": "Al-Falaq",
        "name_arabic": "الفلق",
        "verses_count": 5,
        "pages": [604, 604],
        "translated_name": {"language_name": "english", "name": "The Daybreak"}
      },
      {
        "id": 114,
        "revelation_place": "makkah",
        "revelation_order": 21,
        "bismillah_pre": true,
        "name_simple": "An-Nas",
        "name_complex": "An-Nās",
        "name_arabic": "الناس",
        "verses_count": 6,
        "pages": [604, 604],
        "translated_name": {"language_name": "english", "name": "Mankind"}
      }
    ]
  };
}

int? add(
  int num,
  int amount,
) {
  return num + amount;
}

List<dynamic> reverseJsonArray(
  List<dynamic> jsonData,
  String? direction,
  String? sortBy,
) {
  if (direction != null && sortBy != null) {
    jsonData.sort((a, b) {
      if (direction == "asc") {
        return a[sortBy].compareTo(b[sortBy]);
      } else {
        return b[sortBy].compareTo(a[sortBy]);
      }
    });
  }
  return jsonData;
}

String extractFromJson(dynamic jsonData) {
  List<String> translationTextList = [];
  for (var item in jsonData) {
    if (item['translation'] != null && item['translation']['text'] != null) {
      translationTextList.add(item['translation']['text']);
    }
  }

  return translationTextList.join(' ');
}

dynamic getChapterDataByID(
  dynamic jsonData,
  int id,
) {
  final List<dynamic> chapters = jsonData['chapters'];
  for (var chapter in chapters) {
    if (chapter['id'] == id) {
      return chapter;
    }
  }
  return null;
}

double? divide(
  int num1,
  int num2,
) {
  return double.parse((num1 / num2).toStringAsFixed(3));
}

int round(double num) {
  return num.round();
}

double? multiply(
  double num1,
  double num2,
) {
  return num1 * num2;
}

double divideDouble(
  double double1,
  double double2,
) {
  return double1 / double2;
}

dynamic recitations() {
  return {
    "recitations": [
      {
        "id": 2,
        "reciter_name": "AbdulBaset AbdulSamad",
        "style": "Murattal",
        "translated_name": {
          "name": "AbdulBaset AbdulSamad",
          "language_name": "english"
        }
      },
      {
        "id": 1,
        "reciter_name": "AbdulBaset AbdulSamad",
        "style": "Mujawwad",
        "translated_name": {
          "name": "AbdulBaset AbdulSamad",
          "language_name": "english"
        }
      },
      {
        "id": 3,
        "reciter_name": "Abdur-Rahman as-Sudais",
        "style": null,
        "translated_name": {
          "name": "Abdur-Rahman as-Sudais",
          "language_name": "english"
        }
      },
      {
        "id": 4,
        "reciter_name": "Abu Bakr al-Shatri",
        "style": null,
        "translated_name": {
          "name": "Abu Bakr al-Shatri",
          "language_name": "english"
        }
      },
      {
        "id": 5,
        "reciter_name": "Hani ar-Rifai",
        "style": null,
        "translated_name": {"name": "Hani ar-Rifai", "language_name": "english"}
      },
      {
        "id": 12,
        "reciter_name": "Mahmoud Khalil Al-Husary",
        "style": "Muallim",
        "translated_name": {
          "name": "Mahmoud Khalil Al-Husary",
          "language_name": "english"
        }
      },
      {
        "id": 6,
        "reciter_name": "Mahmoud Khalil Al-Husary",
        "style": null,
        "translated_name": {
          "name": "Mahmoud Khalil Al-Husary",
          "language_name": "english"
        }
      },
      {
        "id": 7,
        "reciter_name": "Mishari Rashid al-`Afasy",
        "style": null,
        "translated_name": {
          "name": "Mishari Rashid al-`Afasy",
          "language_name": "english"
        }
      },
      {
        "id": 9,
        "reciter_name": "Mohamed Siddiq al-Minshawi",
        "style": "Murattal",
        "translated_name": {
          "name": "Mohamed Siddiq al-Minshawi",
          "language_name": "english"
        }
      },
      {
        "id": 8,
        "reciter_name": "Mohamed Siddiq al-Minshawi",
        "style": "Mujawwad",
        "translated_name": {
          "name": "Mohamed Siddiq al-Minshawi",
          "language_name": "english"
        }
      },
      {
        "id": 10,
        "reciter_name": "Sa`ud ash-Shuraym",
        "style": null,
        "translated_name": {
          "name": "Sa`ud ash-Shuraym",
          "language_name": "english"
        }
      },
      {
        "id": 11,
        "reciter_name": "Mohamed al-Tablawi",
        "style": null,
        "translated_name": {
          "name": "Mohamed al-Tablawi",
          "language_name": "english"
        }
      }
    ]
  };
}

int? hasanatCalculator(String input) {
  // Define a regular expression pattern to match Arabic diacritics.
  final diacriticsPattern = RegExp(
      r'[\u064E\u064F\u0650\u0651\u0652]'); //fatḥah, dhammah, kasrah, shaddah, and sukuun

  // Remove diacritics from the input string using the regular expression pattern.
  String modifiedText = input.replaceAll(diacriticsPattern, '');

  // Remove spaces from the modified text.
  modifiedText = modifiedText.replaceAll(' ', '');

  // Calculate the number of characters in the modified text.
  int length = modifiedText.length;

  // Return the number of characters.
  return length * 10;
}

String? formatNumber(int number) {
  if (number < 1000) {
    return number.toString();
  } else if (number < 1000000) {
    double result = number / 1000;
    return result.toStringAsFixed(1) + 'K';
  } else {
    double result = number / 1000000;
    return result.toStringAsFixed(1) + 'M';
  }
}

String? formatTime(int seconds) {
  if (seconds < 3600) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    String minuteString = (minutes < 10) ? '0$minutes' : '$minutes';
    String secondString =
        (remainingSeconds < 10) ? '0$remainingSeconds' : '$remainingSeconds';
    return '$minuteString:$secondString';
  } else {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int remainingSeconds = seconds % 60;
    String hourString = (hours < 10) ? '0$hours' : '$hours';
    String minuteString = (minutes < 10) ? '0$minutes' : '$minutes';
    String secondString =
        (remainingSeconds < 10) ? '0$remainingSeconds' : '$remainingSeconds';
    return '$hourString:$minuteString:$secondString';
  }
}

bool? multipleOfX(
  int multipleX,
  int number,
) {
  return number % multipleX == 0;
}

List<String> stringToList(String inputString) {
  String t = inputString;

  if (inputString == 'Hasanat') {
    t = 'hasanat';
  } else if (inputString == 'Verses') {
    t = 'versesRead';
  } else if (inputString == 'Time') {
    t = 'timeReadSec';
  } else if (inputString == 'Total Avg') {
  } else if (inputString == 'Streak') {
  } else if (inputString == 'Completed') {}

  // Create a list with the inputString as a single element
  List<String> x = [t, "user"];
  return x;
}

List<String> quranHasanatAttributesToRetrieve() {
  List<String> x = ['hasanat', 'user'];
  return x;
}

List<dynamic> pagifyNumbers(int input) {
  List<Map<String, int>> numberList = [];
  for (int i = 1; i <= input; i++) {
    numberList.add({"number": i});
  }
  return numberList;
}

String toString(int input) {
  return input.toString();
}

int toInteger(String string) {
  return int.parse(string);
}

String firstItemInList(List<String> inputList) {
  return inputList[0];
}

int betterThanPerformance(
  int userPosition,
  int totalUsers,
) {
  if (userPosition <= 0 || totalUsers <= 0) {
    return 0; // Return 0% if the inputs are invalid.
  }

  double percentage = (1 - (userPosition - 1) / (totalUsers - 1)) * 100.0;
  return percentage.round(); // Round to the nearest integer.
}

List<dynamic> defaultJSON() {
  return [
    {
      "user": "5QB86p2xPUQ2AhWf4OgYv1ccV9t2",
      "versesRead": 45,
      "hasanat": 52070,
      "timeReadSec": 2960,
      "path": "quranPerformance/QwTI0MvGzt4RpH8nWdLt",
      "objectID": "QwTI0MvGzt4RpH8nWdLt"
    },
    {
      "user": "FTp8EJ9dN5Nfx6i2oihCfDPiUI92",
      "versesRead": 8,
      "hasanat": 11381,
      "timeReadSec": 443,
      "path": "quranPerformance/O7XoRRn6tWxMAbKkEXx7",
      "objectID": "O7XoRRn6tWxMAbKkEXx7"
    },
    {
      "hasanat": 1230,
      "versesRead": 4,
      "timeReadSec": 34,
      "user": "wgUMcgEtWHgAENcAfr7H2M0nFHf1",
      "path": "quranPerformance/SZh7SgVIBpwkhahVlmjx",
      "objectID": "SZh7SgVIBpwkhahVlmjx"
    }
  ];
}

int positionInPagination(
  int index,
  int pageNum,
  int hitsPerPage,
) {
  return (pageNum - 1) * hitsPerPage + index + 1;
}

int findUserPageInPagination(
  int userRank,
  int totalItems,
  int hitsPerPage,
) {
  // Calculate the current page based on the user's rank.
  int currentPage = ((userRank - 1) ~/ hitsPerPage) + 1;

  if (currentPage > totalItems ~/ hitsPerPage) {
    // If the calculated page is greater than the total number of pages,
    // set it to the last page.
    currentPage = totalItems ~/ hitsPerPage + 1;
  }

  return currentPage;
}

List<String> quranVersesAttributesToRetrieve() {
  List<String> x = ['versesRead', 'user'];
  return x;
}

List<String> quranTimeAttributesToRetrieve() {
  List<String> x = ['timeReadSec', 'user'];
  return x;
}

String getDateRangeForWeekWithIndex(
  int index,
  DateTime currentDate,
) {
  DateTime startOfWeek = currentDate
      .subtract(Duration(days: currentDate.weekday - DateTime.monday));
  DateTime endOfWeek = startOfWeek.add(Duration(days: 6));

  if (index != 0) {
    startOfWeek = startOfWeek.subtract(Duration(days: -index * 7));
    endOfWeek = endOfWeek.subtract(Duration(days: -index * 7));
  }

  DateFormat formatter = DateFormat('MMM d, yyyy');
  String formattedStart = formatter.format(startOfWeek).replaceAll(',', '');
  String formattedEnd = formatter.format(endOfWeek);

  String monthStart = DateFormat('MMM').format(startOfWeek);
  String monthEnd = DateFormat('MMM').format(endOfWeek);

  return '$monthStart ${formattedStart.split(' ')[1]} - $monthEnd ${formattedEnd.split(' ')[1]} ${formattedStart.split(' ')[2]}';
}

int getYearFromDateTime(DateTime dateTime) {
  return dateTime.year;
}

int getMonthFromDateTime(DateTime dateTime) {
  return dateTime.month;
}

String destructureGeoPoint(LatLng geo) {
  return geo.latitude.toString() + "," + geo.longitude.toString();
}

int getDayFromDateTime(DateTime dateTime) {
  return dateTime.day;
}

String getDateWithIndexAndDay(
  DateTime currentDate,
  int index,
  String currentDay,
) {
  // Calculate the start of the week based on the current day
  DateTime startOfWeek = currentDate
      .subtract(Duration(days: currentDate.weekday - DateTime.monday));

  // Adjust the start of the week based on the index
  startOfWeek = startOfWeek.add(Duration(days: index * 7));

  // Find the specified day in the week
  if (currentDay.toLowerCase() == 'monday') {
    startOfWeek = startOfWeek.add(Duration(days: 0));
  } else if (currentDay.toLowerCase() == 'tuesday') {
    startOfWeek = startOfWeek.add(Duration(days: 1));
  } else if (currentDay.toLowerCase() == 'wednesday') {
    startOfWeek = startOfWeek.add(Duration(days: 2));
  } else if (currentDay.toLowerCase() == 'thursday') {
    startOfWeek = startOfWeek.add(Duration(days: 3));
  } else if (currentDay.toLowerCase() == 'friday') {
    startOfWeek = startOfWeek.add(Duration(days: 4));
  } else if (currentDay.toLowerCase() == 'saturday') {
    startOfWeek = startOfWeek.add(Duration(days: 5));
  } else if (currentDay.toLowerCase() == 'sunday') {
    startOfWeek = startOfWeek.add(Duration(days: 6));
  }

  DateFormat formatter = DateFormat('dd-MM-yyyy');
  return formatter.format(startOfWeek);
}

String getDateFromDateTime(
  DateTime dateTime,
  int offset,
) {
  DateTime adjustedDateTime = dateTime.add(Duration(days: offset));
  DateFormat formatter = DateFormat('dd-MM-yyyy');
  return formatter.format(adjustedDateTime);
}

int getUnixTimeWithIndexAndDay(
  int index,
  String currentDay,
  DateTime currentDate,
) {
  // Calculate the start of the week based on the current day
  DateTime startOfWeek = currentDate
      .subtract(Duration(days: currentDate.weekday - DateTime.monday));

  // Adjust the start of the week based on the index
  startOfWeek = startOfWeek.add(Duration(days: index * 7));

  // Define a map to map day names to their corresponding day indices
  Map<String, int> dayIndices = {
    'monday': 0,
    'tuesday': 1,
    'wednesday': 2,
    'thursday': 3,
    'friday': 4,
    'saturday': 5,
    'sunday': 6,
  };

  // Find the specified day in the week, or default to Monday
  int dayOffset = dayIndices[currentDay.toLowerCase()] ?? 0;
  startOfWeek = startOfWeek.add(Duration(days: dayOffset));

  // Set the time to 12:00:00 AM UTC+4
  startOfWeek = DateTime(
    startOfWeek.year,
    startOfWeek.month,
    startOfWeek.day,
    0, // 0:00 hours
    0, // 0 minutes
    0, // 0 seconds
    0, // 0 milliseconds
  );

  // Convert the DateTime to UTC+4 timezone
  startOfWeek = startOfWeek.toUtc().add(Duration(hours: 4));

  return startOfWeek.toUtc().millisecondsSinceEpoch ~/ 1000;
}

bool areDatesEqual(
  DateTime date1,
  DateTime date2,
) {
  final formatter = DateFormat('yyyy-MM-dd');
  final dateString1 = formatter.format(date1);
  final dateString2 = formatter.format(date2);
  return dateString1 == dateString2;
}

List<int> defaultStreak() {
  return [0, 0, 0, 0, 0];
}

int datetimeToUnix(DateTime currentDateTime) {
  // Set the time to 4:00:00 PM UTC+4
  DateTime adjustedDateTime = DateTime(
    currentDateTime.year,
    currentDateTime.month,
    currentDateTime.day,
    16, // 16:00 hours
    0, // 0 minutes
    0, // 0 seconds
    0, // 0 milliseconds
  ).add(Duration(hours: 4)); // Adjust to UTC+4

  // Convert the adjusted DateTime to a Unix timestamp
  int unixTimestamp = adjustedDateTime.toUtc().millisecondsSinceEpoch ~/ 1000;

  return unixTimestamp;
}

String datetimeToDay(DateTime dateTime) {
  DateFormat dateFormat = DateFormat('EEEE');
  return dateFormat.format(dateTime);
}

bool isTimeForPrayer(
  String prayerName,
  DateTime currentDateTime,
  dynamic prayerTimesFirst,
  dynamic prayerTimesSecond,
) {
  if (prayerTimesFirst == null ||
      prayerTimesSecond == null ||
      prayerTimesFirst.isEmpty ||
      prayerTimesSecond.isEmpty) {
    return false; // If prayerTimesFirst or prayerTimesSecond is null or empty, return false
  }

  DateTime prayerTime;
  DateTime nextPrayerTime = DateTime.now();

  prayerTime = DateFormat("H:mm").parse(prayerTimesFirst[prayerName], true);

  switch (prayerName) {
    case 'Fajr':
      nextPrayerTime =
          DateFormat("H:mm").parse(prayerTimesFirst['Sunrise'], true);
      break;
    case 'Dhuhr':
      nextPrayerTime = DateFormat("H:mm").parse(prayerTimesFirst['Asr'], true);
      break;
    case 'Asr':
      nextPrayerTime =
          DateFormat("H:mm").parse(prayerTimesFirst['Maghrib'], true);
      break;
    case 'Maghrib':
      nextPrayerTime = DateFormat("H:mm").parse(prayerTimesFirst['Isha'], true);
      break;
    case 'Isha':
      // Adjust Isha time from the second JSON to the day after currentDateTime
      nextPrayerTime =
          DateFormat("H:mm").parse(prayerTimesSecond['Fajr'], true);
      break;
    default:
      return false;
  }

  DateTime nextPrayerDateTime = DateTime.now();
  DateTime prayerDateTime = DateTime.now();

  if (prayerName == 'Isha') {
    bool isAM = currentDateTime.hour < 12;

    if (isAM) {
      // The current time is in AM
      // Add your logic for AM here
      prayerDateTime = DateTime(
        currentDateTime.year,
        currentDateTime.month,
        currentDateTime.day - 1, // Day before currentDateTime
        nextPrayerTime.hour,
        nextPrayerTime.minute,
      );

      nextPrayerDateTime = DateTime(
        currentDateTime.year,
        currentDateTime.month,
        currentDateTime.day,
        nextPrayerTime.hour,
        nextPrayerTime.minute,
      );
    } else {
      // The current time is in PM

      prayerDateTime = DateTime(
        currentDateTime.year,
        currentDateTime.month,
        currentDateTime.day,
        prayerTime.hour,
        prayerTime.minute,
      );

      nextPrayerDateTime = DateTime(
        currentDateTime.year,
        currentDateTime.month,
        currentDateTime.day + 1, // Day after currentDateTime
        nextPrayerTime.hour,
        nextPrayerTime.minute,
      );
    }
  } else {
    // not isha

    prayerDateTime = DateTime(
      currentDateTime.year,
      currentDateTime.month,
      currentDateTime.day,
      prayerTime.hour,
      prayerTime.minute,
    );

    nextPrayerDateTime = DateTime(
      currentDateTime.year,
      currentDateTime.month,
      currentDateTime.day,
      nextPrayerTime.hour,
      nextPrayerTime.minute,
    );
  }

  return currentDateTime.isAfter(prayerDateTime) &&
      currentDateTime.isBefore(nextPrayerDateTime);
  // return nextPrayerDateTime;
}

dynamic defaultPrayerTimes() {
  return {
    "Fajr": "05:14",
    "Sunrise": "06:32",
    "Dhuhr": "12:08",
    "Asr": "15:17",
    "Sunset": "17:41",
    "Maghrib": "17:41",
    "Isha": "18:57",
    "Imsak": "05:04",
    "Midnight": "00:05",
    "Firstthird": "21:56",
    "Lastthird": "02:14"
  };
}

String calculateNextPrayer(
  DateTime currentDateTime,
  dynamic prayerTimesFirst,
  dynamic prayerTimesSecond,
) {
  if (prayerTimesFirst == null ||
      prayerTimesSecond == null ||
      prayerTimesFirst.isEmpty ||
      prayerTimesSecond.isEmpty) {
    return "";
  }

  List<String> prayerNames = [
    "Fajr",
    "Dhuhr",
    "Asr",
    "Maghrib",
    "Isha",
  ];

  String activePrayer = '';
  String nextPrayer = '';
  DateTime activePrayerTime = DateTime.now();
  DateTime nextPrayerTime = DateTime.now();

  for (String prayerName in prayerNames) {
    bool isTimeForPrayerResult = isTimeForPrayer(
      prayerName,
      currentDateTime,
      prayerTimesFirst,
      prayerTimesSecond,
    );

    if (isTimeForPrayerResult) {
      activePrayer = prayerName;

      // Get the next prayer time after the active prayer
      switch (activePrayer) {
        case 'Fajr':
          nextPrayerTime =
              DateFormat("H:mm").parse(prayerTimesFirst['Sunrise'], true);
          nextPrayer = 'Sunrise';
          break;
        case 'Dhuhr':
          nextPrayerTime =
              DateFormat("H:mm").parse(prayerTimesFirst['Asr'], true);
          nextPrayer = 'Asr';
          break;
        case 'Asr':
          nextPrayerTime =
              DateFormat("H:mm").parse(prayerTimesFirst['Maghrib'], true);
          nextPrayer = 'Maghrib';
          break;
        case 'Maghrib':
          nextPrayerTime =
              DateFormat("H:mm").parse(prayerTimesFirst['Isha'], true);
          nextPrayer = 'Isha';
          break;
        case 'Isha':
          nextPrayerTime =
              DateFormat("H:mm").parse(prayerTimesSecond['Fajr'], true);
          nextPrayer = 'Fajr';
          break;
        default:
          return "";
      }
      break;
    }
  }

  if (activePrayer == 'Isha') {
    bool isAM = currentDateTime.hour < 12;

    if (isAM) {
      // The current time is in AM
      // Add your logic for AM here

      nextPrayerTime = DateTime(
        currentDateTime.year,
        currentDateTime.month,
        currentDateTime.day,
        nextPrayerTime.hour,
        nextPrayerTime.minute,
      );
    } else {
      // The current time is in PM

      nextPrayerTime = DateTime(
        currentDateTime.year,
        currentDateTime.month,
        currentDateTime.day + 1, // Day after currentDateTime
        nextPrayerTime.hour,
        nextPrayerTime.minute,
      );
    }
  } else {
    // not isha

    nextPrayerTime = DateTime(
      currentDateTime.year,
      currentDateTime.month,
      currentDateTime.day,
      nextPrayerTime.hour,
      nextPrayerTime.minute,
    );
  }

  Duration timeUntilNextPrayer = nextPrayerTime.difference(currentDateTime);
  String formattedTimeUntilNextPrayer =
      "${timeUntilNextPrayer.inHours}:${(timeUntilNextPrayer.inMinutes % 60).toString().padLeft(2, '0')}:${(timeUntilNextPrayer.inSeconds % 60).toString().padLeft(2, '0')}";

  return "$nextPrayer in $formattedTimeUntilNextPrayer";
}

String extractFirstWord(String text) {
  RegExp wordRegExp = RegExp(r"(\w+)");
  Match? match = wordRegExp.firstMatch(text);

  if (match != null) {
    return match.group(0) ?? ""; // Use null-aware operator
  } else {
    return "";
  }
}

bool checkIfPreviousDay(
  int firstUnixTimestamp,
  int secondUnixTimestamp,
) {
// Convert Unix timestamps to DateTime objects
  DateTime firstDateTime = DateTime.fromMillisecondsSinceEpoch(
      firstUnixTimestamp * 1000,
      isUtc: true);
  DateTime secondDateTime = DateTime.fromMillisecondsSinceEpoch(
      secondUnixTimestamp * 1000,
      isUtc: true);

  // Ensure both DateTime objects have their time set to 12:00:00 AM UTC+4
  DateTime adjustedFirstDateTime = DateTime(
    firstDateTime.year,
    firstDateTime.month,
    firstDateTime.day,
    0, // 12:00 AM
    0,
    0,
    0,
  ).add(Duration(hours: 4)); // Adjust to UTC+4

  DateTime adjustedSecondDateTime = DateTime(
    secondDateTime.year,
    secondDateTime.month,
    secondDateTime.day,
    0, // 12:00 AM
    0,
    0,
    0,
  ).add(Duration(hours: 4)); // Adjust to UTC+4

  // Compare the days
  return adjustedFirstDateTime.isBefore(adjustedSecondDateTime) &&
      adjustedFirstDateTime.day + 1 == adjustedSecondDateTime.day;
}

String formatDate(DateTime dateTime) {
  const List<String> monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  return '${monthNames[dateTime.month - 1]} ${dateTime.day}, ${dateTime.year}';
}

bool isPrayerCompleted(
  List<dynamic> jsonList,
  int currentDay,
  String prayerName,
) {
  // Find the item in the JSON list with the matching currentDay
  final prayerItem = jsonList.firstWhere(
    (item) => item?['day'] == currentDay,
    orElse: () => false,
  );

  // If the item is found, check if the specified prayer is true
  return prayerItem != false && prayerItem[prayerName] == true;
}

int getDayOfMonth(
  int monthIndex,
  int week,
  String day,
  DateTime currentDateTime,
) {
  // Define a map to map day names to their corresponding day indices
  Map<String, int> dayIndices = {
    'sunday': DateTime.sunday,
    'monday': DateTime.monday,
    'tuesday': DateTime.tuesday,
    'wednesday': DateTime.wednesday,
    'thursday': DateTime.thursday,
    'friday': DateTime.friday,
    'saturday': DateTime.saturday,
  };

  // Find the specified day in the week or default to Monday
  int dayIndex = dayIndices[day.toLowerCase()] ?? DateTime.monday;

  // Calculate the start of the month based on the current date
  DateTime startOfMonth =
      DateTime(currentDateTime.year, currentDateTime.month, 1);

  // Adjust for negative monthIndex values
  if (monthIndex < 0) {
    int absMonthIndex = monthIndex.abs();

    // Determine the number of days in the previous month
    int daysInPreviousMonth =
        DateTime(currentDateTime.year, currentDateTime.month + monthIndex, 0)
            .day;

    startOfMonth = startOfMonth.subtract(Duration(days: startOfMonth.day - 1));
    startOfMonth = startOfMonth
        .subtract(Duration(days: daysInPreviousMonth * absMonthIndex));
  }

  // Move to the specified week and day
  DateTime startOfWeek = startOfMonth
      .subtract(Duration(days: startOfMonth.weekday - dayIndex))
      .add(Duration(days: 7 * (week - 1)));

  // Ensure the calculated date is within the specified month and week
  if (startOfWeek.month != (currentDateTime.month + monthIndex - 1) % 12 + 1) {
    return -1;
  }

  // Return the day of the month
  return startOfWeek.day;
}

int getUnixTimeFromMonthIndexAndDay(
  int day,
  int monthIndex,
  DateTime currentDateTime,
) {
  if (day == -1) {
    return 0;
  }

  // Calculate the start of the month based on the current date
  DateTime startOfMonth = DateTime(
      currentDateTime.year, currentDateTime.month + monthIndex, 1, 0, 0, 0);

  // Adjust for negative monthIndex values
  if (monthIndex < 0) {
    int absMonthIndex = monthIndex.abs();

    // Determine the number of days in the previous month
    int daysInPreviousMonth =
        DateTime(currentDateTime.year, currentDateTime.month + monthIndex, 0)
            .day;

    startOfMonth = startOfMonth.subtract(Duration(days: startOfMonth.day - 1));
    startOfMonth = startOfMonth
        .subtract(Duration(days: daysInPreviousMonth * absMonthIndex));
  }

  // Calculate the timestamp at 12:00:00 AM UTC+4 for the specified day
  DateTime timestamp =
      DateTime(startOfMonth.year, startOfMonth.month, day, 0, 0, 0, 0)
          .add(Duration(hours: 4));

  // Return the Unix timestamp in seconds
  return timestamp.toUtc().millisecondsSinceEpoch ~/ 1000;
}

double calculateDayPrayerPerf(
  bool? fajr,
  bool? duhr,
  bool? asr,
  bool? maghrib,
  bool? isha,
) {
  int counter = 0;
  if (fajr != null && fajr == true) {
    if (fajr == true) {
      counter++;
    }
  }
  if (duhr != null && duhr == true) {
    if (duhr == true) {
      counter++;
    }
  }
  if (asr != null && asr == true) {
    if (asr == true) {
      counter++;
    }
  }
  if (maghrib != null && maghrib == true) {
    if (maghrib == true) {
      counter++;
    }
  }
  if (isha != null && isha == true) {
    if (isha == true) {
      counter++;
    }
  }

  double performance = (counter / 5.0); // Calculate the performance as a ratio

  return performance;
}

String getDateRangeForMonthWithIndex(
  int index,
  DateTime currentDate,
) {
  DateTime targetDate = currentDate.add(Duration(days: index * 30));
  int daysInMonth = DateTime(targetDate.year, targetDate.month + 1, 0).day;

  // Handle leap year
  if (targetDate.month == 2 && DateTime(targetDate.year, 2, 29).day == 29) {
    daysInMonth = 29;
  }

  targetDate = currentDate.add(Duration(days: index * daysInMonth));

  String formattedMonth = DateFormat('MMMM yyyy').format(targetDate);
  return formattedMonth;
}

int getDateRangeForYearWithIndex(
  int index,
  DateTime currentDate,
) {
  int targetYear = currentDate.year + index;
  return targetYear;
}

int getUnixTimestampForFirstDay(
  int year,
  int month,
) {
  DateTime firstDayOfMonth =
      DateTime.utc(year, month!, 1, 0, 0, 0).add(Duration(hours: 4));
  int timestamp = firstDayOfMonth.millisecondsSinceEpoch ~/ 1000;
  return timestamp;
}

int getUnixTimestampForLastDay(
  int year,
  int month,
) {
  DateTime lastDayOfMonth = DateTime.utc(year, month + 1, 1, 0, 0, 0)
      .subtract(Duration(seconds: 1))
      .add(Duration(hours: 4));
  int timestamp = lastDayOfMonth.millisecondsSinceEpoch ~/ 1000;
  return timestamp;
}

double calculateMonthPrayerPerf(
  int year,
  int month,
  List<PrayerPerformanceRecord> documents,
) {
  int counter = 0;
  int numOfDays = DateTime(year, month + 1, 0).day;

  for (var doc in documents) {
    int docMonth = DateTime.fromMillisecondsSinceEpoch(doc.day * 1000).month;
    int docYear = DateTime.fromMillisecondsSinceEpoch(doc.day * 1000).year;

    if (docMonth == month && docYear == year) {
      if (doc.hasFajr()) {
        if (doc.fajr == true) {
          counter++;
        }
      }
      if (doc.hasDuhr()) {
        if (doc.duhr == true) {
          counter++;
        }
      }

      if (doc.hasAsr()) {
        if (doc.asr == true) {
          counter++;
        }
      }

      if (doc.hasMaghrib()) {
        if (doc.maghrib == true) {
          counter++;
        }
      }

      if (doc.hasIsha()) {
        if (doc.isha == true) {
          counter++;
        }
      }
    }
  }

  return counter / (5 * numOfDays);
}

dynamic azkarJSON() {
  return {
    "أذكار الصباح": [
      [
        {
          "category": "أذكار الصباح",
          "count": "1",
          "description": "",
          "reference": "",
          "content":
              "أَصْـبَحْنا وَأَصْـبَحَ المُـلْكُ لله وَالحَمدُ لله ، لا إلهَ إلاّ اللّهُ وَحدَهُ لا شَريكَ لهُ، لهُ المُـلكُ ولهُ الحَمْـد، وهُوَ على كلّ شَيءٍ قدير"
        },
        {
          "category": "أذكار الصباح",
          "count": "1",
          "description":
              "من قالها موقنا بها حين يمسى ومات من ليلته دخل الجنة وكذلك حين يصبح.",
          "reference": "",
          "content":
              "اللّهـمَّ أَنْتَ رَبِّـي لا إلهَ إلاّ أَنْتَ ، خَلَقْتَنـي وَأَنا عَبْـدُك ، وَأَنا عَلـى عَهْـدِكَ وَوَعْـدِكَ ما اسْتَـطَعْـت ، أَعـوذُبِكَ مِنْ شَـرِّ ما صَنَـعْت ، أَبـوءُ لَـكَ بِنِعْـمَتِـكَ عَلَـيَّ وَأَبـوءُ بِذَنْـبي فَاغْفـِرْ لي فَإِنَّـهُ لا يَغْـفِرُ الذُّنـوبَ إِلاّ أَنْتَ ."
        },
        {
          "category": "أذكار الصباح",
          "count": "3",
          "description":
              "من قالها حين يصبح وحين يمسى كان حقا على الله أن يرضيه يوم القيامة.",
          "reference": "",
          "content":
              "رَضيـتُ بِاللهِ رَبَّـاً وَبِالإسْلامِ ديـناً وَبِمُحَـمَّدٍ صلى الله عليه وسلم نَبِيّـاً. "
        },
        {
          "category": "أذكار الصباح",
          "count": "4",
          "description": "من قالها أعتقه الله من النار.",
          "reference": "",
          "content":
              "اللّهُـمَّ إِنِّـي أَصْبَـحْتُ أُشْـهِدُك ، وَأُشْـهِدُ حَمَلَـةَ عَـرْشِـك ، وَمَلَائِكَتَكَ ، وَجَمـيعَ خَلْـقِك ، أَنَّـكَ أَنْـتَ اللهُ لا إلهَ إلاّ أَنْـتَ وَحْـدَكَ لا شَريكَ لَـك ، وَأَنَّ ُ مُحَمّـداً عَبْـدُكَ وَرَسـولُـك."
        }
      ],
      {
        "category": "أذكار الصباح",
        "count": "7",
        "description": "من قالها كفاه الله ما أهمه من أمر الدنيا والأخرة.",
        "reference": "",
        "content":
            "حَسْبِـيَ اللّهُ لا إلهَ إلاّ هُوَ عَلَـيهِ تَوَكَّـلتُ وَهُوَ رَبُّ العَرْشِ العَظـيم."
      },
      {
        "category": "أذكار الصباح",
        "count": "3",
        "description": "لم يضره من الله شيء.",
        "reference": "",
        "content":
            "بِسـمِ اللهِ الذي لا يَضُـرُّ مَعَ اسمِـهِ شَيءٌ في الأرْضِ وَلا في السّمـاءِ وَهـوَ السّمـيعُ العَلـيم."
      },
      {
        "category": "أذكار الصباح",
        "count": "1",
        "description": "",
        "reference": "",
        "content":
            "اللّهُـمَّ بِكَ أَصْـبَحْنا وَبِكَ أَمْسَـينا ، وَبِكَ نَحْـيا وَبِكَ نَمُـوتُ وَإِلَـيْكَ النُّـشُور."
      },
      {
        "category": "أذكار الصباح",
        "count": "1",
        "description": "",
        "reference": "",
        "content":
            "أَصْبَـحْـنا عَلَى فِطْرَةِ الإسْلاَمِ، وَعَلَى كَلِمَةِ الإِخْلاَصِ، وَعَلَى دِينِ نَبِيِّنَا مُحَمَّدٍ صَلَّى اللهُ عَلَيْهِ وَسَلَّمَ، وَعَلَى مِلَّةِ أَبِينَا إبْرَاهِيمَ حَنِيفاً مُسْلِماً وَمَا كَانَ مِنَ المُشْرِكِينَ."
      },
      {
        "category": "أذكار الصباح",
        "count": "3",
        "description": "",
        "reference": "",
        "content":
            "سُبْحـانَ اللهِ وَبِحَمْـدِهِ عَدَدَ خَلْـقِه ، وَرِضـا نَفْسِـه ، وَزِنَـةَ عَـرْشِـه ، وَمِـدادَ كَلِمـاتِـه."
      },
      {
        "category": "أذكار الصباح",
        "count": "3",
        "description": "",
        "reference": "",
        "content":
            "اللّهُـمَّ عافِـني في بَدَنـي ، اللّهُـمَّ عافِـني في سَمْـعي ، اللّهُـمَّ عافِـني في بَصَـري ، لا إلهَ إلاّ أَنْـتَ."
      },
      {
        "category": "أذكار الصباح",
        "count": "3",
        "description": "",
        "reference": "",
        "content":
            "اللّهُـمَّ إِنّـي أَعـوذُ بِكَ مِنَ الْكُـفر ، وَالفَـقْر ، وَأَعـوذُ بِكَ مِنْ عَذابِ القَـبْر ، لا إلهَ إلاّ أَنْـتَ."
      },
      {
        "category": "أذكار الصباح",
        "count": "1",
        "description": "",
        "reference": "",
        "content":
            "اللّهُـمَّ إِنِّـي أسْـأَلُـكَ العَـفْوَ وَالعـافِـيةَ في الدُّنْـيا وَالآخِـرَة ، اللّهُـمَّ إِنِّـي أسْـأَلُـكَ العَـفْوَ وَالعـافِـيةَ في ديني وَدُنْـيايَ وَأهْـلي وَمالـي ، اللّهُـمَّ اسْتُـرْ عـوْراتي وَآمِـنْ رَوْعاتـي ، اللّهُـمَّ احْفَظْـني مِن بَـينِ يَدَيَّ وَمِن خَلْفـي وَعَن يَمـيني وَعَن شِمـالي ، وَمِن فَوْقـي ، وَأَعـوذُ بِعَظَمَـتِكَ أَن أُغْـتالَ مِن تَحْتـي."
      },
      {
        "category": "أذكار الصباح",
        "count": "3",
        "description": "",
        "reference": "",
        "content":
            "يَا حَيُّ يَا قيُّومُ بِرَحْمَتِكَ أسْتَغِيثُ أصْلِحْ لِي شَأنِي كُلَّهُ وَلاَ تَكِلْنِي إلَى نَفْسِي طَـرْفَةَ عَيْنٍ."
      },
      {
        "category": "أذكار الصباح",
        "count": "1",
        "description": "",
        "reference": "",
        "content":
            "أَصْبَـحْـنا وَأَصْبَـحْ المُـلكُ للهِ رَبِّ العـالَمـين ، اللّهُـمَّ إِنِّـي أسْـأَلُـكَ خَـيْرَ هـذا الـيَوْم ، فَـتْحَهُ ، وَنَصْـرَهُ ، وَنـورَهُ وَبَـرَكَتَـهُ ، وَهُـداهُ ، وَأَعـوذُ بِـكَ مِـنْ شَـرِّ ما فـيهِ وَشَـرِّ ما بَعْـدَه."
      },
      {
        "category": "أذكار الصباح",
        "count": "1",
        "description": "",
        "reference": "",
        "content":
            "اللّهُـمَّ عالِـمَ الغَـيْبِ وَالشّـهادَةِ فاطِـرَ السّماواتِ وَالأرْضِ رَبَّ كـلِّ شَـيءٍ وَمَليـكَه ، أَشْهَـدُ أَنْ لا إِلـهَ إِلاّ أَنْت ، أَعـوذُ بِكَ مِن شَـرِّ نَفْسـي وَمِن شَـرِّ الشَّيْـطانِ وَشِرْكِهِ ، وَأَنْ أَقْتَـرِفَ عَلـى نَفْسـي سوءاً أَوْ أَجُـرَّهُ إِلـى مُسْـلِم."
      },
      {
        "category": "stop",
        "count": "stop",
        "description": "stpo",
        "reference": "stop",
        "content": "stop"
      },
      {
        "category": "أذكار الصباح",
        "count": "3",
        "description": "",
        "reference": "",
        "content":
            "أَعـوذُ بِكَلِمـاتِ اللّهِ التّـامّـاتِ مِنْ شَـرِّ ما خَلَـق."
      },
      {
        "category": "أذكار الصباح",
        "count": "10",
        "description":
            "من صلى على حين يصبح وحين يمسى ادركته شفاعتى يوم القيامة.",
        "reference": "",
        "content":
            "اللَّهُمَّ صَلِّ وَسَلِّمْ وَبَارِكْ على نَبِيِّنَا مُحمَّد."
      },
      {
        "category": "أذكار الصباح",
        "count": "3",
        "description": "",
        "reference": "",
        "content":
            "اللَّهُمَّ إِنَّا نَعُوذُ بِكَ مِنْ أَنْ نُشْرِكَ بِكَ شَيْئًا نَعْلَمُهُ ، وَنَسْتَغْفِرُكَ لِمَا لَا نَعْلَمُهُ."
      },
      {
        "category": "أذكار الصباح",
        "count": "3",
        "description": "",
        "reference": "",
        "content":
            "اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنْ الْهَمِّ وَالْحَزَنِ، وَأَعُوذُ بِكَ مِنْ الْعَجْزِ وَالْكَسَلِ، وَأَعُوذُ بِكَ مِنْ الْجُبْنِ وَالْبُخْلِ، وَأَعُوذُ بِكَ مِنْ غَلَبَةِ الدَّيْنِ، وَقَهْرِ الرِّجَالِ."
      },
      {
        "category": "أذكار الصباح",
        "count": "3",
        "description": "",
        "reference": "",
        "content":
            "أسْتَغْفِرُ اللهَ العَظِيمَ الَّذِي لاَ إلَهَ إلاَّ هُوَ، الحَيُّ القَيُّومُ، وَأتُوبُ إلَيهِ."
      },
      {
        "category": "أذكار الصباح",
        "count": "3",
        "description": "",
        "reference": "",
        "content":
            "يَا رَبِّ , لَكَ الْحَمْدُ كَمَا يَنْبَغِي لِجَلَالِ وَجْهِكَ , وَلِعَظِيمِ سُلْطَانِكَ."
      },
      {
        "category": "أذكار الصباح",
        "count": "1",
        "description": "",
        "reference": "",
        "content":
            "اللَّهُمَّ إِنِّي أَسْأَلُكَ عِلْمًا نَافِعًا، وَرِزْقًا طَيِّبًا، وَعَمَلًا مُتَقَبَّلًا."
      },
      {
        "category": "أذكار الصباح",
        "count": "100",
        "description":
            "كانت له عدل عشر رقاب، وكتبت له مئة حسنة، ومحيت عنه مئة سيئة، وكانت له حرزا من الشيطان.",
        "reference": "",
        "content":
            "لَا إلَه إلّا اللهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءِ قَدِيرِ."
      },
      {
        "category": "أذكار الصباح",
        "count": "100",
        "description":
            "حُطَّتْ خَطَايَاهُ وَإِنْ كَانَتْ مِثْلَ زَبَدِ الْبَحْرِ. لَمْ يَأْتِ أَحَدٌ يَوْمَ الْقِيَامَةِ بِأَفْضَلَ مِمَّا جَاءَ بِهِ إِلَّا أَحَدٌ قَالَ مِثْلَ مَا قَالَ أَوْ زَادَ عَلَيْهِ.",
        "reference": "",
        "content": "سُبْحـانَ اللهِ وَبِحَمْـدِهِ."
      },
      {
        "category": "أذكار الصباح",
        "count": "100",
        "description":
            "مائة حسنة، ومُحيت عنه مائة سيئة، وكانت له حرزاً من الشيطان حتى يمسى.",
        "reference": "",
        "content": "أسْتَغْفِرُ اللهَ وَأتُوبُ إلَيْهِ"
      }
    ],
    "أذكار المساء": [
      {
        "category": "أذكار المساء",
        "count": "01",
        "description": "",
        "reference": "",
        "content":
            "أَمْسَيْـنا وَأَمْسـى المـلكُ لله وَالحَمدُ لله ، لا إلهَ إلاّ اللّهُ وَحدَهُ لا شَريكَ لهُ، لهُ المُـلكُ ولهُ الحَمْـد، وهُوَ على كلّ شَيءٍ قدير ، رَبِّ أسْـأَلُـكَ خَـيرَ ما في هـذهِ اللَّـيْلَةِ وَخَـيرَ ما بَعْـدَهـا ، وَأَعـوذُ بِكَ مِنْ شَـرِّ ما في هـذهِ اللَّـيْلةِ وَشَرِّ ما بَعْـدَهـا ، رَبِّ أَعـوذُبِكَ مِنَ الْكَسَـلِ وَسـوءِ الْكِـبَر ، رَبِّ أَعـوذُ بِكَ مِنْ عَـذابٍ في النّـارِ وَعَـذابٍ في القَـبْر."
      },
      {
        "category": "أذكار المساء",
        "count": "01",
        "description":
            "من قالها موقنا بها حين يمسى ومات من ليلته دخل الجنة وكذلك حين يصبح.",
        "reference": "",
        "content":
            "اللّهـمَّ أَنْتَ رَبِّـي لا إلهَ إلاّ أَنْتَ ، خَلَقْتَنـي وَأَنا عَبْـدُك ، وَأَنا عَلـى عَهْـدِكَ وَوَعْـدِكَ ما اسْتَـطَعْـت ، أَعـوذُبِكَ مِنْ شَـرِّ ما صَنَـعْت ، أَبـوءُ لَـكَ بِنِعْـمَتِـكَ عَلَـيَّ وَأَبـوءُ بِذَنْـبي فَاغْفـِرْ لي فَإِنَّـهُ لا يَغْـفِرُ الذُّنـوبَ إِلاّ أَنْتَ ."
      },
      {
        "category": "أذكار المساء",
        "count": "03",
        "description":
            "من قالها حين يصبح وحين يمسى كان حقا على الله أن يرضيه يوم القيامة.",
        "reference": "",
        "content":
            "رَضيـتُ بِاللهِ رَبَّـاً وَبِالإسْلامِ ديـناً وَبِمُحَـمَّدٍ صلى الله عليه وسلم نَبِيّـاً."
      },
      {
        "category": "أذكار المساء",
        "count": "04",
        "description": "من قالها أعتقه الله من النار.",
        "reference": "",
        "content":
            "اللّهُـمَّ إِنِّـي أَمسيتُ أُشْـهِدُك ، وَأُشْـهِدُ حَمَلَـةَ عَـرْشِـك ، وَمَلَائِكَتَكَ ، وَجَمـيعَ خَلْـقِك ، أَنَّـكَ أَنْـتَ اللهُ لا إلهَ إلاّ أَنْـتَ وَحْـدَكَ لا شَريكَ لَـك ، وَأَنَّ ُ مُحَمّـداً عَبْـدُكَ وَرَسـولُـك."
      },
      {
        "category": "أذكار المساء",
        "count": "01",
        "description": "من قالها حين يمسى أدى شكر يومه.",
        "reference": "",
        "content":
            "اللّهُـمَّ ما أَمسى بي مِـنْ نِعْـمَةٍ أَو بِأَحَـدٍ مِـنْ خَلْـقِك ، فَمِـنْكَ وَحْـدَكَ لا شريكَ لَـك ، فَلَـكَ الْحَمْـدُ وَلَـكَ الشُّكْـر."
      },
      {
        "category": "أذكار المساء",
        "count": "07",
        "description": "من قالها كفاه الله ما أهمه من أمر الدنيا والأخرة.",
        "reference": "",
        "content":
            "حَسْبِـيَ اللّهُ لا إلهَ إلاّ هُوَ عَلَـيهِ تَوَكَّـلتُ وَهُوَ رَبُّ العَرْشِ العَظـيم."
      },
      {
        "category": "أذكار المساء",
        "count": "03",
        "description": "لم يضره من الله شيء.",
        "reference": "",
        "content":
            "بِسـمِ اللهِ الذي لا يَضُـرُّ مَعَ اسمِـهِ شَيءٌ في الأرْضِ وَلا في السّمـاءِ وَهـوَ السّمـيعُ العَلـيم."
      },
      {
        "category": "أذكار المساء",
        "count": "01",
        "description": "",
        "reference": "",
        "content":
            "اللّهُـمَّ بِكَ أَمْسَـينا وَبِكَ أَصْـبَحْنا، وَبِكَ نَحْـيا وَبِكَ نَمُـوتُ وَإِلَـيْكَ الْمَصِيرُ."
      },
      {
        "category": "أذكار المساء",
        "count": "01",
        "description": "",
        "reference": "",
        "content":
            "أَمْسَيْنَا عَلَى فِطْرَةِ الإسْلاَمِ، وَعَلَى كَلِمَةِ الإِخْلاَصِ، وَعَلَى دِينِ نَبِيِّنَا مُحَمَّدٍ صَلَّى اللهُ عَلَيْهِ وَسَلَّمَ، وَعَلَى مِلَّةِ أَبِينَا إبْرَاهِيمَ حَنِيفاً مُسْلِماً وَمَا كَانَ مِنَ المُشْرِكِينَ."
      },
      {
        "category": "أذكار المساء",
        "count": "03",
        "description": "",
        "reference": "",
        "content":
            "سُبْحـانَ اللهِ وَبِحَمْـدِهِ عَدَدَ خَلْـقِه ، وَرِضـا نَفْسِـه ، وَزِنَـةَ عَـرْشِـه ، وَمِـدادَ كَلِمـاتِـه."
      },
      {
        "category": "أذكار المساء",
        "count": "03",
        "description": "",
        "reference": "",
        "content":
            "اللّهُـمَّ عافِـني في بَدَنـي ، اللّهُـمَّ عافِـني في سَمْـعي ، اللّهُـمَّ عافِـني في بَصَـري ، لا إلهَ إلاّ أَنْـتَ."
      },
      {
        "category": "أذكار المساء",
        "count": "03",
        "description": "",
        "reference": "",
        "content":
            "اللّهُـمَّ إِنّـي أَعـوذُ بِكَ مِنَ الْكُـفر ، وَالفَـقْر ، وَأَعـوذُ بِكَ مِنْ عَذابِ القَـبْر ، لا إلهَ إلاّ أَنْـتَ."
      },
      {
        "category": "أذكار المساء",
        "count": "01",
        "description": "",
        "reference": "",
        "content":
            "اللّهُـمَّ إِنِّـي أسْـأَلُـكَ العَـفْوَ وَالعـافِـيةَ في الدُّنْـيا وَالآخِـرَة ، اللّهُـمَّ إِنِّـي أسْـأَلُـكَ العَـفْوَ وَالعـافِـيةَ في ديني وَدُنْـيايَ وَأهْـلي وَمالـي ، اللّهُـمَّ اسْتُـرْ عـوْراتي وَآمِـنْ رَوْعاتـي ، اللّهُـمَّ احْفَظْـني مِن بَـينِ يَدَيَّ وَمِن خَلْفـي وَعَن يَمـيني وَعَن شِمـالي ، وَمِن فَوْقـي ، وَأَعـوذُ بِعَظَمَـتِكَ أَن أُغْـتالَ مِن تَحْتـي."
      },
      {
        "category": "أذكار المساء",
        "count": "03",
        "description": "",
        "reference": "",
        "content":
            "يَا حَيُّ يَا قيُّومُ بِرَحْمَتِكَ أسْتَغِيثُ أصْلِحْ لِي شَأنِي كُلَّهُ وَلاَ تَكِلْنِي إلَى نَفْسِي طَـرْفَةَ عَيْنٍ."
      },
      {
        "category": "أذكار المساء",
        "count": "01",
        "description": "",
        "reference": "",
        "content":
            "أَمْسَيْنا وَأَمْسَى الْمُلْكُ للهِ رَبِّ الْعَالَمَيْنِ، اللَّهُمَّ إِنَّي أسْأَلُكَ خَيْرَ هَذَه اللَّيْلَةِ فَتْحَهَا ونَصْرَهَا، ونُوْرَهَا وبَرَكَتهَا، وَهُدَاهَا، وَأَعُوذُ بِكَ مِنْ شَرِّ مَا فيهِا وَشَرَّ مَا بَعْدَهَا."
      },
      {
        "category": "أذكار المساء",
        "count": "01",
        "description": "",
        "reference": "",
        "content":
            "اللّهُـمَّ عالِـمَ الغَـيْبِ وَالشّـهادَةِ فاطِـرَ السّماواتِ وَالأرْضِ رَبَّ كـلِّ شَـيءٍ وَمَليـكَه ، أَشْهَـدُ أَنْ لا إِلـهَ إِلاّ أَنْت ، أَعـوذُ بِكَ مِن شَـرِّ نَفْسـي وَمِن شَـرِّ الشَّيْـطانِ وَشِرْكِهِ ، وَأَنْ أَقْتَـرِفَ عَلـى نَفْسـي سوءاً أَوْ أَجُـرَّهُ إِلـى مُسْـلِم."
      },
      {
        "category": "أذكار المساء",
        "count": "03",
        "description": "",
        "reference": "",
        "content":
            "أَعـوذُ بِكَلِمـاتِ اللّهِ التّـامّـاتِ مِنْ شَـرِّ ما خَلَـق."
      },
      {
        "category": "أذكار المساء",
        "count": "10",
        "description":
            "من صلى على حين يصبح وحين يمسى ادركته شفاعتى يوم القيامة.",
        "reference": "",
        "content":
            "اللَّهُمَّ صَلِّ وَسَلِّمْ وَبَارِكْ على نَبِيِّنَا مُحمَّد."
      },
      {
        "category": "أذكار المساء",
        "count": "03",
        "description": "",
        "reference": "",
        "content":
            "اللَّهُمَّ إِنَّا نَعُوذُ بِكَ مِنْ أَنْ نُشْرِكَ بِكَ شَيْئًا نَعْلَمُهُ ، وَنَسْتَغْفِرُكَ لِمَا لَا نَعْلَمُهُ."
      },
      {
        "category": "أذكار المساء",
        "count": "03",
        "description": "",
        "reference": "",
        "content":
            "اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنْ الْهَمِّ وَالْحَزَنِ، وَأَعُوذُ بِكَ مِنْ الْعَجْزِ وَالْكَسَلِ، وَأَعُوذُ بِكَ مِنْ الْجُبْنِ وَالْبُخْلِ، وَأَعُوذُ بِكَ مِنْ غَلَبَةِ الدَّيْنِ، وَقَهْرِ الرِّجَالِ."
      },
      {
        "category": "أذكار المساء",
        "count": "03",
        "description": "",
        "reference": "",
        "content":
            "أسْتَغْفِرُ اللهَ العَظِيمَ الَّذِي لاَ إلَهَ إلاَّ هُوَ، الحَيُّ القَيُّومُ، وَأتُوبُ إلَيهِ."
      },
      {
        "category": "أذكار المساء",
        "count": "03",
        "description": "",
        "reference": "",
        "content":
            "يَا رَبِّ , لَكَ الْحَمْدُ كَمَا يَنْبَغِي لِجَلَالِ وَجْهِكَ , وَلِعَظِيمِ سُلْطَانِكَ."
      },
      {
        "category": "أذكار المساء",
        "count": "100",
        "description":
            "كانت له عدل عشر رقاب، وكتبت له مئة حسنة، ومحيت عنه مئة سيئة، وكانت له حرزا من الشيطان.",
        "reference": "",
        "content":
            "لَا إلَه إلّا اللهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءِ قَدِيرِ."
      },
      {
        "category": "أذكار المساء",
        "count": "01",
        "description": "",
        "reference": "",
        "content":
            "اللَّهُمَّ أَنْتَ رَبِّي لا إِلَهَ إِلا أَنْتَ ، عَلَيْكَ تَوَكَّلْتُ ، وَأَنْتَ رَبُّ الْعَرْشِ الْعَظِيمِ , مَا شَاءَ اللَّهُ كَانَ ، وَمَا لَمْ يَشَأْ لَمْ يَكُنْ ، وَلا حَوْلَ وَلا قُوَّةَ إِلا بِاللَّهِ الْعَلِيِّ الْعَظِيمِ , أَعْلَمُ أَنَّ اللَّهَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ ، وَأَنَّ اللَّهَ قَدْ أَحَاطَ بِكُلِّ شَيْءٍ عِلْمًا , اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنْ شَرِّ نَفْسِي ، وَمِنْ شَرِّ كُلِّ دَابَّةٍ أَنْتَ آخِذٌ بِنَاصِيَتِهَا ، إِنَّ رَبِّي عَلَى صِرَاطٍ مُسْتَقِيمٍ."
      },
      {
        "category": "أذكار المساء",
        "count": "100",
        "description":
            "حُطَّتْ خَطَايَاهُ وَإِنْ كَانَتْ مِثْلَ زَبَدِ الْبَحْرِ. لَمْ يَأْتِ أَحَدٌ يَوْمَ الْقِيَامَةِ بِأَفْضَلَ مِمَّا جَاءَ بِهِ إِلَّا أَحَدٌ قَالَ مِثْلَ مَا قَالَ أَوْ زَادَ عَلَيْهِ.",
        "reference": "",
        "content": "سُبْحـانَ اللهِ وَبِحَمْـدِهِ."
      }
    ],
    "أذكار بعد السلام من الصلاة المفروضة": [
      {
        "category": "أذكار بعد السلام من الصلاة المفروضة",
        "count": "01",
        "description": "",
        "reference": "",
        "content":
            "أَسْـتَغْفِرُ الله، أَسْـتَغْفِرُ الله، أَسْـتَغْفِرُ الله.\nاللّهُـمَّ أَنْـتَ السَّلامُ ، وَمِـنْكَ السَّلام ، تَبارَكْتَ يا ذا الجَـلالِ وَالإِكْـرام ."
      },
      {
        "category": "أذكار بعد السلام من الصلاة المفروضة",
        "count": "01",
        "description": "",
        "reference": "",
        "content":
            "لا إلهَ إلاّ اللّهُ وحدَهُ لا شريكَ لهُ، لهُ المُـلْكُ ولهُ الحَمْد، وهوَ على كلّ شَيءٍ قَدير، اللّهُـمَّ لا مانِعَ لِما أَعْطَـيْت، وَلا مُعْطِـيَ لِما مَنَـعْت، وَلا يَنْفَـعُ ذا الجَـدِّ مِنْـكَ الجَـد."
      },
      {
        "category": "أذكار بعد السلام من الصلاة المفروضة",
        "count": "01",
        "description": "",
        "reference": "",
        "content":
            "لا إلهَ إلاّ اللّه, وحدَهُ لا شريكَ لهُ، لهُ الملكُ ولهُ الحَمد، وهوَ على كلّ شيءٍ قدير، لا حَـوْلَ وَلا قـوَّةَ إِلاّ بِاللهِ، لا إلهَ إلاّ اللّـه، وَلا نَعْـبُـدُ إِلاّ إيّـاه, لَهُ النِّعْـمَةُ وَلَهُ الفَضْل وَلَهُ الثَّـناءُ الحَـسَن، لا إلهَ إلاّ اللّهُ مخْلِصـينَ لَـهُ الدِّينَ وَلَوْ كَـرِهَ الكـافِرون."
      },
      {
        "category": "أذكار بعد السلام من الصلاة المفروضة",
        "count": "33",
        "description": "",
        "reference": "",
        "content": "سُـبْحانَ اللهِ، والحَمْـدُ لله ، واللهُ أكْـبَر."
      },
      {
        "category": "أذكار بعد السلام من الصلاة المفروضة",
        "count": "01",
        "description": "",
        "reference": "",
        "content":
            "لا إلهَ إلاّ اللّهُ وَحْـدَهُ لا شريكَ لهُ، لهُ الملكُ ولهُ الحَمْد، وهُوَ على كُلّ شَيءٍ قَـدير."
      },
      {
        "category": "أذكار بعد السلام من الصلاة المفروضة",
        "count": "10",
        "description": "عَشْر مَرّات بَعْدَ المَغْرِب وَالصّـبْح.",
        "reference": "",
        "content":
            "لا إلهَ إلاّ اللّهُ وحْـدَهُ لا شريكَ لهُ، لهُ المُلكُ ولهُ الحَمْد، يُحيـي وَيُمـيتُ وهُوَ على كُلّ شيءٍ قدير."
      },
      {
        "category": "أذكار بعد السلام من الصلاة المفروضة",
        "count": "01",
        "description": "بَعْد السّلامِ من صَلاةِ الفَجْر.",
        "reference": "",
        "content":
            "اللّهُـمَّ إِنِّـي أَسْأَلُـكَ عِلْمـاً نافِعـاً وَرِزْقـاً طَيِّـباً ، وَعَمَـلاً مُتَقَـبَّلاً."
      },
      {
        "category": "أذكار بعد السلام من الصلاة المفروضة",
        "count": "07",
        "description": "بعد صلاة الصبح والمغرب.",
        "reference": "",
        "content": "اللَّهُمَّ أَجِرْنِي مِنْ النَّار."
      },
      {
        "category": "أذكار بعد السلام من الصلاة المفروضة",
        "count": "01",
        "description": "",
        "reference": "",
        "content":
            "اللَّهُمَّ أَعِنِّي عَلَى ذِكْرِكَ وَشُكْرِكَ وَحُسْنِ عِبَادَتِكَ."
      }
    ],
    "تسابيح": [
      {
        "category": "تسابيح",
        "count": "100",
        "description": "يكتب له ألف حسنة أو يحط عنه ألف خطيئة.",
        "reference": "",
        "content": "سُبْحَانَ اللَّهِ"
      },
      {
        "category": "تسابيح",
        "count": "100",
        "description":
            "حُطَّتْ خَطَايَاهُ وَإِنْ كَانَتْ مِثْلَ زَبَدِ الْبَحْرِ. لَمْ يَأْتِ أَحَدٌ يَوْمَ الْقِيَامَةِ بِأَفْضَلَ مِمَّا جَاءَ بِهِ إِلَّا أَحَدٌ قَالَ مِثْلَ مَا قَالَ أَوْ زَادَ عَلَيْهِ.",
        "reference": "",
        "content": "سُبْحَانَ اللَّهِ وَبِحَمْدِهِ"
      },
      {
        "category": "تسابيح",
        "count": "100",
        "description": "تَمْلَآَنِ مَا بَيْنَ السَّمَاوَاتِ وَالْأَرْضِ.",
        "reference": "",
        "content": "سُبْحَانَ اللَّهِ وَالْحَمْدُ لِلَّهِ"
      },
      {
        "category": "تسابيح",
        "count": "100",
        "description": "غرست له نخلة في الجنة.",
        "reference": "",
        "content": "سُبْحَانَ اللهِ العَظِيمِ وَبِحَمْدِهِ"
      },
      {
        "category": "تسابيح",
        "count": "100",
        "description": "ثقيلتان في الميزان حبيبتان إلى الرحمن.",
        "reference": "",
        "content":
            "سُبْحَانَ اللَّهِ وَبِحَمْدِهِ ، سُبْحَانَ اللَّهِ الْعَظِيمِ"
      },
      {
        "category": "تسابيح",
        "count": "100",
        "description":
            "كانت له عدل عشر رقاب، وكتبت له مئة حسنة، ومحيت عنه مئة سيئة، وكانت له حرزا من الشيطان.",
        "reference": "",
        "content":
            "لَا إلَه إلّا اللهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلُّ شَيْءِ قَدِيرِ."
      },
      {
        "category": "تسابيح",
        "count": "100",
        "description": "كنز من كنوز الجنة.",
        "reference": "",
        "content": "لا حَوْلَ وَلا قُوَّةَ إِلا بِاللَّهِ"
      },
      {
        "category": "تسابيح",
        "count": "100",
        "description": "تملأ ميزان العبد بالحسنات.",
        "reference": "",
        "content": "الْحَمْدُ للّهِ رَبِّ الْعَالَمِينَ"
      },
      {
        "category": "تسابيح",
        "count": "100",
        "description":
            "من صلى على حين يصبح وحين يمسى ادركته شفاعتى يوم القيامة.",
        "reference": "",
        "content": "الْلَّهُم صَلِّ وَسَلِم وَبَارِك عَلَى سَيِّدِنَا مُحَمَّد"
      },
      {
        "category": "تسابيح",
        "count": "100",
        "description": "لفعل الرسول صلى الله عليه وسلم.",
        "reference": "",
        "content": "أستغفر الله"
      },
      {
        "category": "تسابيح",
        "count": "100",
        "description":
            "أنهن أحب الكلام الى الله، ومكفرات للذنوب، وغرس الجنة، وجنة لقائلهن من النار، وأحب الى النبي عليه السلام مما طلعت عليه الشمس، والْبَاقِيَاتُ الْصَّالِحَات.",
        "reference": "",
        "content":
            "سُبْحَانَ الْلَّهِ، وَالْحَمْدُ لِلَّهِ، وَلَا إِلَهَ إِلَّا الْلَّهُ، وَالْلَّهُ أَكْبَرُ"
      },
      {
        "category": "تسابيح",
        "count": "100",
        "description": "أفضل الذكر لا إله إلاّ الله.",
        "reference": "",
        "content": "لَا إِلَهَ إِلَّا اللَّهُ"
      },
      {
        "category": "تسابيح",
        "count": "100",
        "description":
            "من قال الله أكبر كتبت له عشرون حسنة وحطت عنه عشرون سيئة. الله أكبر من كل شيء.",
        "reference": "",
        "content": "الْلَّهُ أَكْبَرُ"
      },
      {
        "category": "تسابيح",
        "count": "100",
        "description": "خير الدنيا والآخرة",
        "reference": "",
        "content":
            "سُبْحَانَ اللَّهِ ، وَالْحَمْدُ لِلَّهِ ، وَلا إِلَهَ إِلا اللَّهُ ، وَاللَّهُ أَكْبَرُ ، اللَّهُمَّ اغْفِرْ لِي ، اللَّهُمَّ ارْحَمْنِي ، اللَّهُمَّ ارْزُقْنِي."
      },
      {
        "category": "تسابيح",
        "count": "100",
        "description":
            "قَالَ النَّبِيُّ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ \"عَجِبْتُ لَهَا ، فُتِحَتْ لَهَا أَبْوَابُ السَّمَاءِ\".",
        "reference": "",
        "content":
            "اللَّهُ أَكْبَرُ كَبِيرًا ، وَالْحَمْدُ لِلَّهِ كَثِيرًا ، وَسُبْحَانَ اللَّهِ بُكْرَةً وَأَصِيلاً."
      },
      {
        "category": "تسابيح",
        "count": "100",
        "description":
            "في كل مره تحط عنه عشر خطايا ويرفع له عشر درجات ويصلي الله عليه عشرا وتعرض على الرسول صلى الله عليه وسلم.",
        "reference": "",
        "content":
            "اللَّهُمَّ صَلِّ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ كَمَا صَلَّيْتَ عَلَى إِبْرَاهِيمَ , وَعَلَى آلِ إِبْرَاهِيمَ إِنَّكَ حَمِيدٌ مَجِيدٌ , اللَّهُمَّ بَارِكْ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ كَمَا بَارَكْتَ عَلَى إِبْرَاهِيمَ وَعَلَى آلِ إِبْرَاهِيمَ إِنَّكَ حَمِيدٌ مَجِيدٌ."
      }
    ],
    "أذكار النوم": [
      {
        "category": "أذكار النوم",
        "count": "01",
        "description": "",
        "reference": "",
        "content":
            "بِاسْمِكَ رَبِّـي وَضَعْـتُ جَنْـبي ، وَبِكَ أَرْفَعُـه، فَإِن أَمْسَـكْتَ نَفْسـي فارْحَـمْها ، وَإِنْ أَرْسَلْتَـها فاحْفَظْـها بِمـا تَحْفَـظُ بِه عِبـادَكَ الصّـالِحـين."
      },
      {
        "category": "أذكار النوم",
        "count": "01",
        "description": "",
        "reference": "",
        "content":
            "اللّهُـمَّ إِنَّـكَ خَلَـقْتَ نَفْسـي وَأَنْـتَ تَوَفّـاهـا لَكَ ممَـاتـها وَمَحْـياها ، إِنْ أَحْيَيْـتَها فاحْفَظْـها ، وَإِنْ أَمَتَّـها فَاغْفِـرْ لَـها . اللّهُـمَّ إِنَّـي أَسْـأَلُـكَ العـافِـيَة."
      },
      {
        "category": "أذكار النوم",
        "count": "03",
        "description": "",
        "reference": "",
        "content": "اللّهُـمَّ قِنـي عَذابَـكَ يَـوْمَ تَبْـعَثُ عِبـادَك."
      },
      {
        "category": "أذكار النوم",
        "count": "01",
        "description": "",
        "reference": "",
        "content": "بِاسْـمِكَ اللّهُـمَّ أَمـوتُ وَأَحْـيا."
      },
      {
        "category": "أذكار النوم",
        "count": "01",
        "description": "",
        "reference": "",
        "content":
            "الـحَمْدُ للهِ الَّذي أَطْـعَمَنا وَسَقـانا، وَكَفـانا، وَآوانا، فَكَـمْ مِمَّـنْ لا كـافِيَ لَـهُ وَلا مُـؤْوي."
      },
      {
        "category": "أذكار النوم",
        "count": "01",
        "description": "",
        "reference": "",
        "content":
            "اللّهُـمَّ عالِـمَ الغَـيبِ وَالشّـهادةِ فاطِـرَ السّماواتِ وَالأرْضِ رَبَّ كُـلِّ شَـيءٍ وَمَليـكَه، أَشْهـدُ أَنْ لا إِلـهَ إِلاّ أَنْت، أَعـوذُ بِكَ مِن شَـرِّ نَفْسـي، وَمِن شَـرِّ الشَّيْـطانِ وَشِـرْكِه، وَأَنْ أَقْتَـرِفَ عَلـى نَفْسـي سوءاً أَوْ أَجُـرَّهُ إِلـى مُسْـلِم ."
      },
      {
        "category": "أذكار النوم",
        "count": "01",
        "description": "",
        "reference": "",
        "content":
            "اللّهُـمَّ أَسْـلَمْتُ نَفْـسي إِلَـيْكَ، وَفَوَّضْـتُ أَمْـري إِلَـيْكَ، وَوَجَّـهْتُ وَجْـهي إِلَـيْكَ، وَأَلْـجَـاْتُ ظَهـري إِلَـيْكَ، رَغْبَـةً وَرَهْـبَةً إِلَـيْكَ، لا مَلْجَـأَ وَلا مَنْـجـا مِنْـكَ إِلاّ إِلَـيْكَ، آمَنْـتُ بِكِتـابِكَ الّـذي أَنْزَلْـتَ وَبِنَبِـيِّـكَ الّـذي أَرْسَلْـت."
      },
      {
        "category": "أذكار النوم",
        "count": "33",
        "description": "",
        "reference": "",
        "content": "سُبْحَانَ اللَّهِ."
      },
      {
        "category": "أذكار النوم",
        "count": "33",
        "description": "",
        "reference": "",
        "content": "الْحَمْدُ لِلَّهِ."
      },
      {
        "category": "أذكار النوم",
        "count": "34",
        "description": "",
        "reference": "",
        "content": "اللَّهُ أَكْبَرُ."
      }
    ],
    "أذكار الاستيقاظ": [
      {
        "category": "أذكار الاستيقاظ",
        "count": "01",
        "description": "",
        "reference": "",
        "content":
            "الحَمْـدُ لِلّهِ الّذي أَحْـيانا بَعْـدَ ما أَماتَـنا وَإليه النُّـشور."
      },
      {
        "category": "أذكار الاستيقاظ",
        "count": "01",
        "description": "",
        "reference": "",
        "content":
            "الحمدُ للهِ الذي عافاني في جَسَدي وَرَدّ عَليّ روحي وَأَذِنَ لي بِذِكْرِه."
      },
      {
        "category": "أذكار الاستيقاظ",
        "count": "01",
        "description": "",
        "reference": "",
        "content":
            "لا إلهَ إلاّ اللّهُ وَحْـدَهُ لا شَـريكَ له، لهُ المُلـكُ ولهُ الحَمـد، وهوَ على كلّ شيءٍ قدير، سُـبْحانَ اللهِ، والحمْـدُ لله ، ولا إلهَ إلاّ اللهُ واللهُ أكبَر، وَلا حَولَ وَلا قوّة إلاّ باللّهِ العليّ العظيم. رَبِّ اغْفرْ لي."
      }
    ],
    "أدعية قرآنية": [
      {
        "category": "أدعية قرآنية",
        "count": "01",
        "description": "",
        "reference": ". [البقرة - 201].",
        "content":
            "\\n', '\"رَبَّنَا آتِنَا فِي الدُّنْيَا حَسَنَةً وَفِي الآخِرَةِ حَسَنَةً وَقِنَا عَذَابَ النَّارِ\". [البقرة - 201].\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '"
      },
      {
        "category": "أدعية قرآنية",
        "count": "01",
        "description": "",
        "reference": ". [البقرة - 250].",
        "content":
            "\\n', '\"رَبَّنَا أَفْرِغْ عَلَيْنَا صَبْرًا وَثَبِّتْ أَقْدَامَنَا وَانصُرْنَا عَلَى الْقَوْمِ الْكَافِرِينَ\". [البقرة - 250].\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '"
      },
      {
        "category": "أدعية قرآنية",
        "count": "01",
        "description": "",
        "reference": ". [البقرة\\n', '- 286].",
        "content":
            "\\n', '\"رَبَّنَا لاَ تُؤَاخِذْنَا إِن نَّسِينَا أَوْ أَخْطَأْنَا رَبَّنَا وَلاَ تَحْمِلْ عَلَيْنَا إِصْرًا كَمَا حَمَلْتَهُ عَلَى الَّذِينَ مِن قَبْلِنَا رَبَّنَا وَلاَ تُحَمِّلْنَا مَا لاَ طَاقَةَ لَنَا بِهِ وَاعْفُ عَنَّا وَاغْفِرْ لَنَا وَارْحَمْنَا أَنتَ مَوْلاَنَا فَانصُرْنَا عَلَى الْقَوْمِ الْكَافِرِينَ\". [البقرة\\n', '- 286].\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '"
      },
      {
        "category": "أدعية قرآنية",
        "count": "01",
        "description": "",
        "reference": ". [آل عمران - 8].",
        "content":
            "\\n', '\"رَبَّنَا لاَ تُزِغْ قُلُوبَنَا بَعْدَ إِذْ هَدَيْتَنَا وَهَبْ لَنَا مِن لَّدُنكَ رَحْمَةً إِنَّكَ أَنتَ الْوَهَّابُ\". [آل عمران - 8].\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '"
      },
      {
        "category": "أدعية قرآنية",
        "count": "01",
        "description": "",
        "reference": ". [آل عمران - 16].",
        "content":
            "\\n', '\"رَبَّنَا إِنَّنَا آمَنَّا فَاغْفِرْ لَنَا ذُنُوبَنَا وَقِنَا عَذَابَ النَّارِ\". [آل عمران - 16].\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '"
      },
      {
        "category": "أدعية قرآنية",
        "count": "01",
        "description": "",
        "reference": ". [آل عمران - 38].",
        "content":
            "\\n', '\"رَبِّ هَبْ لِي مِن لَّدُنْكَ ذُرِّيَّةً طَيِّبَةً إِنَّكَ سَمِيعُ الدُّعَاء\". [آل عمران - 38].\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '"
      },
      {
        "category": "أدعية قرآنية",
        "count": "01",
        "description": "",
        "reference": ". [آل عمران - 53].",
        "content":
            "\\n', '\"رَبَّنَا آمَنَّا بِمَا أَنزَلْتَ وَاتَّبَعْنَا الرَّسُولَ فَاكْتُبْنَا مَعَ الشَّاهِدِينَ\". [آل عمران - 53].\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '"
      },
      {
        "category": "أدعية قرآنية",
        "count": "01",
        "description": "",
        "reference": ". [آل عمران - 147].",
        "content":
            "\\n', '\"ربَّنَا اغْفِرْ لَنَا ذُنُوبَنَا وَإِسْرَافَنَا فِي أَمْرِنَا وَثَبِّتْ أَقْدَامَنَا وانصُرْنَا عَلَى الْقَوْمِ الْكَافِرِينَِ\". [آل عمران - 147].\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '"
      },
      {
        "category": "أدعية قرآنية",
        "count": "01",
        "description": "",
        "reference": ". [آل عمران -  191-194].",
        "content":
            "\\n', '\"رَبَّنَا مَا خَلَقْتَ هَذا بَاطِلاً سُبْحَانَكَ فَقِنَا عَذَابَ النَّارِ رَبَّنَا إِنَّكَ مَن تُدْخِلِ النَّارَ فَقَدْ أَخْزَيْتَهُ وَمَا لِلظَّالِمِينَ مِنْ أَنصَارٍ رَّبَّنَا إِنَّنَا سَمِعْنَا مُنَادِيًا يُنَادِي لِلإِيمَانِ أَنْ آمِنُواْ بِرَبِّكُمْ فَآمَنَّا رَبَّنَا فَاغْفِرْ لَنَا ذُنُوبَنَا وَكَفِّرْ عَنَّا سَيِّئَاتِنَا وَتَوَفَّنَا مَعَ الأبْرَارِ رَبَّنَا وَآتِنَا مَا وَعَدتَّنَا عَلَى رُسُلِكَ وَلاَ تُخْزِنَا يَوْمَ الْقِيَامَةِ إِنَّكَ لاَ تُخْلِفُ الْمِيعَادَ\". [آل عمران -  191-194].\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '"
      },
      {
        "category": "أدعية قرآنية",
        "count": "01",
        "description": "",
        "reference": ". [الأعراف - 23].",
        "content":
            "\\n', '\"رَبَّنَا ظَلَمْنَا أَنفُسَنَا وَإِن لَّمْ تَغْفِرْ لَنَا وَتَرْحَمْنَا لَنَكُونَنَّ مِنَ الْخَاسِرِينَ\". [الأعراف - 23].\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '"
      },
      {
        "category": "أدعية قرآنية",
        "count": "01",
        "description": "",
        "reference": ". [الأعراف - 47].",
        "content":
            "\\n', '\"رَبَّنَا لاَ تَجْعَلْنَا مَعَ الْقَوْمِ الظَّالِمِينَ\". [الأعراف - 47].\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '"
      },
      {
        "category": "أدعية قرآنية",
        "count": "01",
        "description": "",
        "reference": ". [الأعراف - 126].",
        "content":
            "\\n', '\"رَبَّنَا أَفْرِغْ عَلَيْنَا صَبْرًا وَتَوَفَّنَا مُسْلِمِينَ\". [الأعراف - 126].\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '"
      },
      {
        "category": "أدعية قرآنية",
        "count": "01",
        "description": "",
        "reference": ". [التوبة - 129].",
        "content":
            "\\n', '\"حَسْبِيَ اللّهُ لا إِلَـهَ إِلاَّ هُوَ عَلَيْهِ تَوَكَّلْتُ وَهُوَ رَبُّ الْعَرْشِ الْعَظِيمِ\". [التوبة - 129].\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '"
      },
      {
        "category": "أدعية قرآنية",
        "count": "01",
        "description": "",
        "reference": ". [يونس - 85-86].",
        "content":
            "\\n', '\"رَبَّنَا لاَ تَجْعَلْنَا فِتْنَةً لِّلْقَوْمِ الظَّالِمِينَ وَنَجِّنَا بِرَحْمَتِكَ مِنَ الْقَوْمِ الْكَافِرِينَ\". [يونس - 85-86].\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '"
      },
      {
        "category": "أدعية قرآنية",
        "count": "01",
        "description": "",
        "reference": ". [هود - 47].",
        "content":
            "\\n', '\"رَبِّ إِنِّي أَعُوذُ بِكَ أَنْ أَسْأَلَكَ مَا لَيْسَ لِي بِهِ عِلْمٌ وَإِلاَّ تَغْفِرْ لِي وَتَرْحَمْنِي أَكُن مِّنَ الْخَاسِرِينَ\". [هود - 47].\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '"
      },
      {
        "category": "أدعية قرآنية",
        "count": "01",
        "description": "",
        "reference": ". [إبرهيم - 40].",
        "content":
            "\\n', '\"رَبِّ اجْعَلْنِي مُقِيمَ الصَّلاَةِ وَمِن ذُرِّيَّتِي رَبَّنَا وَتَقَبَّلْ دُعَاء\". [إبرهيم - 40].\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '"
      },
      {
        "category": "أدعية قرآنية",
        "count": "01",
        "description": "",
        "reference": ". [إبرهيم - 41].",
        "content":
            "\\n', '\"رَبَّنَا اغْفِرْ لِي وَلِوَالِدَيَّ وَلِلْمُؤْمِنِينَ يَوْمَ يَقُومُ الْحِسَابُ\". [إبرهيم - 41].\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '"
      },
      {
        "category": "أدعية قرآنية",
        "count": "01",
        "description": "",
        "reference": ". [الإسراء - 80].",
        "content":
            "\\n', '\"رَّبِّ أَدْخِلْنِي مُدْخَلَ صِدْقٍ وَأَخْرِجْنِي مُخْرَجَ صِدْقٍ وَاجْعَل لِّي مِن لَّدُنكَ سُلْطَانًا نَّصِيرًا\". [الإسراء - 80].\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '"
      },
      {
        "category": "أدعية قرآنية",
        "count": "01",
        "description": "",
        "reference": ". [الكهف - 10].",
        "content":
            "\\n', '\"رَبَّنَا آتِنَا مِن لَّدُنكَ رَحْمَةً وَهَيِّئْ لَنَا مِنْ أَمْرِنَا رَشَدًا\". [الكهف - 10].\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '"
      },
      {
        "category": "أدعية قرآنية",
        "count": "01",
        "description": "",
        "reference": ". [طه - 25-28].",
        "content":
            "\\n', '\"رَبِّ اشْرَحْ لِي صَدْرِي وَيَسِّرْ لِي أَمْرِي وَاحْلُلْ عُقْدَةً مِّن لِّسَانِي يَفْقَهُوا قَوْلِي\". [طه - 25-28].\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '"
      },
      {
        "category": "أدعية قرآنية",
        "count": "01",
        "description": "",
        "reference": ". [طه - 114].",
        "content":
            "\\n', '\"رَّبِّ زِدْنِي عِلْمًا\". [طه - 114].\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '"
      },
      {
        "category": "أدعية قرآنية",
        "count": "01",
        "description": "",
        "reference": ". [الأنبياء - 87].",
        "content":
            "\\n', '\"لا إِلَهَ إِلا أَنتَ سُبْحَانَكَ إِنِّي كُنتُ مِنَ الظَّالِمِينَ\". [الأنبياء - 87].\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '"
      },
      {
        "category": "أدعية قرآنية",
        "count": "01",
        "description": "",
        "reference": ". [الأنبياء - 89].",
        "content":
            "\\n', '\"رَبِّ لَا تَذَرْنِي فَرْدًا وَأَنتَ خَيْرُ الْوَارِثِينَ\". [الأنبياء - 89].\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '"
      },
      {
        "category": "أدعية قرآنية",
        "count": "01",
        "description": "",
        "reference": ". [المؤمنون - 97-98].",
        "content":
            "\\n', '\"رَّبِّ أَعُوذُ بِكَ مِنْ هَمَزَاتِ الشَّيَاطِينِ وَأَعُوذُ بِكَ رَبِّ أَن يَحْضُرُونِ\". [المؤمنون - 97-98].\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '"
      },
      {
        "category": "أدعية قرآنية",
        "count": "01",
        "description": "",
        "reference": ". [المؤمنون - 109].",
        "content":
            "\\n', '\"رَبَّنَا آمَنَّا فَاغْفِرْ لَنَا وَارْحَمْنَا وَأَنتَ خَيْرُ الرَّاحِمِينَ\". [المؤمنون - 109].\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '"
      },
      {
        "category": "أدعية قرآنية",
        "count": "01",
        "description": "",
        "reference": ". [المؤمنون - 118].",
        "content":
            "\\n', '\"رَّبِّ اغْفِرْ وَارْحَمْ وَأَنتَ خَيْرُ الرَّاحِمِينَ\". [المؤمنون - 118].\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '"
      }
    ],
    "أدعية الأنبياء": [
      {
        "category": "أدعية الأنبياء",
        "count": "01",
        "description": "آدم علية السلام.",
        "reference": ". [الأعراف - 23].",
        "content":
            "\\n', '\"رَبَّنَا ظَلَمْنَا أَنفُسَنَا وَإِن لَّمْ تَغْفِرْ لَنَا وَتَرْحَمْنَا لَنَكُونَنَّ مِنَ الْخَاسِرِينَ\". [الأعراف - 23].\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '"
      },
      {
        "category": "أدعية الأنبياء",
        "count": "01",
        "description": "نوح علية السلام.",
        "reference": ". [نوح - 28].",
        "content":
            "\\n', '\"رَّبِّ اغْفِرْ لِي وَلِوَالِدَيَّ وَلِمَن دَخَلَ بَيْتِيَ مُؤْمِنًا وَلِلْمُؤْمِنِينَ وَالْمُؤْمِنَاتِ وَلَا تَزِدِ الظَّالِمِينَ إِلَّا تَبَارًا\". [نوح - 28].\\n', '\" رَبِّ إِنِّي أَعُوذُ بِكَ أَنْ أَسْأَلَكَ مَا لَيْسَ لِي بِهِ عِلْمٌ وَإِلاَّ تَغْفِرْ لِي وَتَرْحَمْنِي أَكُن مِّنَ الْخَاسِرِينَ\". [هود - 47].\\n', '\"رَّبِّ أَنزِلْنِي مُنزَلاً مُّبَارَكاً وَأَنتَ خَيْرُ الْمُنزِلِينَ\". [المؤمنون - 29].\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '"
      },
      {
        "category": "أدعية الأنبياء",
        "count": "01",
        "description": "إبراهيم علية السلام.",
        "reference": ". [هود - 47].",
        "content":
            "\\n', '\"رَبَّنَا تَقَبَّلْ مِنَّا إِنَّكَ أَنْتَ السَّمِيعُ الْعَلِيمُ (127) رَبَّنَا وَاجْعَلْنَا مُسْلِمَيْنِ لَكَ وَمِنْ ذُرِّيَّتِنَا أُمَّةً مُسْلِمَةً لَكَ وَأَرِنَا مَنَاسِكَنَا وَتُبْ عَلَيْنَا إِنَّكَ أَنْتَ التَّوَّابُ الرَّحِيمُ (128)\". [البقرة - 127-128].\\n', '\"رَبِّ اجْعَلْنِي مُقِيمَ الصَّلَاةِ وَمِن ذُرِّيَّتِي ۚ رَبَّنَا وَتَقَبَّلْ دُعَاءِ (40) رَبَّنَا اغْفِرْ لِي وَلِوَالِدَيَّ وَلِلْمُؤْمِنِينَ يَوْمَ يَقُومُ الْحِسَابُ (41)\". [إبراهيم - 40-41].\\n', '\"رَبِّ هَبْ لِي حُكْمًا وَأَلْحِقْنِي بِالصَّالِحِينَ (83) وَاجْعَل لِّي لِسَانَ صِدْقٍ فِي الْآخِرِينَ (84) وَاجْعَلْنِي مِن وَرَثَةِ جَنَّةِ النَّعِيمِ (85)\". [الشعراء - 83-85].\\n', '\"رَّبَّنَا عَلَيْكَ تَوَكَّلْنَا وَإِلَيْكَ أَنَبْنَا وَإِلَيْكَ الْمَصِيرُ (4) رَبَّنَا لَا تَجْعَلْنَا فِتْنَةً لِّلَّذِينَ كَفَرُوا وَاغْفِرْ لَنَا رَبَّنَا ۖ  إِنَّكَ أَنتَ الْعَزِيزُ الْحَكِيمُ (5)\". [الممتحنة - 4-5].\\n', '\"رَبِّ هَبْ لِي مِنَ الصَّالِحِينَ\". [الصافات - 100].\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '"
      },
      {
        "category": "أدعية الأنبياء",
        "count": "01",
        "description": "هود علية السلام.",
        "reference": ". [المؤمنون - 29].",
        "content":
            "\\n', '\"إِنِّي تَوَكَّلْتُ عَلَى اللَّهِ رَبِّي وَرَبِّكُم ۚ مَّا مِن دَابَّةٍ إِلَّا هُوَ آخِذٌ بِنَاصِيَتِهَا ۚ إِنَّ رَبِّي عَلَىٰ صِرَاطٍ مُّسْتَقِيمٍ\". [هود - 56].\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '"
      },
      {
        "category": "أدعية الأنبياء",
        "count": "01",
        "description": "لوط علية السلام.",
        "reference": ". [البقرة - 127-128].",
        "content":
            "\\n', '\"رَبِّ انْصُرْنِي عَلَى الْقَوْمِ الْمُفْسِدِينَ\". [العنكبوت - 30].\\n', '\"رَبِّ نَجِّنِي وَأَهْلِي مِمَّا يَعْمَلُونَ\". [الشعراء - 169].\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '"
      },
      {
        "category": "أدعية الأنبياء",
        "count": "01",
        "description": "يوسف علية السلام.",
        "reference": ". [إبراهيم - 40-41].",
        "content":
            "\\n', '\"فَاطِرَ السَّمَاوَاتِ وَالْأَرْضِ أَنتَ وَلِيِّي فِي الدُّنْيَا وَالْآخِرَةِ ۖ تَوَفَّنِي مُسْلِمًا وَأَلْحِقْنِي بِالصَّالِحِينَ\". [يوسف - 101].\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '"
      },
      {
        "category": "أدعية الأنبياء",
        "count": "01",
        "description": "شعيب علية السلام.",
        "reference": ". [الشعراء - 83-85].",
        "content":
            "\\n', '\"وَسِعَ رَبُّنَا كُلَّ شَيْءٍ عِلْماً عَلَى اللّهِ تَوَكَّلْنَا رَبَّنَا افْتَحْ بَيْنَنَا وَبَيْنَ قَوْمِنَا بِالْحَقِّ وَأَنتَ خَيْرُ الْفَاتِحِينَ\". [الأعراف - 89].\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '"
      },
      {
        "category": "أدعية الأنبياء",
        "count": "01",
        "description": "موسى علية السلام.",
        "reference": ". [الممتحنة - 4-5].",
        "content":
            "\\n', '\"رَبِّ إِنِّي ظَلَمْتُ نَفْسِي فَاغْفِرْ لِي\". [القصص - 16].\\n', '\"رَبِّ بِمَا أَنْعَمْتَ عَلَيَّ فَلَنْ أَكُونَ ظَهِيراً لِّلْمُجْرِمِينَ\". [القصص - 17].\\n', '\"رَبِّ إِنِّي لِمَا أَنزَلْتَ إِلَيَّ مِنْ خَيْرٍ فَقِيرٌ\". [القصص - 24].\\n', '\"رَبِّ اشْرَحْ لِي صَدْرِي (25) وَيَسِّرْ لِي أَمْرِي (26) وَاحْلُلْ عُقْدَةً مِّن لِّسَانِي (27) يَفْقَهُوا قَوْلِي (28)\". [طه - 25-28].\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '"
      },
      {
        "category": "أدعية الأنبياء",
        "count": "01",
        "description": "أيوب علية السلام.",
        "reference": "\". [الصافات - 100].",
        "content":
            "\\n', '\"أَنِّي مَسَّنِيَ الضُّرُّ وَأَنتَ أَرْحَمُ الرَّاحِمِينَ\". [الأنبياء - 83].\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '"
      },
      {
        "category": "أدعية الأنبياء",
        "count": "01",
        "description": "سليمان علية السلام.",
        "reference": ". [هود - 56].",
        "content":
            "\\n', '\"رَبِّ أَوْزِعْنِي أَنْ أَشْكُرَ نِعْمَتَكَ الَّتِي أَنْعَمْتَ عَلَيَّ وَعَلَى وَالِدَيَّ وَأَنْ أَعْمَلَ صَالِحًا تَرْضَاهُ وَأَدْخِلْنِي بِرَحْمَتِكَ فِي عِبَادِكَ الصَّالِحِينَ\". [النمل - 19].\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '"
      },
      {
        "category": "أدعية الأنبياء",
        "count": "01",
        "description": "يونس علية السلام.",
        "reference": ". [العنكبوت - 30].",
        "content":
            "\\n', '\" لَّا إِلَهَ إِلَّا أَنتَ سُبْحَانَكَ إِنِّي كُنتُ مِنَ الظَّالِمِينَ\". [الأنبياء - 87].\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '"
      },
      {
        "category": "أدعية الأنبياء",
        "count": "01",
        "description": "زكريا علية السلام.",
        "reference": ". [الشعراء - 169].",
        "content":
            "\\n', '\"رَبِّ هَبْ لِي مِن لَّدُنْكَ ذُرِّيَّةً طَيِّبَةً إِنَّكَ سَمِيعُ الدُّعَاء\". [آل عمران - 38].\\n', '\"رَبِّ لَا تَذَرْنِي فَرْداً وَأَنتَ خَيْرُ الْوَارِثِينَ\". [الأنبياء - 89].\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '"
      },
      {
        "category": "أدعية الأنبياء",
        "count": "01",
        "description": "يعقوب علية السلام.",
        "reference": ". [يوسف - 101].",
        "content":
            "\\n', '\"إِنَّمَا أَشْكُو بَثِّي وَحُزْنِي إِلَى اللَّهِ\". [يوسف - 86].\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '\\n', '"
      }
    ]
  };
}

String removeFullStop(String inputString) {
  String result = inputString.replaceAll('.', '');
  return result;
}

List<dynamic> hisnmuslim1() {
  return [
    {
      "ID": 1,
      "ARABIC_TEXT":
          "(.الْحَمْدُ للَّهِ الَّذِي أَحْيَانَا بَعْدَ مَا أَمَاتَنَا، وَإِلَيْهِ النُّشُورُ )",
      "LANGUAGE_ARABIC_TRANSLATED_TEXT":
          "(Alhamdu lillahil-lathee ahyana baAAda ma amatana wa-ilayhin-nushoor.)",
      "TRANSLATED_TEXT":
          "(All praise is for Allah who gave us life after having taken it from us and unto Him is the resurrection.)",
      "REPEAT": 1,
      "AUDIO": "http://www.hisnmuslim.com/audio/ar/1.mp3"
    },
    {
      "ID": 2,
      "ARABIC_TEXT":
          "لاَ إِلَهَ إِلاَّ اللَّهُ وَحْدَهُ لاَ شَريكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ، وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ، سُبْحَانَ اللَّهِ، وَالْحَمْدُ للَّهِ، وَلاَ إِلَهَ إِلاَّ اللَّهُ، وَاللَّهُ أَكبَرُ، وَلاَ حَوْلَ وَلاَ قُوَّةَ إِلاَّ بِاللَّهِ الْعَلِيِّ الْعَظِيمِ، رَبِّ اغْفرْ لِي",
      "LANGUAGE_ARABIC_TRANSLATED_TEXT":
          "(La ilaha illal-lahu wahdahu la shareeka lah, lahul-mulku walahul-hamd, wahuwa AAala kulli shay-in qadeer, subhanal-lah, walhamdu lillah, wala  ilaha illal-lah wallahu akbar, wala hawla wala quwwata illa billahil-AAaliyyil AAatheem. Rabbigh-fir lee)",
      "TRANSLATED_TEXT":
          "(None has the right to be worshipped except Allah, alone without associate, to Him belongs sovereignty and praise and He is over all things wholly capable.  How perfect Allah is, and all praise is for Allah, and none has the right to be worshipped except Allah, Allah is the greatest and there is no power nor might except with Allah, The Most High, The Supreme.O my Lord forgive me)",
      "REPEAT": 1,
      "AUDIO": "http://www.hisnmuslim.com/audio/ar/2.mp3"
    },
    {
      "ID": 3,
      "ARABIC_TEXT":
          "( الْحَمْدُ لِلَّهِ الَّذِي عَافَانِي فِي جَسَدِي، وَرَدَّ عَلَيَّ رُوحِي، وَأَذِنَ لي بِذِكْرِهِ )",
      "LANGUAGE_ARABIC_TRANSLATED_TEXT":
          "(Alhamdu lillahil-lathee AAafanee fee jasadee waradda AAalayya roohee wa-athina lee bithikrih.)",
      "TRANSLATED_TEXT":
          "(All praise is for Allah who restored to me my health and returned my soul and  has allowed me to remember Him.)",
      "REPEAT": 1,
      "AUDIO": "http://www.hisnmuslim.com/audio/ar/3.mp3"
    },
    {
      "ID": 4,
      "ARABIC_TEXT":
          "﴿ إِنَّ فِي خَلْقِ السَّمَوَاتِ وَالأَرْضِ وَاخْتِلاَفِ اللَّيْلِ وَالنَّهَارِ لَآيَاتٍ لأُوْلِي الألْبَابِ * الَّذِينَ يَذْكُرُونَ اللَّهَ قِيَاماً وَقُعُوداً وَعَلَىَ جُنُوبِهِمْ وَيَتَفَكَّرُونَ فِي خَلْقِ السَّمَوَاتِ وَالأَرْضِ رَبَّنَا مَا خَلَقْتَ هَذا بَاطِلاً سُبْحَانَكَ فَقِنَا عَذَابَ النَّارِ* رَبَّنَا إِنَّكَ مَن تُدْخِلِ النَّارَ فَقَدْ أَخْزَيْتَهُ وَمَا لِلظَّالِمِينَ مِنْ أَنصَارٍ* رَّبَّنَا إِنَّنَا سَمِعْنَا مُنَادِياً يُنَادِي لِلإِيمَانِ أَنْ آمِنُواْ بِرَبِّكُمْ فَآمَنَّا رَبَّنَا فَاغْفِرْ لَنَا ذُنُوبَنَا وَكَفِّرْ عَنَّا سَيِّئَاتِنَا وَتَوَفَّنَا مَعَ الأبْرَارِ* رَبَّنَا وَآتِنَا مَا وَعَدتَّنَا عَلَى رُسُلِكَ وَلاَ تُخْزِنَا يَوْمَ الْقِيَامَةِ إِنَّكَ لاَ تُخْلِفُ الْمِيعَادَ* فَاسْتَجَابَ لَهُمْ رَبُّهُمْ أَنِّي لاَ أُضِيعُ عَمَلَ عَامِلٍ مِّنكُم مِّن ذَكَرٍ أَوْ أُنثَى بَعْضُكُم مِّن بَعْضٍ فَالَّذِينَ هَاجَرُواْ وَأُخْرِجُواْ مِن دِيَارِهِمْ وَأُوذُواْ فِي سَبِيلِي وَقَاتَلُواْ وَقُتِلُواْ لأُكَفِّرَنَّ عَنْهُمْ سَيِّئَاتِهِمْ وَلأُدْخِلَنَّهُمْ جَنَّاتٍ تَجْرِي مِن تَحْتِهَا الأَنْهَارُ ثَوَاباً مِّن عِندِ اللَّهِ وَاللَّهُ عِندَهُ حُسْنُ الثَّوَابِ * لاَ يَغُرَّنَّكَ تَقَلُّبُ الَّذِينَ كَفَرُواْ فِي الْبِلاَدِ * مَتَاعٌ قَلِيلٌ ثُمَّ مَأْوَاهُمْ جَهَنَّمُ وَبِئْسَ الْمِهَادُ * لَكِنِ الَّذِينَ اتَّقَوْاْ رَبَّهُمْ لَهُمْ جَنَّاتٌ تَجْرِي مِنْ تَحْتِهَا الأَنْهَارُ خَالِدِينَ فِيهَا نُزُلاً مِّنْ عِندِ اللَّهِ وَمَا عِندَ اللَّهِ خَيْرٌ لِّلأَبْرَارِ * وَإِنَّ مِنْ أَهْلِ الْكِتَابِ لَمَن يُؤْمِنُ بِاللَّهِ وَمَا أُنزِلَ إِلَيْكُمْ وَمَآ أُنزِلَ إِلَيْهِمْ خَاشِعِينَ لِلَّهِ لاَ يَشْتَرُونَ بِآيَاتِ اللَّهِ ثَمَناً قَلِيلاً أُوْلَئِكَ لَهُمْ أَجْرُهُمْ عِندَ رَبِّهِمْ إِنَّ اللَّهَ سَرِيعُ الْحِسَابِ*يَا أَيُّهَا الَّذِينَ آمَنُواْ اصْبِرُواْ وَصَابِرُواْ وَرَابِطُواْ وَاتَّقُواْ اللَّهَ لَعَلَّكُمْ تُفْلِحُونَ ﴾",
      "LANGUAGE_ARABIC_TRANSLATED_TEXT":
          "From Verse 3:190 till the end of the chapter Al-Imran",
      "TRANSLATED_TEXT":
          "( 190 )   Indeed, in the creation of the heavens and the earth and the alternation of the night and the day are signs for those of understanding.( 191 )   Who remember Allah while standing or sitting or [lying] on their sides and give thought to the creation of the heavens and the earth, [saying], Our Lord, You did not create this aimlessly; exalted are You [above such a thing]; then protect us from the punishment of the Fire.( 192 )   Our Lord, indeed whoever You admit to the Fire - You have disgraced him, and for the wrongdoers there are no helpers.( 193 )   Our Lord, indeed we have heard a caller calling to faith, [saying], 'Believe in your Lord,' and we have believed. Our Lord, so forgive us our sins and remove from us our misdeeds and cause us to die with the righteous.( 194 )   Our Lord, and grant us what You promised us through Your messengers and do not disgrace us on the Day of Resurrection. Indeed, You do not fail in [Your] promise.( 195 )   And their Lord responded to them, Never will I allow to be lost the work of [any] worker among you, whether male or female; you are of one another. So those who emigrated or were evicted from their homes or were harmed in My cause or fought or were killed - I will surely remove from them their misdeeds, and I will surely admit them to gardens beneath which rivers flow as reward from Allah, and Allah has with Him the best reward.( 196 )   Be not deceived by the [uninhibited] movement of the disbelievers throughout the land.( 197 )   [It is but] a small enjoyment; then their [final] refuge is Hell, and wretched is the resting place.( 198 )   But those who feared their Lord will have gardens beneath which rivers flow, abiding eternally therein, as accommodation from Allah. And that which is with Allah is best for the righteous.( 199 )   And indeed, among the People of the Scripture are those who believe in Allah and what was revealed to you and what was revealed to them, [being] humbly submissive to Allah. They do not exchange the verses of Allah for a small price.Those will have their reward with their Lord. Indeed, Allah is swift in account.( 200 )   O you who have believed, persevere and endure and remain stationed and fear Allah that you may be successful.",
      "REPEAT": 1,
      "AUDIO": "http://www.hisnmuslim.com/audio/ar/4.mp3"
    }
  ];
}

List<dynamic> hisnmuslim27() {
  return [
    {
      "ID": 75,
      "ARABIC_TEXT":
          "أَعُوذُ بِاللَّهِ مِنَ الشَّيطَانِ الرَّجِيمِ ﴿اللَّهُ لاَ إِلَهَ إِلاَّ هُوَ الْحَيُّ الْقَيُّومُ لاَ تَأْخُذُهُ سِنَةٌ وَلاَ نَوْمٌ لَّهُ مَا فِي السَّمَوَاتِ وَمَا فِي الأَرْضِ مَن ذَا الَّذِي يَشْفَعُ عِنْدَهُ إِلاَّ بِإِذْنِهِ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ وَلاَ يُحِيطُونَ بِشَيْءٍ مِّنْ عِلْمِهِ إِلاَّ بِمَا شَاء وَسِعَ كُرْسِيُّهُ السَّمَوَاتِ وَالْأَرْضَ وَلاَ يَؤُودُهُ حِفْظُهُمَا وَهُوَ الْعَلِيُّ الْعَظِيمُ﴾.",
      "LANGUAGE_ARABIC_TRANSLATED_TEXT":
          "Recite Ayat-Al-Kursiy (Al-Baqarah :255)",
      "TRANSLATED_TEXT":
          " Allah - there is no deity except Him, the Ever-Living, the Sustainer of [all] existence. Neither drowsiness overtakes Him nor sleep. To Him belongs whatever is in the heavens and whatever is on the earth. Who is it that can intercede with Him except by His permission? He knows what is [presently] before them and what will be after them, and they encompass not a thing of His knowledge except for what He wills. His Kursi extends over the heavens and the earth, and their preservation tires Him not. And He is the Most High, the Most Great.",
      "REPEAT": 1,
      "AUDIO": "http://www.hisnmuslim.com/audio/ar/75.mp3"
    },
    {
      "ID": 76,
      "ARABIC_TEXT":
          "(بسم الله الرحمن الرحيم ﴿قُلْ هُوَ اللَّهُ أَحَدٌ* اللَّهُ الصَّمَدُ* لَمْ يَلِدْ وَلَمْ يُولَدْ* وَلَمْ يَكُن لَّهُ كُفُواً أَحَدٌ﴾.) (بسم الله الرحمن الرحيم ﴿قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ* مِن شَرِّ مَا خَلَقَ* وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ* وَمِن شَرِّ النَّفَّاثَاتِ فِي الْعُقَدِ* وَمِن شَرِّ حَاسِدٍ إِذَا حَسَدَ﴾.) (بسم الله الرحمن الرحيم ﴿قُلْ أَعُوذُ بِرَبِّ النَّاسِ* مَلِكِ النَّاسِ* إِلَهِ النَّاسِ* مِن شَرِّ الْوَسْوَاسِ الْخَنَّاسِ* الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ* مِنَ الْجِنَّةِ وَ النَّاسِ﴾)",
      "LANGUAGE_ARABIC_TRANSLATED_TEXT":
          "Then recite [Soorah al-Ikhlaas (112)], [Soorah al-Falaq (113)] and [Soorah an-Naas (114)]",
      "TRANSLATED_TEXT":
          "([Soorah al-Ikhlaas (112)]( 1 )   Say, He is Allah, [who is] One,( 2 )   Allah, the Eternal Refuge.( 3 )   He neither begets nor is born,( 4 )   Nor is there to Him any equivalent.)([Soorah al-Falaq (113)] ( 1 )   Say, I seek refuge in the Lord of daybreak( 2 )   From the evil of that which He created( 3 )   And from the evil of darkness when it settles( 4 )   And from the evil of the blowers in knots( 5 )   And from the evil of an envier when he envies. )([Soorah an-Naas (114)])( 1 )   Say, I seek refuge in the Lord of mankind,( 2 )   The Sovereign of mankind.( 3 )   The God of mankind,( 4 )   From the evil of the retreating whisperer -( 5 )   Who whispers [evil] into the breasts of mankind -( 6 )   From among the jinn and mankind.",
      "REPEAT": 3,
      "AUDIO": "http://www.hisnmuslim.com/audio/ar/76.mp3"
    },
    {
      "ID": 77,
      "ARABIC_TEXT":
          "((أَصْبَحْنَا وَأَصْبَحَ الْمُلْكُ لِلَّهِ ، وَالْحَمْدُ لِلَّهِ، لاَ إِلَهَ إلاَّ اللَّهُ وَحْدَهُ لاَ شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ، رَبِّ أَسْأَلُكَ خَيْرَ مَا فِي هَذَا الْيَوْمِ وَخَيرَ مَا بَعْدَهُ ، وَأَعُوذُ بِكَ مِنْ شَرِّ مَا فِي  هَذَا الْيَوْمِ وَشَرِّ مَا بَعْدَهُ، رَبِّ أَعُوذُ بِكَ مِنَ الْكَسَلِ وَسُوءِ الْكِبَرِ، رَبِّ أَعُوذُ بِكَ مِنْ عَذَابٍ فِي النَّارِ وَعَذَابٍ فِي الْقَبْرِ)). [ وإذا أمسى قال: أمسينا وأمسى الملك للَّه] [وإذا أمسى قال: رب أسألك خير ما في هذه الليلة، وخير ما بعدها، وأعوذ بك من شر ما في هذه الليلة، وشر ما بعدها.]",
      "LANGUAGE_ARABIC_TRANSLATED_TEXT":
          "Asbahna wa-asbahal-mulku lillah walhamdu lillah la ilaha illal-lah, wahdahu la shareeka lah, lahul-mulku walahul-hamd, wahuwa AAala kulli shayin qadeer, rabbi as-aluka khayra ma fee hathihil-laylah, wakhayra ma baAAdaha, wa-aAAoothu bika min sharri hathihil-laylah, washarri ma baAAdaha, rabbi aAAoothu bika minal-kasal, wasoo-il kibar, rabbi aAAoothu bika min AAathabin fin-nar, waAAathabin fil-qabr.‘We have reached the morning and at this very time unto Allah belongs all sovereignty, and all praise is for Allah.  None has the right to be worshipped except Allah, alone, without partner, to Him belongs all sovereignty and praise and He is over all things omnipotent. My Lord, I ask You for the good of this night and the good of what follows it and I take refuge in You from the evil of this night and the evil of what follows it.  My Lord, I take refuge in You from laziness and senility.  My Lord, I take refuge in You from torment in the Fire and punishment in the grave.’…likewise, one says in the morning:Amsayna wa-amsal-mulku lillah….‘We have reached the evening and at this very time unto Allah belongs all sovereignty…’",
      "TRANSLATED_TEXT":
          "‘We have reached the morning and at this very time unto Allaah, belongs all sovereignty , and all praise is for Allaah. None has the right to be worshipped except Allaah, alone, without any partner, to Him belong all sovereignty and praise and He is over all things omnipotent. My Lord, I ask You for the good of this day and the good of what follows it and I take refuge in You from the evil of this day and the evil of what follows it . My Lord, I take refuge in You from laziness and senility. My Lord, I take refuge in You from torment in the Fire and punishment in the grave.’",
      "REPEAT": 1,
      "AUDIO": "http://www.hisnmuslim.com/audio/ar/77.mp3"
    },
    {
      "ID": 78,
      "ARABIC_TEXT":
          "((اللَّهُمَّ بِكَ أَصْبَحْنَا، وَبِكَ أَمْسَيْنَا ، وَبِكَ نَحْيَا، وَبِكَ نَمُوتُ وَإِلَيْكَ النُّشُورُ)). [وإذا أمسى قال: اللَّهم بك أمسينا، وبك أصبحنا، وبك نحيا، وبك نموت، وإليك المصير.]",
      "LANGUAGE_ARABIC_TRANSLATED_TEXT":
          "(Allahumma bika asbahna wabika amsayna, wabika nahya ,wabika namootu wa-ilaykan-nushoor.)[In the evening:] (Allahumma bika amsayna, wabika asbahna, wabika nahya wabika namootu wa-ilaykal-maseer.)",
      "TRANSLATED_TEXT":
          "(O Allah, by your leave we have reached the morning and by Your leave we have reached the evening, by Your leave we live and die and unto You is our resurrection.)[In the evening:](O Allah, by Your leave we have reached the evening and by Your leave we have reached the morning, by Your leave we live and die and unto You is our return.)",
      "REPEAT": 1,
      "AUDIO": "http://www.hisnmuslim.com/audio/ar/78.mp3"
    },
    {
      "ID": 79,
      "ARABIC_TEXT":
          "((اللَّهُمَّ أَنْتَ رَبِّي لَا إِلَهَ إِلاَّ أَنْتَ، خَلَقْتَنِي وَأَنَا عَبْدُكَ، وَأَنَا عَلَى عَهْدِكَ وَوَعْدِكَ مَا اسْتَطَعْتُ، أَعُوذُ بِكَ مِنْ شَرِّ مَا صَنَعْتُ، أَبُوءُ لَكَ بِنِعْمَتِكَ عَلَيَّ، وَأَبُوءُ بِذَنْبِي فَاغْفِرْ لِي فَإِنَّهُ لاَ يَغْفِرُ الذُّنوبَ إِلاَّ أَنْتَ)).",
      "LANGUAGE_ARABIC_TRANSLATED_TEXT":
          "(Allahumma anta rabbee la ilaha illa ant, khalaqtanee wa-ana AAabduk, wa-ana AAala AAahdika wawaAAdika mas-tataAAt, aAAoothu bika min sharri ma sanaAAt, aboo-o laka biniAAmatika AAalay, wa-aboo-o bithanbee, faghfir lee fa-innahu la yaghfiruth-thunooba illa ant.)",
      "TRANSLATED_TEXT":
          "(O Allah, You are my Lord, none has the right to be worshipped except You, You created me and I am Your servant and I abide to Your covenant and promise as best I can, I take refuge in You from the evil of which I have committed.  I acknowledge Your favour upon me and I acknowledge my sin, so forgive me, for verily none can forgive sin except You.)",
      "REPEAT": 1,
      "AUDIO": "http://www.hisnmuslim.com/audio/ar/79.mp3"
    },
    {
      "ID": 80,
      "ARABIC_TEXT":
          "((اللَّهُمَّ إِنِّي أَصْبَحْتُ أُشْهِدُكَ، وَأُشْهِدُ حَمَلَةَ عَرْشِكَ، وَمَلاَئِكَتِكَ، وَجَمِيعَ خَلْقِكَ، أَنَّكَ أَنْتَ اللَّهُ لَا إِلَهَ إِلاَّ أَنْتَ وَحْدَكَ لاَ شَرِيكَ لَكَ، وَأَنَّ مُحَمَّداً عَبْدُكَ وَرَسُولُكَ)) (أربعَ مَرَّاتٍ).[ وإذا أمسى قال: اللَّهم إني أمسيت...]",
      "LANGUAGE_ARABIC_TRANSLATED_TEXT":
          "(Allahumma innee asbahtu oshhiduk, wa-oshhidu hamalata AAarshik, wamala-ikatak, wajameeAAa khalqik, annaka antal-lahu la ilaha illa ant, wahdaka la shareeka lak, wa-anna Muhammadan AAabduka warasooluk .) (four times in the morning & evening)(Note: for the evening, one reads (amsaytu) instead of (asbahtu).)",
      "TRANSLATED_TEXT":
          "(O Allah, verily I have reached the morning and call on You, the bearers of Your throne, Your angles, and all of Your creation to witness that You are Allah, none has the right to be worshipped except You, alone, without partner and that Muhammad is Your Servant and Messenger.) (four times in the morning & evening)(Note: for the evening, one reads (amsaytu) instead of (asbahtu).)",
      "REPEAT": 4,
      "AUDIO": "http://www.hisnmuslim.com/audio/ar/80.mp3"
    },
    {
      "ID": 81,
      "ARABIC_TEXT":
          "((اللَّهُمَّ مَا أَصْبَحَ بِي مِنْ نِعْمَةٍ أَوْ بِأَحَدٍ مِنْ خَلْقِكَ فَمِنْكَ وَحْدَكَ لاَ شَرِيكَ لَكَ، فَلَكَ الْحَمْدُ وَلَكَ الشُّكْرُ)). [وإذا أمسى قال: اللَّهم ما أمسى بي...]",
      "LANGUAGE_ARABIC_TRANSLATED_TEXT":
          "(Allahumma ma asbaha bee min niAAmatin, aw bi-ahadin min khalqik, faminka wahdaka la shareeka lak, falakal-hamdu walakash-shukr.)(Note: for the evening, one reads (amsa) instead of (asbaha).)",
      "TRANSLATED_TEXT":
          "(O Allah, what blessing I or any of Your creation have risen upon, is from You alone, without partner, so for You is all praise and unto You all thanks.)(…whoever says this in the morning has indeed offered his day’s thanks and whoever says this in the evening has indeed offered his night’s thanks.)(Note: for the evening, one reads (amsa) instead of (asbaha).)",
      "REPEAT": 1,
      "AUDIO": "http://www.hisnmuslim.com/audio/ar/81.mp3"
    },
    {
      "ID": 82,
      "ARABIC_TEXT":
          "((اللَّهُمَّ عَافِنِي فِي بَدَنِي، اللَّهُمَّ عَافِنِي فِي سَمْعِي، اللَّهُمَّ عَافِنِي فِي بَصَرِي، لاَ إِلَهَ إِلاَّ أَنْتَ. اللَّهُمَّ  إِنِّي أَعُوذُ بِكَ مِنَ الْكُفْرِ، وَالفَقْرِ، وَأَعُوذُ بِكَ مِنْ عَذَابِ القَبْرِ، لاَ إِلَهَ إِلاَّ أَنْتَ)) (ثلاثَ مرَّاتٍ).",
      "LANGUAGE_ARABIC_TRANSLATED_TEXT":
          "(Allahumma AAafinee fee badanee, allahumma AAafinee fee samAAee, allahumma AAafinee fee basaree, la ilaha illa ant.(three times).)(Allahumma innee aAAoothu bika minal-kufr, walfaqr, wa-aAAoothu bika min AAathabil-qabr, la ilaha illa ant (three times).)",
      "TRANSLATED_TEXT":
          "(O Allah, grant my body health, O Allah, grant my hearing health, O Allah, grant my sight health.  None has the right to be worshipped except You.)(three times) (O Allah, I take refuge with You from disbelief and poverty, and I take refuge with You from the punishment of the grave.  None has the right to be worshipped except You. (three times))",
      "REPEAT": 3,
      "AUDIO": "http://www.hisnmuslim.com/audio/ar/82.mp3"
    },
    {
      "ID": 83,
      "ARABIC_TEXT":
          "((حَسْبِيَ اللَّهُ لاَ إِلَهَ إِلاَّ هُوَ عَلَيهِ تَوَكَّلتُ وَهُوَ رَبُّ الْعَرْشِ الْعَظِيمِ)) (سَبْعَ مَرّاتٍ).",
      "LANGUAGE_ARABIC_TRANSLATED_TEXT":
          "(Hasbiyal-lahu la ilaha illa huwa, AAalayhi tawakkalt, wahuwa rabbul-AAarshil-AAatheem (Recite seven times in Arabic.)",
      "TRANSLATED_TEXT":
          "Allah is Sufficient for me, none has the right to be worshipped except Him, upon Him I rely and He is Lord of the exalted throne.’ (Recite seven times in Arabic.)",
      "REPEAT": 1,
      "AUDIO": "http://www.hisnmuslim.com/audio/ar/83.mp3"
    },
    {
      "ID": 84,
      "ARABIC_TEXT":
          "((اللَّهُمَّ إِنِّي أَسْأَلُكَ الْعَفْوَ وَالْعَافِيَةَ فِي الدُّنْيَا وَالآخِرَةِ، اللَّهُمَّ إِنِّي أَسْأَلُكَ الْعَفْوَ وَالْعَافِيَةَ: فِي دِينِي وَدُنْيَايَ وَأَهْلِي، وَمَالِي، اللَّهُمَّ اسْتُرْ عَوْرَاتِي، وَآمِنْ رَوْعَاتِي، اللَّهُمَّ احْفَظْنِي مِنْ بَينِ يَدَيَّ، وَمِنْ خَلْفِي، وَعَنْ يَمِينِي، وَعَنْ شِمَالِي، وَمِنْ فَوْقِي، وَأَعُوذُ بِعَظَمَتِكَ أَنْ أُغْتَالَ مِنْ تَحْتِي)).",
      "LANGUAGE_ARABIC_TRANSLATED_TEXT":
          "Allahumma innee as-alukal-AAafwa walAAafiyah, fid-dunya wal-akhirah, allahumma innee as-alukal-AAafwa walAAafiyah fee deenee, wadunyaya wa-ahlee, wamalee, allahummas-tur AAawratee, wa-amin rawAAatee, allahummah-fathnee min bayni yaday, wamin khalfee, waAAan yameenee, waAAan shimalee, wamin fawqee, wa-aAAoothu biAAathamatika an oghtala min tahtee.",
      "TRANSLATED_TEXT":
          "O Allah, I ask You for pardon and well-being in this life and the next. O Allah, I ask You for pardon and well-being in my religious and worldly affairs, and my family and my wealth. O Allah, veil my weaknesses and set at ease my dismay. O Allah, preserve me from the front and from behind and on my right and on my left and from above, and I take refuge with You lest I be swallowed up by the earth.",
      "REPEAT": 1,
      "AUDIO": "http://www.hisnmuslim.com/audio/ar/84.mp3"
    },
    {
      "ID": 85,
      "ARABIC_TEXT":
          "((اللَّهُمَّ عَالِمَ الغَيْبِ وَالشَّهَادَةِ فَاطِرَ السَّمَوَاتِ وَالْأَرْضِ، رَبَّ كُلِّ شَيْءٍ وَمَلِيكَهُ، أَشْهَدُ أَنْ لاَ إِلَهَ إِلاَّ أَنْتَ، أَعُوذُ بِكَ مِنْ شَرِّ نَفْسِي، وَمِنْ شَرِّ الشَّيْطانِ وَشَرَكِهِ، وَأَنْ أَقْتَرِفَ عَلَى  نَفْسِي سُوءاً، أَوْ أَجُرَّهُ إِلَى مُسْلِمٍ)).",
      "LANGUAGE_ARABIC_TRANSLATED_TEXT":
          "(Allahumma AAalimal-ghaybi washshahadah, fatiras-samawati wal-ard, rabba kulli shayin wamaleekah, ashhadu an la ilaha illa ant, aAAoothu bika min sharri nafsee wamin sharrish-shaytani washirkih, waan aqtarifa AAala nafsee soo-an aw ajurrahu ila muslim.)",
      "TRANSLATED_TEXT":
          "(O Allah, Knower of the unseen and the seen, Creator of the heavens and the Earth, Lord and Sovereign of all things, I bear witness that none has the right to be worshipped except You. I take refuge in You from the evil of my soul and from the evil and shirk of the devil, and from committing wrong against my soul or bringing such upon another Muslim.)(shirk: to associate others with Allah in those things which are specific to Him.  This can occur in (1) belief, e.g. to believe that other than Allah has the power to benefit or harm, (2) speech, e.g. to swear by other than Allah and (3) action, e.g. to bow or prostrate to other than Allah.)",
      "REPEAT": 1,
      "AUDIO": "http://www.hisnmuslim.com/audio/ar/85.mp3"
    },
    {
      "ID": 86,
      "ARABIC_TEXT":
          "((بِسْمِ اللَّهِ الَّذِي لاَ يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي الْأَرْضِ وَلاَ فِي السّمَاءِ وَهُوَ السَّمِيعُ الْعَلِيمُ)) (ثلاثَ مرَّاتٍ).",
      "LANGUAGE_ARABIC_TRANSLATED_TEXT":
          "(Bismil-lahil-lathee la yadurru maAAas-mihi shay-on fil-ardi wala fis-sama-i wahuwas-sameeAAul-AAaleem. (three times).)",
      "TRANSLATED_TEXT":
          "(In the name of Allah with whose name nothing is harmed on earth nor in the heavens and He is The All-Seeing, The All-Knowing.’(three times))",
      "REPEAT": 3,
      "AUDIO": "http://www.hisnmuslim.com/audio/ar/86.mp3"
    },
    {
      "ID": 87,
      "ARABIC_TEXT":
          "((رَضِيتُ بِاللَّهِ رَبَّاً، وَبِالْإِسْلاَمِ دِيناً، وَبِمُحَمَّدٍ صلى الله عليه وسلم نَبِيّاً)) (ثلاثَ مرَّاتٍ).",
      "LANGUAGE_ARABIC_TRANSLATED_TEXT":
          "(Radeetu billahi rabban wabil-islami deenan wabiMuhammadin  nabiyya. (three times))",
      "TRANSLATED_TEXT":
          "(I am pleased with Allah as a Lord, and Islam as a religion and Muhammad  as a Prophet.’(three times))",
      "REPEAT": 3,
      "AUDIO": "http://www.hisnmuslim.com/audio/ar/87.mp3"
    },
    {
      "ID": 88,
      "ARABIC_TEXT":
          "((يَا حَيُّ يَا قَيُّومُ بِرَحْمَتِكَ أَسْتَغيثُ أَصْلِحْ لِي شَأْنِيَ كُلَّهُ وَلاَ تَكِلْنِي إِلَى نَفْسِي طَرْفَةَ عَيْنٍ)).",
      "LANGUAGE_ARABIC_TRANSLATED_TEXT":
          "(Ya hayyu ya qayyoom, birahmatika astagheeth, aslih lee sha/nee kullah, wala takilnee ila nafsee tarfata AAayn.)",
      "TRANSLATED_TEXT":
          "(O Ever Living, O Self-Subsisting and Supporter of all, by Your mercy I seek assistance, rectify for me all of my affairs and do not leave me to myself, even for the blink of an eye.)",
      "REPEAT": 1,
      "AUDIO": "http://www.hisnmuslim.com/audio/ar/88.mp3"
    },
    {
      "ID": 89,
      "ARABIC_TEXT":
          "((أَصْبَحْنَا وَأَصْبَحَ الْمُلْكُ لِلَّهِ رَبِّ الْعَالَمِينَ، اللَّهُـمَّ إِنِّي أَسْأَلُكَ خَيْرَ هَذَا الْيَوْمِ:فَتْحَهُ، وَنَصْرَهُ، وَنورَهُ، وَبَرَكَتَهُ، وَهُدَاهُ، وَأَعُوذُ بِكَ مِنْ شَرِّ مَا فِيهِ وَشَرِّ مَا بَعْدَهُ)). [وإذا أمسى قال: أمسينا وأمسى الملك للَّه ربّ العالمين اللَّهم إني أسألك خير هذه الليلة: فتحها، ونصرها، ونورها، وبركتها، وهداها، وأعوذ بك من شر ما فيها، وشر ما بعدها.]",
      "LANGUAGE_ARABIC_TRANSLATED_TEXT":
          "(Asbahna wa-asbahal-mulku lillahi rabbil-AAalameen, allahumma innee as-aluka khayra hathal-yawm, fat-hahu, wanasrahu, wanoorahu, wabarakatahu, wahudahu, wa-aAAoothu bika min sharri ma feehi, washarri ma baAAdah.)[For the evening, the supplication is read as follows: ](Amsayna wa-amsal-mulku lillahi rabbil-AAalameen, allahumma innee as-aluka khayra hathihil-laylah, fat-haha, wanasraha, wanooraha, wabarakataha, wahudaha, wa-aAAoothu bika min sharri ma feeha washarri ma baAAdaha.)",
      "TRANSLATED_TEXT":
          "(We have reached the morning and at this very time all sovereignty belongs to Allah, Lord of the worlds. O Allah, I ask You for the good of this day, its triumphs and its victories, its light and its blessings and its guidance, and I take refuge in You from the evil of this day and the evil that follows it.)[For the evening, the supplication is read as follows:](We have reached the evening and at this very time all sovereignty belongs to Allah, Lord of the worlds. O Allah, I ask You for the good of tonight, its triumphs and its victories, its light and its blessings and its guidance, and I take refuge in You from the evil of tonight and the evil that follows it.)",
      "REPEAT": 1,
      "AUDIO": "http://www.hisnmuslim.com/audio/ar/89.mp3"
    },
    {
      "ID": 90,
      "ARABIC_TEXT":
          "((أَصْبَحْنا عَلَى فِطْرَةِ الْإِسْلاَمِ، وَعَلَى كَلِمَةِ الْإِخْلاَصِ، وَعَلَى دِينِ نَبِيِّنَا مُحَمَّدٍ صلى الله عليه وسلم، وَعَلَى مِلَّةِ أَبِينَا إِبْرَاهِيمَ، حَنِيفاً مُسْلِماً وَمَا كَانَ مِنَ الْمُشرِكِينَ)). [وإذا أمسى قال: أمسينا على فطرة الإسلام...]",
      "LANGUAGE_ARABIC_TRANSLATED_TEXT":
          "(Asbahna AAala fitratil-islam, waAAala kalimatil-ikhlas, waAAala deeni nabiyyina Muhammad  waAAala millati abeena Ibraheem, haneefan musliman wama kana minal-mushrikeen.)(Note: for the evening, one reads amsayna instead of asbahna.)",
      "TRANSLATED_TEXT":
          "(We rise upon the fitrah of Islam, and the word of pure faith, and upon the religion of our Prophet Muhammad  and the religion of our forefather Ibraheem, who was a Muslim and of true faith and was not of those who associate others with Allah.)(fitrah: the religion of Islam, the way of Ibraheem u.)(Note: for the evening, one reads amsayna instead of asbahna.)",
      "REPEAT": 1,
      "AUDIO": "http://www.hisnmuslim.com/audio/ar/90.mp3"
    },
    {
      "ID": 91,
      "ARABIC_TEXT": "((سُبْحَانَ اللَّهِ وَبِحَمْدِهِ)) (مائة مرَّةٍ).",
      "LANGUAGE_ARABIC_TRANSLATED_TEXT":
          "(Subhanal-lahi wabihamdih.)one hundred times)",
      "TRANSLATED_TEXT":
          "(How perfect Allah is and I praise Him.)(one hundred times)",
      "REPEAT": 100,
      "AUDIO": "http://www.hisnmuslim.com/audio/ar/91.mp3"
    },
    {
      "ID": 92,
      "ARABIC_TEXT":
          "((لاَ إِلَهَ إِلاَّ اللَّهُ وَحْدَهُ لاَ شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ، وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ)) (عشرَ مرَّات) ، أَوْ (مرَّةً واحدةً عندَ الكَسَلِ).",
      "LANGUAGE_ARABIC_TRANSLATED_TEXT":
          "(La ilaha illal-lah, wahdahu la shareeka lah, lahul-mulku walahul-hamd, wahuwa AAala kulli shay-in qadeer.  [ten times or once if lazy])",
      "TRANSLATED_TEXT":
          "(None has the right to be worshipped except Allah, alone, without partner, to Him belongs all sovereignty and praise, and He is over all things omnipotent.)( [ten times or once if lazy])",
      "REPEAT": 10,
      "AUDIO": "http://www.hisnmuslim.com/audio/ar/92.mp3"
    },
    {
      "ID": 93,
      "ARABIC_TEXT":
          "((لاَ إِلَهَ إِلاَّ اللَّهُ، وَحْدَهُ لاَ شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ)) (مائةَ مرَّةٍ إذا أصبحَ).",
      "LANGUAGE_ARABIC_TRANSLATED_TEXT":
          "(La ilaha illal-lah, wahdahu la shareeka lah, lahul-mulku walahul-hamd, wahuwa AAala kulli shay-in qadeer. (one hundred times every day))",
      "TRANSLATED_TEXT":
          "(None has the right to be worshipped except Allah, alone, without partner, to Him belongs all sovereignty and praise, and He is over all things omnipotent.)((one hundred times every day))",
      "REPEAT": 100,
      "AUDIO": "http://www.hisnmuslim.com/audio/ar/93.mp3"
    },
    {
      "ID": 94,
      "ARABIC_TEXT":
          "((سُبْحَانَ اللَّهِ وَبِحَمْدِهِ: عَدَدَ خَلْقِهِ، وَرِضَا نَفْسِهِ، وَزِنَةَ عَرْشِهِ، وَمِدَادَ كَلِمَاتِهِ)) (ثلاثَ مرَّاتٍ إذا أصبحَ).",
      "LANGUAGE_ARABIC_TRANSLATED_TEXT":
          "(Subhanal-lahi wabihamdih, AAadada khalqihi warida nafsih, wazinata AAarshih, wamidada kalimatih.)(three times)",
      "TRANSLATED_TEXT":
          "(How perfect Allah is and I praise Him by the number of His creation and His pleasure, and by the weight of His throne, and the ink of His words.)(three times)",
      "REPEAT": 3,
      "AUDIO": "http://www.hisnmuslim.com/audio/ar/94.mp3"
    },
    {
      "ID": 95,
      "ARABIC_TEXT":
          "((اللَّهُمَّ إِنِّي أَسْأَلُكَ عِلْماً نَافِعاً، وَرِزْقاً طَيِّباً، وَعَمَلاً مُتَقَبَّلاً)) (إذا أصبحَ).",
      "LANGUAGE_ARABIC_TRANSLATED_TEXT":
          "(Allahumma innee as-aluka AAilman nafiAAan, warizqan tayyiban, waAAamalan mutaqabbalan.)",
      "TRANSLATED_TEXT":
          "(O Allah, I ask You for knowledge which is beneficial and sustenance which is good, and deeds which are acceptable.)",
      "REPEAT": 1,
      "AUDIO": "http://www.hisnmuslim.com/audio/ar/95.mp3"
    },
    {
      "ID": 96,
      "ARABIC_TEXT":
          "((أَسْتَغْفِرُ اللَّهَ وَأَتُوبُ إِلَيْهِ)) (مِائَةَ مَرَّةٍ فِي الْيَوْمِ).",
      "LANGUAGE_ARABIC_TRANSLATED_TEXT":
          "Astaghfirullaaha wa 'atoobu 'ilayhi[one hundred times a day]",
      "TRANSLATED_TEXT":
          "‘I seek Allaah’s forgiveness and I turn to Him in repentance.’ [one hundred times a day]",
      "REPEAT": 100,
      "AUDIO": "http://www.hisnmuslim.com/audio/ar/96.mp3"
    },
    {
      "ID": 97,
      "ARABIC_TEXT":
          "((أَعُوذُ بِكَلِمَاتِ اللَّهِ التَّامَّاتِ مِنْ شَرِّ مَا خَلَقَ)) (ثلاثَ مرَّاتٍ إذا أمسى).",
      "LANGUAGE_ARABIC_TRANSLATED_TEXT":
          "(aAAoothu bikalimatil-lahit-tammati min sharri ma khalaq.) (three times in the evening)",
      "TRANSLATED_TEXT":
          "(I take refuge in Allah’s perfect words from the evil He has created.)(three times in the evening)",
      "REPEAT": 3,
      "AUDIO": "http://www.hisnmuslim.com/audio/ar/97.mp3"
    },
    {
      "ID": 98,
      "ARABIC_TEXT":
          "((اللَّهُمَّ صَلِّ وَسَلِّمْ عَلَى نَبَيِّنَا مُحَمَّدٍ)) (عشرَ مرَّاتٍ).",
      "LANGUAGE_ARABIC_TRANSLATED_TEXT":
          "Allaahumma salli wa sallim 'alaa Nabiyyinaa Muhammadin[ten times]",
      "TRANSLATED_TEXT":
          "‘O Allaah, send prayers and peace upon our Prophet Muhammad.’ [ten times]",
      "REPEAT": 10,
      "AUDIO": "http://www.hisnmuslim.com/audio/ar/98.mp3"
    }
  ];
}

List<dynamic> hisnmuslim28() {
  return [
    {
      "ID": 99,
      "ARABIC_TEXT":
          "((يَجْمَعُ كَفَّيْهِ ثُمَّ يَنْفُثُ فِيهِمَا فَيَقْرَأُ فِيهِمَا:بسم الله الرحمن الرحيم ﴿قُلْ هُوَ اللَّهُ أَحَدٌ * اللَّهُ الصَّمَدُ* لَمْ يَلِدْ وَلَمْ يُولَدْ* وَلَمْ يَكُن لَّهُ كُفُواً أَحَدٌ﴾.  بسم الله الرحمن الرحيم ﴿قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ* مِن شَرِّ مَا خَلَقَ* وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ* وَمِن شَرِّ النَّفَّاثَاتِ فِي الْعُقَدِ* وَمِن شَرِّ حَاسِدٍ إِذَا حَسَدَ﴾.  بسم الله الرحمن الرحيم ﴿قُلْ أَعُوذُ بِرَبِّ النَّاسِ* مَلِكِ النَّاسِ* إِلَهِ النَّاسِ* مِن شَرِّ الْوَسْوَاسِ الْخَنَّاسِ* الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ* مِنَ الْجِنَّةِ وَ النَّاسِ﴾ ثُمَّ يَمْسَحُ بِهِمَا مَا اسْتَطَاعَ مِنْ جَسَدِهِ يَبْدَأُ بِهِمَا عَلَى رَأْسِهِ وَوَجْهِهِ وَمَا أَقبَلَ مِنْ جَسَدِهِ)) (يفعلُ ذلك ثلاثَ مرَّاتٍ).",
      "LANGUAGE_ARABIC_TRANSLATED_TEXT": "",
      "TRANSLATED_TEXT":
          "(When retiring to his bed every night, the Prophet  would hold his palms together, spit (A form of spitting comprising mainly of air with little spittle) in them, recite the last three chapters (Al-Ikhlas, Al-Falaq, An-Nas) of the Quran and then wipe over his entire body as much as possible with his hands, beginning with his head and face and then all parts of the body, he would do this three times.)",
      "REPEAT": 3,
      "AUDIO": "http://www.hisnmuslim.com/audio/ar/99.mp3"
    },
    {
      "ID": 100,
      "ARABIC_TEXT":
          "﴿اللَّهُ لاَ إِلَهَ إِلاَّ هُوَ الْحَيُّ الْقَيُّومُ لاَ تَأْخُذُهُ سِنَةٌ وَلاَ نَوْمٌ لَّهُ مَا فِي السَّمَوَاتِ وَمَا فِي الأَرْضِ مَن ذَا الَّذِي يَشْفَعُ عِنْـــــــــــدَهُ إِلاَّ بِإِذْنِهِ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ وَلاَ يُحِيطُونَ بِشَيْءٍ مِّنْ عِلْمِهِ إِلاَّ بِمَا شَاء وَسِعَ كُرْسِيُّهُ السَّمَوَاتِ وَالأَرْضَ وَلاَ يَؤُودُهُ حِفْظُهُمَا وَهُوَ الْعَلِيُّ الْعَظِيمُ﴾.",
      "LANGUAGE_ARABIC_TRANSLATED_TEXT":
          "Recite Ayat-Al-Kursiy (Al-Baqarah :255)",
      "TRANSLATED_TEXT":
          " Allah - there is no deity except Him, the Ever-Living, the Sustainer of [all] existence. Neither drowsiness overtakes Him nor sleep. To Him belongs whatever is in the heavens and whatever is on the earth. Who is it that can intercede with Him except by His permission? He knows what is [presently] before them and what will be after them, and they encompass not a thing of His knowledge except for what He wills. His Kursi extends over the heavens and the earth, and their preservation tires Him not. And He is the Most High, the Most Great.",
      "REPEAT": 1,
      "AUDIO": "http://www.hisnmuslim.com/audio/ar/100.mp3"
    },
    {
      "ID": 101,
      "ARABIC_TEXT":
          "﴿آمَنَ الرَّسُولُ بِمَا أُنزِلَ إِلَيْهِ مِن رَّبِّهِ وَالْمُؤْمِنُونَ كُلٌّ آمَنَ بِاللَّهِ وَمَلآئِكَتِهِ وَكُتُبِهِ وَرُسُلِهِ لاَ نُفَرِّقُ بَيْنَ أَحَدٍ مِّن رُّسُلِهِ وَقَالُواْ سَمِعْنَا وَأَطَعْنَا غُفْرَانَكَ رَبَّنَا وَإِلَيْكَ الْمَصِيرُ* لاَ يُكَلِّفُ اللَّهُ نَفْساً إِلاَّ وُسْعَهَا لَهَا مَا كَسَبَتْ وَعَلَيْهَا مَا اكْتَسَبَتْ رَبَّنَا لاَ تُؤَاخِذْنَا إِن نَّسِينَا أَوْ أَخْطَأْنَا رَبَّنَا وَلاَ تَحْمِلْ عَلَيْنَا إِصْراً كَمَا حَمَلْتَهُ عَلَى الَّذِينَ مِن قَبْلِنَا رَبَّنَا وَلاَ تُحَمِّلْنَا مَا لاَ طَاقَةَ لَنَا بِهِ وَاعْفُ عَنَّا وَاغْفِرْ لَنَا وَارْحَمْنَآ أَنتَ مَوْلاَنَا فَانصُرْنَا عَلَى الْقَوْمِ الْكَافِرِينَ﴾.",
      "LANGUAGE_ARABIC_TRANSLATED_TEXT":
          "Recite last two verses of Soorah (Al-Baqarah :285-286)",
      "TRANSLATED_TEXT":
          "( 285 )   The Messenger has believed in what was revealed to him from his Lord, and [so have] the believers. All of them have believed in Allah and His angels and His books and His messengers, [saying], We make no distinction between any of His messengers. And they say, We hear and we obey. [We seek] Your forgiveness, our Lord, and to You is the [final] destination.( 286 )   Allah does not charge a soul except [with that within] its capacity. It will have [the consequence of] what [good] it has gained, and it will bear [the consequence of] what [evil] it has earned. Our Lord, do not impose blame upon us if we have forgotten or erred. Our Lord, and lay not upon us a burden like that which You laid upon those before us. Our Lord, and burden us not with that which we have no ability to bear. And pardon us; and forgive us; and have mercy upon us. You are our protector, so give us victory over the disbelieving people.",
      "REPEAT": 1,
      "AUDIO": "http://www.hisnmuslim.com/audio/ar/101.mp3"
    },
    {
      "ID": 102,
      "ARABIC_TEXT":
          "((بِاسْمِكَ رَبِّي وَضَعْتُ جَنْبِي، وَبِكَ أَرْفَعُهُ، فَإِن أَمْسَكْتَ نَفْسِي فارْحَمْهَا، وَإِنْ أَرْسَلْتَهَا فَاحْفَظْهَا، بِمَا تَحْفَظُ بِهِ عِبَادَكَ الصَّالِحِينَ)).",
      "LANGUAGE_ARABIC_TRANSLATED_TEXT":
          "(Bismika rabbee wadaAAtu janbee wabika arfaAAuh, fa-in amsakta nafsee farhamha, wa-in arsaltaha fahfathha bima tahfathu bihi AAibadakas-saliheen.)",
      "TRANSLATED_TEXT":
          "(In Your name my Lord, I lie down and in Your name I rise, so if You should take my soul then have mercy upon it, and if You should return my soul then protect it in the manner You do so with Your righteous servants.)",
      "REPEAT": 1,
      "AUDIO": "http://www.hisnmuslim.com/audio/ar/102.mp3"
    },
    {
      "ID": 103,
      "ARABIC_TEXT":
          "((اللَّهُمَّ إِنَّكَ خَلَقْتَ نَفْسِي وَأَنْتَ تَوَفَّاهَا، لَكَ مَمَاتُهَا وَمَحْياهَا، إِنْ أَحْيَيْتَهَا فَاحْفَظْهَا، وَإِنْ أَمَتَّهَا فَاغْفِرْ لَهَا. اللَّهُمَّ إِنِّي أَسْأَلُكَ العَافِيَةَ)).",
      "LANGUAGE_ARABIC_TRANSLATED_TEXT":
          "(Allahumma innaka khalaqta nafsee wa-anta tawaffaha, laka mamatuha wamahyaha in ahyaytaha fahfathha, wa-in amattaha faghfir laha. Allahumma innee as-alukal-AAafiyah.)",
      "TRANSLATED_TEXT":
          "(O Allah, verily You have created my soul and You shall take it’s life, to You belongs it’s life and death. If You should keep my soul alive then protect it, and if You should take it’s life then forgive it. O Allah, I ask You to grant me good health.)",
      "REPEAT": 1,
      "AUDIO": "http://www.hisnmuslim.com/audio/ar/103.mp3"
    },
    {
      "ID": 104,
      "ARABIC_TEXT":
          " ((اللَّهُمَّ قِنِي عَذَابَكَ يَوْمَ تَبْعَثُ عِبَادَكَ)).",
      "LANGUAGE_ARABIC_TRANSLATED_TEXT":
          "(Allahumma qinee AAathabaka yawma tabAAathu AAibadak.)",
      "TRANSLATED_TEXT":
          "(O Allah, protect me from Your punishment on the day Your servants are resurrected.)",
      "REPEAT": 1,
      "AUDIO": "http://www.hisnmuslim.com/audio/ar/104.mp3"
    },
    {
      "ID": 105,
      "ARABIC_TEXT": "((بِاسْمِكَ اللَّهُمَّ أَمُوتُ وَأَحْيَا)).",
      "LANGUAGE_ARABIC_TRANSLATED_TEXT": "(Bismikal-lahumma amootu wa-ahya.)",
      "TRANSLATED_TEXT": "(In Your name O Allah, I live and die.)",
      "REPEAT": 1,
      "AUDIO": "http://www.hisnmuslim.com/audio/ar/105.mp3"
    },
    {
      "ID": 106,
      "ARABIC_TEXT":
          "((سُبْحَانَ اللَّهِ (ثلاثاً وثلاثين) وَالْحَمْدُ لِلَّهِ (ثلاثاً وثلاثين) وَاللَّهُ أَكْبَرُ (أربعاً وثلاثينَ))).",
      "LANGUAGE_ARABIC_TRANSLATED_TEXT":
          "(Subhanal-lah. (thirty-three times) Alhamdu lillah. (thirty-three times) Allahu akbar. (thirty-four times))",
      "TRANSLATED_TEXT":
          "(How Perfect Allah is. (thirty-three times) All praise is for Allah.(thirty-three times) Allah is the greatest.(thirty-four times))",
      "REPEAT": 1,
      "AUDIO": "http://www.hisnmuslim.com/audio/ar/106.mp3"
    },
    {
      "ID": 107,
      "ARABIC_TEXT":
          "((اللَّهُمَّ رَبَّ السَّمَوَاتِ السَّبْعِ وَرَبَّ الأَرْضِ، وَرَبَّ الْعَرْشِ الْعَظِيمِ، رَبَّنَا وَرَبَّ كُلِّ شَيْءٍ، فَالِقَ الْحَبِّ وَالنَّوَى، وَمُنْزِلَ التَّوْرَاةِ وَالْإِنْجِيلِ، وَالْفُرْقَانِ، أَعُوذُ بِكَ مِنْ شَرِّ كُلِّ شَيْءٍ أَنْتَ آخِذٌ بِنَاصِيَتِهِ. اللَّهُمَّ أَنْتَ الأَوَّلُ فَلَيْسَ قَبْلَكَ شَيْءٌ، وَأَنْتَ الآخِرُ فَلَيسَ بَعْدَكَ شَيْءٌ، وَأَنْتَ الظَّاهِرُ فَلَيْسَ فَوْقَكَ شَيْءٌ، وَأَنْتَ الْبَاطِنُ فَلَيْسَ دُونَكَ شَيْءٌ، اقْضِ عَنَّا الدَّيْنَ وَأَغْنِنَا مِنَ الْفَقْرِ)).",
      "LANGUAGE_ARABIC_TRANSLATED_TEXT":
          "(Allahumma rabbas-samawatis-sabAA, warabbal-AAarshil-AAatheem, rabbana warabba kulli shay/, faliqal-habbi wannawa, wamunazzilat-tawra, wal-injeel, walfurqan, aAAoothu bika min sharri kulli shayin anta akhithun binasiyatih. Allahumma antal-awwal, falaysa qablaka shay/, wa-antal-akhir, falaysa baAAdaka shay/, wa-antath-thahir falaysa fawqaka shay/, waantal-batin, falaysa doonaka shay/, iqdi AAannad-dayna wa-aghnina minal-faqr.)",
      "TRANSLATED_TEXT":
          "(O Allah, Lord of the seven heavens and the exalted throne, our Lord and Lord of all things, Splitter of the seed and the date stone, Revealer of the Tawrah, the Injeel and the Furqan, I take refuge in You from the evil of all things You shall seize by the forelock (i.e. You have total mastery over). O Allah, You are The First so there is nothing before You and You are The Last so there is nothing after You.You are Aththahir so there is nothing above You and You are Al-Batin so there is nothing closer than You.Settle our debt for us and spare us from poverty.)(Tawrah: The book revealed to Moosa u.)(Injeel: The book revealed to Easa u.)(Furqan: One of the many names of the Quran, means: The Criterion which distinguishes between truth and falsehood.)(Aththahir: Indicates the greatness of His attributes and the insignificance of every single creation in respect to His greatness and Highness, for He is above all of His creation as regards His essence and attributes.)(Al-Batin: Indicates His awareness and knowledge of all secrets, of that which is in the hearts and the most intimate of things just as it indicates His closeness and nearness to all in a manner which befits His majesty.)",
      "REPEAT": 1,
      "AUDIO": "http://www.hisnmuslim.com/audio/ar/107.mp3"
    },
    {
      "ID": 108,
      "ARABIC_TEXT":
          "((الْحَمْدُ لِلَّهِ الَّذِي أَطْعَمَنَا وَسَقَانَا، وَكَفَانَا، وَآوَانَا، فَكَمْ مِمَّنْ لاَ كَافِيَ لَهُ وَلاَ مُؤْوِيَ)).",
      "LANGUAGE_ARABIC_TRANSLATED_TEXT":
          "(Alhamdu lillahil-lathee atAAamana wasaqana, wakafana, wa-awana, fakam mimman la kafiya lahu wala mu'wee.)",
      "TRANSLATED_TEXT":
          "(All praise is for Allah, Who fed us and gave us drink, and Who is sufficient for us and has sheltered us, for how many have none to suffice them or shelter them.)",
      "REPEAT": 1,
      "AUDIO": "http://www.hisnmuslim.com/audio/ar/108.mp3"
    },
    {
      "ID": 109,
      "ARABIC_TEXT":
          "((اللَّهُمَّ عَالِمَ الغَيْبِ وَالشَّهَادَةِ فَاطِرَ السَّمَوَاتِ وَالْأَرْضِ، رَبَّ كُلِّ شَيْءٍ وَمَلِيكَهُ، أَشْهَدُ أَنْ لاَ إِلَهَ إِلاَّ أَنْتَ، أَعُوذُ بِكَ مِنْ شَرِّ نَفْسِي، وَمِنْ شَرِّ الشَّيْطانِ وَشِرْكِهِ، وَأَنْ أَقْتَرِفَ عَلَى نَفْسِي سُوءاً، أَوْ أَجُرَّهُ إِلَى مُسْلِمٍ)).",
      "LANGUAGE_ARABIC_TRANSLATED_TEXT":
          "(Allahumma AAalimal-ghaybi washshahadah, fatiras-samawati wal-ard, rabba kulli shayin wamaleekah, ashhadu an la ilaha illa ant, aAAoothu bika min sharri nafsee wamin sharrish-shaytani washirkih, wa-an aqtarifa AAala nafsee soo-an aw ajurrahu ila muslim.)",
      "TRANSLATED_TEXT":
          "(O Allah, Knower of the seen and the unseen, Creator of the heavens and the earth, Lord and Sovereign of all things I bear witness that none has the right to be worshipped except You.  I take refuge in You from the evil of my soul and from the evil and shirk of the devil, and from committing wrong against my soul or bringing such upon another Muslim.)(shirk: to associate others with Allah in those things which are specific to Him.  This can occur in (1) belief, e.g. to believe that other than Allah has the power to benefit or harm, (2) speech, e.g. to swear by other than Allah and (3) action, e.g. to bow or prostrate to other than Allah.)",
      "REPEAT": 1,
      "AUDIO": "http://www.hisnmuslim.com/audio/ar/109.mp3"
    },
    {
      "ID": 110,
      "ARABIC_TEXT":
          "((يَقْرَأُ ﴿الم﴾ تَنْزِيلَ السَّجْدَة ِ،  وَتَبَارَكَ الَّذي بِيَدِهِ الْمُلْكُ)).",
      "LANGUAGE_ARABIC_TRANSLATED_TEXT": "",
      "TRANSLATED_TEXT":
          "(The Prophet  never used to sleep until he had recited Soorat As-Sajdah (chapter 32) and Soorat Al-Mulk (chapter 67).)",
      "REPEAT": 1,
      "AUDIO": "http://www.hisnmuslim.com/audio/ar/110.mp3"
    },
    {
      "ID": 111,
      "ARABIC_TEXT":
          "((اللَّهُمَّ أَسْلَمْتُ نَفْسِي إِلَيْكَ، وَفَوَّضْتُ أَمْرِي إِلَيْكَ، وَوَجَّهْتُ وَجْهِي إِلَيْكَ، وَأَلْجَأْتُ ظَهْرِي إِلَيْكَ، رَغْبَةً وَرَهْبَةً إِلَيْكَ، لاَ مَلْجَأَ وَلاَ مَنْجَا مِنْكَ إِلاَّ إِلَيْكَ، آمَنْتُ بِكِتَابِكَ الَّذِي أَنْزَلْتَ، وَبِنَبِيِّكَ الَّذِي أَرْسَلْتَ)).",
      "LANGUAGE_ARABIC_TRANSLATED_TEXT":
          "(Allahumma aslamtu nafsee ilayk, wafawwadtu amree ilayk, wawajjahtu wajhee ilayk, wa-alja/tu thahree ilayk, raghbatan warahbatan ilayk, la maljaa wala manja minka illa ilayk, amantu bikitabikal-lathee anzalt, wabinabiyyikal-lathee arsalt.)",
      "TRANSLATED_TEXT":
          "(O Allah, I submit my soul unto You, and I entrust my affair unto You, and I turn my face towards You, and I totally rely on You, in hope and fear of You.Verily there is no refuge nor safe haven from You except with You.  I believe in Your Book which You have revealed and in Your Prophet whom You have sent.)(If you then die, you will die upon the fitrah.)(fitrah: the religion of Islam, the way of Ibraheem u.)",
      "REPEAT": 1,
      "AUDIO": "http://www.hisnmuslim.com/audio/ar/111.mp3"
    }
  ];
}

List<dynamic> hisnmuslim8() {
  return [
    {
      "ID": 12,
      "ARABIC_TEXT": "(بِسْمِ اللَّهِ).",
      "LANGUAGE_ARABIC_TRANSLATED_TEXT": "(Bismil-lah.)",
      "TRANSLATED_TEXT": "(In the name of Allah.)",
      "REPEAT": 1,
      "AUDIO": "http://www.hisnmuslim.com/audio/ar/12.mp3"
    }
  ];
}

int getVersesCountFromId(
  dynamic jsonData,
  int chapterId,
) {
  // Find the chapter with the specified ID
  Map<String, dynamic>? chapter = (jsonData['chapters'] as List<dynamic>)
      .cast<Map<String, dynamic>>()
      .firstWhere((c) => c['id'] == chapterId);

  return chapter['verses_count'] ?? 1;
}

int return0() {
  return 0;
}

String getValueFromQuranSurahEN(
  dynamic jsonData,
  int chapterId,
  String key,
) {
  // Find the chapter with the specified ID
  Map<String, dynamic>? chapter = (jsonData['chapters'] as List<dynamic>)
      .cast<Map<String, dynamic>>()
      .firstWhere((c) => c['id'] == chapterId);

  return chapter[key] ?? "";
}

int getValueBeforeColon(String input) {
  // Split the input string using the colon as a delimiter
  List<String> parts = input.split(':');

  // Get the value before the colon (first element after splitting)
  String valueBeforeColon = parts.first;

  // Convert the string to an integer and return
  return int.parse(valueBeforeColon);
}

int getValueAfterColon(String input) {
  // Split the input string using the colon as a delimiter
  List<String> parts = input.split(':');

  // Get the value after the colon (second element after splitting)
  String valueAfterColon = parts.length > 1 ? parts[1] : '0';

  // Convert the string to an integer and return
  return int.parse(valueAfterColon);
}

dynamic sortQuranChapters(
  dynamic json,
  String sortBy,
  String direction,
) {
  if (json['chapters'] is List) {
    json['chapters'].sort((a, b) {
      var aValue = (a as Map<String, Object>?)?[sortBy];
      var bValue = (b as Map<String, Object>?)?[sortBy];

      if (aValue == null && bValue == null) {
        return 0; // both values are null, consider them equal
      } else if (aValue == null) {
        return -1; // a is null, consider it less than b
      } else if (bValue == null) {
        return 1; // b is null, consider it less than a
      }

      if (sortBy == 'id') {
        // Parse values as integers for numerical comparison
        aValue = int.parse(aValue.toString());
        bValue = int.parse(bValue.toString());
      }

      if (direction == 'asc') {
        return (aValue as Comparable).compareTo(bValue);
      } else {
        return (bValue as Comparable).compareTo(aValue);
      }
    });
  }
  return json;
}

double truncateToDecimalPlaces(
  double value,
  int numOfDecimalPlaces,
) {
// Calculate the multiplier to shift the decimal places
  double multiplier = 1.0;
  for (int i = 0; i < numOfDecimalPlaces; i++) {
    multiplier *= 10.0;
  }

  // Truncate the decimal places without rounding
  double truncatedValue = (value * multiplier).truncateToDouble() / multiplier;

  return truncatedValue;
}

String formattedUnixTimeDifference(
  int startTimestamp,
  int endTimestamp,
) {
  // Calculate the time difference in seconds.
  int timeDifference = endTimestamp - startTimestamp;

  // Calculate hours, minutes, and seconds.
  int hours = timeDifference ~/ 3600;
  int remainingSeconds = timeDifference % 3600;
  int minutes = remainingSeconds ~/ 60;

  // Format the result as "h m" without including minutes if it's zero.
  String formattedResult = hours > 0
      ? (minutes > 0 ? '$hours${'h'} $minutes${'m'}' : '$hours${'h'}')
      : '$minutes${'m'}';

  return formattedResult;
}

String userIDFromReferenceString(String referenceString) {
  List<String> parts = referenceString.split('/');
  return parts.isNotEmpty ? parts.last : '';
}

List<dynamic> countryList() {
  return [
    {
      "name": "Ascension Island",
      "code": "AC",
      "emoji": "🇦🇨",
      "unicode": "U+1F1E6 U+1F1E8",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/AC.svg"
    },
    {
      "name": "Andorra",
      "code": "AD",
      "emoji": "🇦🇩",
      "unicode": "U+1F1E6 U+1F1E9",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/AD.svg"
    },
    {
      "name": "United Arab Emirates",
      "code": "AE",
      "emoji": "🇦🇪",
      "unicode": "U+1F1E6 U+1F1EA",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/AE.svg"
    },
    {
      "name": "Afghanistan",
      "code": "AF",
      "emoji": "🇦🇫",
      "unicode": "U+1F1E6 U+1F1EB",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/AF.svg"
    },
    {
      "name": "Antigua & Barbuda",
      "code": "AG",
      "emoji": "🇦🇬",
      "unicode": "U+1F1E6 U+1F1EC",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/AG.svg"
    },
    {
      "name": "Anguilla",
      "code": "AI",
      "emoji": "🇦🇮",
      "unicode": "U+1F1E6 U+1F1EE",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/AI.svg"
    },
    {
      "name": "Albania",
      "code": "AL",
      "emoji": "🇦🇱",
      "unicode": "U+1F1E6 U+1F1F1",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/AL.svg"
    },
    {
      "name": "Armenia",
      "code": "AM",
      "emoji": "🇦🇲",
      "unicode": "U+1F1E6 U+1F1F2",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/AM.svg"
    },
    {
      "name": "Angola",
      "code": "AO",
      "emoji": "🇦🇴",
      "unicode": "U+1F1E6 U+1F1F4",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/AO.svg"
    },
    {
      "name": "Antarctica",
      "code": "AQ",
      "emoji": "🇦🇶",
      "unicode": "U+1F1E6 U+1F1F6",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/AQ.svg"
    },
    {
      "name": "Argentina",
      "code": "AR",
      "emoji": "🇦🇷",
      "unicode": "U+1F1E6 U+1F1F7",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/AR.svg"
    },
    {
      "name": "American Samoa",
      "code": "AS",
      "emoji": "🇦🇸",
      "unicode": "U+1F1E6 U+1F1F8",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/AS.svg"
    },
    {
      "name": "Austria",
      "code": "AT",
      "emoji": "🇦🇹",
      "unicode": "U+1F1E6 U+1F1F9",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/AT.svg"
    },
    {
      "name": "Australia",
      "code": "AU",
      "emoji": "🇦🇺",
      "unicode": "U+1F1E6 U+1F1FA",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/AU.svg"
    },
    {
      "name": "Aruba",
      "code": "AW",
      "emoji": "🇦🇼",
      "unicode": "U+1F1E6 U+1F1FC",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/AW.svg"
    },
    {
      "name": "Åland Islands",
      "code": "AX",
      "emoji": "🇦🇽",
      "unicode": "U+1F1E6 U+1F1FD",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/AX.svg"
    },
    {
      "name": "Azerbaijan",
      "code": "AZ",
      "emoji": "🇦🇿",
      "unicode": "U+1F1E6 U+1F1FF",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/AZ.svg"
    },
    {
      "name": "Bosnia & Herzegovina",
      "code": "BA",
      "emoji": "🇧🇦",
      "unicode": "U+1F1E7 U+1F1E6",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/BA.svg"
    },
    {
      "name": "Barbados",
      "code": "BB",
      "emoji": "🇧🇧",
      "unicode": "U+1F1E7 U+1F1E7",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/BB.svg"
    },
    {
      "name": "Bangladesh",
      "code": "BD",
      "emoji": "🇧🇩",
      "unicode": "U+1F1E7 U+1F1E9",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/BD.svg"
    },
    {
      "name": "Belgium",
      "code": "BE",
      "emoji": "🇧🇪",
      "unicode": "U+1F1E7 U+1F1EA",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/BE.svg"
    },
    {
      "name": "Burkina Faso",
      "code": "BF",
      "emoji": "🇧🇫",
      "unicode": "U+1F1E7 U+1F1EB",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/BF.svg"
    },
    {
      "name": "Bulgaria",
      "code": "BG",
      "emoji": "🇧🇬",
      "unicode": "U+1F1E7 U+1F1EC",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/BG.svg"
    },
    {
      "name": "Bahrain",
      "code": "BH",
      "emoji": "🇧🇭",
      "unicode": "U+1F1E7 U+1F1ED",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/BH.svg"
    },
    {
      "name": "Burundi",
      "code": "BI",
      "emoji": "🇧🇮",
      "unicode": "U+1F1E7 U+1F1EE",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/BI.svg"
    },
    {
      "name": "Benin",
      "code": "BJ",
      "emoji": "🇧🇯",
      "unicode": "U+1F1E7 U+1F1EF",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/BJ.svg"
    },
    {
      "name": "St. Barthélemy",
      "code": "BL",
      "emoji": "🇧🇱",
      "unicode": "U+1F1E7 U+1F1F1",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/BL.svg"
    },
    {
      "name": "Bermuda",
      "code": "BM",
      "emoji": "🇧🇲",
      "unicode": "U+1F1E7 U+1F1F2",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/BM.svg"
    },
    {
      "name": "Brunei",
      "code": "BN",
      "emoji": "🇧🇳",
      "unicode": "U+1F1E7 U+1F1F3",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/BN.svg"
    },
    {
      "name": "Bolivia",
      "code": "BO",
      "emoji": "🇧🇴",
      "unicode": "U+1F1E7 U+1F1F4",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/BO.svg"
    },
    {
      "name": "Caribbean Netherlands",
      "code": "BQ",
      "emoji": "🇧🇶",
      "unicode": "U+1F1E7 U+1F1F6",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/BQ.svg"
    },
    {
      "name": "Brazil",
      "code": "BR",
      "emoji": "🇧🇷",
      "unicode": "U+1F1E7 U+1F1F7",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/BR.svg"
    },
    {
      "name": "Bahamas",
      "code": "BS",
      "emoji": "🇧🇸",
      "unicode": "U+1F1E7 U+1F1F8",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/BS.svg"
    },
    {
      "name": "Bhutan",
      "code": "BT",
      "emoji": "🇧🇹",
      "unicode": "U+1F1E7 U+1F1F9",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/BT.svg"
    },
    {
      "name": "Bouvet Island",
      "code": "BV",
      "emoji": "🇧🇻",
      "unicode": "U+1F1E7 U+1F1FB",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/BV.svg"
    },
    {
      "name": "Botswana",
      "code": "BW",
      "emoji": "🇧🇼",
      "unicode": "U+1F1E7 U+1F1FC",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/BW.svg"
    },
    {
      "name": "Belarus",
      "code": "BY",
      "emoji": "🇧🇾",
      "unicode": "U+1F1E7 U+1F1FE",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/BY.svg"
    },
    {
      "name": "Belize",
      "code": "BZ",
      "emoji": "🇧🇿",
      "unicode": "U+1F1E7 U+1F1FF",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/BZ.svg"
    },
    {
      "name": "Canada",
      "code": "CA",
      "emoji": "🇨🇦",
      "unicode": "U+1F1E8 U+1F1E6",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/CA.svg"
    },
    {
      "name": "Cocos (Keeling) Islands",
      "code": "CC",
      "emoji": "🇨🇨",
      "unicode": "U+1F1E8 U+1F1E8",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/CC.svg"
    },
    {
      "name": "Congo - Kinshasa",
      "code": "CD",
      "emoji": "🇨🇩",
      "unicode": "U+1F1E8 U+1F1E9",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/CD.svg"
    },
    {
      "name": "Central African Republic",
      "code": "CF",
      "emoji": "🇨🇫",
      "unicode": "U+1F1E8 U+1F1EB",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/CF.svg"
    },
    {
      "name": "Congo - Brazzaville",
      "code": "CG",
      "emoji": "🇨🇬",
      "unicode": "U+1F1E8 U+1F1EC",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/CG.svg"
    },
    {
      "name": "Switzerland",
      "code": "CH",
      "emoji": "🇨🇭",
      "unicode": "U+1F1E8 U+1F1ED",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/CH.svg"
    },
    {
      "name": "Côte d’Ivoire",
      "code": "CI",
      "emoji": "🇨🇮",
      "unicode": "U+1F1E8 U+1F1EE",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/CI.svg"
    },
    {
      "name": "Cook Islands",
      "code": "CK",
      "emoji": "🇨🇰",
      "unicode": "U+1F1E8 U+1F1F0",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/CK.svg"
    },
    {
      "name": "Chile",
      "code": "CL",
      "emoji": "🇨🇱",
      "unicode": "U+1F1E8 U+1F1F1",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/CL.svg"
    },
    {
      "name": "Cameroon",
      "code": "CM",
      "emoji": "🇨🇲",
      "unicode": "U+1F1E8 U+1F1F2",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/CM.svg"
    },
    {
      "name": "China",
      "code": "CN",
      "emoji": "🇨🇳",
      "unicode": "U+1F1E8 U+1F1F3",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/CN.svg"
    },
    {
      "name": "Colombia",
      "code": "CO",
      "emoji": "🇨🇴",
      "unicode": "U+1F1E8 U+1F1F4",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/CO.svg"
    },
    {
      "name": "Clipperton Island",
      "code": "CP",
      "emoji": "🇨🇵",
      "unicode": "U+1F1E8 U+1F1F5",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/CP.svg"
    },
    {
      "name": "Costa Rica",
      "code": "CR",
      "emoji": "🇨🇷",
      "unicode": "U+1F1E8 U+1F1F7",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/CR.svg"
    },
    {
      "name": "Cuba",
      "code": "CU",
      "emoji": "🇨🇺",
      "unicode": "U+1F1E8 U+1F1FA",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/CU.svg"
    },
    {
      "name": "Cape Verde",
      "code": "CV",
      "emoji": "🇨🇻",
      "unicode": "U+1F1E8 U+1F1FB",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/CV.svg"
    },
    {
      "name": "Curaçao",
      "code": "CW",
      "emoji": "🇨🇼",
      "unicode": "U+1F1E8 U+1F1FC",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/CW.svg"
    },
    {
      "name": "Christmas Island",
      "code": "CX",
      "emoji": "🇨🇽",
      "unicode": "U+1F1E8 U+1F1FD",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/CX.svg"
    },
    {
      "name": "Cyprus",
      "code": "CY",
      "emoji": "🇨🇾",
      "unicode": "U+1F1E8 U+1F1FE",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/CY.svg"
    },
    {
      "name": "Czechia",
      "code": "CZ",
      "emoji": "🇨🇿",
      "unicode": "U+1F1E8 U+1F1FF",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/CZ.svg"
    },
    {
      "name": "Germany",
      "code": "DE",
      "emoji": "🇩🇪",
      "unicode": "U+1F1E9 U+1F1EA",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/DE.svg"
    },
    {
      "name": "Diego Garcia",
      "code": "DG",
      "emoji": "🇩🇬",
      "unicode": "U+1F1E9 U+1F1EC",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/DG.svg"
    },
    {
      "name": "Djibouti",
      "code": "DJ",
      "emoji": "🇩🇯",
      "unicode": "U+1F1E9 U+1F1EF",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/DJ.svg"
    },
    {
      "name": "Denmark",
      "code": "DK",
      "emoji": "🇩🇰",
      "unicode": "U+1F1E9 U+1F1F0",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/DK.svg"
    },
    {
      "name": "Dominica",
      "code": "DM",
      "emoji": "🇩🇲",
      "unicode": "U+1F1E9 U+1F1F2",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/DM.svg"
    },
    {
      "name": "Dominican Republic",
      "code": "DO",
      "emoji": "🇩🇴",
      "unicode": "U+1F1E9 U+1F1F4",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/DO.svg"
    },
    {
      "name": "Algeria",
      "code": "DZ",
      "emoji": "🇩🇿",
      "unicode": "U+1F1E9 U+1F1FF",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/DZ.svg"
    },
    {
      "name": "Ceuta & Melilla",
      "code": "EA",
      "emoji": "🇪🇦",
      "unicode": "U+1F1EA U+1F1E6",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/EA.svg"
    },
    {
      "name": "Ecuador",
      "code": "EC",
      "emoji": "🇪🇨",
      "unicode": "U+1F1EA U+1F1E8",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/EC.svg"
    },
    {
      "name": "Estonia",
      "code": "EE",
      "emoji": "🇪🇪",
      "unicode": "U+1F1EA U+1F1EA",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/EE.svg"
    },
    {
      "name": "Egypt",
      "code": "EG",
      "emoji": "🇪🇬",
      "unicode": "U+1F1EA U+1F1EC",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/EG.svg"
    },
    {
      "name": "Western Sahara",
      "code": "EH",
      "emoji": "🇪🇭",
      "unicode": "U+1F1EA U+1F1ED",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/EH.svg"
    },
    {
      "name": "Eritrea",
      "code": "ER",
      "emoji": "🇪🇷",
      "unicode": "U+1F1EA U+1F1F7",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/ER.svg"
    },
    {
      "name": "Spain",
      "code": "ES",
      "emoji": "🇪🇸",
      "unicode": "U+1F1EA U+1F1F8",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/ES.svg"
    },
    {
      "name": "Ethiopia",
      "code": "ET",
      "emoji": "🇪🇹",
      "unicode": "U+1F1EA U+1F1F9",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/ET.svg"
    },
    {
      "name": "European Union",
      "code": "EU",
      "emoji": "🇪🇺",
      "unicode": "U+1F1EA U+1F1FA",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/EU.svg"
    },
    {
      "name": "Finland",
      "code": "FI",
      "emoji": "🇫🇮",
      "unicode": "U+1F1EB U+1F1EE",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/FI.svg"
    },
    {
      "name": "Fiji",
      "code": "FJ",
      "emoji": "🇫🇯",
      "unicode": "U+1F1EB U+1F1EF",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/FJ.svg"
    },
    {
      "name": "Falkland Islands",
      "code": "FK",
      "emoji": "🇫🇰",
      "unicode": "U+1F1EB U+1F1F0",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/FK.svg"
    },
    {
      "name": "Micronesia",
      "code": "FM",
      "emoji": "🇫🇲",
      "unicode": "U+1F1EB U+1F1F2",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/FM.svg"
    },
    {
      "name": "Faroe Islands",
      "code": "FO",
      "emoji": "🇫🇴",
      "unicode": "U+1F1EB U+1F1F4",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/FO.svg"
    },
    {
      "name": "France",
      "code": "FR",
      "emoji": "🇫🇷",
      "unicode": "U+1F1EB U+1F1F7",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/FR.svg"
    },
    {
      "name": "Gabon",
      "code": "GA",
      "emoji": "🇬🇦",
      "unicode": "U+1F1EC U+1F1E6",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/GA.svg"
    },
    {
      "name": "United Kingdom",
      "code": "GB",
      "emoji": "🇬🇧",
      "unicode": "U+1F1EC U+1F1E7",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/GB.svg"
    },
    {
      "name": "Grenada",
      "code": "GD",
      "emoji": "🇬🇩",
      "unicode": "U+1F1EC U+1F1E9",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/GD.svg"
    },
    {
      "name": "Georgia",
      "code": "GE",
      "emoji": "🇬🇪",
      "unicode": "U+1F1EC U+1F1EA",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/GE.svg"
    },
    {
      "name": "French Guiana",
      "code": "GF",
      "emoji": "🇬🇫",
      "unicode": "U+1F1EC U+1F1EB",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/GF.svg"
    },
    {
      "name": "Guernsey",
      "code": "GG",
      "emoji": "🇬🇬",
      "unicode": "U+1F1EC U+1F1EC",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/GG.svg"
    },
    {
      "name": "Ghana",
      "code": "GH",
      "emoji": "🇬🇭",
      "unicode": "U+1F1EC U+1F1ED",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/GH.svg"
    },
    {
      "name": "Gibraltar",
      "code": "GI",
      "emoji": "🇬🇮",
      "unicode": "U+1F1EC U+1F1EE",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/GI.svg"
    },
    {
      "name": "Greenland",
      "code": "GL",
      "emoji": "🇬🇱",
      "unicode": "U+1F1EC U+1F1F1",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/GL.svg"
    },
    {
      "name": "Gambia",
      "code": "GM",
      "emoji": "🇬🇲",
      "unicode": "U+1F1EC U+1F1F2",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/GM.svg"
    },
    {
      "name": "Guinea",
      "code": "GN",
      "emoji": "🇬🇳",
      "unicode": "U+1F1EC U+1F1F3",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/GN.svg"
    },
    {
      "name": "Guadeloupe",
      "code": "GP",
      "emoji": "🇬🇵",
      "unicode": "U+1F1EC U+1F1F5",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/GP.svg"
    },
    {
      "name": "Equatorial Guinea",
      "code": "GQ",
      "emoji": "🇬🇶",
      "unicode": "U+1F1EC U+1F1F6",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/GQ.svg"
    },
    {
      "name": "Greece",
      "code": "GR",
      "emoji": "🇬🇷",
      "unicode": "U+1F1EC U+1F1F7",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/GR.svg"
    },
    {
      "name": "South Georgia & South Sandwich Islands",
      "code": "GS",
      "emoji": "🇬🇸",
      "unicode": "U+1F1EC U+1F1F8",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/GS.svg"
    },
    {
      "name": "Guatemala",
      "code": "GT",
      "emoji": "🇬🇹",
      "unicode": "U+1F1EC U+1F1F9",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/GT.svg"
    },
    {
      "name": "Guam",
      "code": "GU",
      "emoji": "🇬🇺",
      "unicode": "U+1F1EC U+1F1FA",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/GU.svg"
    },
    {
      "name": "Guinea-Bissau",
      "code": "GW",
      "emoji": "🇬🇼",
      "unicode": "U+1F1EC U+1F1FC",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/GW.svg"
    },
    {
      "name": "Guyana",
      "code": "GY",
      "emoji": "🇬🇾",
      "unicode": "U+1F1EC U+1F1FE",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/GY.svg"
    },
    {
      "name": "Hong Kong SAR China",
      "code": "HK",
      "emoji": "🇭🇰",
      "unicode": "U+1F1ED U+1F1F0",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/HK.svg"
    },
    {
      "name": "Heard & McDonald Islands",
      "code": "HM",
      "emoji": "🇭🇲",
      "unicode": "U+1F1ED U+1F1F2",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/HM.svg"
    },
    {
      "name": "Honduras",
      "code": "HN",
      "emoji": "🇭🇳",
      "unicode": "U+1F1ED U+1F1F3",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/HN.svg"
    },
    {
      "name": "Croatia",
      "code": "HR",
      "emoji": "🇭🇷",
      "unicode": "U+1F1ED U+1F1F7",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/HR.svg"
    },
    {
      "name": "Haiti",
      "code": "HT",
      "emoji": "🇭🇹",
      "unicode": "U+1F1ED U+1F1F9",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/HT.svg"
    },
    {
      "name": "Hungary",
      "code": "HU",
      "emoji": "🇭🇺",
      "unicode": "U+1F1ED U+1F1FA",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/HU.svg"
    },
    {
      "name": "Canary Islands",
      "code": "IC",
      "emoji": "🇮🇨",
      "unicode": "U+1F1EE U+1F1E8",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/IC.svg"
    },
    {
      "name": "Indonesia",
      "code": "ID",
      "emoji": "🇮🇩",
      "unicode": "U+1F1EE U+1F1E9",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/ID.svg"
    },
    {
      "name": "Ireland",
      "code": "IE",
      "emoji": "🇮🇪",
      "unicode": "U+1F1EE U+1F1EA",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/IE.svg"
    },
    {
      "name": "Isle of Man",
      "code": "IM",
      "emoji": "🇮🇲",
      "unicode": "U+1F1EE U+1F1F2",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/IM.svg"
    },
    {
      "name": "India",
      "code": "IN",
      "emoji": "🇮🇳",
      "unicode": "U+1F1EE U+1F1F3",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/IN.svg"
    },
    {
      "name": "British Indian Ocean Territory",
      "code": "IO",
      "emoji": "🇮🇴",
      "unicode": "U+1F1EE U+1F1F4",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/IO.svg"
    },
    {
      "name": "Iraq",
      "code": "IQ",
      "emoji": "🇮🇶",
      "unicode": "U+1F1EE U+1F1F6",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/IQ.svg"
    },
    {
      "name": "Iran",
      "code": "IR",
      "emoji": "🇮🇷",
      "unicode": "U+1F1EE U+1F1F7",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/IR.svg"
    },
    {
      "name": "Iceland",
      "code": "IS",
      "emoji": "🇮🇸",
      "unicode": "U+1F1EE U+1F1F8",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/IS.svg"
    },
    {
      "name": "Italy",
      "code": "IT",
      "emoji": "🇮🇹",
      "unicode": "U+1F1EE U+1F1F9",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/IT.svg"
    },
    {
      "name": "Jersey",
      "code": "JE",
      "emoji": "🇯🇪",
      "unicode": "U+1F1EF U+1F1EA",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/JE.svg"
    },
    {
      "name": "Jamaica",
      "code": "JM",
      "emoji": "🇯🇲",
      "unicode": "U+1F1EF U+1F1F2",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/JM.svg"
    },
    {
      "name": "Jordan",
      "code": "JO",
      "emoji": "🇯🇴",
      "unicode": "U+1F1EF U+1F1F4",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/JO.svg"
    },
    {
      "name": "Japan",
      "code": "JP",
      "emoji": "🇯🇵",
      "unicode": "U+1F1EF U+1F1F5",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/JP.svg"
    },
    {
      "name": "Kenya",
      "code": "KE",
      "emoji": "🇰🇪",
      "unicode": "U+1F1F0 U+1F1EA",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/KE.svg"
    },
    {
      "name": "Kyrgyzstan",
      "code": "KG",
      "emoji": "🇰🇬",
      "unicode": "U+1F1F0 U+1F1EC",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/KG.svg"
    },
    {
      "name": "Cambodia",
      "code": "KH",
      "emoji": "🇰🇭",
      "unicode": "U+1F1F0 U+1F1ED",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/KH.svg"
    },
    {
      "name": "Kiribati",
      "code": "KI",
      "emoji": "🇰🇮",
      "unicode": "U+1F1F0 U+1F1EE",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/KI.svg"
    },
    {
      "name": "Comoros",
      "code": "KM",
      "emoji": "🇰🇲",
      "unicode": "U+1F1F0 U+1F1F2",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/KM.svg"
    },
    {
      "name": "St. Kitts & Nevis",
      "code": "KN",
      "emoji": "🇰🇳",
      "unicode": "U+1F1F0 U+1F1F3",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/KN.svg"
    },
    {
      "name": "North Korea",
      "code": "KP",
      "emoji": "🇰🇵",
      "unicode": "U+1F1F0 U+1F1F5",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/KP.svg"
    },
    {
      "name": "South Korea",
      "code": "KR",
      "emoji": "🇰🇷",
      "unicode": "U+1F1F0 U+1F1F7",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/KR.svg"
    },
    {
      "name": "Kuwait",
      "code": "KW",
      "emoji": "🇰🇼",
      "unicode": "U+1F1F0 U+1F1FC",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/KW.svg"
    },
    {
      "name": "Cayman Islands",
      "code": "KY",
      "emoji": "🇰🇾",
      "unicode": "U+1F1F0 U+1F1FE",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/KY.svg"
    },
    {
      "name": "Kazakhstan",
      "code": "KZ",
      "emoji": "🇰🇿",
      "unicode": "U+1F1F0 U+1F1FF",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/KZ.svg"
    },
    {
      "name": "Laos",
      "code": "LA",
      "emoji": "🇱🇦",
      "unicode": "U+1F1F1 U+1F1E6",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/LA.svg"
    },
    {
      "name": "Lebanon",
      "code": "LB",
      "emoji": "🇱🇧",
      "unicode": "U+1F1F1 U+1F1E7",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/LB.svg"
    },
    {
      "name": "St. Lucia",
      "code": "LC",
      "emoji": "🇱🇨",
      "unicode": "U+1F1F1 U+1F1E8",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/LC.svg"
    },
    {
      "name": "Liechtenstein",
      "code": "LI",
      "emoji": "🇱🇮",
      "unicode": "U+1F1F1 U+1F1EE",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/LI.svg"
    },
    {
      "name": "Sri Lanka",
      "code": "LK",
      "emoji": "🇱🇰",
      "unicode": "U+1F1F1 U+1F1F0",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/LK.svg"
    },
    {
      "name": "Liberia",
      "code": "LR",
      "emoji": "🇱🇷",
      "unicode": "U+1F1F1 U+1F1F7",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/LR.svg"
    },
    {
      "name": "Lesotho",
      "code": "LS",
      "emoji": "🇱🇸",
      "unicode": "U+1F1F1 U+1F1F8",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/LS.svg"
    },
    {
      "name": "Lithuania",
      "code": "LT",
      "emoji": "🇱🇹",
      "unicode": "U+1F1F1 U+1F1F9",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/LT.svg"
    },
    {
      "name": "Luxembourg",
      "code": "LU",
      "emoji": "🇱🇺",
      "unicode": "U+1F1F1 U+1F1FA",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/LU.svg"
    },
    {
      "name": "Latvia",
      "code": "LV",
      "emoji": "🇱🇻",
      "unicode": "U+1F1F1 U+1F1FB",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/LV.svg"
    },
    {
      "name": "Libya",
      "code": "LY",
      "emoji": "🇱🇾",
      "unicode": "U+1F1F1 U+1F1FE",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/LY.svg"
    },
    {
      "name": "Morocco",
      "code": "MA",
      "emoji": "🇲🇦",
      "unicode": "U+1F1F2 U+1F1E6",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/MA.svg"
    },
    {
      "name": "Monaco",
      "code": "MC",
      "emoji": "🇲🇨",
      "unicode": "U+1F1F2 U+1F1E8",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/MC.svg"
    },
    {
      "name": "Moldova",
      "code": "MD",
      "emoji": "🇲🇩",
      "unicode": "U+1F1F2 U+1F1E9",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/MD.svg"
    },
    {
      "name": "Montenegro",
      "code": "ME",
      "emoji": "🇲🇪",
      "unicode": "U+1F1F2 U+1F1EA",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/ME.svg"
    },
    {
      "name": "St. Martin",
      "code": "MF",
      "emoji": "🇲🇫",
      "unicode": "U+1F1F2 U+1F1EB",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/MF.svg"
    },
    {
      "name": "Madagascar",
      "code": "MG",
      "emoji": "🇲🇬",
      "unicode": "U+1F1F2 U+1F1EC",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/MG.svg"
    },
    {
      "name": "Marshall Islands",
      "code": "MH",
      "emoji": "🇲🇭",
      "unicode": "U+1F1F2 U+1F1ED",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/MH.svg"
    },
    {
      "name": "North Macedonia",
      "code": "MK",
      "emoji": "🇲🇰",
      "unicode": "U+1F1F2 U+1F1F0",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/MK.svg"
    },
    {
      "name": "Mali",
      "code": "ML",
      "emoji": "🇲🇱",
      "unicode": "U+1F1F2 U+1F1F1",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/ML.svg"
    },
    {
      "name": "Myanmar (Burma)",
      "code": "MM",
      "emoji": "🇲🇲",
      "unicode": "U+1F1F2 U+1F1F2",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/MM.svg"
    },
    {
      "name": "Mongolia",
      "code": "MN",
      "emoji": "🇲🇳",
      "unicode": "U+1F1F2 U+1F1F3",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/MN.svg"
    },
    {
      "name": "Macao SAR China",
      "code": "MO",
      "emoji": "🇲🇴",
      "unicode": "U+1F1F2 U+1F1F4",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/MO.svg"
    },
    {
      "name": "Northern Mariana Islands",
      "code": "MP",
      "emoji": "🇲🇵",
      "unicode": "U+1F1F2 U+1F1F5",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/MP.svg"
    },
    {
      "name": "Martinique",
      "code": "MQ",
      "emoji": "🇲🇶",
      "unicode": "U+1F1F2 U+1F1F6",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/MQ.svg"
    },
    {
      "name": "Mauritania",
      "code": "MR",
      "emoji": "🇲🇷",
      "unicode": "U+1F1F2 U+1F1F7",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/MR.svg"
    },
    {
      "name": "Montserrat",
      "code": "MS",
      "emoji": "🇲🇸",
      "unicode": "U+1F1F2 U+1F1F8",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/MS.svg"
    },
    {
      "name": "Malta",
      "code": "MT",
      "emoji": "🇲🇹",
      "unicode": "U+1F1F2 U+1F1F9",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/MT.svg"
    },
    {
      "name": "Mauritius",
      "code": "MU",
      "emoji": "🇲🇺",
      "unicode": "U+1F1F2 U+1F1FA",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/MU.svg"
    },
    {
      "name": "Maldives",
      "code": "MV",
      "emoji": "🇲🇻",
      "unicode": "U+1F1F2 U+1F1FB",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/MV.svg"
    },
    {
      "name": "Malawi",
      "code": "MW",
      "emoji": "🇲🇼",
      "unicode": "U+1F1F2 U+1F1FC",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/MW.svg"
    },
    {
      "name": "Mexico",
      "code": "MX",
      "emoji": "🇲🇽",
      "unicode": "U+1F1F2 U+1F1FD",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/MX.svg"
    },
    {
      "name": "Malaysia",
      "code": "MY",
      "emoji": "🇲🇾",
      "unicode": "U+1F1F2 U+1F1FE",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/MY.svg"
    },
    {
      "name": "Mozambique",
      "code": "MZ",
      "emoji": "🇲🇿",
      "unicode": "U+1F1F2 U+1F1FF",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/MZ.svg"
    },
    {
      "name": "Namibia",
      "code": "NA",
      "emoji": "🇳🇦",
      "unicode": "U+1F1F3 U+1F1E6",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/NA.svg"
    },
    {
      "name": "New Caledonia",
      "code": "NC",
      "emoji": "🇳🇨",
      "unicode": "U+1F1F3 U+1F1E8",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/NC.svg"
    },
    {
      "name": "Niger",
      "code": "NE",
      "emoji": "🇳🇪",
      "unicode": "U+1F1F3 U+1F1EA",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/NE.svg"
    },
    {
      "name": "Norfolk Island",
      "code": "NF",
      "emoji": "🇳🇫",
      "unicode": "U+1F1F3 U+1F1EB",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/NF.svg"
    },
    {
      "name": "Nigeria",
      "code": "NG",
      "emoji": "🇳🇬",
      "unicode": "U+1F1F3 U+1F1EC",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/NG.svg"
    },
    {
      "name": "Nicaragua",
      "code": "NI",
      "emoji": "🇳🇮",
      "unicode": "U+1F1F3 U+1F1EE",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/NI.svg"
    },
    {
      "name": "Netherlands",
      "code": "NL",
      "emoji": "🇳🇱",
      "unicode": "U+1F1F3 U+1F1F1",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/NL.svg"
    },
    {
      "name": "Norway",
      "code": "NO",
      "emoji": "🇳🇴",
      "unicode": "U+1F1F3 U+1F1F4",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/NO.svg"
    },
    {
      "name": "Nepal",
      "code": "NP",
      "emoji": "🇳🇵",
      "unicode": "U+1F1F3 U+1F1F5",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/NP.svg"
    },
    {
      "name": "Nauru",
      "code": "NR",
      "emoji": "🇳🇷",
      "unicode": "U+1F1F3 U+1F1F7",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/NR.svg"
    },
    {
      "name": "Niue",
      "code": "NU",
      "emoji": "🇳🇺",
      "unicode": "U+1F1F3 U+1F1FA",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/NU.svg"
    },
    {
      "name": "New Zealand",
      "code": "NZ",
      "emoji": "🇳🇿",
      "unicode": "U+1F1F3 U+1F1FF",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/NZ.svg"
    },
    {
      "name": "Oman",
      "code": "OM",
      "emoji": "🇴🇲",
      "unicode": "U+1F1F4 U+1F1F2",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/OM.svg"
    },
    {
      "name": "Panama",
      "code": "PA",
      "emoji": "🇵🇦",
      "unicode": "U+1F1F5 U+1F1E6",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/PA.svg"
    },
    {
      "name": "Peru",
      "code": "PE",
      "emoji": "🇵🇪",
      "unicode": "U+1F1F5 U+1F1EA",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/PE.svg"
    },
    {
      "name": "French Polynesia",
      "code": "PF",
      "emoji": "🇵🇫",
      "unicode": "U+1F1F5 U+1F1EB",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/PF.svg"
    },
    {
      "name": "Papua New Guinea",
      "code": "PG",
      "emoji": "🇵🇬",
      "unicode": "U+1F1F5 U+1F1EC",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/PG.svg"
    },
    {
      "name": "Philippines",
      "code": "PH",
      "emoji": "🇵🇭",
      "unicode": "U+1F1F5 U+1F1ED",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/PH.svg"
    },
    {
      "name": "Pakistan",
      "code": "PK",
      "emoji": "🇵🇰",
      "unicode": "U+1F1F5 U+1F1F0",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/PK.svg"
    },
    {
      "name": "Poland",
      "code": "PL",
      "emoji": "🇵🇱",
      "unicode": "U+1F1F5 U+1F1F1",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/PL.svg"
    },
    {
      "name": "St. Pierre & Miquelon",
      "code": "PM",
      "emoji": "🇵🇲",
      "unicode": "U+1F1F5 U+1F1F2",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/PM.svg"
    },
    {
      "name": "Pitcairn Islands",
      "code": "PN",
      "emoji": "🇵🇳",
      "unicode": "U+1F1F5 U+1F1F3",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/PN.svg"
    },
    {
      "name": "Puerto Rico",
      "code": "PR",
      "emoji": "🇵🇷",
      "unicode": "U+1F1F5 U+1F1F7",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/PR.svg"
    },
    {
      "name": "Palestine",
      "code": "PS",
      "emoji": "🇵🇸",
      "unicode": "U+1F1F5 U+1F1F8",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/PS.svg"
    },
    {
      "name": "Portugal",
      "code": "PT",
      "emoji": "🇵🇹",
      "unicode": "U+1F1F5 U+1F1F9",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/PT.svg"
    },
    {
      "name": "Palau",
      "code": "PW",
      "emoji": "🇵🇼",
      "unicode": "U+1F1F5 U+1F1FC",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/PW.svg"
    },
    {
      "name": "Paraguay",
      "code": "PY",
      "emoji": "🇵🇾",
      "unicode": "U+1F1F5 U+1F1FE",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/PY.svg"
    },
    {
      "name": "Qatar",
      "code": "QA",
      "emoji": "🇶🇦",
      "unicode": "U+1F1F6 U+1F1E6",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/QA.svg"
    },
    {
      "name": "Réunion",
      "code": "RE",
      "emoji": "🇷🇪",
      "unicode": "U+1F1F7 U+1F1EA",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/RE.svg"
    },
    {
      "name": "Romania",
      "code": "RO",
      "emoji": "🇷🇴",
      "unicode": "U+1F1F7 U+1F1F4",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/RO.svg"
    },
    {
      "name": "Serbia",
      "code": "RS",
      "emoji": "🇷🇸",
      "unicode": "U+1F1F7 U+1F1F8",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/RS.svg"
    },
    {
      "name": "Russia",
      "code": "RU",
      "emoji": "🇷🇺",
      "unicode": "U+1F1F7 U+1F1FA",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/RU.svg"
    },
    {
      "name": "Rwanda",
      "code": "RW",
      "emoji": "🇷🇼",
      "unicode": "U+1F1F7 U+1F1FC",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/RW.svg"
    },
    {
      "name": "Saudi Arabia",
      "code": "SA",
      "emoji": "🇸🇦",
      "unicode": "U+1F1F8 U+1F1E6",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/SA.svg"
    },
    {
      "name": "Solomon Islands",
      "code": "SB",
      "emoji": "🇸🇧",
      "unicode": "U+1F1F8 U+1F1E7",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/SB.svg"
    },
    {
      "name": "Seychelles",
      "code": "SC",
      "emoji": "🇸🇨",
      "unicode": "U+1F1F8 U+1F1E8",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/SC.svg"
    },
    {
      "name": "Sudan",
      "code": "SD",
      "emoji": "🇸🇩",
      "unicode": "U+1F1F8 U+1F1E9",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/SD.svg"
    },
    {
      "name": "Sweden",
      "code": "SE",
      "emoji": "🇸🇪",
      "unicode": "U+1F1F8 U+1F1EA",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/SE.svg"
    },
    {
      "name": "Singapore",
      "code": "SG",
      "emoji": "🇸🇬",
      "unicode": "U+1F1F8 U+1F1EC",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/SG.svg"
    },
    {
      "name": "St. Helena",
      "code": "SH",
      "emoji": "🇸🇭",
      "unicode": "U+1F1F8 U+1F1ED",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/SH.svg"
    },
    {
      "name": "Slovenia",
      "code": "SI",
      "emoji": "🇸🇮",
      "unicode": "U+1F1F8 U+1F1EE",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/SI.svg"
    },
    {
      "name": "Svalbard & Jan Mayen",
      "code": "SJ",
      "emoji": "🇸🇯",
      "unicode": "U+1F1F8 U+1F1EF",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/SJ.svg"
    },
    {
      "name": "Slovakia",
      "code": "SK",
      "emoji": "🇸🇰",
      "unicode": "U+1F1F8 U+1F1F0",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/SK.svg"
    },
    {
      "name": "Sierra Leone",
      "code": "SL",
      "emoji": "🇸🇱",
      "unicode": "U+1F1F8 U+1F1F1",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/SL.svg"
    },
    {
      "name": "San Marino",
      "code": "SM",
      "emoji": "🇸🇲",
      "unicode": "U+1F1F8 U+1F1F2",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/SM.svg"
    },
    {
      "name": "Senegal",
      "code": "SN",
      "emoji": "🇸🇳",
      "unicode": "U+1F1F8 U+1F1F3",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/SN.svg"
    },
    {
      "name": "Somalia",
      "code": "SO",
      "emoji": "🇸🇴",
      "unicode": "U+1F1F8 U+1F1F4",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/SO.svg"
    },
    {
      "name": "Suriname",
      "code": "SR",
      "emoji": "🇸🇷",
      "unicode": "U+1F1F8 U+1F1F7",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/SR.svg"
    },
    {
      "name": "South Sudan",
      "code": "SS",
      "emoji": "🇸🇸",
      "unicode": "U+1F1F8 U+1F1F8",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/SS.svg"
    },
    {
      "name": "São Tomé & Príncipe",
      "code": "ST",
      "emoji": "🇸🇹",
      "unicode": "U+1F1F8 U+1F1F9",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/ST.svg"
    },
    {
      "name": "El Salvador",
      "code": "SV",
      "emoji": "🇸🇻",
      "unicode": "U+1F1F8 U+1F1FB",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/SV.svg"
    },
    {
      "name": "Sint Maarten",
      "code": "SX",
      "emoji": "🇸🇽",
      "unicode": "U+1F1F8 U+1F1FD",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/SX.svg"
    },
    {
      "name": "Syria",
      "code": "SY",
      "emoji": "🇸🇾",
      "unicode": "U+1F1F8 U+1F1FE",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/SY.svg"
    },
    {
      "name": "Eswatini",
      "code": "SZ",
      "emoji": "🇸🇿",
      "unicode": "U+1F1F8 U+1F1FF",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/SZ.svg"
    },
    {
      "name": "Tristan da Cunha",
      "code": "TA",
      "emoji": "🇹🇦",
      "unicode": "U+1F1F9 U+1F1E6",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/TA.svg"
    },
    {
      "name": "Turks & Caicos Islands",
      "code": "TC",
      "emoji": "🇹🇨",
      "unicode": "U+1F1F9 U+1F1E8",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/TC.svg"
    },
    {
      "name": "Chad",
      "code": "TD",
      "emoji": "🇹🇩",
      "unicode": "U+1F1F9 U+1F1E9",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/TD.svg"
    },
    {
      "name": "French Southern Territories",
      "code": "TF",
      "emoji": "🇹🇫",
      "unicode": "U+1F1F9 U+1F1EB",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/TF.svg"
    },
    {
      "name": "Togo",
      "code": "TG",
      "emoji": "🇹🇬",
      "unicode": "U+1F1F9 U+1F1EC",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/TG.svg"
    },
    {
      "name": "Thailand",
      "code": "TH",
      "emoji": "🇹🇭",
      "unicode": "U+1F1F9 U+1F1ED",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/TH.svg"
    },
    {
      "name": "Tajikistan",
      "code": "TJ",
      "emoji": "🇹🇯",
      "unicode": "U+1F1F9 U+1F1EF",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/TJ.svg"
    },
    {
      "name": "Tokelau",
      "code": "TK",
      "emoji": "🇹🇰",
      "unicode": "U+1F1F9 U+1F1F0",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/TK.svg"
    },
    {
      "name": "Timor-Leste",
      "code": "TL",
      "emoji": "🇹🇱",
      "unicode": "U+1F1F9 U+1F1F1",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/TL.svg"
    },
    {
      "name": "Turkmenistan",
      "code": "TM",
      "emoji": "🇹🇲",
      "unicode": "U+1F1F9 U+1F1F2",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/TM.svg"
    },
    {
      "name": "Tunisia",
      "code": "TN",
      "emoji": "🇹🇳",
      "unicode": "U+1F1F9 U+1F1F3",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/TN.svg"
    },
    {
      "name": "Tonga",
      "code": "TO",
      "emoji": "🇹🇴",
      "unicode": "U+1F1F9 U+1F1F4",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/TO.svg"
    },
    {
      "name": "Turkey",
      "code": "TR",
      "emoji": "🇹🇷",
      "unicode": "U+1F1F9 U+1F1F7",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/TR.svg"
    },
    {
      "name": "Trinidad & Tobago",
      "code": "TT",
      "emoji": "🇹🇹",
      "unicode": "U+1F1F9 U+1F1F9",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/TT.svg"
    },
    {
      "name": "Tuvalu",
      "code": "TV",
      "emoji": "🇹🇻",
      "unicode": "U+1F1F9 U+1F1FB",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/TV.svg"
    },
    {
      "name": "Taiwan",
      "code": "TW",
      "emoji": "🇹🇼",
      "unicode": "U+1F1F9 U+1F1FC",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/TW.svg"
    },
    {
      "name": "Tanzania",
      "code": "TZ",
      "emoji": "🇹🇿",
      "unicode": "U+1F1F9 U+1F1FF",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/TZ.svg"
    },
    {
      "name": "Ukraine",
      "code": "UA",
      "emoji": "🇺🇦",
      "unicode": "U+1F1FA U+1F1E6",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/UA.svg"
    },
    {
      "name": "Uganda",
      "code": "UG",
      "emoji": "🇺🇬",
      "unicode": "U+1F1FA U+1F1EC",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/UG.svg"
    },
    {
      "name": "U.S. Outlying Islands",
      "code": "UM",
      "emoji": "🇺🇲",
      "unicode": "U+1F1FA U+1F1F2",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/UM.svg"
    },
    {
      "name": "United Nations",
      "code": "UN",
      "emoji": "🇺🇳",
      "unicode": "U+1F1FA U+1F1F3",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/UN.svg"
    },
    {
      "name": "United States",
      "code": "US",
      "emoji": "🇺🇸",
      "unicode": "U+1F1FA U+1F1F8",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/US.svg"
    },
    {
      "name": "Uruguay",
      "code": "UY",
      "emoji": "🇺🇾",
      "unicode": "U+1F1FA U+1F1FE",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/UY.svg"
    },
    {
      "name": "Uzbekistan",
      "code": "UZ",
      "emoji": "🇺🇿",
      "unicode": "U+1F1FA U+1F1FF",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/UZ.svg"
    },
    {
      "name": "Vatican City",
      "code": "VA",
      "emoji": "🇻🇦",
      "unicode": "U+1F1FB U+1F1E6",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/VA.svg"
    },
    {
      "name": "St. Vincent & Grenadines",
      "code": "VC",
      "emoji": "🇻🇨",
      "unicode": "U+1F1FB U+1F1E8",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/VC.svg"
    },
    {
      "name": "Venezuela",
      "code": "VE",
      "emoji": "🇻🇪",
      "unicode": "U+1F1FB U+1F1EA",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/VE.svg"
    },
    {
      "name": "British Virgin Islands",
      "code": "VG",
      "emoji": "🇻🇬",
      "unicode": "U+1F1FB U+1F1EC",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/VG.svg"
    },
    {
      "name": "U.S. Virgin Islands",
      "code": "VI",
      "emoji": "🇻🇮",
      "unicode": "U+1F1FB U+1F1EE",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/VI.svg"
    },
    {
      "name": "Vietnam",
      "code": "VN",
      "emoji": "🇻🇳",
      "unicode": "U+1F1FB U+1F1F3",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/VN.svg"
    },
    {
      "name": "Vanuatu",
      "code": "VU",
      "emoji": "🇻🇺",
      "unicode": "U+1F1FB U+1F1FA",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/VU.svg"
    },
    {
      "name": "Wallis & Futuna",
      "code": "WF",
      "emoji": "🇼🇫",
      "unicode": "U+1F1FC U+1F1EB",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/WF.svg"
    },
    {
      "name": "Samoa",
      "code": "WS",
      "emoji": "🇼🇸",
      "unicode": "U+1F1FC U+1F1F8",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/WS.svg"
    },
    {
      "name": "Kosovo",
      "code": "XK",
      "emoji": "🇽🇰",
      "unicode": "U+1F1FD U+1F1F0",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/XK.svg"
    },
    {
      "name": "Yemen",
      "code": "YE",
      "emoji": "🇾🇪",
      "unicode": "U+1F1FE U+1F1EA",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/YE.svg"
    },
    {
      "name": "Mayotte",
      "code": "YT",
      "emoji": "🇾🇹",
      "unicode": "U+1F1FE U+1F1F9",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/YT.svg"
    },
    {
      "name": "South Africa",
      "code": "ZA",
      "emoji": "🇿🇦",
      "unicode": "U+1F1FF U+1F1E6",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/ZA.svg"
    },
    {
      "name": "Zambia",
      "code": "ZM",
      "emoji": "🇿🇲",
      "unicode": "U+1F1FF U+1F1F2",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/ZM.svg"
    },
    {
      "name": "Zimbabwe",
      "code": "ZW",
      "emoji": "🇿🇼",
      "unicode": "U+1F1FF U+1F1FC",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/ZW.svg"
    },
    {
      "name": "England",
      "code": "ENGLAND",
      "emoji": "🏴󠁧󠁢󠁥󠁮󠁧󠁿",
      "unicode": "U+1F3F4 U+E0067 U+E0062 U+E0065 U+E006E U+E0067 U+E007F",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/ENGLAND.svg"
    },
    {
      "name": "Scotland",
      "code": "SCOTLAND",
      "emoji": "🏴󠁧󠁢󠁳󠁣󠁴󠁿",
      "unicode": "U+1F3F4 U+E0067 U+E0062 U+E0073 U+E0063 U+E0074 U+E007F",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/SCOTLAND.svg"
    },
    {
      "name": "Wales",
      "code": "WALES",
      "emoji": "🏴󠁧󠁢󠁷󠁬󠁳󠁿",
      "unicode": "U+1F3F4 U+E0067 U+E0062 U+E0077 U+E006C U+E0073 U+E007F",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/WALES.svg"
    }
  ];
}

String lowerCaseLetters(String str) {
  return str.toLowerCase();
}

List<String>? decodeJSON(List<dynamic> jsonData) {
  List<String> namesList =
      jsonData.map((item) => item["name"].toString()).toList();

  return namesList;
}

List<dynamic>? filterJSONData(
  List<dynamic> jsonList,
  List<String> stringList,
  String fieldToCheck,
) {
  List<dynamic> filteredList = jsonList.where((jsonItem) {
    if (jsonItem is Map<String, dynamic> &&
        jsonItem.containsKey(fieldToCheck) &&
        stringList.contains(jsonItem[fieldToCheck].toString())) {
      return true;
    }
    return false;
  }).toList();

  return filteredList;
}

String? jsonToString(dynamic jsonData) {
  return jsonData.toString();
}

String concatenateVersesText(dynamic jsonData) {
  // Extract the list of verses
  List<dynamic> verses = jsonData['verses'];

  // Concatenate the 'text_imlaei' values
  String concatenatedText =
      verses.map((verse) => verse['text_imlaei'].toString()).join(' ');
  return concatenatedText;
}

String concatenatVersesTextWithNum(dynamic jsonData) {
  // Extract the list of verses
  List<dynamic> verses = jsonData['verses'];

  // Concatenate the 'text_imlaei' values
// Concatenate the 'text_imlaei' values along with 'verse_key'
  String concatenatedText = verses.map((verse) {
    String verseKey = verse["verse_key"];
    String keyPart =
        verseKey.split(":").last; // Extract the part after the colon

    return '${verse["text_imlaei"]} $keyPart';
  }).join(' ');
  return concatenatedText;
}

String getValueFromJsonArray(
  List<dynamic> jsonArray,
  int index,
  String key,
) {
  return jsonArray[index][key];
}

int? getJSONArrayLength(dynamic jsonData) {
  if (jsonData.containsKey("verses")) {
    // Access the "verses" array and return its length
    List<dynamic> versesArray = jsonData["verses"];
    return versesArray.length;
  } else {
    // Return 0 if "verses" key is not present
    return 0;
  }
}

bool checkVerseKeysExist(
  List<dynamic> jsonArray,
  List<String> stringList,
) {
  List<String> verseKeysInJson =
      jsonArray.map((item) => item["verse_key"] as String).toList();

  // Check if all verse keys in jsonArray exist in the stringList
  return verseKeysInJson.every((verseKey) => stringList.contains(verseKey));
}

String getConcatenatedText(String jsonString) {
  // Parse JSON
  Map<String, dynamic> jsonMap = jsonDecode(jsonString);
  List<dynamic> verses = jsonMap['verses'];

  // Process each verse
  String result = verses.map((verse) {
    int verseNumber = verse['verse_number'];
    String text = verse['translations'][0]['text']
        .replaceAllMapped(RegExp(r'<sup[^>]*>.*?<\/sup>'), (match) => '');
    return '$text ($verseNumber)';
  }).join(' ');

  return result;
}

String calculateTimeDifference(
  int currentUnixTimeInSeconds,
  int targetUnixTimeInSeconds,
) {
  int differenceInSeconds = targetUnixTimeInSeconds - currentUnixTimeInSeconds;

  if (differenceInSeconds.abs() < 60) {
    return '${differenceInSeconds.abs()} sec';
  } else if (differenceInSeconds.abs() < 3600) {
    int minutes = (differenceInSeconds.abs() / 60).floor();
    return '$minutes min';
  } else if (differenceInSeconds.abs() < 86400) {
    int hours = (differenceInSeconds.abs() / 3600).floor();
    return '$hours hr';
  } else if (differenceInSeconds.abs() < 604800) {
    int days = (differenceInSeconds.abs() / 86400).floor();
    return '$days d';
  } else if (differenceInSeconds.abs() < 2629746) {
    int weeks = (differenceInSeconds.abs() / 604800).floor();
    return '$weeks w';
  } else if (differenceInSeconds.abs() < 31556952) {
    int months = (differenceInSeconds.abs() / 2629746).floor();
    return '$months m';
  } else {
    int years = (differenceInSeconds.abs() / 31556952).floor();
    return '$years y';
  }
}
