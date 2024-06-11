import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy/models/todo_model.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class AddSheet extends StatefulWidget {
  const AddSheet(
    this.titleValue,
    this.descValue,
    this.editId, {
    super.key,
  });

  final int? editId;
  final String? titleValue;
  final String? descValue;

  @override
  State<AddSheet> createState() => AddSheetState();
}

class AddSheetState extends State<AddSheet> {
  GlobalKey<FormState> formAddKey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();
  static const String nameKey = 'nameKey';
  static const String nameListKey = 'nameListKey';
  bool isEditBtn = false;
  bool isAvailable = false;
  Random random = Random();
  int editId = 0;
  late int editIdIndex;
  ToDoModel toDoModel = ToDoModel();
  ValueNotifier<bool> isRegistered = ValueNotifier(true);
  @override
  void didChangeDependencies() {
    final getOldName = widget.titleValue;
    final getOldDesc = widget.descValue;
    final getOldId = widget.editId;
    if (getOldName is String) {
      title.text = getOldName;
      desc.text = getOldDesc ?? '';
      editId = getOldId ?? 0;
      isEditBtn = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        child: Container(
          color: const Color(0xFFE3E1D4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Container(
                margin: const EdgeInsets.only(left: 23, bottom: 15, top: 20),
                alignment: Alignment.centerLeft,
                child: !isEditBtn
                    ? const Text(
                        "Add Note",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      )
                    : const Text(
                        "Update Note",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
              ),
              Form(
                key: formAddKey,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          right: 23, left: 23, bottom: 10),
                      child: TextField(
                        controller: title,
                        cursorColor: Colors.black,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          labelText: 'Title',
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          right: 23, left: 23, bottom: 20),
                      child: TextField(
                        maxLines: 6,
                        controller: desc,
                        cursorColor: Colors.black,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          alignLabelWithHint: true,
                          labelText: 'Description',
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 23, bottom: 15),
                alignment: Alignment.centerLeft,
                child: ElevatedButton(
                  onPressed: () async {
                    try{
                    if (isEditBtn) {
                      toDoModel.title = title.text.trim();
                      toDoModel.description = desc.text.trim();
                      toDoModel.status = false;
                      toDoModel.id = editId;
                      await editData();
                    } else {
                      toDoModel.title = title.text.trim();
                      toDoModel.description = desc.text.trim();
                      toDoModel.status = false;
                      toDoModel.id = random.nextInt(1000000);
                      await dataAdd();
                    }
                    Future.delayed(Duration.zero)
                        .then((value) => Navigator.pop(context, true));
                  }on FirebaseException catch(e){
                      Future.delayed(Duration.zero).then((value) =>
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: const Color(0xd52d2d2d),
                              content: Text(
                                e.message.toString(),
                                style:
                                const TextStyle(color: Colors.white),
                              ),
                              duration:
                              const Duration(milliseconds: 1000),
                            ),
                          ));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.transparent,
                    backgroundColor: Colors.black,
                    elevation: 0,
                    shape: const StadiumBorder(),
                    minimumSize: const Size(150, 40),
                  ),
                  child: !isEditBtn
                      ? const Text(
                          "Add",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 15,
                          ),
                        )
                      : const Text(
                          "Update",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 15,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> editData() async {
    final db = FirebaseFirestore.instance;
    db.collection('todo').doc('${toDoModel.id}').update(toDoModel.toJson());
  }

  Future<void> dataAdd() async {
    final db = FirebaseFirestore.instance;
    db.collection('todo').doc('${toDoModel.id}').set(toDoModel.toJson());
  }
}
