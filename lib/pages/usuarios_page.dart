// ignore_for_file: non_constant_identifier_names

import 'package:aoo_chat_live/models/usuario.dart';
import 'package:aoo_chat_live/services/auth_service.dart';
import 'package:aoo_chat_live/services/chat_service.dart';
import 'package:aoo_chat_live/services/usuarios_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../services/sockt_service.dart';

class UsuariosScreen extends StatefulWidget {
  @override
  State<UsuariosScreen> createState() => _UsuariosScreenState();
}

class _UsuariosScreenState extends State<UsuariosScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final usuarioServ = UsuarioServicio();

  List<Usuario> usuarios = [];

  // final usuarios = [

  @override
  void initState() {
    _cargandoUsuario();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authServicio = Provider.of<AutenticacionService>(context);
    final socketServicio = Provider.of<SocketService>(context);
    final usuario = authServicio.usuario;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          usuario!.nombre,
          style: const TextStyle(
            color: Colors.black54,
          ),
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            socketServicio.desconectar();
            AutenticacionService.deleteToken();
            Navigator.pushReplacementNamed(context, 'login');
          },
          icon: const Icon(
            Icons.exit_to_app,
            color: Colors.black54,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: (socketServicio.serverStatusG == ServerStatus.Online)
                ? Icon(Icons.check_circle, color: Colors.blue[400])
                : Icon(Icons.offline_bolt, color: Colors.red),
          ),
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: _cargandoUsuario,
        header: const WaterDropMaterialHeader(
          color: Colors.blue,
        ),
        enablePullDown: true,
        child: _ListVIEWuSUARIOS(),
      ),
    );
  }

  ListView _ListVIEWuSUARIOS() {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (_, index) => _usuarioListTile(usuarios[index]),
      separatorBuilder: (_, index) => const Divider(),
      itemCount: usuarios.length,
    );
  }

  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
      title: Text(usuario.nombre),
      leading: CircleAvatar(
        backgroundColor: Colors.blue[100],
        child: Text(
          usuario.nombre.substring(0, 2),
        ),
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: usuario.online ? Colors.green : Colors.red,
            borderRadius: BorderRadius.circular(100)),
      ),
      onTap: () {
        final chatSer = Provider.of<ChatServicio>(context, listen: false);
        chatSer.usuarioDestino = usuario;
        //print('id del nuevo');
        //print(usuario.uid);
        Navigator.pushNamed(context, 'chat');
      },
    );
  }

  _cargandoUsuario() async {
    usuarioServ.getUsuario();
    usuarios = await usuarioServ.getUsuario();

    setState(() {});
    // if failed,use refreshFailed()'
    _refreshController.refreshCompleted();
  }
}
