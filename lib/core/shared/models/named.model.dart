import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:equatable/equatable.dart';

class NamedModel extends Equatable with CustomDropdownListFilter {
  final String? name;

  const NamedModel({this.name});

  @override
  String toString() {
    return name!;
  }

  @override
  bool filter(String query) {
    return name!.toLowerCase().contains(query.toLowerCase());
  }

  @override
  List<Object?> get props => [name];

  static List<NamedModel> willayas = [
    const NamedModel(name: 'Adrar'),
    const NamedModel(name: 'Chlef'),
    const NamedModel(name: 'Laghouat'),
    const NamedModel(name: 'Oum El Bouaghi'),
    const NamedModel(name: 'Batna'),
    const NamedModel(name: 'Béjaïa'),
    const NamedModel(name: 'Biskra'),
    const NamedModel(name: 'Béchar'),
    const NamedModel(name: 'Blida'),
    const NamedModel(name: 'Bouira'),
    const NamedModel(name: 'Tamanrasset'),
    const NamedModel(name: 'Tébessa'),
    const NamedModel(name: 'Tlemcen'),
    const NamedModel(name: 'Tiaret'),
    const NamedModel(name: 'Tizi Ouzou'),
    const NamedModel(name: 'Alger'),
    const NamedModel(name: 'Djelfa'),
    const NamedModel(name: 'Jijel'),
    const NamedModel(name: 'Sétif'),
    const NamedModel(name: 'Saïda'),
    const NamedModel(name: 'Skikda'),
    const NamedModel(name: 'Sidi Bel Abbès'),
    const NamedModel(name: 'Annaba'),
    const NamedModel(name: 'Guelma'),
    const NamedModel(name: 'Constantine'),
    const NamedModel(name: 'Médéa'),
    const NamedModel(name: 'Mostaganem'),
    const NamedModel(name: 'M\'Sila'),
    const NamedModel(name: 'Mascara'),
    const NamedModel(name: 'Ouargla'),
    const NamedModel(name: 'Oran'),
    const NamedModel(name: 'El Bayadh'),
    const NamedModel(name: 'Illizi'),
    const NamedModel(name: 'Bordj Bou Arreridj'),
    const NamedModel(name: 'Boumerdès'),
    const NamedModel(name: 'El Tarf'),
    const NamedModel(name: 'Tindouf'),
    const NamedModel(name: 'Tissemsilt'),
    const NamedModel(name: 'El Oued'),
    const NamedModel(name: 'Khenchela'),
    const NamedModel(name: 'Souk Ahras'),
    const NamedModel(name: 'Tipaza'),
    const NamedModel(name: 'Mila'),
    const NamedModel(name: 'Aïn Defla'),
    const NamedModel(name: 'Naâma'),
    const NamedModel(name: 'Aïn Témouchent'),
    const NamedModel(name: 'Ghardaïa'),
  ];
}
