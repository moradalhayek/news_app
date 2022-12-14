// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/business/business_ssscreen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialStates());

  static NewsCubit get(context) => BlocProvider.of(context);
  List<String> titles = [
    "Business",
    "Sports",
    "Scince",
  ];
  List<Widget> screens = [
    const BusinessScreen(),
    const SportsScreen(),
    const ScinceScreen(),
  ];
  int currentIndex = 0;
  void changeBottomNavigationBarItems(int index) {
    currentIndex = index;
    if (index == 1) getSports();
    if (index == 2) getScinence();
    emit(ChangeBottomNavigationBarItems());
  }

  List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.business_outlined),
      label: "Business",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: "Sports",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.science_outlined),
      label: "Scinence",
    ),
  ];

  List<dynamic> business = [];
  int selectbusinessItem = 0;

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      qury: {
        'country': 'eg',
        'category': 'business',
        'apikey': 'c7cfbee96c2f47d2a7b758fa87def9d4',
      },
    ).then((value) {
      business = value.data['articles'];

      emit(NewsGetBusinessSuccsessState());
    }).catchError((erorr) {
      // ignore: avoid_print
      print(erorr.toString());
      emit(NewsGetBusinessErorrState(erorr));
    });
  }

  void selectBusinessItem(index) {
    selectbusinessItem = index;
    emit(NewsselectbusinessItemState());
  }

  bool isDesktop = false;
  void setDesktop(bool value) {
    isDesktop = value;
    emit(NewsSetDesktopState());
  }

  List<dynamic> sports = [];
  getSports() {
    emit(NewsGetSportsLoadingState());

    {
      DioHelper.getData(
        url: 'v2/top-headlines',
        qury: {
          'country': 'eg',
          'category': 'sport',
          'apikey': 'c7cfbee96c2f47d2a7b758fa87def9d4',
        },
      ).then((value) {
        sports = value.data['articles'];

        // ignore: avoid_print
        print(value.data['totalResults']);
        emit(NewsGetSportsSuccsessState());
      }).catchError((erorr) {
        emit(NewsGetSportsErorrState(erorr));
      });
    }
  }

  List<dynamic> Scinence = [];
  void getScinence() {
    emit(NewsGetScinenceLoadingState());
    {
      DioHelper.getData(
        url: 'v2/top-headlines',
        qury: {
          'country': 'eg',
          'category': 'Science',
          'apikey': 'c7cfbee96c2f47d2a7b758fa87def9d4',
        },
      ).then((value) {
        Scinence = value.data['articles'];

        emit(NewsGetScinenceSuccsessState());
      }).catchError((erorr) {
        // ignore: avoid_print
        print(erorr.toString());
        emit(NewsGetScinenceErorrState(erorr));
      });
    }
  }

  List<dynamic> search = [];
  var totalResults = 0;
  var searchValue;
  void getSearch({required var value}) {
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(
      url: 'v2/everything',
      qury: {
        'q': '$value',
        'apikey': 'c7cfbee96c2f47d2a7b758fa87def9d4',
      },
    ).then((value) {
      search = value.data['articles'];
      searchValue = value;

      totalResults = value.data['totalResults'];

      emit(NewsGetSearchSuccsessState());
    }).catchError((erorr) {
      print(erorr.toString());
      emit(NewsGetSearchErorrState(erorr));
    });
  }

  bool isDark = false;
  void changeThemMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(NewsThemModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBool(key: 'isDark', value: isDark).then((value) {
        emit(NewsThemModeState());
      });
    }
  }
}
