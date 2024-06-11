import 'package:fancy/API/bloc/postal_code/api_repository.dart';
import 'package:fancy/API/bloc/postal_code/postal_code_bloc.dart';
import 'package:fancy/models/postal_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/app_keys.dart';

class PostOfficeSearch extends StatefulWidget {
  const PostOfficeSearch({super.key});

  static Widget create() {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) {
            return PostalApiRepository();
          },
        ),
        BlocProvider(
          create: (BuildContext context) => PostalCodeBloc(apiRepository: context.read<PostalApiRepository>()),
          child: const PostOfficeSearch(),
        ),
      ],
      child: const PostOfficeSearch(),
    );
  }

  @override
  State<PostOfficeSearch> createState() => PostOfficeSearchState();
}

class PostOfficeSearchState extends State<PostOfficeSearch> {
  TextEditingController postalCodeCont = TextEditingController();
  GlobalKey<FormState> postalKey = GlobalKey<FormState>();
  // static var postalCode = 0;

  @override
  void initState() {
    super.initState();
    makeDis();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            //#region -- Form
            Form(
              key: postalKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8, left: 8, top: 8),
                    child: TextFormField(
                      controller: postalCodeCont,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                      cursorColor: Colors.white,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "* Required";
                        } else if (value.length >= 7 || value.length < 6) {
                          return "* Invalid postal code";
                        } else {
                          return null;
                        }
                      },
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.black,
                        focusColor: Colors.black,
                        hintText: 'Postal Code',
                        hintStyle: const TextStyle(color: Colors.white),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8, left: 8, top: 8),
                    child: ElevatedButton(
                      onPressed: () async {
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        if (postalKey.currentState?.validate() ?? true) {
                          context
                              .read<PostalCodeBloc>()
                              .add(GetPostalCode(postalCode: int.parse(postalCodeCont.text)));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          shadowColor: Colors.transparent,
                          backgroundColor: Colors.grey,
                          elevation: 0,
                          shape: const StadiumBorder(),
                          minimumSize: const Size(double.maxFinite, 40)),
                      child: const Text(
                        'Get',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 8, left: 8, top: 8),
                    child: Divider(
                      thickness: 1,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            //endregion

            BlocConsumer<PostalCodeBloc, PostalCodeState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is CodeState && state.status == ApiStatus.isLoaded) {
                  if (state.dataList!.isEmpty) {
                    return Center(child: Text(state.message ?? ''));
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8, left: 8, top: 8),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: const [
                            DataColumn(
                              label: Text(
                                'No.',
                                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Name',
                                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'BranchType',
                                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Division',
                                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Region',
                                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'State',
                                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Country',
                                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                              ),
                            ),
                          ],
                          rows: List.generate(
                            state.dataList?.length ?? 0,
                            (index) {
                              var data = state.dataList![index];
                              return DataRow(cells: [
                                DataCell(
                                  Text("${index + 1}"),
                                ),
                                DataCell(
                                  Text(data.name.toString()),
                                ),
                                DataCell(
                                  Text(data.branchType.toString()),
                                ),
                                DataCell(
                                  Text(data.division.toString()),
                                ),
                                DataCell(
                                  Text(data.region.toString()),
                                ),
                                DataCell(
                                  Text(data.state.toString()),
                                ),
                                DataCell(
                                  Text(data.country.toString()),
                                ),
                              ]);
                            },
                          ).toList(),
                          showBottomBorder: true,
                        ),
                      ),
                    );
                  }
                } else if (state is CodeState && state.status == ApiStatus.isError) {
                  return Center(child: Text(state.errorMessage ?? ''));
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<String> getPostalCode() async {
    var sharedPref = await SharedPreferences.getInstance();
    String? getPostalCodeString = sharedPref.getString(AppKeys.postalCodeKey);
    if (getPostalCodeString != null) {
      return getPostalCodeString;
    } else {
      return '';
    }
  }

  void makeDis() async {
    final code = await getPostalCode();
    if (code.isNotEmpty) {
      postalCodeCont.text = code;
      Future.delayed(Duration.zero).then((value) =>
          context.read<PostalCodeBloc>().add(GetPostalCode(postalCode: int.parse(code))));
    }
  }
}
