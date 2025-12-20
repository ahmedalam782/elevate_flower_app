import 'dart:developer';
import 'dart:io';

void main(List<String> args) {
  if (args.isEmpty || args[0].trim().isEmpty) {
    log('Usage: dart generate_feature.dart <feature_name>');
    exit(1);
  }
  var featureName = args[0].trim();
  final featuresDir = Directory('lib/features');
  if (!featuresDir.existsSync()) {
    featuresDir.createSync(recursive: true);
  }
  final baseDir = Directory('lib/features/$featureName');
  if (baseDir.existsSync()) {
    log('Feature "$featureName" already exists.');
    return;
  }
  // Create main feature directories
  final dirs = [
    baseDir.path,
    '${baseDir.path}/api',
    '${baseDir.path}/api/api_client',
    '${baseDir.path}/api/datasources',
    '${baseDir.path}/data',
    '${baseDir.path}/data/datasources',
    '${baseDir.path}/data/models',
    '${baseDir.path}/data/repositories',
    '${baseDir.path}/domain',
    '${baseDir.path}/domain/entities',
    '${baseDir.path}/domain/repositories',
    '${baseDir.path}/domain/use_cases',
    '${baseDir.path}/presentation',
    '${baseDir.path}/presentation/view',
    '${baseDir.path}/presentation/view/pages',
    '${baseDir.path}/presentation/view/widgets',
    '${baseDir.path}/presentation/view_model',
    '${baseDir.path}/presentation/view_model/cubit',
  ];
  for (final dir in dirs) {
    Directory(dir).createSync(recursive: true);
  }

  // Create api_client and datasources files in each layer
  final layers = ['api', 'data', 'domain', 'presentation'];
  for (final layer in layers) {
    final apiClientDir = Directory('${baseDir.path}/$layer/api_client');
    final datasourcesDir = Directory('${baseDir.path}/$layer/datasources');
    final cubitDir = Directory('${baseDir.path}/$layer/view_model/cubit');
    final widgetDir = Directory('${baseDir.path}/$layer/view/widgets');
    final repositoryDir = Directory('${baseDir.path}/$layer/repositories');
    if (apiClientDir.existsSync()) {
      File(
        '${apiClientDir.path}/${featureName}_api_client.dart',
      ).writeAsStringSync(
        '// TODO: $layer ${_capitalize(featureName)}ApiClient\n',
      );
    }
    if (datasourcesDir.existsSync()) {
      if (layer == 'api') {
        File(
          '${datasourcesDir.path}/${featureName}_local_data_source_impl.dart',
        ).writeAsStringSync(
          '// TODO: $layer ${_capitalize(featureName)}LocalDataSourceImpl\n',
        );
        File(
          '${datasourcesDir.path}/${featureName}_remote_data_source_impl.dart',
        ).writeAsStringSync(
          '// TODO: $layer ${_capitalize(featureName)}RemoteDataSourceImpl\n',
        );
      } else if (layer == 'data') {
        File(
          '${datasourcesDir.path}/${featureName}_local_data_source_contract.dart',
        ).writeAsStringSync(
          '// TODO: $layer ${_capitalize(featureName)}LocalDataSourceContract\n',
        );
        File(
          '${datasourcesDir.path}/${featureName}_remote_data_source_contract.dart',
        ).writeAsStringSync(
          '// TODO: $layer ${_capitalize(featureName)}RemoteDataSourceContract\n',
        );
      }
    }
    if (cubitDir.existsSync()) {
      File(
        '${cubitDir.path}/${featureName}_cubit.dart',
      ).writeAsStringSync('// TODO: $layer ${_capitalize(featureName)}Cubit\n');
      File('${cubitDir.path}/${featureName}_states.dart').writeAsStringSync(
        '// TODO: $layer ${_capitalize(featureName)}States\n',
      );
      File('${cubitDir.path}/${featureName}_events.dart').writeAsStringSync(
        '// TODO: $layer ${_capitalize(featureName)}Events\n',
      );
    }
    if (widgetDir.existsSync()) {
      File(
        '${widgetDir.path}/${featureName}_body.dart',
      ).writeAsStringSync('// TODO: $layer ${_capitalize(featureName)}Body\n');
    }
    if (repositoryDir.existsSync()) {
      if (layer == 'domain') {
        File(
          '${repositoryDir.path}/${featureName}_repository.dart',
        ).writeAsStringSync(
          '// TODO: $layer ${_capitalize(featureName)}Repository\n',
        );
      } else {
        File(
          '${repositoryDir.path}/${featureName}_repository_impl.dart',
        ).writeAsStringSync(
          '// TODO: $layer ${_capitalize(featureName)}RepositoryImpl\n',
        );
      }
    }
  }

  // Create a sample page file
  final pageFile = File(
    '${baseDir.path}/presentation/view/pages/${featureName}_page.dart',
  );
  featureName = featureName.contains('_')
      ? featureName.split('_').map((e) => _capitalize(e)).join()
      : featureName;
  pageFile.writeAsStringSync('''
import 'package:flutter/material.dart';
    
class ${_capitalize(featureName)}Page extends StatelessWidget {
  const ${_capitalize(featureName)}Page({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('$featureName page')),
    );
  }
}
''');
  log('Feature "$featureName" structure created in lib/features/$featureName/');
}

String _capitalize(String s) {
  if (s.isEmpty) return s;
  return s[0].toUpperCase() + s.substring(1);
}

// To run this script, use the command:
// dart lib/generate_feature.dart <feature_name>
