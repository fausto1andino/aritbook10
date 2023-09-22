
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_static/shelf_static.dart';

class ServerConfig {
  late final server;

  start() async {
    var handler = createStaticHandler('assets/interactive_geogebra_book',
        defaultDocument: 'ebook.html', listDirectories: true);
    server = await io.serve(handler, 'localhost', 8080);
  }

  stop() {
    server.close();
  }
}
