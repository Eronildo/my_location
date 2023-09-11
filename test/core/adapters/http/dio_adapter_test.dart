import 'dart:io' hide HttpResponse;

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart' as http_mock;
import 'package:my_location/core/adapters/http/dio_adapter.dart';
import 'package:my_location/core/adapters/http/http_adapter.dart';
import 'package:my_location/core/exceptions/app_exception.dart'
    show HttpException;

void main() {
  late DioAdapter dioAdapter;
  late http_mock.DioAdapter httpMockDio;

  const successResponse = {'data': 'Success!'};
  const errorResponse = {'error': '404 Error!'};

  setUp(() {
    httpMockDio = http_mock.DioAdapter(
      dio: Dio(
        BaseOptions(
          baseUrl: 'https://api.test/',
          validateStatus: (status) => true,
          headers: <String, dynamic>{
            'accept': 'application/json',
            'content-type': 'application/json',
          },
        ),
      ),
    );

    dioAdapter = DioAdapter(dioOverride: httpMockDio.dio);
  });

  group('dio.get', () {
    const getSuccessRequest = 'successful-get-request-test';
    const getErrorRequest = '404-get-request-test';

    test(
      'given http status ok when get method be called '
      'should expect a success response',
      () async {
        // Arrange:
        httpMockDio.onGet(
          getSuccessRequest,
          (server) => server.reply(HttpStatus.ok, successResponse),
        );

        // Act:
        final response =
            await dioAdapter.get<ResponseMapType>(getSuccessRequest);

        // Assert:
        expect(response.data, successResponse);
      },
    );

    test(
      'given http status not found when get method be called '
      'should throws a HttpException',
      () async {
        // Arrange:
        httpMockDio.onGet(
          getErrorRequest,
          (server) => server.reply(HttpStatus.notFound, errorResponse),
        );

        // Act:
        final future = dioAdapter.get<ResponseMapType>(getErrorRequest);

        // Assert:
        expect(
          () => future,
          throwsA(isA<HttpException>()),
        );

        try {
          await dioAdapter.get<ResponseMapType>(getErrorRequest);
        } on HttpException catch (e) {
          expect(e.statusCode, HttpStatus.notFound);
        }
      },
    );
  });

  group('dio.post', () {
    const postSuccessRequest = 'successful-post-request-test';
    const postErrorRequest = '404-post-request-test';

    test(
      'given http status ok when post method be called '
      'should expect a success response',
      () async {
        // Arrange:
        httpMockDio.onPost(
          postSuccessRequest,
          (server) => server.reply(HttpStatus.ok, successResponse),
        );

        // Act:
        final response =
            await dioAdapter.post<ResponseMapType>(postSuccessRequest);

        // Assert:
        expect(response.data, successResponse);
      },
    );

    test(
      'given http status not found when post method be called '
      'should throws a HttpException',
      () async {
        // Arrange:
        httpMockDio.onPost(
          postErrorRequest,
          (server) => server.reply(HttpStatus.notFound, errorResponse),
        );

        // Act:
        final future = dioAdapter.post<ResponseMapType>(postErrorRequest);

        // Assert:
        expect(
          () => future,
          throwsA(isA<HttpException>()),
        );

        try {
          await dioAdapter.post<ResponseMapType>(postErrorRequest);
        } on HttpException catch (e) {
          expect(e.statusCode, HttpStatus.notFound);
        }
      },
    );
  });

  group('dio.delete', () {
    const deleteSuccessRequest = 'successful-delete-request-test';
    const deleteErrorRequest = '404-delete-request-test';

    test(
      'given http status ok when delete method be called '
      'should expect a success response',
      () async {
        // Arrange:
        httpMockDio.onDelete(
          deleteSuccessRequest,
          (server) => server.reply(HttpStatus.ok, successResponse),
        );

        // Act:
        final response =
            await dioAdapter.delete<ResponseMapType>(deleteSuccessRequest);

        // Assert:
        expect(response.data, successResponse);
      },
    );

    test(
      'given http status not found when delete method be called '
      'should throws a HttpException',
      () async {
        // Arrange:
        httpMockDio.onDelete(
          deleteErrorRequest,
          (server) => server.reply(HttpStatus.notFound, errorResponse),
        );

        // Act:
        final future = dioAdapter.delete<ResponseMapType>(deleteErrorRequest);

        // Assert:
        expect(
          () => future,
          throwsA(isA<HttpException>()),
        );

        try {
          await dioAdapter.delete<ResponseMapType>(deleteErrorRequest);
        } on HttpException catch (e) {
          expect(e.statusCode, HttpStatus.notFound);
        }
      },
    );
  });

  group('dio.put', () {
    const putSuccessRequest = 'successful-put-request-test';
    const putErrorRequest = '404-put-request-test';

    test(
      'given http status ok when put method be called '
      'should expect a success response',
      () async {
        // Arrange:
        httpMockDio.onPut(
          putSuccessRequest,
          (server) => server.reply(HttpStatus.ok, successResponse),
        );

        // Act:
        final response =
            await dioAdapter.put<ResponseMapType>(putSuccessRequest);

        // Assert:
        expect(response.data, successResponse);
      },
    );

    test(
      'given http status not found when put method be called '
      'should throws a HttpException',
      () async {
        // Arrange:
        httpMockDio.onPut(
          putErrorRequest,
          (server) => server.reply(HttpStatus.notFound, errorResponse),
        );

        // Act:
        final future = dioAdapter.put<ResponseMapType>(putErrorRequest);

        // Assert:
        expect(
          () => future,
          throwsA(isA<HttpException>()),
        );

        try {
          await dioAdapter.put<ResponseMapType>(putErrorRequest);
        } on HttpException catch (e) {
          expect(e.statusCode, HttpStatus.notFound);
        }
      },
    );
  });
}
