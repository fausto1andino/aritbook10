import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer' as dev;

class UnitContent {
  getContent() async {
    var db = FirebaseFirestore.instance;
    final content = db.collection('contenido').orderBy('unidad');
    final fullContent = await content.get();
    db.enableNetwork().then((_) {
      dev.log("Network enabled");
      fullContent.docs.forEach((unidad) async {
        dev.log(unidad.id.toString());
        var unitContent = db
            .collection('contenido')
            .doc(unidad.id)
            .collection('temas')
            .orderBy('idSubject', descending: false);
        var units = await unitContent.get();
        dev.log(unidad.data().toString());
        units.docs.forEach((tema) async {
          dev.log(tema.id.toString());
          dev.log(tema.data().toString());
          var topicContent = db
              .collection('contenido')
              .doc(unidad.id)
              .collection('temas')
              .doc(tema.id)
              .collection('topic');

          dev.log("TOPIC");
          var topicUnidad = await topicContent.get();
          topicUnidad.docs.forEach((topic) {
            dev.log(topic.id.toString());
            dev.log(topic.data().toString());
          });
        });
      });
    });
    return fullContent.docs;
  }
}
