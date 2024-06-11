import 'dart:async';
import 'dart:io';
import 'package:fancy/constants/app_keys.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/postal_model.dart';
import 'api_repository.dart';
part 'postal_code_event.dart';
part 'postal_code_state.dart';

class PostalCodeBloc extends Bloc<PostalCodeEvent, PostalCodeState> {
  PostalCodeBloc({required IPostalRepository apiRepository})
      : _postalCodeRepo = apiRepository,
        super(const CodeState.isLoading()) {
    on<GetPostalCode>(getPostalDetail);
  }

  final IPostalRepository _postalCodeRepo;

  Future<void> getPostalDetail(GetPostalCode event, Emitter<PostalCodeState> emit) async {
    try {
      emit(const CodeState.isLoading());
      final data = await _postalCodeRepo.getPostDetails(event.postalCode);
      final dataList = data.resultList ?? [];
      final dataMessage = data.message ?? '';
      var sp = await SharedPreferences.getInstance();
      sp.setString(AppKeys.postalCodeKey, event.postalCode.toString());
      if (dataList.isNotEmpty) {
        emit(CodeState.isLoaded(dataList: dataList, message: dataMessage));
      } else {
        emit(CodeState.isLoaded(dataList: const [], message: dataMessage));
      }
    } on SocketException catch (e) {
      emit(CodeState.isError(errorMessage: e.message));
    }
  }
}
