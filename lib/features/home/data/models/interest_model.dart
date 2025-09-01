import 'package:breach/features/home/data/models/category_model.dart';
import 'package:breach/features/home/domain/entities/interest_entity.dart';

class InterestModel extends InterestEntity {


  InterestModel({
    super.id,
    super.category,
    super.user,
  });

  factory InterestModel.fromJson(Map<String, dynamic> json){
    return InterestModel(
        id : json['id'] as int?,
        category : (json['category'] as Map<String,dynamic>?) !=
            null ? CategoryModel.fromJson(json['category'] as Map<String,dynamic>) : null,
        user : (json['user'] as Map<String,dynamic>?) != null ?
        UserModel.fromJson(json['user'] as Map<String,dynamic>) : null
    );
  }
  Map<String, dynamic> toJson() => {
    'id' : id,
    'category' : (category as CategoryModel?)?.toJson(),
    'user' : (user as UserModel?)?.toJson()
  };
}


class UserModel extends UserEntity{


  UserModel({
    super.id,
    super.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
        id : json['id'] as int?,
        email : json['email'] as String?
    );
  }

  Map<String, dynamic> toJson() => {
    'id' : id,
    'email' : email
  };
}