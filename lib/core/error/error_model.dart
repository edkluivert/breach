class ErrorModel {

  ErrorModel({
    this.message,
  });

  ErrorModel.fromJson(Map<String, dynamic> json)
      : message = json['message'] as String?;
  final String? message;

  Map<String, dynamic> toJson() => {
    'message' : message
  };
}