import 'project_template.dart';
import 'basic_template.dart';
import 'feature_driven_template.dart';
import 'clean_architecture_template.dart';
import 'bloc_pattern_template.dart';
import 'provider_pattern_template.dart';

class TemplateFactory {
  static ProjectTemplate getTemplate(String templateName) {
    switch (templateName) {
      case 'basic':
        return BasicTemplate();
      case 'feature_driven':
        return FeatureDrivenTemplate();
      case 'clean_architecture':
        return CleanArchitectureTemplate();
      case 'bloc_pattern':
        return BlocPatternTemplate();
      case 'provider_pattern':
        return ProviderPatternTemplate();
      default:
        throw ArgumentError('Unknown template: $templateName');
    }
  }

  static List<String> get availableTemplates => [
        'basic',
        'feature_driven',
        'clean_architecture',
        'bloc_pattern',
        'provider_pattern',
      ];
}
