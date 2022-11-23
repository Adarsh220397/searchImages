import 'package:search_images/src/services/model/user_model.dart';

class UserService {
  UserService._internal();
  static UserService instance = UserService._internal();
  factory UserService() {
    return instance;
  }

  Future<List<UserModel>> getCurrentUserLoginDetails() async {
    List<UserModel> list = [];
    list = [
      UserModel(image: 'assets/imgs/bird1.jpg', type: 'bird'),
      UserModel(image: 'assets/imgs/bird2.jpg', type: 'bird'),
      UserModel(image: 'assets/imgs/bird3.jpg', type: 'bird'),
      UserModel(image: 'assets/imgs/bird5.jpg', type: 'bird'),
      UserModel(image: 'assets/imgs/bird6.jpg', type: 'bird'),
      UserModel(image: 'assets/imgs/mountain1.jpg', type: 'mountain'),
      UserModel(image: 'assets/imgs/mountain2.jpg', type: 'mountain'),
      UserModel(image: 'assets/imgs/mountain3.jpg', type: 'mountain'),
      UserModel(image: 'assets/imgs/mountain4.jpg', type: 'mountain'),
      UserModel(image: 'assets/imgs/mountain5.jpg', type: 'mountain'),
      UserModel(image: 'assets/imgs/mountain6.jpg', type: 'mountain'),
      UserModel(image: 'assets/imgs/animal1.jpg', type: 'animal'),
      UserModel(image: 'assets/imgs/animal2.jpg', type: 'animal'),
      UserModel(image: 'assets/imgs/animal3.jpg', type: 'animal'),
      UserModel(image: 'assets/imgs/animal4.jpg', type: 'animal'),
      UserModel(image: 'assets/imgs/animal5.jpg', type: 'animal'),
      UserModel(image: 'assets/imgs/animal6.jpg', type: 'animal'),
      UserModel(image: 'assets/imgs/food1.jpg', type: 'food'),
      UserModel(image: 'assets/imgs/food2.jpg', type: 'food'),
      UserModel(image: 'assets/imgs/food3.jpg', type: 'food'),
      UserModel(image: 'assets/imgs/food4.jpg', type: 'food'),
      UserModel(image: 'assets/imgs/food5.jpg', type: 'food'),
    ];
    return list;
  }
}
