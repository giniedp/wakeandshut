import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wakeandshut/services/music_cast/index.dart';
import 'package:wakeandshut/services/music_cast/models/menu_list.dart';

class MenuListScreen extends StatelessWidget {
  static Future<MaterialPageRoute> navigate({
    BuildContext context,
    MusicCastApi client,
    String input,
  }) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider.value(
                value: MCMenuState.init(
                  client: client,
                  input: input,
                  zone: "main",
                ),
              )
            ],
            child: MenuListScreen(),
          );
        },
      ),
    );
  }

  FutureBuilder _buildItem(BuildContext context, int index) {
    var state = Provider.of<MCMenuState>(context);
    return FutureBuilder(
      future: state.getItem(index),
      builder: (context, snapshot) {
        MenuListInfo item;
        item = snapshot.data;
        return ListTile(
          leading: (item?.thumbnail?.isEmpty ?? true)
              ? null
              : Image.network(item.thumbnail),
          title: Text(item?.text ?? ''),
          onTap: () {
            state.select(index);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<MCMenuState>(context);
    print("COUNT ${state.itemcount}");
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              if (state.canGoBack) {
                state.back();
              } else {
                Navigator.pop(context);
              }
            }),
        title: Text("${state.menuName}"),
      ),
      body: ListView.builder(
        itemCount: state.itemcount,
        itemBuilder: _buildItem,
      ),
    );
  }
}
