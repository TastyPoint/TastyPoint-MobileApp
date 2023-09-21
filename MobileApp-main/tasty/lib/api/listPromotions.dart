import 'Promotion.dart';

class listadoP {
  static List<Promotion> listaPromotions(List<dynamic> listaJson) {
    List<Promotion> listadoPromotion = [];

    if (listaJson != null) {
      for (var u in listaJson) {
        final usu = Promotion.fromJson(u);
        listadoPromotion.add(usu);
      }
    }
    return listadoPromotion;
  }
}
