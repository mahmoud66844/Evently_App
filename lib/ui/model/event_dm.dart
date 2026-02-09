import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class EventDM {
  String? id;
  String? ownerId;
  CategoryDM categoryDM;
  String title;
  String description;
  DateTime dateTime;
  String? imageUrl;
  bool isFavorite;

  EventDM({
    this.id,
    this.ownerId,
    required this.categoryDM,
    required this.dateTime,
    required this.title,
    required this.description,
    this.imageUrl,
    this.isFavorite = false,
  });

  factory EventDM.fromJson(Map<String, dynamic> json) {
    Timestamp? timeStamp = json["dateTime"];
    return EventDM(
      id: json["id"],
      ownerId: json["ownerId"],
      categoryDM: CategoryDM.fromJson(json["categoryDM"] ?? json["category"]),
      dateTime: timeStamp?.toDate() ?? DateTime.now(),
      title: json["title"],
      description: json["description"],
      imageUrl: json["imageUrl"],
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "ownerId": ownerId,
      "categoryDM": categoryDM.toJson(),
      "title": title,
      "description": description,
      "dateTime": Timestamp.fromDate(dateTime),
      "imageUrl": imageUrl,
      'isFavorite': isFavorite,
    };
  }
}

class CategoryDM {
  String name;
  String imagePath;
  IconData icon;

  CategoryDM({required this.name, required this.imagePath, required this.icon});

  factory CategoryDM.fromJson(Map<String, dynamic> json) {
    var iconJson = json['icon'];
    // to handle both old and new formats
    if (iconJson is int) {
        return CategoryDM(
          name: json["name"],
          imagePath: json["imagePath"],
          icon: IconData(iconJson, fontFamily: "MaterialIcons"),
        );
    }
    return CategoryDM(
      name: json['name'] as String,
      imagePath: json['imagePath'] as String,
      icon: IconData(
        iconJson['codePoint'] as int,
        fontFamily: iconJson['fontFamily'] as String?,
      ),
    );
  }

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
