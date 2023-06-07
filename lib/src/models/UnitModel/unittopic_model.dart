class Topic {
  int idTopic;
  String titleTopic;
  String topicDescription;
  String urlImageTopic;
  String urlVideoTopic;

  Topic({
    required this.idTopic,
    required this.titleTopic,
    required this.topicDescription,
    required this.urlImageTopic,
    required this.urlVideoTopic,
  });

  factory Topic.fromJson(Map<String, dynamic> json) => Topic(
        idTopic: json["idTopic"],
        titleTopic: json["titleTopic"],
        topicDescription: json["topicDescription"],
        urlImageTopic: json["urlImageTopic"],
        urlVideoTopic: json["urlVideoTopic"],
      );

  Map<String, dynamic> toJson() => {
        "idTopic": idTopic,
        "titleTopic": titleTopic,
        "topicDescription": topicDescription,
        "urlImageTopic": urlImageTopic,
        "urlVideoTopic": urlVideoTopic,
      };
}
