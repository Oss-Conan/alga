import 'package:devtoys/constants/import_helper.dart';
import 'package:devtoys/tools/text_tools/markdown_preview/markdown_preview_provider.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MarkdownPreviewView extends StatefulWidget {
  const MarkdownPreviewView({Key? key}) : super(key: key);

  @override
  State<MarkdownPreviewView> createState() => _MarkdownPreviewViewState();
}

class _MarkdownPreviewViewState extends State<MarkdownPreviewView> {
  final _provider = MarkdownPreviewProvider();

  update() => setState(() {});
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
      title: Text(S.of(context).markdownPreview),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AppTitleWrapper(
                title: S.of(context).markdownInput,
                actions: [
                  Button(
                    child: const Icon(FluentIcons.copy),
                    onPressed: _provider.copy,
                  ),
                ],
                child: TextBox(
                  minLines: 12,
                  maxLines: 12,
                  controller: _provider.markdownController,
                  onChanged: (_) {
                    _provider.convert();
                  },
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: AppTitleWrapper(
                title: S.of(context).markdownPreviewInput,
                actions: const [],
                child: SizedBox(
                  height: 300,
                  child: Markdown(data: _provider.data),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
