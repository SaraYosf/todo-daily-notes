
class TaskModel {
  String id;
  String title;
  String description;
  int date;
  bool isDone;
  String userId;

  TaskModel({this.id="",
    required this.title,
    required this.userId,
    required this.description,required this.date, this.isDone=false});
  TaskModel.fromJason(Map<String,dynamic> json):this(
    id: json['id'],
      userId: json['userId'],
    title: json['title'],
    description: json['description'],
    date: json['date'],
    isDone: json['isDone']
  );

  Map<String,dynamic> toJson(){
return {
"id":id,
"userId":userId,
"title":title,
  "description":description,
  "date":date,
  "isDone":isDone
  };
  }

}