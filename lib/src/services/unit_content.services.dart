import 'dart:async';

import 'package:aritbook10/src/models/UnitModel/unitsubject._model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer' as dev;
import '../models/UnitModel/unit_model.dart';
import '../models/UnitModel/unittopic_model.dart';

class UnitContent {
  Future<UnitBook> getContent() async {
    var db = FirebaseFirestore.instance;
    final content = db.collection('contenido').orderBy('unidad');
    final fullContent = await content.get();
    Future<UnitBook> unitBook = Future.value(UnitBook(
        descriptionUnitBook: '',
        idUnitBook: '',
        titleUnitBook: '',
        unitQuestion: [],
        unitSubject: [],
        urlMainImage: ''));

    try {
      //   db.enableNetwork().then((_) {
      //dev.log("Network enabled");
      for (var unidad in fullContent.docs) {
        // dev.log(unidad.id.toString());
        // dev.log(unidad.data().toString());
        var unitContent = db
            .collection('contenido')
            .doc(unidad.id)
            .collection('temas')
            .orderBy('idSubject', descending: false);
        var unidadID = unidad.id;
        var units = await unitContent.get();

        List<UnitSubject> unitSubject = [];

        for (var tema in units.docs) {
          // dev.log(tema.id.toString());
          // dev.log(tema.data().toString());
          var topicContent = db
              .collection('contenido')
              .doc(unidadID)
              .collection('temas')
              .doc(tema.id)
              .collection('topic');
          var topicUnidad = await topicContent.get();
          List<Topic> topics = [];
          for (var topic in topicUnidad.docs) {
            //  dev.log("TOPIC");
            // dev.log(topic.id.toString());
            // dev.log(topic.data().toString());
            var datos = topic.data();
            Topic topicData = Topic(
              idTopic: datos['idTopic'],
              titleTopic: datos['titleTopic'],
              topicDescription: datos['topicDescription'],
              urlImageTopic: datos['urlImageTopic'],
              urlVideoTopic: datos['urlVideoTopic'],
            );
            topics.add(topicData);
          }
          var datos = tema.data();
          UnitSubject unidad = UnitSubject(
            idSubject: datos['idSubject'],
            titleSubject: datos['titleSubject'],
            descriptionSubject: datos['descriptionSubject'],
            topic: topics,
          );
          unitSubject.add(unidad);
        }

        // dev.log(unitSubject.toString());
        var datos = unidad.data();

        UnitBook unit = UnitBook(
          idUnitBook: datos['idUnitBook'],
          titleUnitBook: datos['titleUnitBook'],
          urlMainImage: datos['urlMainImage'],
          descriptionUnitBook: datos['descriptionUnitBook'],
          unitSubject: unitSubject,
          unitQuestion: [],
        );
        dev.log("UNIT");
        return unit;
      }
      return unitBook;
      //dev.log("UNITBOOK");
      //dev.log(unitBook.toString());
    } catch (e) {
      dev.log(e.toString());

      return Future.error(e);
    }
  }
}
