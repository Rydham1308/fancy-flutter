// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:rxdart/rxdart.dart';
// import '../../models/postal_model.dart';
//
// class RemoteSrvs {
//   static BehaviorSubject<ApiHelper> apiHelperStream =
//       BehaviorSubject<ApiHelper>();
//   static String message = '';
//
//   static Future<List<PostOfficeData>> fetchUserList(var postcode) async {
//     RemoteSrvs.apiHelperStream.add(ApiHelper(status: ApiStatus.isLoading));
//     try {
//       final response = await http
//           .get(Uri.parse('https://api.postalpincode.in/pincode/$postcode'));
//       if (response.statusCode == 200) {
//         final result = jsonDecode(response.body) as List<dynamic>;
//         final apiData = result.first['Message'] as String;
//         // final apiData = (result.first['Message'] is String)
//         //     ? (result.first?['Message'] ?? '') as String
//         //     : null;
//         message = apiData;
//         final data = (result.first is Map)
//             ? (result.first?['PostOffice'] ?? []) as List<dynamic>
//             : null;
//         if (data?.isNotEmpty ?? false) {
//           final dta = data?.map((e) => PostOfficeData.fromJson(e)).toList();
//           RemoteSrvs.apiHelperStream
//               .add(ApiHelper(status: ApiStatus.isLoaded, resultList: dta));
//           return dta ?? [];
//         } else {
//           RemoteSrvs.apiHelperStream
//               .add(ApiHelper(status: ApiStatus.isLoaded, resultList: []));
//           return [];
//         }
//       } else {
//         RemoteSrvs.apiHelperStream.add(ApiHelper(status: ApiStatus.isError));
//         throw Exception('No Data Found');
//       }
//     } on SocketException catch (e) {
//       RemoteSrvs.apiHelperStream.add(ApiHelper(status: ApiStatus.networkError));
//       throw Exception('network error : $e');
//     }
//   }
// }
