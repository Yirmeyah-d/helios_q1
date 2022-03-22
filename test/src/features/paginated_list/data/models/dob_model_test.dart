import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:helios_q1/src/features/paginated_list/data/models/dob_model.dart';
import 'package:helios_q1/src/features/paginated_list/domain/entities/dob.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tDobModel = DobModel(age: 23);

  test(
    'should be a subclass of Dob entity',
    () async {
      // assert
      expect(tDobModel, isA<Dob>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model when the JSON number is an integer',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(fixture('dob.json'));
        // act
        final result = DobModel.fromJson(jsonMap);
        // assert
        expect(result, tDobModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a Json map containing the proper data',
      () async {
        // act
        final result = tDobModel.toJson();

        // assert
        final expectedMap = {
          'age': 23,
        };

        expect(result, expectedMap);
      },
    );
  });
}
