class Topic {
  int idTopic;
  String tittleTopic;
  String topicDescription;
  String urlImageTopic;
  String urlVideoTopic;

  Topic({
    required this.idTopic,
    required this.tittleTopic,
    required this.topicDescription,
    required this.urlImageTopic,
    required this.urlVideoTopic,
  });

  factory Topic.fromJson(Map<String, dynamic> json) => Topic(
        idTopic: json["idTopic"],
        tittleTopic: json["tittleTopic"],
        topicDescription: json["topicDescription"],
        urlImageTopic: json["urlImageTopic"],
        urlVideoTopic: json["urlVideoTopic"],
      );

  Map<String, dynamic> toJson() => {
        "idTopic": idTopic,
        "tittleTopic": tittleTopic,
        "topicDescription": topicDescription,
        "urlImageTopic": urlImageTopic,
        "urlVideoTopic": urlVideoTopic,
      };
}
