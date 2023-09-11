import 'package:dio/dio.dart';
import 'package:dson_adapter/dson_adapter.dart';

import '../../../core/adapters/http/http_adapter.dart';
import '../../../core/adapters/network/network_adapter.dart';
import '../../../core/exceptions/app_exception.dart';
import '../../../core/utils/result.dart';
import '../models/coordinates.dart';

const _apiUrlPart = '/json';
const _apiQueryParamsKey = 'fields';
const _apiQueryParamsValue = 'lat,lon';

/// A Repository class for Location feature.
class LocationRepository {
  /// [LocationRepository] constructor
  ///
  /// Requires a [HttpAdapter].
  LocationRepository({
    required HttpAdapter httpAdapter,
    required NetworkAdapter networkAdapter,
  })  : _networkAdapter = networkAdapter,
        _httpAdapter = httpAdapter;

  final HttpAdapter _httpAdapter;

  /// Network status checker.
  final NetworkAdapter _networkAdapter;

  /// Get [Coordinates] by API via HTTP.
  Future<Result<AppException, Coordinates>> getCoordinatesByHttp() async {
    if (await _networkAdapter.isConnected) {
      try {
        final response = await _httpAdapter.get<ResponseMapType>(
          _apiUrlPart,
          queryParameters: {_apiQueryParamsKey: _apiQueryParamsValue},
        );

        return Success(Coordinates.fromJson(response.data));
      } on HttpException catch (e) {
        return Failure(e);
      } on DioException catch (e, s) {
        return Failure(HttpException(message: e.message, stackTrace: s));
      } on DSONException catch (e, s) {
        return Failure(HttpException(message: e.message, stackTrace: s));
      }
    } else {
      return Failure(NoInternetException());
    }
  }
}
