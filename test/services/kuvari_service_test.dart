import 'package:flutter_test/flutter_test.dart';
import 'package:kuvari_app/services/kuvari_service.dart';
import 'package:kuvari_app/models/kuvari_image.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_functions/cloud_functions.dart';

// Generate mocks
@GenerateMocks([http.Client, FirebaseFunctions, HttpsCallable, HttpsCallableResult])
import 'kuvari_service_test.mocks.dart';

void main() {
  group('KuvariService', () {
    late KuvariService service;
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
      service = KuvariService(client: mockClient);
    });

    test('searchImages calls Papunet API for Finnish', () async {
      when(mockClient.get(any)).thenAnswer((_) async =>
          http.Response('{"images": []}', 200));

      await service.searchImages('cat', [], 'fi');

      verify(mockClient.get(argThat(predicate((Uri uri) =>
          uri.host == 'kuha.papunet.net' &&
          uri.queryParameters['lang'] == 'fi'))));
    });

    test('searchImages calls Papunet API for Swedish (mapped to se)', () async {
      when(mockClient.get(any)).thenAnswer((_) async =>
          http.Response('{"images": []}', 200));

      await service.searchImages('cat', [], 'sv');

      verify(mockClient.get(argThat(predicate((Uri uri) =>
          uri.host == 'kuha.papunet.net' &&
          uri.queryParameters['lang'] == 'se'))));
    });

    // Note: Testing the Firebase Functions call is tricky without extensive mocking of the static instance.
    // For this unit test, we primarily verified that 'fi' and 'sv' still go to Papunet.
    // The 'en' path goes to _searchOpenSymbols which uses the static FirebaseFunctions.instance.
    // To test that properly, we'd need to refactor KuvariService to accept FirebaseFunctions as a dependency.
    // For now, we rely on the implementation plan's manual verification for the 'en' path,
    // or we could refactor the service to be more testable.
  });
}
