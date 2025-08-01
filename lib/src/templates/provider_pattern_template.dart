import 'basic_template.dart';
import '../models/project_config.dart';

class ProviderPatternTemplate extends BasicTemplate {
  @override
  String get name => 'provider_pattern';

  @override
  String get description => 'Provider state management structure';

  @override
  Future<void> generate(ProjectConfig config) async {
    // For now, use basic template structure
    // TODO: Implement Provider pattern structure
    await super.generate(config);
  }
}
