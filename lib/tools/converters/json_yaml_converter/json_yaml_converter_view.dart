import 'package:devtoys/constants/import_helper.dart';
import 'package:devtoys/tools/converters/json_yaml_converter/json_yaml_converter_provider.dart';
import 'package:devtoys/widgets/app_title.dart';
import 'package:devtoys/widgets/tool_view.dart';

class JsonYamlConverterView extends StatefulWidget {
  const JsonYamlConverterView({Key? key}) : super(key: key);

  @override
  State<JsonYamlConverterView> createState() => _JsonYamlConverterViewState();
}

class _JsonYamlConverterViewState extends State<JsonYamlConverterView> {
  final _provider = JsonYamlConverterProvider();
  @override
  void dispose() {
    _provider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ToolView.scrollVertical(
      title: const Text("JSON <> YAML Converter"),
      children: [
        Row(
          children: [
            Expanded(
              child: AppTitleWrapper(
                title: 'JSON',
                actions: [],
                child: TextBox(
                  minLines: 12,
                  maxLines: 12,
                  controller: _provider.jsonController,
                  onChanged: (_) {
                    _provider.json2yaml();
                  },
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: AppTitleWrapper(
                title: 'YAML',
                actions: [],
                child: TextBox(
                  minLines: 12,
                  maxLines: 12,
                  controller: _provider.yamlController,
                  onChanged: (_) {
                    _provider.yaml2json();
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
