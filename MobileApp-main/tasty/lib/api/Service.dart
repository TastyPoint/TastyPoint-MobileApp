import 'dart:convert';
import 'package:tasty/api/Promotion.dart';
import 'package:tasty/api/listFoodStores.dart';
import 'package:tasty/api/listPromotions.dart';
import 'package:tasty/api/listReviews.dart';
import 'package:tasty/api/Review.dart';

import 'package:tasty/api/listUsers.dart';
import 'package:http/http.dart' as http;
import 'FoodStore.dart';
import 'UserProfile.dart';


class service{

  static Future<List<FoodStore>> getFoodStores() async{
    final rspta=await http.get(Uri.parse("https://tastypointapi.azurewebsites.net/api/v1/foodstores"));

    if(rspta.statusCode==200){
      final rsptaJson=json.decode(rspta.body);
      final todosFoodStores=listado.listaFoodStores(rsptaJson);
      return todosFoodStores;
    }
    return <FoodStore>[];
  }

  static Future<List<Promotion>> getPromotions() async {
    final rspta = await http.get(Uri.parse("https://tastypointapi.azurewebsites.net/api/v1/promotion"));

    if (rspta.statusCode == 200) {
      final rsptaJson = json.decode(rspta.body);
      final todosPromotions = listadoP.listaPromotions(rsptaJson);
      return todosPromotions;
    }
    return <Promotion>[];
  }

  static Future<List<Review>> getReviews() async {
    final rspta = await http.get(Uri.parse("https://tastypointapi.azurewebsites.net/api/v1/comments"));

    if (rspta.statusCode == 200) {
      final rsptaJson = json.decode(rspta.body);
      final todosReviews = listadoR.listaReviews(rsptaJson);
      return todosReviews;
    }
    return <Review>[];
  }

  static Future<UserProfile?> getUserProfileByCredentials(String phoneNumber, String type) async {
    final response = await http.get(Uri.parse('https://tastypointapi.azurewebsites.net/api/v1/userprofile'));

    if (response.statusCode == 200) {
      final userProfileList = json.decode(response.body) as List<dynamic>;
      final userList = listadoU.listaUsers(userProfileList);

      for (var userProfile in userList) {
        if (userProfile.phoneNumber == phoneNumber && userProfile.type == type) {
          return userProfile;
        }
      }
    }
    return null;
  }

  static Future<List<Promotion>> getUserPromotions(int userId) async {
    final url = Uri.parse('https://tastypointapi.azurewebsites.net/api/v1/userprofile/$userId/promotions');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      final promotions = listadoP.listaPromotions(responseJson);
      return promotions;
    } else {
      throw Exception('Failed to get user promotions');
    }
  }

  static Future<Promotion> createPromotion(Promotion promotion) async {
    final url = Uri.parse('https://tastypointapi.azurewebsites.net/api/v1/promotion');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode(promotion.toJson());

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 201) {
      final responseJson = json.decode(response.body);
      final createdPromotion = Promotion.fromJson(responseJson);
      return createdPromotion;
    } else {
      throw Exception('Failed to create promotion');
    }
  }

  static Future<void> deletePromotion(int promotionId) async {
    final url = Uri.parse('https://tastypointapi.azurewebsites.net/api/v1/promotion/$promotionId');
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      print('Promotion deleted successfully');
    } else {
      throw Exception('Failed to delete promotion');
    }
  }

  static Future<void> editPromotion(Promotion promotion) async {
    final url = Uri.parse('https://tastypointapi.azurewebsites.net/api/v1/promotion/${promotion.id}');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode(promotion.toJson());

    final response = await http.put(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      print('Promotion edited successfully');
    } else {
      throw Exception('Failed to edit promotion');
    }
  }

  static Future<List<Promotion>> getFoodStorePromotions(int foodStoreId) async {
    final url = Uri.parse('https://tastypointapi.azurewebsites.net/api/v1/userprofile/$foodStoreId/promotions');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      final promotions = data.map((item) => Promotion.fromJson(item)).toList();
      return promotions;
    } else {
      throw Exception('Failed to load promotions');
    }
  }
  static Future<Promotion> getPromotion(int id) async {
    final url = Uri.parse('https://tastypointapi.azurewebsites.net/api/v1/promotion/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      final promotion = Promotion.fromJson(responseJson);
      return promotion;
    } else {
      throw Exception('Failed to get promotion');
    }
  }
  static Future<void> reducePromotionQuantity(int promotionId, int quantityToReduce) async {
    final promotion = await getPromotion(promotionId);
    promotion.quantity -= quantityToReduce;
    await editPromotion(promotion);
  }

  static Future<int> getPromotionQuantity(int promotionId) async {
    final promotion = await getPromotion(promotionId);
    return promotion.quantity;
  }

  static Future<UserProfile?> getUserProfileById(int id) async {
    final url = Uri.parse('https://tastypointapi.azurewebsites.net/api/v1/userprofile/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      final userProfile = UserProfile.fromJson(responseJson);
      return userProfile;
    } else {
      throw Exception('Failed to get user profile');
    }
  }

  static Future<UserProfile> createUserProfile(UserProfile userProfile) async {
    final url = Uri.parse('https://tastypointapi.azurewebsites.net/api/v1/userprofile');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode(userProfile.toJson());

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 201) {
      final responseJson = json.decode(response.body);
      final createdUserProfile = UserProfile.fromJson(responseJson);
      return createdUserProfile;
    } else {
      throw Exception('Failed to create user profile');
    }
  }


}