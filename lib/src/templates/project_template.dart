import '../models/project_config.dart';

abstract class ProjectTemplate {
  String get name;
  String get description;

  Future<void> generate(ProjectConfig config);
}
