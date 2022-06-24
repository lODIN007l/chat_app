import 'package:aoo_chat_live/routes/routes.dart';
import 'package:aoo_chat_live/services/auth_service.dart';
import 'package:aoo_chat_live/services/chat_service.dart';
import 'package:aoo_chat_live/services/sockt_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AutenticacionService()),
        ChangeNotifierProvider(create: (_) => SocketService()),
        ChangeNotifierProvider(create: (_) => ChatServicio()),
      ],
      child: MaterialApp(
        title: 'Chat App',
        debugShowCheckedModeBanner: false,
        initialRoute: 'loading',
        routes: appRutas,
      ),
    );
  }
}
