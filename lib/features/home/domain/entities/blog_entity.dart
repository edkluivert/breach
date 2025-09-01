import 'package:breach/features/home/domain/entities/category_entity.dart';

class BlogEntity {

  BlogEntity({
    this.id,
    this.title,
    this.content,
    this.imageUrl,
    this.createdAt,
    this.author,
    this.category,
    this.series,
  });
  final int? id;
  final String? title;
  final String? content;
  final String? imageUrl;
  final String? createdAt;
  final AuthorEntity? author;
  final CategoryEntity? category;
  final SeriesEntity? series;


}

class AuthorEntity {

  AuthorEntity({
    this.id,
    this.name,
  });
  final int? id;
  final String? name;


}

class SeriesEntity {

  SeriesEntity({
    this.id,
    this.name,
  });
  final int? id;
  final String? name;

}