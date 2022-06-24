import 'dart:io';

class Enviroment {
  static String apiUrl = Platform.isAndroid
      ? 'https://chat-app-odin.herokuapp.com/api'
      : 'https://chat-app-odin.herokuapp.com/api';

  static String socketUrl = Platform.isAndroid
      ? 'https://chat-app-odin.herokuapp.com/'
      : 'https://chat-app-odin.herokuapp.com/';
}
