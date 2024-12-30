import 'package:tender/core/di/container.dart';
import 'package:tender/core/network/models/api_response.model.dart';
import 'package:tender/core/network/try_call_api.dart';
import 'package:tender/core/types/repo_functions.type.dart';
import 'package:tender/features/Auth/data/dto/login.dto.dart';
import 'package:tender/features/Auth/data/sources/auth.api.dart';

class AuthRepo {
  final _api = locator<AuthApi>();

  RepoResult<AuthTokens> login(LoginDto dto) async {
    apiCall() async {
      final response = await _api.login(dto.body);
      return response.tokens!;
    }

    return await TryCallApi.call(apiCall);
  }

  RepoResult<AuthTokens> refreshToken(String refreshToken) async {
    apiCall() async {
      final response = await _api.refreshToken({
        'refreshToken': refreshToken,
      });

      return response.tokens!;
    }

    return await TryCallApi.call(apiCall);
  }
}
