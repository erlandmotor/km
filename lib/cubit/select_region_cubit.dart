import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'select_region_state.dart';

class SelectRegionCubit extends Cubit<SelectRegionState> {
  SelectRegionCubit() : super(SelectRegionInitial());
  
  var provinceId = 0;
  var cityId = 0;
  var districtsId = 0;

  void updateProvinceState(int provinceIdState) {
    provinceId = provinceIdState;
    cityId = 0;
    districtsId = 0;
  }

  void updateCitiesState(int cityIdState) {
    cityId = cityIdState;
    districtsId = 0;
  }

  void updateDistrictState(int districtIdState) {
    districtsId = districtIdState;
  }
}
