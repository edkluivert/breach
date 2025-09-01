import 'package:breach/features/home/domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {


  CategoryModel({
    super.id,
    super.name,
    super.icon,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json){
    return CategoryModel(
        id : json['id'] as int?,
        name : json['name'] as String?,
        icon : json['icon'] as String?
    );
  }

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'icon' : icon
  };
}