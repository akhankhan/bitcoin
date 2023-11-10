import 'package:bitcoinapp/screens/cards_screen/cards_screen.dart';
import 'package:bitcoinapp/screens/dashboard/dashboard_provider.dart';
import 'package:bitcoinapp/screens/earn_screen/earn_screen.dart';
import 'package:bitcoinapp/screens/historyscreen/historyscreen.dart';
import 'package:bitcoinapp/screens/homescreen/homescreen.dart';
import 'package:bitcoinapp/screens/profile_screen/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  @override
  final myValue;
  const Dashboard({super.key, this.myValue});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  ///
  ///  Exit App PopUp Show Dialog =====================>>>
  ///
  Future<bool> showExitPopup(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Exit App'),
            content: const Text('Do you want to exit an App?'),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No',
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                onPressed: () {
                  SystemNavigator.pop();
                },
                child: const Text('Yes',
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ),
            ],
          ),
        ) ??
        false;
  }

  int _currentIndex = 0;

  final pages = [
    const HomeScreen(),
    HistoryScreen(),
    const CardsScreen(),
    const EarnScreen(),
    const PRofileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: WillPopScope(
          onWillPop: () async {
            return await showExitPopup(context);
          },
          child: pages[_currentIndex]),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 0.1,
        clipBehavior: Clip.antiAlias,
        child: ChangeNotifierProvider(
          create: (context) => DashBoardProvider(),
          child: Consumer<DashBoardProvider>(builder: (context, value, child) {
            return SizedBox(
                height: kBottomNavigationBarHeight,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(
                        color: Colors.grey,
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BottomNavigationItems(
                        icon: _currentIndex == 0
                            ? 'assets/icons/HomeActive.png'
                            : 'assets/icons/Homeicon.png',
                        onPressed: () {
                          setState(() {
                            _currentIndex = 0;
                          });
                        },
                      ),
                      BottomNavigationItems(
                        icon: _currentIndex == 1
                            ? 'assets/icons/historique-icone-de-l-historique-violet.png'
                            : 'assets/icons/history.png',
                        onPressed: () {
                          setState(() {
                            _currentIndex = 1;
                          });
                        },
                      ),
                      BottomNavigationItems(
                        icon: _currentIndex == 2
                            ? 'assets/images/images.png'
                            : 'assets/images/credit-card-2-icon-7.png',
                        onPressed: () {
                          setState(() {
                            _currentIndex = 2;
                          });
                        },
                      ),
                      BottomNavigationItems(
                        icon: _currentIndex == 3
                            ? 'assets/images/Unknown1.png'
                            : 'assets/images/Unknown.png',
                        onPressed: () {
                          setState(() {
                            _currentIndex = 3;
                          });
                        },
                      ),
                      BottomNavigationItems(
                        icon: _currentIndex == 4
                            ? 'assets/icons/ProfileActive.png'
                            : 'assets/icons/Profileicon.png',
                        onPressed: () {
                          setState(() {
                            _currentIndex = 4;
                          });
                        },
                      ),
                    ],
                  ),
                ));
          }),
        ),
      ),
    );
  }
}

class BottomNavigationItems extends StatelessWidget {
  final icon;
  final onPressed;
  //final getColor;

  const BottomNavigationItems({
    super.key,
    this.icon,
    this.onPressed,
    //this.getColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            icon,
            //color: getColor,
            height: 40,
          ),
        ],
      ),
    );
  }
}
