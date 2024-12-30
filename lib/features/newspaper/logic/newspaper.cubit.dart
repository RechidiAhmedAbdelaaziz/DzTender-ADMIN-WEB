import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tender/core/di/container.dart';
import 'package:tender/core/network/models/api_response.model.dart';
import 'package:tender/core/types/error_state.dart';
import 'package:tender/core/types/repo_functions.type.dart';
import 'package:tender/features/newspaper/data/dto/create_newspaper.dto.dart';
import 'package:tender/features/newspaper/data/models/news_paper.model.dart';
import 'package:tender/features/newspaper/data/rep/newspaper.repo.dart';

part 'newspaper.satat.dart';

class NewsPaperCubit extends Cubit<NewsPaperState> {
  final _repo = locator<NewsPaperRepo>();

  NewsPaperCubit() : super(NewsPaperState.initial());

  Future<void> getNewsPapers() async {
    emit(state._loading(_NewsPaperStatus.loading));

    final results = await _repo.getNewspapers();

    results.when(
      success: (pagination) => emit(state._loaded(pagination)),
      error: (error) => emit(state._error(error.message)),
    );
  }

  Future<void> createNewsPaper(CreateNewsPaperDTO dto) async {
    emit(state._loading(_NewsPaperStatus.creating));

    final results = await _repo.createNewspaper(dto);

    results.when(
      success: (newsPaper) => emit(state._addElement(newsPaper)),
      error: (error) => emit(state._error(error.message)),
    );
  }

  Future<void> updateNewsPaper(UpdateNewsPaperDTO dto) async {
    emit(state._loading(_NewsPaperStatus.updating));

    final results = await _repo.updateNewspaper(dto);

    results.when(
      success: (newspaper) => emit(state._updateElement(newspaper)),
      error: (error) => emit(state._error(error.message)),
    );
  }

  Future<void> deleteNewsPaper(NewsPaperModel newsPaper) async {
    emit(state._loading(_NewsPaperStatus.deleting));

    final results = await _repo.deleteNewspaper(newsPaper.id!);

    results.when(
      success: (_) => emit(state._removeElement(newsPaper)),
      error: (error) => emit(state._error(error.message)),
    );
  }
}
