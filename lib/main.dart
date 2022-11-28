
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc_observer.dart';
import 'package:news_app/layout/news_layout.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';
import 'package:news_app/shared/styles/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 
  Bloc.observer=MyBlocObserver();
     
      DioHelper.init();
      await CacheHelper.init();
      bool deffoultMode = false;
      late bool? isDark = CacheHelper.getBool(key: 'isDark');
      runApp(MyApp(isDark ?? deffoultMode));
    
    

}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  late bool isDark;
  MyApp(this.isDark, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => NewsCubit()
            ..getBusiness()
            ..changeThemMode(fromShared: isDark),
        ),
      ],
      child: BlocConsumer<NewsCubit, NewsStates>(
          listener: (BuildContext context, state) {},
          builder: (BuildContext context, Object? state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme:themLight(),
              darkTheme:themDark(), 
              themeMode: NewsCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              home:  const NewsLayout(),
            );
          }),
    );
  }
}
