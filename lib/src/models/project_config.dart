class ProjectConfig {
  final String name;
  final String template;
  final String outputDirectory;
  final bool isInteractive;

  const ProjectConfig({
    required this.name,
    required this.template,
    required this.outputDirectory,
    this.isInteractive = false,
  });

  String get projectPath => '$outputDirectory/$name';

  @override
  String toString() {
    return 'ProjectConfig{name: $name, template: $template, outputDirectory: $outputDirectory, isInteractive: $isInteractive}';
  }
}
