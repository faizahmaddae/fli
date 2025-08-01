import 'basic_template.dart';
import '../models/project_config.dart';

class BlocPatternTemplate extends BasicTemplate {
  @override
  String get name => 'bloc_pattern';

  @override
  String get description => 'BLoC pattern implementation for state management';

  @override
  Future<void> generate(ProjectConfig config) async {
    // For now, use basic template structure
    // TODO: Implement BLoC pattern structure
    await super.generate(config);
  }
}
