

class ScreenData {
  final String urlImg;
  final String titulo;
  final String texto;

  ScreenData({this.urlImg, this.titulo, this.texto});
}

final List<ScreenData> listScreen = [
  ScreenData(
      urlImg: 'assets/img/img_1.png',
      titulo: 'Woin',
      texto: '''Directorio digital,red social de marketing
y publicidad para el intercambio comercial'''),
  ScreenData(
      urlImg: 'assets/img/img_2.png',
      titulo: 'Cliwoin',
      texto: '''Usuarios que desean comprar en
   promoción para ganar puntos'''),
  ScreenData(
      urlImg: 'assets/img/img_3.png',
      titulo: 'Emwoin',
      texto: '''      Comercios que buscan visibilidad e
incrementar sus ventas y fidelizar clientes''')
];
