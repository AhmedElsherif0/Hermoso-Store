class ErrorModel {
  String? field;
  String? message;

  ErrorModel(this.field, this.message);

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        json['field'] as String?,
        json['message'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'field': field,
        'message': message,
      };
}
