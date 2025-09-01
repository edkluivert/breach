import 'package:breach/features/home/data/models/category_model.dart';
import 'package:breach/features/home/domain/entities/blog_entity.dart';

class BlogModel extends BlogEntity {
  

  BlogModel({
    super.id,
    super.title,
    super.content,
    super.imageUrl,
    super.createdAt,
    super.author,
    super.category,
    super.series,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json){
    return BlogModel(
        id : json['id'] as int?,
        title : json['title'] as String?,
        content : json['content'] as String?,
        imageUrl : json['imageUrl'] as String?,
        createdAt : json['createdAt'] as String?,
        author : (json['author'] as Map<String,dynamic>?) != null ? Author.fromJson(json['author'] as Map<String,dynamic>) : null,
        category : (json['category'] as Map<String,dynamic>?) != null ? CategoryModel.fromJson(json['category'] as Map<String,dynamic>) : null,
        series : (json['series'] as Map<String,dynamic>?) != null ? Series.fromJson(json['series'] as Map<String,dynamic>) : null
    );
  }
  Map<String, dynamic> toJson() => {
    'id' : id,
    'title' : title,
    'content' : content,
    'imageUrl' : imageUrl,
    'createdAt' : createdAt,
    'author' : (author as Author?)?.toJson(),
    'category' : (category as CategoryModel?)?.toJson(),
    'series' : (series as Series?)?.toJson()
  };
}

class Author extends AuthorEntity {


  Author({
    super.id,
    super.name,
  });

  factory Author.fromJson(Map<String, dynamic> json){
    return Author(
        id : json['id'] as int?,
        name : json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name
  };
}


class Series extends SeriesEntity{

  Series({
    super.id,
    super.name,
  });

  factory Series.fromJson(Map<String, dynamic> json){
   return Series(
       id : json['id'] as int?,
       name : json['name'] as String?
    );
  }

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name
  };
}