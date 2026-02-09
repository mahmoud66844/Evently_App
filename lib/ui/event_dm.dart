import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class EventDM {
  String? id;
  CategoryDM categoryDM;
  String title;
  String description;
  DateTime dateTime;
  bool isFavorite;

  EventDM({
    this.id,
    required this.categoryDM,
    required this.dateTime,
    required this.title,
    required this.description,
    this.isFavorite = false,
  });

  EventDM.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'] as String?,
          categoryDM: CategoryDM.fromJson(json['categoryDM'] as Map<String, dynamic>),
          title: json['title'] as String,
          description: json['description'] as String,
          dateTime: (json['dateTime'] as Timestamp).toDate(),
          isFavorite: json['isFavorite'] as bool? ?? false,
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryDM': categoryDM.toJson(),
      'title': title,
      'description': description,
      'dateTime': Timestamp.fromDate(dateTime),
      'isFavorite': isFavorite,
    };
  }
}

class CategoryDM {
  String name;
  String imagePath;
  IconData icon;

  CategoryDM({required this.name, required this.imagePath, required this.icon});

  CategoryDM.fromJson(Map<String, dynamic> json)
      : this(
          name: json['name'] as String,
          imagePath: json['imagePath'] as String,
          icon: IconData(
            json['icon']['codePoint'] as int,
            fontFamily: json['icon']['fontFamily'] as String?,
          ),
        );

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imagePath': imagePath,
      'icon': {
        'codePoint': icon.codePoint,
        'fontFamily': icon.fontFamily,
      },
    };
  }
}
