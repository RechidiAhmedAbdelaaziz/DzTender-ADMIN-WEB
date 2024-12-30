import 'package:tender/core/di/container.dart';
import 'package:tender/core/network/try_call_api.dart';
import 'package:tender/core/types/repo_functions.type.dart';
import 'package:tender/features/newspaper/data/api/newspaper.api.dart';
import 'package:tender/features/newspaper/data/dto/create_newspaper.dto.dart';

import '../models/news_paper.model.dart';

class NewsPaperRepo {
  final _api = locator<NewsPaperApi>();

  RepoListResult<NewsPaperModel> getNewspapers() async {
    apiCall() async {
      final response = await _api.getNewspapers();
      return PaginationResult.fromResponse(
        response: response,
        fromJson: NewsPaperModel.fromJson,
      );
    }

    return await TryCallApi.call(apiCall);
  }

  RepoResult<NewsPaperModel> createNewspaper(
      CreateNewsPaperDTO dto) async {
    apiCall() async {
      final response = await _api.createNewspaper(await dto.toMap());
      return NewsPaperModel.fromJson(response.data!);
    }

    return await TryCallApi.call(apiCall);
  }

  RepoResult<NewsPaperModel> updateNewspaper(
      UpdateNewsPaperDTO dto) async {
    apiCall() async {
      final response = await _api.updateNewspaper(
        dto.model.id!,
        await dto.toMap(),
      );
      return NewsPaperModel.fromJson(response.data!);
    }

    return await TryCallApi.call(apiCall);
  }

  RepoResult<void> deleteNewspaper(String id) async {
    apiCall() async => await _api.deleteNewspaper(id);

    return await TryCallApi.call(apiCall);
  }
}
