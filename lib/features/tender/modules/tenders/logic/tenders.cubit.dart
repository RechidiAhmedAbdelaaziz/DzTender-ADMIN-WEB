import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tender/core/di/container.dart';
import 'package:tender/core/network/models/api_response.model.dart';
import 'package:tender/core/types/error_state.dart';
import 'package:tender/core/types/repo_functions.type.dart';
import 'package:tender/features/tender/data/dto/list_tenders.dto.dart';
import 'package:tender/features/tender/data/models/tender.model.dart';
import 'package:tender/features/tender/data/repo/tender.repo.dart';

part 'tenders.state.dart';

class TendersCubit extends Cubit<TendersState> {
  final _tenderRepo = locator<TenderRepo>();

  TendersCubit() : super(TendersState.initial());

  ListTendersDTO dto = ListTendersDTO();

  void search(String keyword) {
    dto.copyWith(keyword: keyword);
    fetchTenders();
  }

  void filter(ListTendersDTO filter) {
    dto.replace(filter);
    fetchTenders();
  }

  Future<void> fetchTenders() async {
    emit(state._loading());
    final result = await _tenderRepo.getTenders(dto);
    result.when(
      success: (tenders) => emit(state._fetchSuccess(tenders)),
      error: (error) => emit(state._failure(error.message)),
    );
  }
}
