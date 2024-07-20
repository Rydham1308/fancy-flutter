// import 'package:fancy/screens/home/food_page/food_class.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// class FoodAdd extends StatefulWidget {
//   const FoodAdd({super.key});
//
//   @override
//   State<FoodAdd> createState() => _FoodAddState();
// }
//
// class _FoodAddState extends State<FoodAdd> {
//   GlobalKey<FormState> foodKey = GlobalKey<FormState>();
//   TextEditingController txtFoodName = TextEditingController();
//   TextEditingController txtKcal = TextEditingController();
//   TextEditingController txtTime = TextEditingController();
//   List<String> category = ['Breakfast', 'Lunch', 'Snack', 'Dinner'];
//   List<int> dayNo = List.generate(30, (index) => index + 1);
//   int dayNoFinal = 0;
//   String categoryFinal = 'Breakfast';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         leadingWidth: 24,
//         title: const Text(
//           'Add a new food',
//           style: TextStyle(
//             fontFamily: 'Inter',
//             fontSize: 16,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding:
//               const EdgeInsets.only(top: 12, left: 16, right: 16, bottom: 16),
//           child: Form(
//             key: foodKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 //region -- Name
//                 const Padding(
//                     padding: EdgeInsets.only(bottom: 8),
//                     child: Text('Food Name')),
//                 TextFormField(
//                   controller: txtFoodName,
//                   cursorColor: Colors.yellow,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "* Required";
//                     } else {
//                       return null;
//                     }
//                   },
//                   style: const TextStyle(
//                     color: Colors.white,
//                   ),
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: Colors.grey,
//                     focusColor: Colors.grey,
//                     hintText: 'Add Food Name',
//                     border: InputBorder.none,
//                     contentPadding:
//                         const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: const BorderSide(
//                           color: Colors.yellow, width: 1),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     errorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                   ),
//                 ),
//                 //endregion
//
//                 //region -- Category
//                 const Padding(
//                     padding: EdgeInsets.only(top: 8, bottom: 8),
//                     child: Text('Category')),
//                 DropdownButtonFormField(
//                   items: category.map((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value),
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     categoryFinal = value!;
//                   },
//                   value: category.first,
//                   // validator: (value) {
//                   //   if (value!.isEmpty) {
//                   //     return "* Required";
//                   //   } else {
//                   //     return null;
//                   //   }
//                   // },
//                   icon: const Padding(
//                       padding: EdgeInsets.only(right: 12),
//                       child: Icon(
//                         CupertinoIcons.chevron_down,
//                         color: Colors.grey,
//                         size: 16,
//                       )),
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: Colors.grey,
//                     focusColor: Colors.grey,
//                     hintText: 'Select Category',
//                     border: InputBorder.none,
//                     contentPadding:
//                         const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                   ),
//                 ),
//                 //endregion
//
//                 //region -- Day No.
//                 const Padding(
//                     padding: EdgeInsets.only(top: 8, bottom: 8),
//                     child: Text('Day No.')),
//                 DropdownButtonFormField(
//                   items: dayNo.map((int value) {
//                     return DropdownMenuItem<int>(
//                       value: value,
//                       child: Text('$value'),
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     dayNoFinal = value ?? 0;
//                   },
//                   validator: (value) {
//                     if (value == null) {
//                       return "* Required";
//                     } else {
//                       return null;
//                     }
//                   },
//                   icon: const Padding(
//                       padding: EdgeInsets.only(right: 12),
//                       child: Icon(
//                         CupertinoIcons.chevron_down,
//                         color: Colors.grey,
//                         size: 16,
//                       )),
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: Colors.grey,
//                     focusColor: Colors.grey,
//                     hintText: 'Select Category',
//                     border: InputBorder.none,
//                     contentPadding:
//                         const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     errorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                   ),
//                 ),
//                 //endregion
//
//                 //region -- Calories & Time
//                 Padding(
//                   padding: const EdgeInsets.only(top: 8, bottom: 8),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       Flexible(
//                         child: Container(
//                           alignment: Alignment.centerLeft,
//                           child: const Text('Calories'),
//                         ),
//                       ),
//                       Flexible(
//                         child: Container(
//                           alignment: Alignment.centerLeft,
//                           child: const Text('Prep Time'),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     Expanded(
//                       child: TextFormField(
//                         controller: txtKcal,
//                         keyboardType: TextInputType.number,
//                         inputFormatters: <TextInputFormatter>[
//                           FilteringTextInputFormatter.digitsOnly
//                         ],
//                         cursorColor: Colors.white,
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return "* Required";
//                           } else {
//                             return null;
//                           }
//                         },
//                         style: const TextStyle(color: Colors.white),
//                         decoration: InputDecoration(
//                           filled: true,
//                           fillColor: Colors.grey,
//                           focusColor: Colors.grey,
//                           hintText: 'Calories',
//                           border: InputBorder.none,
//                           contentPadding: const EdgeInsets.only(
//                               left: 14.0, bottom: 8.0, top: 8.0),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                                 color: Colors.yellow, width: 1),
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           errorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const Padding(
//                       padding: EdgeInsets.only(left: 8, right: 8),
//                       child: Text('kcal'),
//                     ),
//                     Expanded(
//                       child: TextFormField(
//                         controller: txtTime,
//                         keyboardType: TextInputType.number,
//                         inputFormatters: <TextInputFormatter>[
//                           FilteringTextInputFormatter.digitsOnly
//                         ],
//                         cursorColor: Colors.white,
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return "* Required";
//                           } else {
//                             return null;
//                           }
//                         },
//                         style: const TextStyle(color: Colors.white),
//                         decoration: InputDecoration(
//                           filled: true,
//                           fillColor: Colors.grey,
//                           focusColor: Colors.grey,
//                           hintText: 'Time',
//                           border: InputBorder.none,
//                           contentPadding: const EdgeInsets.only(
//                               left: 14.0, bottom: 8.0, top: 8.0),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                                 color: Colors.yellow, width: 1),
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           errorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const Padding(
//                       padding: EdgeInsets.only(left: 8, right: 8),
//                       child: Text('mins'),
//                     ),
//                   ],
//                 ),
//                 //endregion
//
//                 //region -- Buttons
//                 Padding(
//                   padding: const EdgeInsets.only(top: 8, bottom: 8),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.only(right: 8),
//                           child: ElevatedButton(
//                             onPressed: () {
//                               if (foodKey.currentState?.validate() ?? true) {
//                                 Navigator.pop(
//                                   context,
//                                   FoodModelClass(
//                                     image: image3,
//                                     name: txtFoodName.text,
//                                     kcal: txtKcal.text,
//                                     time: txtTime.text,
//                                     day: dayNoFinal,
//                                     type: categoryFinal,
//                                   ),
//                                 );
//                               }
//                             },
//                             style: ElevatedButton.styleFrom(
//                               shadowColor: Colors.transparent,
//                               backgroundColor: Colors.yellow,
//                               elevation: 0,
//                             ),
//                             child: const Text(
//                               'Save',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w900,
//                                 fontSize: 15,
//                                 color: Colors.black,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.only(left: 8),
//                           child: OutlinedButton(
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                             style: ElevatedButton.styleFrom(
//                               foregroundColor: Colors.yellow,
//                               shadowColor: Colors.transparent,
//                               elevation: 00,
//                               side: const BorderSide(
//                                 color: Colors.yellow,
//                                 width: 2,
//                               ),
//                             ),
//                             child: const Text(
//                               'Cancel',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w900,
//                                 fontSize: 15,
//                                 color: Colors.yellow,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 //endregion
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
