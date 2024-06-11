import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart%20';
import 'package:rxdart/rxdart.dart';
import 'add_screen.dart';
import 'explore_bloc/todo_bloc.dart';

class ExploreList extends StatefulWidget {
  const ExploreList({Key? key}) : super(key: key);

  // static Widget create() {
  //   return MultiRepositoryProvider(
  //     providers: [
  //       RepositoryProvider(
  //         create: (context) {
  //           return FetchPopularMovies();
  //         },
  //       ),
  //       BlocProvider(
  //         create: (BuildContext context) {
  //           return PopularMoviesBloc(popularMovies: context.read<FetchPopularMovies>())
  //             ..add(GetPopularMoviesEvent());
  //         },
  //         child: const ExploreList(),
  //       ),
  //     ],
  //     child: const ExploreList(),
  //   );
  // }

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
            child: StreamBuilder<QuerySnapshot>(
              stream: fireStore.collection('todo').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                      return GestureDetector(
                        onTap: () {
                          getBottomModelSheet(data['title'], data['description'], data['id'], true);
                        },
                        child: Container(
                          color: Colors.grey.shade200,
                          margin: const EdgeInsets.only(bottom: 15.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: ListTile(
                                  title: Text(data['title']),
                                  subtitle: Text(data['description']),

                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    String taskId = (data['id']).toString();
                                    var collection = FirebaseFirestore.instance.collection('todo');
                                    collection.doc(taskId).delete();
                                  },
                                  icon: const Icon(
                                    Icons.delete_forever,
                                    color: Colors.red,
                                  ))
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          getBottomModelSheet(null, null, null, false);
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

  Future<void> getBottomModelSheet(
      String? titleValue, String? descValue, int? editId, bool isEditBool) async {
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
                padding: MediaQuery.of(context).viewInsets,
                child: AddSheet(titleValue, descValue, editId)),
          );
        });
    /*.then((value) {
      if (value ?? false) {
        isEditBool ? editName() : getName();
      }
    });*/
  }
}
