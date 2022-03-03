import 'dart:convert';

import 'package:devtoys/constants/import_helper.dart';
import 'package:json2yaml/json2yaml.dart' as json_2_yaml;
import 'package:yaml/yaml.dart';

class JsonYamlConverterProvider extends ChangeNotifier {
  TextEditingController jsonController = TextEditingController();
  TextEditingController yamlController = TextEditingController();

  json2yaml() {
    try {
      yamlController.text =
          json_2_yaml.json2yaml(json.decode(jsonController.text));
    } catch (e) {
      print(e);
    }
  }

  yaml2json() {
    try {
      final result = loadYaml(yamlController.text);
      if (result is YamlMap || result is YamlList) {
        jsonController.text = formatJson(result);
      } else {
        jsonController.text = 'unknown yaml';
      }
    } catch (e) {
      print(e);
    }
  }

  formatJson(Map map) {
    final JsonEncoder jsonEncoder = JsonEncoder.withIndent(' ' * 4);
    jsonController.text = jsonEncoder.convert(map);
  }

  @override
  void dispose() {
    jsonController.dispose();
    yamlController.dispose();
    super.dispose();
  }
}