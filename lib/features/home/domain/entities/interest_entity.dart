import 'package:breach/features/home/domain/entities/category_entity.dart';

class InterestEntity {

  InterestEntity({
    this.id,
    this.category,
    this.user,
  });
  final int? id;
  final CategoryEntity? category;
  final UserEntity? user;


}


class UserEntity {

  UserEntity({
    this.id,
    this.email,
  });
  final int? id;
  final String? email;


}