import 'basic_template.dart';
import '../models/project_config.dart';

class CleanArchitectureTemplate extends BasicTemplate {
  @override
  String get name => 'clean_architecture';

  @override
  String get description =>
      'Clean Architecture with proper separation of concerns';

  @override
  Future<void> generate(ProjectConfig config) async {
    // For now, use basic template structure
    // TODO: Implement full clean architecture structure
    await super.generate(config);
  }
}
