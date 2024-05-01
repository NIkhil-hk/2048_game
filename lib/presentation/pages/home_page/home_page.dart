import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:game_2048/LeaderBoard.dart';
import 'package:game_2048/Profile.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_2048/domain/entities/game_board_settings.dart';
import 'package:game_2048/presentation/pages/home_page/widgets/translucent_button.dart';
import 'package:game_2048/presentation/pages/game_page/game_page.dart';
// import 'package:game_2048/presentation/pages/home_page/cubit/home_page_cubit.dart';
// import 'package:game_2048/presentation/pages/home_page/cubit/home_page_state.dart';
// import 'package:game_2048/presentation/di/injector.dart';

import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatelessWidget {
  // final HomePageCubit _cubit = i.get<HomePageCubit>();

  HomePage({Key? key}) : super(key: key);

  final Box _boxLogin = Hive.box("login");

  @override
  Widget build(BuildContext context) {
    // return BlocBuilder<HomePageCubit, HomePageState>(
    //     bloc: _cubit,
    //     builder: (context, state) {
    return Scaffold(
      backgroundColor: Color(0xff0045e8),
      body: SingleChildScrollView(child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.15),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xffe2b7f6),
              Color(0xff0045e8),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 100,),
                const Text(
                  "Welcome  ",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Text(
                  _boxLogin.get("userName"),
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            const Text(
              '2048',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10.0),
            // GameModeSelector(
            //   gameModeName: state.boardSize.name,
            //   onLeftArrowTap: state.showLeftArrow
            //       ? _cubit.decreaseGameBoardSize
            //       : null,
            //   onRightArrowTap: state.showRightArrow
            //       ? _cubit.increaseGameBoardSize
            //       : null,
            // ),
            Row(),
            const SizedBox(height: 25.0),
            TranslucentButton(
              text: 'Play 4x4',
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const GamePage(
                      gameBoardSize: GameBoardSettings.classic))),
            ),
            const SizedBox(height: 16.0),
            TranslucentButton(
                text: 'Play 3x3',
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const GamePage(
                        gameBoardSize: GameBoardSettings.tiny)))),
            const SizedBox(height: 16.0),
            TranslucentButton(
              text: 'Profile',
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Profile_page()));
              },
              // onTap: () => _goToAboutPage(context),
            ),
            const SizedBox(height: 16.0),
            TranslucentButton(
              text: 'LeaderBoard',
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LeaderBoard_page()));
             

              },
              // onTap: () => _goToAboutPage(context),
            ),
            SizedBox(height: 100,)
          ],
        ),
      ),
      
      )
    );
  }

  // void _goToGamePage(
  //   BuildContext context,
  //   HomePageState state,
  // ) {
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (context) => GamePage(
  //         gameBoardSize: _cubit.state.boardSize,
  //       ),
  //     ),
  //   );
  // }

  // void _goToAboutPage(BuildContext context) => Navigator.of(context).push(
  //       MaterialPageRoute(
  //         builder: (context) => const AboutPage(),
  //       ),
  //     );
}
