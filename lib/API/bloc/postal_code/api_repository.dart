import 'dart:io';
import 'package:fancy/healper/dio_singleton.dart';
import 'package:fancy/healper/injections.dart';
import '../../../models/postal_model.dart';

abstract class IPostalRepository {
  Future<ApiHelper> getPostDetails(int postcode);
}

class PostalApiRepository implements IPostalRepository {
  DioClient dioClient = getIt<DioClient>();

  @override
  Future<ApiHelper> getPostDetails(int postcode) async {
    final response = await dioClient.getDio().get('$postcode');

    try {
      if (response.statusCode == 200) {
        final result = response.data as List<dynamic>;
        final apiDataMsg = result.first['Message'] as String;
        final data =
            (result.first is Map) ? (result.first?['PostOffice'] ?? []) as List<dynamic> : null;
        if (data?.isNotEmpty ?? false) {
          final dataList = data?.map((e) => PostOfficeData.fromJson(e)).toList();
          return ApiHelper(resultList: dataList);
        } else {
          return ApiHelper(message: apiDataMsg);
        }
      } else {
        return ApiHelper();
      }
    } on SocketException catch (e) {
      throw Exception(e);
    }
  }
}
