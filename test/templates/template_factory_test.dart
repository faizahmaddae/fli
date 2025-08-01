import 'package:test/test.dart';
import 'package:fli/src/templates/template_factory.dart';
import 'package:fli/src/templates/basic_template.dart';
import 'package:fli/src/templates/feature_driven_template.dart';

void main() {
  group('TemplateFactory', () {
    test('should return BasicTemplate for basic template name', () {
      final template = TemplateFactory.getTemplate('basic');
      expect(template, isA<BasicTemplate>());
    });

    test('should return FeatureDrivenTemplate for feature_driven template name',
        () {
      final template = TemplateFactory.getTemplate('feature_driven');
      expect(template, isA<FeatureDrivenTemplate>());
    });

    test('should throw ArgumentError for unknown template', () {
      expect(
        () => TemplateFactory.getTemplate('unknown'),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('should have available templates list', () {
      final templates = TemplateFactory.availableTemplates;
      expect(templates, contains('basic'));
      expect(templates, contains('feature_driven'));
      expect(templates, contains('clean_architecture'));
    });
  });
}
