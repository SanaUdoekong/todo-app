class Todo {
  String title;
  String description;
  int id;
  bool isStarred =  false;
  bool isCompleted = false;

  Todo({this.title, this.description, this.id});

  Todo.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['desc'];
    id = json['id'];
    isStarred = json['isStarred'];
    isCompleted = json['isCompleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['desc'] = this.description;
    data['id'] = this.id;
    data['isStarred'] = this.isStarred;
    data['isCompleted'] = this.isCompleted;
    return data;
  }
}
