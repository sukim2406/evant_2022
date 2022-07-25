//<a href="https://pixabay.com/ko/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=image&amp;utm_content=67701">Pixabay</a>로부터 입수된 <a href="https://pixabay.com/ko/users/wikiimages-1897/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=image&amp;utm_content=67701">WikiImages</a>님의 이미지 입니다.

import 'package:flutter/material.dart';

const kTabletBreakPoint = 768.0;
const kDesktopBreakPoint = 1440.0;
const kMaxWidth = 2400.0;

const primaryColor = Color.fromRGBO(9, 212, 3, 1);
const secondaryColor = Color.fromRGBO(82, 82, 82, 1);

const double initMapLat = 40.4259;
const double initMapLng = 86.9081;

const List<String> categoryStrings = [
  'Etc',
  'Sports',
  'Study',
  'Gaming',
  'Social',
];

const List<String> statusStrings = [
  'Open',
  'Joinable',
  'In progress',
  'Closed',
];

const List<Map> categories = <Map>[
  {
    'category': 'Sports',
    'img': 'img/category_sports.jpg',
  },
  {
    'category': 'Study',
    'img': 'img/category_sports.jpg',
  },
  {
    'category': 'Gaming',
    'img': 'img/category_sports.jpg',
  },
  {
    'category': 'Social',
    'img': 'img/category_sports.jpg',
  },
];

const List<Map> tempFollowing = <Map>[
  {
    'host': 'host user1',
    'category': 'sports',
    'title': 'temp event 1',
    'limit': '5',
    'attending': '3',
  },
  {
    'host': 'host user1',
    'category': 'sports',
    'title': 'temp event 1',
    'limit': '5',
    'attending': '3',
  },
  {
    'host': 'host user1',
    'category': 'sports',
    'title': 'temp event 1',
    'limit': '5',
    'attending': '3',
  },
  {
    'host': 'host user1',
    'category': 'sports',
    'title': 'temp event 1',
    'limit': '5',
    'attending': '3',
  },
  {
    'host': 'host user1',
    'category': 'sports',
    'title': 'temp event 1',
    'limit': '5',
    'attending': '3',
  },
];
