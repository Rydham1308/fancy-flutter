part of 'postal_code_bloc.dart';


abstract class PostalCodeEvent {}

class GetPostalCode extends PostalCodeEvent {
  final int postalCode;

  GetPostalCode({required this.postalCode});
}
