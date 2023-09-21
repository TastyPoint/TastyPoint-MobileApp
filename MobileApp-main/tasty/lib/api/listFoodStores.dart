import 'FoodStore.dart';

class listado{
  static List<FoodStore> listaFoodStores(List<dynamic> listaJson){
    List<FoodStore> listadoFoodStore=[];

    if(listaJson!=null){
      for(var u in listaJson){
        final usu=FoodStore.objJson(u);
        listadoFoodStore.add(usu);
      }
    }
    return listadoFoodStore;
  }
}