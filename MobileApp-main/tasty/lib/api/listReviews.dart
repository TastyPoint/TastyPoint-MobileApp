import 'Review.dart';

class listadoR {
  static List<Review> listaReviews(List<dynamic> listaJson) {
    List<Review> listadoReview = [];

    if (listaJson != null) {
      for (var u in listaJson) {
        final usu = Review.objJson(u);
        listadoReview.add(usu);
      }
    }
    return listadoReview;
  }
}
