import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_chef/models/models.dart';
import 'package:the_chef/models/profile_manager.dart';

import 'package:the_chef/navigation/app_router.dart';

import 'fooderlich_theme.dart';

void main() {
  runApp(const Fooderlich());
}

class Fooderlich extends StatefulWidget {
  const Fooderlich({Key? key}) : super(key: key);

  @override
  State<Fooderlich> createState() => _FooderlichState();
}

class _FooderlichState extends State<Fooderlich> {
  final _groceryManager = GroceryManager();
  final _profileManager = ProfileManager();
  final _appStateManager = AppStateManager();
  late AppRouter _appRouter;

  @override
  void initState() {
    _appRouter = AppRouter(
      appStateManager: _appStateManager,
      groceryManager: _groceryManager,
      profileManager: _profileManager,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => _groceryManager),
        ChangeNotifierProvider(create: (context) => _appStateManager),
        ChangeNotifierProvider(create: (context) => _profileManager),
      ],
      child: Consumer<ProfileManager>(
        builder: (context, profileManager, chil) {
          ThemeData theme;
          if (profileManager.darkMode) {
            theme = FooderlichTheme.dark();
          } else {
            theme = FooderlichTheme.light();
          }
          return MaterialApp(
            theme: theme,
            title: 'Fooderlich',
            home: Router(
              routerDelegate: _appRouter,
              backButtonDispatcher: RootBackButtonDispatcher(),
            ),
          );
        },
      ),
    );
  }
}

// class RecipeApp extends StatelessWidget {
//   const RecipeApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final ThemeData theme = ThemeData();

//     return MaterialApp(
//       title: 'Recipe Calculator',
//       theme: theme.copyWith(
//           colorScheme: theme.colorScheme.copyWith(
//         primary: Colors.grey,
//         secondary: Colors.black,
//       )),
//       home: const MyHomePage(title: 'Recipe Calculator'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: SafeArea(
//         child: ListView.builder(
//             itemCount: Recipe.samples.length,
//             itemBuilder: (BuildContext context, int index) {
//               return GestureDetector(
//                   onTap: () {
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (context) {
//                       return RecipeDetail(
//                         recipe: Recipe.samples[index],
//                       );
//                     }));
//                   },
//                   child: buildRecipeCard(Recipe.samples[index]));
//             }),
//       ),
//     );
//   }

//   Widget buildRecipeCard(Recipe recipe) {
//     return Card(
//       elevation: 2.0,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: <Widget>[
//             Image(image: AssetImage(recipe.imageUrl)),
//             const SizedBox(
//               height: 14.0,
//             ),
//             Text(
//               recipe.label,
//               style: const TextStyle(
//                 fontSize: 20.0,
//                 fontWeight: FontWeight.w700,
//                 fontFamily: 'Palatino',
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }