import 'package:drmohan/models/model_spotlightitem.dart';

class Dashboarditem {
  final List<SpotLightitem> spotLights;
  //final List<String> notifies;

  Dashboarditem({required this.spotLights});

  factory Dashboarditem.fromJson(Map<String, dynamic> json) {
    return Dashboarditem(spotLights: json['spotLights'] as List<SpotLightitem>);
  }
}
