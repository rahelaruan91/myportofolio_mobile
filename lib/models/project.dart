import 'package:json_annotation/json_annotation.dart';

part 'project.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Project {
  const Project({
    this.id,
    required this.projectName,
    required this.subheading,
    required this.description,
    required this.thumbnail,
    this.projectUrl = '',
  });

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  @JsonKey(includeToJson: false)
  final String? id;

  @JsonKey(name: 'title')
  final String projectName;
  final String subheading;
  final String description;
  final String thumbnail;
  final String projectUrl;

  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}
