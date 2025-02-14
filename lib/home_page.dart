import 'package:devtoys/home_provider.dart';
import 'package:devtoys/l10n/l10n.dart';
import 'package:devtoys/models/tool_items.dart';
import 'package:devtoys/views/settings_view.dart';
import 'package:devtoys/widgets/window_tool_widget.dart';
import 'package:fluent_ui/fluent_ui.dart';

final homeProvider = HomeProvider();

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late NaviUtil naviUtil;
  final _suggestController = TextEditingController();

  update() {
    setState(() {});
  }

  @override
  void initState() {
    homeProvider.addListener(update);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    naviUtil = NaviUtil(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _suggestController.dispose();
    homeProvider.removeListener(update);
    homeProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget child = NavigationView(
      appBar: NavigationAppBar(
        title: Text(S.of(context).appName),
        automaticallyImplyLeading: true,
        leading: Image.asset('assets/logo/256x256.webp'),
      ),
      pane: NavigationPane(
        selected: homeProvider.currentIndex,
        onChanged: (index) {
          homeProvider.currentIndex = index;
        },
        autoSuggestBox: AutoSuggestBox(
          placeholder: S.of(context).typeToSearch,
          trailingIcon: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Icon(FluentIcons.search),
          ),
          controller: _suggestController,
          clearButtonEnabled: true,
          items: naviUtil.suggestItems,
          onSelected: (data) {
            int index = naviUtil.suggestGetIndex(data);
            homeProvider.currentIndex = index;
            setState(() {});
          },
        ),
        autoSuggestBoxReplacement: const Icon(FluentIcons.search),
        items: [...naviUtil.displayItems],
        footerItems: [
          PaneItem(
            icon: const Icon(FluentIcons.settings),
            title: Text(S.of(context).settings),
          ),
        ],
      ),
      content: NavigationBody.builder(
        index: homeProvider.currentIndex,
        itemBuilder: (context, index) {
          if (index < naviUtil.realItems.length) {
            return naviUtil.realItems[index].page;
          }
          return const SettingsView();
        },
      ),
    );

    return WindowToolWidget(child: child);
  }
}
