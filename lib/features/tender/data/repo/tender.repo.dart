import 'package:tender/core/di/container.dart';
import 'package:tender/core/network/try_call_api.dart';
import 'package:tender/core/types/repo_functions.type.dart';
import 'package:tender/features/tender/data/dto/list_tenders.dto.dart';
import 'package:tender/features/tender/data/dto/tender.dto.dart';
import 'package:tender/features/tender/data/models/tender.model.dart';
import 'package:tender/features/tender/data/source/tender.api.dart';

class TenderRepo {
  final _api = locator<TenderApi>();

  RepoListResult<TenderModel> getTenders(ListTendersDTO dto) async {
    apiCall() async {
      final response = await _api.getTenders(dto.toMap());
      return PaginationResult.fromResponse(
        response: response,
        fromJson: TenderModel.fromJson,
      );
    }

    return await TryCallApi.call(apiCall);
  }

  RepoResult<TenderModel> getTender(String id) async {
    apiCall() async {
      final response = await _api.getTender(id);
      return TenderModel.fromJson(response.data!);
    }

    return await TryCallApi.call(apiCall);
  }

  RepoResult<TenderModel> createTender(CreateTenderDTO dto) async {
    apiCall() async {
      final response = await _api.createTender(await dto.toMap());
      return TenderModel.fromJson(response.data!);
    }

    return await TryCallApi.call(apiCall);
  }

  RepoResult<TenderModel> updateTender(UpdateTenderDTO dto) async {
    apiCall() async {
      final response = await _api.updateTender(dto.model.id!, await dto.toMap());
      return TenderModel.fromJson(response.data!);
    }

    return await TryCallApi.call(apiCall);
  }
}
