class ToDoModel {
  final String? description;
  final String? title;
  final int? id;
  final bool? status;

  const ToDoModel({this.description, this.title, this.id, this.status});

  ToDoModel copyWith({
    String? description,
    String? title,
    int? id,
    bool? status,
  }) {
    return ToDoModel(
      status: status ?? this.status,
      description: description ?? this.description,
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }

  ToDoModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        status = json['status'],
        title = json['title'],
        description = json['description'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'status': status,
        'title': title,
        'description': description,
      };
}

// class TodoServices {
//   final db = FirebaseFirestore.instance;
//
//   late final CollectionReference todoReference;
//
//   TodoServices() {
//     todoReference = db.collection('todo').withConverter<ToDoModel>(
//         fromFirestore: (snapshot, options) =>
//             ToDoModel.fromJson(snapshot.data()!),
//         toFirestore: (value, options) => value.toJson());
//   }
//
//   Stream<QuerySnapshot> getTodo(){
//     return todoReference.snapshots();
//   }
//
//   void addTodo(ToDoModel toDoModel){
//     todoReference.add(toDoModel);
//   }
// }
