import 'package:devtoys/tools/generators/uuid_generator/uuid_provider.dart';
import 'package:devtoys/widgets/app_title.dart';
import 'package:devtoys/widgets/tool_view.dart';
import 'package:devtoys/widgets/tool_view_config.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';

class UUIDGeneratorView extends StatefulWidget {
  const UUIDGeneratorView({Key? key}) : super(key: key);

  @override
  State<UUIDGeneratorView> createState() => _UUIDGeneratorViewState();
}

class _UUIDGeneratorViewState extends State<UUIDGeneratorView> {
  final _provider = UUIDProvider();
  update() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _provider.addListener(update);
  }

  @override
  void dispose() {
    _provider.removeListener(update);
    _provider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ToolView.scrollVertical(
      title: const Text('UUID Generator'),
      children: [
        const AppTitle(title: 'Config'),
        ToolViewConfig(
          title: const Text('Hypens'),
          trailing: ToggleSwitch(
            checked: _provider.hypens,
            onChanged: (value) {
              _provider.hypens = value;
            },
          ),
        ),
        ToolViewConfig(
          title: const Text('Upper case'),
          trailing: ToggleSwitch(
            checked: _provider.upperCase,
            onChanged: (value) {
              _provider.upperCase = value;
            },
          ),
        ),
        ToolViewConfig(
          title: const Text('version'),
          trailing: Combobox(
            items: UUIDVersion.values.map((e) {
              return ComboboxItem(child: Text(e.value), value: e);
            }).toList(),
            value: _provider.version,
            onChanged: (UUIDVersion? version) {
              _provider.version = version ?? UUIDVersion.v4;
            },
          ),
        ),
        const AppTitle(title: 'generate'),
        Row(
          children: [
            Button(
              child: const Text('Generate UUIDs'),
              onPressed: () {
                _provider.generate();
              },
              style: ButtonStyle(
                backgroundColor: ButtonState.all(Colors.blue['lightest']),
                foregroundColor: ButtonState.all(Colors.black),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text('X'),
            ),
            SizedBox(
              width: 100,
              child: TextBox(
                placeholder: '1',
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (value) {
                  final _value = int.tryParse(value);
                  _provider.count = _value ?? 1;
                },
              ),
            )
          ],
        ),
        AppTitle(
          title: 'UUIDs',
          actions: [
            Button(
              child: const Icon(FluentIcons.copy),
              onPressed: () async {
                await _provider.copy();
              },
            ),
            Button(
              child: const Icon(FluentIcons.clear),
              onPressed: () {},
            ),
          ],
        ),
        TextBox(
          minLines: 10,
          maxLines: 20,
          controller: _provider.resultController,
        ),
      ],
    );
  }
}