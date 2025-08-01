import 'package:test/test.dart';
import 'package:fli/src/models/project_config.dart';

void main() {
  group('ProjectConfig', () {
    test('should create project config with required fields', () {
      const config = ProjectConfig(
        name: 'test_app',
        template: 'basic',
        outputDirectory: '/tmp',
      );

      expect(config.name, equals('test_app'));
      expect(config.template, equals('basic'));
      expect(config.outputDirectory, equals('/tmp'));
      expect(config.isInteractive, isFalse);
    });

    test('should generate correct project path', () {
      const config = ProjectConfig(
        name: 'my_app',
        template: 'basic',
        outputDirectory: '/home/user',
      );

      expect(config.projectPath, equals('/home/user/my_app'));
    });
  });
}
