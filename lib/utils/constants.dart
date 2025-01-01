import 'package:flutter/material.dart';

class Constants {
  Constants._();

  static const VIETNAMESE = 'vi';
  static const ENGLISH = 'en';

  static final statusColor = <String, Color>{
    'Urgent': Colors.red,
    'Pending': Colors.yellow,
    'New': Colors.green
  };

}