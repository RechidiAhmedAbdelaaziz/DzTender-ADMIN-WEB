import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tender/core/di/container.dart';
import 'package:tender/core/types/error_state.dart';
import 'package:tender/features/tender/data/dto/tender.dto.dart';
import 'package:tender/features/tender/data/repo/tender.repo.dart';

part 'tender.state.dart';

class TenderCubit extends Cubit<TenderState> {
  final _tenderRepo = locator<TenderRepo>();
  final formKey = GlobalKey<FormState>();
  TenderCubit([String? tenderId]) : super(TenderState.initial()) {
    loadTender(tenderId);
  }

  void updateTender(TenderDTO tenderDTO) {
    emit(state._loaded(tenderDTO));
  }

  Future<void> loadTender([String? tenderId]) async {
    emit(state._loading());

    if (tenderId == null) {
      emit(state._loaded(CreateTenderDTO()));
      return;
    }

    final result = await _tenderRepo.getTender(tenderId);

    result.when(
      success: (tender) =>
          emit(state._loaded(UpdateTenderDTO.fromModel(tender))),
      error: (error) => emit(state._error(error.message)),
    );
  }

  Future<void> saveTender() async {
    // if (!formKey.currentState!.validate()) return; //TODO validate form
    emit(state._loading());

    final result = !state.isUpdating
        ? await _tenderRepo
            .createTender(state._tenderDTO as CreateTenderDTO)
        : await _tenderRepo
            .updateTender(state._tenderDTO as UpdateTenderDTO);

    result.when(
      success: (_) => emit(state._success()),
      error: (error) => emit(state._error(error.message)),
    );
  }
}
