class Topic {
  int idTopic;

  String urlImageTopic;


  Topic({
    required this.idTopic,

    required this.urlImageTopic,

  });

  factory Topic.fromJson(Map<String, dynamic> json) => Topic(
        idTopic: json["idTopic"],

        urlImageTopic: json["urlImageTopic"]

      );

  Map<String, dynamic> toJson() => {
        "idTopic": idTopic,
    
        "urlImageTopic": urlImageTopic,

      };
}
