/**
 * @discripe: 斗鱼APP
 */
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import 'base.dart';
import 'dy_init/index.dart';
import 'dy_index/index.dart';
import 'dy_room/index.dart';
import 'dy_login/index.dart';

class DyApp extends StatelessWidget {
  // 路由路径匹配
  Route<dynamic> _getRoute(RouteSettings settings) {
    Map<String, WidgetBuilder> routes = {
      '/': (BuildContext context) => SplashPage(),
      '/index': (BuildContext context) => DyIndexPage(),
      '/room': (BuildContext context) => DyRoomPage(arguments: settings.arguments),
      '/login': (BuildContext context) => DyLoginPage(arguments: settings.arguments),
      '/webView': (BuildContext context) {  // webView全屏容器
        Map arg = settings.arguments;
        return WebviewScaffold(
          url: arg['url'],
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: DYBase.defaultColor,
            brightness: Brightness.dark,
            textTheme: TextTheme(
              title: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            title: Text(arg['title']),
          ),
        );
      }
    };
    var widget = routes[settings.name];

    if (widget != null) {
      return MaterialPageRoute<void>(
        settings: settings,
        builder: widget,
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(     // 多个Bloc注册
      providers: [
        BlocProvider<CounterBloc>(
          builder: (context) => BlocObj.counter,
        ),
        BlocProvider<IndexBloc>(
          builder: (context) => BlocObj.index,
        ),
      ],
      child: MaterialApp(
          title: 'DYFlutter',
          theme: ThemeData(
            scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
            primarySwatch: Colors.orange,
            textTheme: TextTheme(body1: TextStyle(color: Colors.black)),
            appBarTheme: AppBarTheme(
              textTheme: TextTheme(
                title: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
                body1: TextStyle(color: Colors.black),
              ),
            )
            // splashFactory: NoSplashFactory()
          ),
          onGenerateRoute: _getRoute,
        ),
    );
  }
}

void main() => runApp(DyApp());