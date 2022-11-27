import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/status.dart';
import 'package:news_app/modules/search/search_screen.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('News App'),
            actions: [
              IconButton(onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder:(context) =>SearchScreen() ));
              }, icon: const Icon(Icons.search)),
              const SizedBox(
                width: 5,
              ),
              IconButton(
                  onPressed: () {
                    NewsCubit.get( context).ChingDarkMode();
                  },
                  icon: const Icon(Icons.brightness_4_outlined))
            ],
          ),
          body: cubit.screens[cubit.curintIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.item,
            onTap: (index) {
              cubit.chingBottom(index);
            },
            currentIndex: cubit.curintIndex,
          ),
        );
      },
    );
  }
}
