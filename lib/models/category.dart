import 'package:flutter/material.dart';
import 'package:meal_app_v2/styleClass.dart';

class Category {
  final String id;
  final Color color;

  const Category({
    required this.id,
    this.color = StyleClass.O_D97904,
  });
}
