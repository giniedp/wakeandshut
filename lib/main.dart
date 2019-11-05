import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'services/index.dart';
import 'widgets/service_log_list.dart';
import 'widgets/service_record/index.dart';

void main() async {
  var discovery = Discovery();
  var storage = Storage();
  await storage.init();
  discovery.start();
  runApp(MultiProvider(
    providers: [
      Provider.value(value: discovery),
      ChangeNotifierProvider.value(value: storage),
      ChangeNotifierProvider.value(value: discovery.logger),
      ChangeNotifierProvider.value(value: discovery.services),
    ],
    child: LifeCycleManager(child: MyApp()),
  ));
}

class LifeCycleManager extends StatefulWidget {
  final Widget child;
  LifeCycleManager({Key key, this.child}) : super(key: key);
  LifeCycleManagerState createState() => LifeCycleManagerState();
}

class LifeCycleManagerState extends State<LifeCycleManager>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('state = $state');
    if (state == AppLifecycleState.inactive) {
      Provider.of<Discovery>(context).stop();
    }
    if (state == AppLifecycleState.resumed) {
      Provider.of<Discovery>(context).start();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'W|a|S',
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: Text('W|a|S'),
                bottom: TabBar(tabs: [
                  Tab(
                    text: "Services",
                    icon: Icon(FontAwesomeIcons.server),
                  ),
                  Tab(
                    text: "Discovery Log",
                    icon: Icon(FontAwesomeIcons.clipboardList),
                  ),
                ]),
              ),
              body: TabBarView(children: [
                ServiceRecordList(
                  ids: Provider.of<Storage>(context).getRecordIds(),
                  services: Provider.of<DiscoveryList>(context).items,
                ),
                ServiceLogList(
                  list: Provider.of<DiscoveryLog>(context).items,
                ),
              ]),
            ),
          );
        },
        ServiceRecordForm.routeName: (context) => ServiceRecordForm(null),
      },
    );
  }
}
