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
      UserModel(image: 'assets/imgs/bird1.png', type: 'bird'),
      UserModel(image: 'assets/imgs/bird2.png', type: 'bird'),
      UserModel(image: 'assets/imgs/bird3.png', type: 'bird'),
      UserModel(image: 'assets/imgs/bird5.jpg', type: 'bird'),
      UserModel(image: 'assets/imgs/bird6.jpg', type: 'bird'),
      UserModel(image: 'assets/imgs/mountain1.png', type: 'mountain'),
      UserModel(image: 'assets/imgs/mountain2.png', type: 'mountain'),
      UserModel(image: 'assets/imgs/mountain3.png', type: 'mountain'),
      UserModel(image: 'assets/imgs/mountain4.png', type: 'mountain'),
      UserModel(image: 'assets/imgs/mountain5.png', type: 'mountain'),
      UserModel(image: 'assets/imgs/mountain6.png', type: 'mountain'),
      UserModel(image: 'assets/imgs/animal1.png', type: 'animal'),
      UserModel(image: 'assets/imgs/animal2.png', type: 'animal'),
      UserModel(image: 'assets/imgs/animal3.png', type: 'animal'),
      UserModel(image: 'assets/imgs/animal4.png', type: 'animal'),
      UserModel(image: 'assets/imgs/animal5.png', type: 'animal'),
      UserModel(image: 'assets/imgs/animal6.png', type: 'animal'),
      UserModel(image: 'assets/imgs/food1.jpg', type: 'food'),
      UserModel(image: 'assets/imgs/food2.jpg', type: 'food'),
      UserModel(image: 'assets/imgs/food3.jpg', type: 'food'),
      UserModel(image: 'assets/imgs/food4.jpg', type: 'food'),
      UserModel(image: 'assets/imgs/food5.jpg', type: 'food'),
    ];
    return list;
  }
}
