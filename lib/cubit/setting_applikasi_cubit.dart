import 'package:adamulti_mobile_clone_new/model/setting_applikasi_response.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'setting_applikasi_state.dart';

class SettingApplikasiCubit extends Cubit<SettingApplikasiState> {
  SettingApplikasiCubit() : super(SettingApplikasiInitial(settingDataState: SettingApplikasiResponse()));

  void updateState(SettingApplikasiResponse data) {
    emit(SettingApplikasiInitial(settingDataState: data));
  } 
}
