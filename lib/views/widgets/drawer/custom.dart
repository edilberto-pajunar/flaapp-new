import 'package:flaapp/services/functions/nav.dart';
import 'package:flaapp/services/networks/providers/user.dart';
import 'package:flaapp/values/strings/images.dart';
import 'package:flaapp/values/theme/colors.dart';
import 'package:flaapp/views/screens/mobile/flashcard/level_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final NavigationServices nav = NavigationServices();

    final TextStyle style = TextStyle(
      fontSize: 22,
      color: ColorTheme.tBlueColor,
      fontWeight: FontWeight.w600,
    );

    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: ColorTheme.tBlueColor,
              ),
              child: Center(
                child: Text(
                  "FLAAPP",
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: Colors.white,
                    fontSize: 34.0,
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text(
                "Levels",
                style: style,
              ),
              leading: Image.asset(PngImage.levels),
              trailing: IconButton(
                icon: const Icon(Icons.keyboard_arrow_right),
                onPressed: () {
                  // nav.pushScreen(context, screen: const LevelsScreen());

                },
              ),
            ),
            ListTile(
              title: Text(
                "Instructions",
                style: style,
              ),
              leading: Image.asset(PngImage.instructions),
              trailing: IconButton(
                icon: const Icon(
                  Icons.keyboard_arrow_right,
                ),
                onPressed: () {},
              ),
            ),
            ListTile(
              title: Text(
                "Account",
                style: style,
              ),
              leading: Image.asset(PngImage.account),
              trailing: IconButton(
                icon: const Icon(Icons.keyboard_arrow_right),
                onPressed: () {
                    // context.push(ProfileScreen.route, extra: {
                    //   "profile": profile,
                    // },
                  // );
                },
              ),
            ),
            ListTile(
              title: Text(
                "Change Language",
                style: style.copyWith(
                  fontSize: 18.0,
                ),
              ),
              leading: Image.asset(PngImage.levels),
              trailing: IconButton(
                icon: const Icon(Icons.keyboard_arrow_right),
                onPressed: () {
                  // context.push(SelectLanguageScreen.route);
                },
              ),
            ),
            /// TODO: REMOVE ONCE PROD ---> CLEARING OF DATA
            // ListTile(
            //   title: Text(
            //     "Remove Data",
            //     style: style,
            //   ),
            //   leading: Image.asset(PngImage.instructions),
            //   trailing: IconButton(
            //     icon: const Icon(
            //       Icons.keyboard_arrow_right,
            //     ),
            //     onPressed: () {
            //       userProvider.deleteAllUser();
            //       context.go(LoginScreen.route);
            //     },
            //   ),
            // ),
            const SizedBox(height: 100.0),
            ListTile(
              title: Text(
                "Log Out",
                style: style,
              ),
              leading: Image.asset(PngImage.logout),
              trailing: IconButton(
                icon: const Icon(Icons.keyboard_arrow_right),
                onPressed: () {
                  // userProvider.logout();
                  // context.go(LoginScreen.route);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
