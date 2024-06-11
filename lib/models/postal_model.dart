enum ApiStatus { isInitial ,isLoaded, isLoading, isError, networkError }

class ApiHelper {
  String? message;
  List<PostOfficeData>? resultList;

  ApiHelper({ this.resultList, this.message});
}

// class ApiData {
//   final String message;
//   final String status;
//
//   ApiData({
//     required this.message,
//     required this.status,
//   });
// }

class PostOfficeData {
  final String name;
  final String branchType;
  final String deliveryStatus;
  final String circle;
  final String district;
  final String division;
  final String region;
  final String block;
  final String state;
  final String country;
  final String pincode;

  const PostOfficeData({
    required this.name,
    required this.branchType,
    required this.deliveryStatus,
    required this.circle,
    required this.district,
    required this.division,
    required this.region,
    required this.block,
    required this.state,
    required this.country,
    required this.pincode,
  });

  PostOfficeData.fromJson(Map<String, dynamic> json)
      : name = json['Name'],
        branchType = json['BranchType'],
        deliveryStatus = json['DeliveryStatus'],
        circle = json['Circle'],
        district = json['District'],
        division = json['Division'],
        region = json['Region'],
        block = json['Block'],
        state = json['State'],
        country = json['Country'],
        pincode = json['Pincode'];
}
