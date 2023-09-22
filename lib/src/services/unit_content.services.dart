import 'dart:async';

import 'package:espe_math/src/models/UnitModel/unitquestion_model.dart';
import 'package:espe_math/src/models/UnitModel/unitsubject._model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer' as dev;
import '../models/UnitModel/unit_model.dart';
import '../models/UnitModel/unitoption_model.dart';
import '../models/UnitModel/unittopic_model.dart';

class UnitContent {
  Future<List<UnitBook>> getContent() async {
    var db = FirebaseFirestore.instance;
    final content = db.collection('contenido').orderBy('unidad');
    final fullContent = await content.get();
    List<UnitBook> totalBook = [];

    try {
      for (var unidad in fullContent.docs) {
        var unitContent = db
            .collection('contenido')
            .doc(unidad.id)
            .collection('temas')
            .orderBy('idSubject', descending: false);
        var unitQuestionContent =
            db.collection('contenido').doc(unidad.id).collection('preguntas');

        var unidadID = unidad.id;
        var units = await unitContent.get();
        var unitsQuestion = await unitQuestionContent.get();

        List<UnitSubject> unitSubject = [];
        List<UnitQuestion> unitQuestions = [];

        for (var quetions in unitsQuestion.docs) {
          var quetionsContent = db
              .collection('contenido')
              .doc(unidadID)
              .collection('preguntas')
              .doc(quetions.id)
              .collection("option")
              .orderBy('idOption', descending: false);
          var quetionContent = await quetionsContent.get();
          List<Option> options = [];
          for (var option in quetionContent.docs) {
            var dataOptions = option.data();
            Option dataOption = Option(
                idOption: dataOptions["idOption"],
                answerOption: dataOptions["answerOption"],
                isTheCorrectOption: dataOptions["isTheCorrectOption"]);
            options.add(dataOption);
          }
          var dataQuestions = quetions.data();
          UnitQuestion unitQuestion = UnitQuestion(
              idQuestion: dataQuestions["idQuestion"],
              titleQuestion: dataQuestions["titleQuestion"],
              feedBackQuestion: dataQuestions["feedBackQuestion"],
              urlImageOrVideoQuestion: dataQuestions["urlImageOrVideoQuestion"],
              option: options);
          unitQuestions.add(unitQuestion);
          dev.log(unitQuestions.first.toJson().toString());
        }

        for (var tema in units.docs) {
          var topicContent = db
              .collection('contenido')
              .doc(unidadID)
              .collection('temas')
              .doc(tema.id)
              .collection('topic');
          var topicUnidad = await topicContent.get();
          List<Topic> topics = [];
          for (var topic in topicUnidad.docs) {
            var datos = topic.data();
            Topic topicData = Topic(
              idTopic: datos['idTopic'],
              urlImageTopic: datos['urlImageTopic'],
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
        var datos = unidad.data();
        UnitBook unit = UnitBook(
          idUnitBook: datos['idUnitBook'],
          titleUnitBook: datos['titleUnitBook'],
          urlMainImage: datos['urlMainImage'],
          descriptionUnitBook: datos['descriptionUnitBook'],
          unitSubject: unitSubject,
          unitQuestion: unitQuestions,
        );
        totalBook.add(unit);
      }
      return totalBook;
    } catch (e) {
      dev.log(e.toString());
      return Future.error(e);
    }
  }
}
