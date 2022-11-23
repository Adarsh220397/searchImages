import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:search_images/src/services/model/user_model.dart';
import 'package:search_images/src/services/user/user.dart';

class LoginDetails extends StatefulWidget {
  const LoginDetails({super.key});

  @override
  State<LoginDetails> createState() => _LoginDetailsState();
}

class _LoginDetailsState extends State<LoginDetails> {
  late ThemeData themeData;
  bool isLoading = false;
  List<UserModel> list = [];
  List<UserModel> totalList = [];
  List<UserModel> mountainList = [];
  List<UserModel> birdList = [];
  List<UserModel> animalsList = [];
  List<UserModel> foodList = [];
  List<UserModel> suggestionList = [];

  List<String> tabList = [
    'All',
    'Mountains',
    'Birds',
    'Animals',
    'Foods',
    'Other',
  ];
  TextEditingController searchDistributorController = TextEditingController();
  FocusNode searchDistributorFocusNode = FocusNode();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    // suggestionList.clear();
    for (String tab in tabList) {
      if (tab == 'All') {
        totalList = await UserService.instance.getCurrentUserLoginDetails();
        suggestionList = totalList;
      } else if (tab == 'Mountains') {
        totalList = await UserService.instance.getCurrentUserLoginDetails();
        mountainList = totalList;
        mountainList.removeWhere(
          (element) => element.type != 'mountain',
        );
        suggestionList = mountainList;
      } else if (tab == 'Birds') {
        totalList = await UserService.instance.getCurrentUserLoginDetails();
        birdList = totalList;
        birdList.removeWhere(
          (element) => element.type != 'bird',
        );
        suggestionList = birdList;
      } else if (tab == 'Animals') {
        totalList = await UserService.instance.getCurrentUserLoginDetails();
        animalsList = totalList;
        animalsList.removeWhere(
          (element) => element.type != 'animal',
        );
        suggestionList = animalsList;
      } else if (tab == 'Food') {
        totalList = await UserService.instance.getCurrentUserLoginDetails();
        foodList = totalList;
        foodList.removeWhere(
          (element) => element.type != 'food',
        );
        suggestionList = foodList;
      } else {
        totalList = await UserService.instance.getCurrentUserLoginDetails();
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);

    return DefaultTabController(
      length: 6,
      child: Scaffold(
          key: _scaffoldKey,
          body: SafeArea(
            child: KeyboardDismissOnTap(child: loginDetailsScreenBodyUI()),
          )),
    );
  }

  Widget loginDetailsScreenBodyUI() {
    return Stack(
      children: <Widget>[
        Positioned(
            top: MediaQuery.of(context).size.height / 10,
            // left: 90,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: tabBarUI()),
        //  Positioned(top: 70, left: 60, child: welcomeText()),
      ],
    );
  }

  Widget tabBarUI() {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            //  color: Colors.black,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: Column(
            children: [
              searchDistributorFilterTextField(),
              TabBar(
                labelColor: Colors.black,
                indicatorColor: Colors.blue,
                unselectedLabelColor: Colors.black,
                indicatorSize: TabBarIndicatorSize.tab,
                labelStyle: themeData.textTheme.titleMedium,
                unselectedLabelStyle: themeData.textTheme.titleSmall!
                    .copyWith(color: Colors.grey),
                isScrollable: true,
                onTap: (int i) {
                  print(i);
                  fetchData();
                },
                tabs: const [
                  Tab(
                    text: 'All',
                  ),
                  Tab(
                    text: 'Mountains',
                  ),
                  Tab(
                    text: 'Birds',
                  ),
                  Tab(
                    text: 'Animals',
                  ),
                  Tab(
                    text: 'Foods',
                  ),
                  Tab(
                    text: 'Other',
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TabBarView(
              children: <Widget>[
                tabUI(totalList),
                tabUI(mountainList),
                tabUI(birdList),
                tabUI(animalsList),
                tabUI(foodList),
                tabUI(list),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget searchDistributorFilterTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        child: ListTile(
          tileColor: Colors.grey,
          trailing: const Icon(Icons.search),
          iconColor: Colors.black,
          title: TextFormField(
            focusNode: searchDistributorFocusNode,
            controller: searchDistributorController,
            style: const TextStyle(color: Colors.black),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.search,
            decoration: const InputDecoration(
              filled: false,
              isDense: true,
              border: InputBorder.none,
              disabledBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              hintText: "Enter Keyword..",
            ),
            onChanged: (value) => {_runFilter(value)},
          ),
        ),
      ),
    );
  }

  void _runFilter(String enteredKeyword) async {
    if (enteredKeyword.isEmpty) {
      totalList;
      setState(() {});
      return;
    }

    var suggestions = totalList.where(
      (element) {
        var type = element.type.toLowerCase();
        print(element.type);
        var input = enteredKeyword.toLowerCase();
        print(enteredKeyword);
        return type.contains(input);
      },
    ).toList();

    setState(() {
      if (enteredKeyword.isNotEmpty) {
        suggestionList = suggestions;
      } else {
        fetchData();
      }
    });
  }

  Widget tabUI(List<UserModel> list) {
    return list.isEmpty
        ? CircularProgressIndicator()
        : SingleChildScrollView(
            //  color: Colors.black,
            child: Column(
              children: [
                SizedBox(
                  // height: MediaQuery.of(context).size.height / 1.5,
                  child: Wrap(
                    //direction: ,
                    children: [
                      for (UserModel user in list) loginScreenUI(user),
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  Widget loginScreenUI(UserModel user) {
    return Container(
        height: MediaQuery.of(context).size.height / 5,
        width: MediaQuery.of(context).size.width / 3,
        child: Image.asset(user.image));
  }
}
