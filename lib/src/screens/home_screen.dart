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
  List<UserModel> suggestionList = [];

  TextEditingController searchDistributorController = TextEditingController();
  FocusNode searchDistributorFocusNode = FocusNode();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    list = await UserService.instance.getCurrentUserLoginDetails();

    print(list.length);
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
                tabUI(),
                tabUI(),
                tabUI(),
                tabUI(),
                tabUI(),
                tabUI(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget searchDistributorFilterTextField() {
    return Container(
      color: Colors.grey,
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: ListTile(
        tileColor: Colors.grey,
        leading: const Icon(Icons.search),
        title: TextFormField(
          focusNode: searchDistributorFocusNode,
          controller: searchDistributorController,
          style: const TextStyle(color: Colors.white),
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
    );
  }

  void _runFilter(String enteredKeyword) async {
    if (enteredKeyword.isEmpty) {
      list;
      setState(() {});
      return;
    }

    var suggestions = list.where(
      (element) {
        var type = element.type.toLowerCase();

        var input = enteredKeyword.toLowerCase();
        return type.contains(input);
        // email.contains(input) ||
        // phone.contains(input);
      },
    ).toList();

    setState(() {
      if (enteredKeyword.isNotEmpty) {
        suggestionList = suggestions;
      }
    });
  }

  Widget tabUI() {
    return Container(
      //  color: Colors.black,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.5,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //     for (UserModel user in list) loginScreenUI(user),
                ],
              ),
            ),
          ),

          // the save button can be implemented if required

          // list.isNotEmpty
          //     ? Container(
          //         padding: EdgeInsets.only(
          //             left: MediaQuery.of(context).size.width / 10,
          //             right: MediaQuery.of(context).size.width / 10),
          //         child: Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: ButtonWidget(text: 'SAVE', onClicked: () {}),
          //         ))
          //     : const SizedBox()
        ],
      ),
    );
  }

  Widget loginScreenUI(UserModel user) {
    return Stack(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 25, bottom: 10, top: 10, right: 25),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
