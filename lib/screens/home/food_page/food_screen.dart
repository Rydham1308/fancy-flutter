// import 'package:fancy/screens/home/food_page/food_card.dart';
// import 'package:fancy/screens/home/food_page/food_class.dart';
// import 'package:flutter/material.dart';
// import 'package:rxdart/rxdart.dart';
//
// class FoodScreen extends StatefulWidget {
//   const FoodScreen({super.key});
//
//   @override
//   State<FoodScreen> createState() => FoodScreenState();
// }
//
// class FoodScreenState extends State<FoodScreen> {
//   static List<FoodModelClass> foodList = [
//     FoodModelClass(
//       image: image1,
//       name: name1,
//       kcal: kcal1,
//       time: time1,
//       day: day1,
//       type: type1,
//     ),
//     FoodModelClass(
//       image: image2,
//       name: name2,
//       kcal: kcal2,
//       time: time2,
//       day: day2,
//       type: type2,
//     ),
//     FoodModelClass(
//       image: image3,
//       name: name3,
//       kcal: kcal3,
//       time: time3,
//       day: day3,
//       type: type3,
//     ),
//   ];
//
//   BehaviorSubject<FoodModelClass> streamList =
//       BehaviorSubject<FoodModelClass>();
//
//   @override
//   void dispose() {
//     streamList.close();
//     super.dispose();
//   }
//
//   static var currIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         leadingWidth: 24,
//         title: const Text(
//           'Food for Strong Home',
//           style: TextStyle(
//             fontFamily: 'Inter',
//             fontSize: 16,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//       ),
//       body: Padding(
//         padding:
//             const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 16),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//
//               //#region -- From StreamBuilder & RxDart
//               StreamBuilder(
//                 stream: streamList,
//                 builder: (context, snapshot) {
//                   if (snapshot.hasData) {
//                     streamList.add(snapshot.data!);
//                   }
//                   return ListView.builder(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: foodList.length,
//                     itemBuilder: (context, index) {
//                       currIndex = index;
//                       return FoodCard(
//                         model: foodList[index],
//                         delCallBack: () {
//                           setState(() {
//                             foodList.removeAt(index);
//                           });
//                         },
//                       );
//                     },
//                   );
//                 },
//               ),
//               //endregion
//
//               //#region -- From ListView.builder
//               // ListView.builder(
//               //shrinkWrap: true,
//               //physics: const NeverScrollableScrollPhysics(),
//               //   itemCount:,
//               //   itemBuilder: (context, index) {
//               //     currIndex = index;
//               //     return;
//               //     // return FoodCard(
//               //     //   model: foodList[index],
//               //     //   delCallBack: () {
//               //     //     setState(() {
//               //     //       foodList.removeAt(index);
//               //     //     });
//               //     //   },
//               //     // );
//               //   },
//               // ),
//               //endregion
//
//               Padding(
//                 padding: const EdgeInsets.only(top: 16),
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     elevation: 20,
//                     backgroundColor: Colors.yellow,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20.0)),
//                     minimumSize: const Size(double.maxFinite, 42),
//                   ),
//                   onPressed: () async {
//                     final addObj =
//                         await Navigator.pushNamed(context, '/foodAdd');
//                     if (addObj is FoodModelClass) {
//                       foodList.add(addObj);
//                     }
//                   },
//                   child: const Text(
//                     'Add a new food',
//                     style: TextStyle(
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
