import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy/models/postal_model.dart';
import 'package:fancy/screens/home/explore_page/explore_bloc/todo_bloc.dart';
import 'package:fancy/screens/home/explore_page/todo_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_screen.dart';

class ExploreList extends StatefulWidget {
  const ExploreList({Key? key}) : super(key: key);

  static Widget create() {
    return MultiRepositoryProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) {
            return TodoBloc()..add(GetTodoEvent());
          },
        ),
      ],
      child: const ExploreList(),
    );
  }

  @override
  State<ExploreList> createState() => _ExploreListState();
}

class _ExploreListState extends State<ExploreList> {
  // static final BehaviorSubject<QuerySnapshot> _usersStream =
  // BehaviorSubject<QuerySnapshot>();
  final fireStore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    // getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(10.0),
            child: BlocListener<TodoBloc, TodoState>(
              // listenWhen: (previous, current) => previous.addTodoStatus != current.addTodoStatus,
              listener: (context, state) {
                if(state.addTodoStatus == ApiStatus.isLoaded || state.editTodoStatus == ApiStatus.isLoaded){
                  context.read<TodoBloc>().add(GetTodoEvent());
                }
              },
              child: BlocSelector<
                  TodoBloc,
                  TodoState,
                  ({
                    ApiStatus? status,
                    String? error,
                    List<ToDoModel>? datalist,
                  })>(
                selector: (state) {
                  return (
                    datalist: state.toDoModel,
                    error: state.errorMessage,
                    status: state.getTodoStatus
                  );
                },
                builder: (context, state) {
                  if (state.status == ApiStatus.isLoaded) {
                    if (state.datalist?.isNotEmpty ?? false) {
                      return ListView.builder(
                        itemCount: state.datalist?.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              getBottomModelSheet(state.datalist?[index], true);
                            },
                            child: Container(
                              color: Colors.grey.shade200,
                              margin: const EdgeInsets.only(bottom: 15.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: ListTile(
                                      title: Text(state.datalist?[index].title ?? ''),
                                      subtitle: Text(state.datalist?[index].description ?? ''),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        String todoId =
                                            (state.datalist?[index].id ?? '').toString();
                                        context
                                            .read<TodoBloc>()
                                            .add(DeleteTodoEvent(todoId: todoId));
                                      },
                                      icon: const Icon(
                                        Icons.delete_forever,
                                        color: Colors.red,
                                      ))
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: Text('No Data'),
                      );
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            // child: StreamBuilder<QuerySnapshot>(
            //   stream: fireStore.collection('todo').snapshots(),
            //   builder: (context, snapshot) {
            //     if (snapshot.hasData) {
            //       return ListView(
            //         children: snapshot.data!.docs.map((DocumentSnapshot document) {
            //           Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            //           return GestureDetector(
            //             onTap: () {
            //               getBottomModelSheet(
            //                   ToDoModel(
            //                     title: data['title'],
            //                     description: data['description'],
            //                     id: data['id'],
            //                     status: false,
            //                   ),
            //                   true);
            //             },
            //             child: Container(
            //               color: Colors.grey.shade200,
            //               margin: const EdgeInsets.only(bottom: 15.0),
            //               child: Row(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Flexible(
            //                     child: ListTile(
            //                       title: Text(data['title']),
            //                       subtitle: Text(data['description']),
            //                     ),
            //                   ),
            //                   IconButton(
            //                       onPressed: () {
            //                         String taskId = (data['id']).toString();
            //                       },
            //                       icon: const Icon(
            //                         Icons.delete_forever,
            //                         color: Colors.red,
            //                       ))
            //                 ],
            //               ),
            //             ),
            //           );
            //         }).toList(),
            //       );
            //     } else {
            //       return const Center(
            //         child: CircularProgressIndicator(),
            //       );
            //     }
            //   },
            // ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          getBottomModelSheet(null, false);
        },
        elevation: 25,
        child: const Icon(
          CupertinoIcons.add_circled_solid,
          size: 20,
          color: Colors.white,
        ),
      ),
    );
  }

  // Future<void> getData() async {
  //   _usersStream.add(await FirebaseFirestore.instance.collection('todo').get());
  // }

  Future<void> getBottomModelSheet(ToDoModel? todoModel, bool isEditBool) async {
    showModalBottomSheet(
        // barrierColor: Colors.transparent,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius:
              BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        ),
        context: context,
        builder: (context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
            child: Padding(
                padding: MediaQuery.of(context).viewInsets, child: AddSheet.create(todoModel)),
          );
        });
    /*.then((value) {
      if (value ?? false) {
        isEditBool ? editName() : getName();
      }
    });*/
  }
}
