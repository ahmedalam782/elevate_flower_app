// TODO: api Address_detailsLocalDataSourceImpl
import 'package:elevate_flower_app/core/helper/json_parser/asset_json_parser.dart';
import 'package:elevate_flower_app/core/utils/constants/app_strings.dart';
import 'package:elevate_flower_app/features/address_details/data/datasources/address_details_local_data_source_contract.dart';
import 'package:elevate_flower_app/features/address_details/data/models/cities_model.dart';
import 'package:elevate_flower_app/features/address_details/data/models/states_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AddressDetailsLocalDataSourceContract)
class AddressDetailsLocalDataSourceImpl
    implements AddressDetailsLocalDataSourceContract {
  final AssetJasonparser parser;

  AddressDetailsLocalDataSourceImpl({required this.parser});

  @override
  Future<List<StatesModel>> getAllStates() async {
    List<StatesModel> data = [];
    final decodedData = await parser.parseTableData(
      assetPath: AppStrings.statesJsonPath,
    );

    for (var item in decodedData[2]["data"]) {
      data.add(StatesModel.fromJson(item));
    }

    return data;
  }

  @override
  Future<List<CityModel>> getAllCitites() async {
    List<CityModel> data = [];
    final decodedData = await parser.parseTableData(
      assetPath: AppStrings.cititesJsonpath,
    );

    for (var item in decodedData[2]["data"]) {
      data.add(CityModel.fromJson(item));
    }

    return data;
  }
}
