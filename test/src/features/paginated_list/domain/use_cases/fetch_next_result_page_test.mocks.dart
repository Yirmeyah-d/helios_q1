// Mocks generated by Mockito 5.1.0 from annotations
// in helios_q1/test/src/features/paginated_list/domain/use_cases/fetch_next_result_page_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:fpdart/fpdart.dart' as _i2;
import 'package:helios_q1/src/core/error/failures.dart' as _i5;
import 'package:helios_q1/src/features/paginated_list/domain/entities/user.dart'
    as _i6;
import 'package:helios_q1/src/features/paginated_list/domain/repositories/paginated_list_repository.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

/// A class which mocks [PaginatedListRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockPaginatedListRepository extends _i1.Mock
    implements _i3.PaginatedListRepository {
  MockPaginatedListRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.User>>> fetchNextResultsPage(
          int? page) =>
      (super.noSuchMethod(Invocation.method(#fetchNextResultsPage, [page]),
          returnValue: Future<_i2.Either<_i5.Failure, List<_i6.User>>>.value(
              _FakeEither_0<_i5.Failure, List<_i6.User>>())) as _i4
          .Future<_i2.Either<_i5.Failure, List<_i6.User>>>);
}