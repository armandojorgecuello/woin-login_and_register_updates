class QuestionSeg{
  String message;
  bool status;
  List<Question> entities;

  QuestionSeg({this.message, this.status, this.entities});

  QuestionSeg.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['entities'] != null) {
      entities = new List<Question>();
      json['entities'].forEach((v) {
        entities.add(new Question.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.entities != null) {
      data['entities'] = this.entities.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Question {
  int id;
  String question;
  int type;
  int state;
  int createdAt;
  int updatedAt;

  Question(
      {this.id,
        this.question,
        this.type,
        this.state,
        this.createdAt,
        this.updatedAt});

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    type = json['type'];
    state = json['state'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question'] = this.question;
    data['type'] = this.type;
    data['state'] = this.state;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}