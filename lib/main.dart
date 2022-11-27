import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/status.dart';
import 'package:news_app/layout/news_app/news_layout.dart';
import 'package:news_app/shared/network/local/cach_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';
import 'package:news_app/shared/styles/bloc_observer.dart';
import 'package:news_app/shared/styles/const.dart';

void main()async {
   WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
await  CachHelper.init();
bool? isDark=CachHelper.getBoolean(key: 'isDark');

 
  runApp( MyApp(isDark: isDark,));
}

class MyApp extends StatelessWidget {
   bool? isDark;
  MyApp({Key? key,  this.isDark}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [BlocProvider(create: (context) => NewsCubit()..getBusiness()..getSports()..getScience()
        ..ChingDarkMode(fromSheard: isDark)),
        ],
        child: BlocConsumer<NewsCubit, NewsState>(
            listener: (context, state) {},
            builder: (context, state) {
              return MaterialApp(
                theme: themLight(),
                darkTheme: themDark(),
                debugShowCheckedModeBanner: false,
               themeMode:NewsCubit.get( context).isDark?ThemeMode.dark:ThemeMode.light,
                home: NewsLayout(key: key),
              );
            }));
  }
}
