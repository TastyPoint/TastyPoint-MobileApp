import 'UserProfile.dart';

class listadoU {
  static List<UserProfile> listaUsers(List<dynamic> listaJson) {
    List<UserProfile> listadoUser = [];

    if (listaJson != null) {
      for (var u in listaJson) {
        final usu = UserProfile.objJson(u);
        listadoUser.add(usu);
      }
    }
    return listadoUser;
  }
}
