import 'package:flutter/material.dart';

class GlobalVariables {
  static const baseUrl = 'https://431b-103-164-229-100.ngrok-free.app';
  static const List<Map<String, String>> categoryImages = [
    {
      'title': 'Mobiles',
      'image': 'assets/images/mobiles.jpeg',
    },
    {
      'title': 'Essentials',
      'image': 'assets/images/essentials.jpeg',
    },
    {
      'title': 'Appliances',
      'image': 'assets/images/appliances.jpeg',
    },
    {
      'title': 'Books',
      'image': 'assets/images/books.jpeg',
    },
    {
      'title': 'Fashion',
      'image': 'assets/images/fashion.jpeg',
    },
  ];

  static const List<String> bannerImages = [
    'https://storage.googleapis.com/astro-site/home/new-user.webp',
    'https://storage.googleapis.com/astro-site/home/24jam.webp',
  ];

  static const backgroundColor = Colors.white;
  static const primaryColor = Colors.indigo;
  static const secondaryColor = Colors.deepOrangeAccent;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = Colors.indigo;
  static const unselectedNavBarColor = Colors.black87;
}
