import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/features/user_addresses/domain/entities/user_address_entity.dart';
import 'package:elevate_flower_app/features/user_addresses/domain/use_cases/delete_user_address_usecase.dart';
import 'package:elevate_flower_app/features/user_addresses/domain/use_cases/get_all_addresses_usecase.dart';
import 'package:elevate_flower_app/features/user_addresses/presentation/view_model/cubit/user_addresses_cubit.dart';
import 'package:elevate_flower_app/features/user_addresses/presentation/view_model/cubit/user_addresses_events.dart';
import 'package:elevate_flower_app/features/user_addresses/presentation/view_model/cubit/user_addresses_states.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_addresses_cubit_test.mocks.dart';

@GenerateMocks([GetAllAddressesUsecase, DeleteUserAddressUsecase])
void main() {
  late UserAddressesCubit cubit;
  late MockGetAllAddressesUsecase getAllAddressesUsecase;
  late MockDeleteUserAddressUsecase deleteUserAddressUsecase;

  final address1 = UserAddressEntity(id: '1');
  final address2 = UserAddressEntity(id: '2');

  setUp(() {
    getAllAddressesUsecase = MockGetAllAddressesUsecase();
    deleteUserAddressUsecase = MockDeleteUserAddressUsecase();

    cubit = UserAddressesCubit(
      getAllAddressesUsecase,
      deleteUserAddressUsecase,
    );
  });

  tearDown(() {
    cubit.close();
  });

  group("UserAddressesCubit", () {
    test("initial state is correct", () {
      expect(cubit.state, isA<UserAddressesStates>());
    });

    group("getAllAddresses tests", () {
      test("emits loading then success", () async {
        provideDummy<Result<List<UserAddressEntity>>>(
          Success(data: [address1, address2]),
        );

        when(
          getAllAddressesUsecase.call(),
        ).thenAnswer((_) async => Success(data: [address1, address2]));

        final statesStream = cubit.stream
            .map((state) => state.getUserAddressesState)
            .take(2)
            .toList();

        cubit.doIntent(UserAddressesEvent.getAllAddresses());

        final states = await statesStream;

        expect(states[0].state, StateType.loading);
        expect(states[1].state, StateType.success);
        expect(states[1].data, [address1, address2]);
      });

      test("emits loading then error", () async {
        final exception = Exception("Fetch failed");

        provideDummy<Result<List<UserAddressEntity>>>(
          Error(exception: exception),
        );

        when(
          getAllAddressesUsecase.call(),
        ).thenAnswer((_) async => Error(exception: exception));

        final statesStream = cubit.stream
            .map((state) => state.getUserAddressesState)
            .take(2)
            .toList();

        cubit.doIntent(UserAddressesEvent.getAllAddresses());

        final states = await statesStream;

        expect(states[0].state, StateType.loading);
        expect(states[1].state, StateType.error);
        expect(states[1].exception, exception);
      });
    });

    group("deleteAddress tests", () {
      test("removes address locally and emits success", () async {
        // prepare initial state
        cubit.emit(
          cubit.state.copyWith(
            getUserAddressesState: BaseState.success([address1, address2]),
          ),
        );

        provideDummy<Result<List<UserAddressEntity>>>(
          Success(data: [address2]),
        );

        when(
          deleteUserAddressUsecase.call('1'),
        ).thenAnswer((_) async => Success(data: [address2]));

        final statesStream = cubit.stream
            .map((state) => state.getUserAddressesState)
            .take(1)
            .toList();

        cubit.doIntent(UserAddressesEvent.deleteAddress('1'));

        final states = await statesStream;

        expect(states[0].state, StateType.success);
        expect(states[0].data, [address2]);
      });

      test("emits error when delete fails", () async {
        cubit.emit(
          cubit.state.copyWith(
            getUserAddressesState: BaseState.success([address1, address2]),
          ),
        );

        final exception = Exception("Delete failed");

        provideDummy<Result<List<UserAddressEntity>>>(
          Error(exception: exception),
        );

        when(
          deleteUserAddressUsecase.call('1'),
        ).thenAnswer((_) async => Error(exception: exception));

        final statesStream = cubit.stream
            .map((state) => state.getUserAddressesState)
            .take(1)
            .toList();

        cubit.doIntent(UserAddressesEvent.deleteAddress('1'));

        final states = await statesStream;

        expect(states[0].state, StateType.error);
        expect(states[0].exception, exception);
      });
    });
  });
}
