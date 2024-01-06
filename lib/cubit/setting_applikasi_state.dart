part of 'setting_applikasi_cubit.dart';

sealed class SettingApplikasiState extends Equatable {
  const SettingApplikasiState({ required this.settingData });

  final SettingApplikasiResponse settingData;

  @override
  List<Object> get props => [
    settingData
  ];
}

final class SettingApplikasiInitial extends SettingApplikasiState {

  final SettingApplikasiResponse settingDataState;

  const SettingApplikasiInitial({ required this.settingDataState }) : super(settingData: settingDataState);
}
