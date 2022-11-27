// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/status.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/sports/sports-screen.dart';
import 'package:news_app/shared/network/local/cach_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(InatailState());
  static NewsCubit get(context) => BlocProvider.of(context);
  int curintIndex = 0;
  void chingBottom(int index) {
    curintIndex = index;
    emit(ChingBotomNav());
  }

  List<BottomNavigationBarItem> item = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.business), label: 'business'),
    const BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'sports'),
    const BottomNavigationBarItem(icon: Icon(Icons.science), label: 'science')
  ];
  List<Widget> screens = [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen()
  ];
  List<dynamic> business = [];
  void getBusiness() {
    emit(NewsGetBusinessLodingState());
    DioHelper.getData(path: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'business',
      'apiKey': '372ac5c8751f4bb0a0624f15df043f98'
    }).then((value) {
      business = value.data['articles'];
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      // ignore: avoid_print
      print(error.toString());
      emit(NewsGetBusinessErrorState());
    });
  }

  List<dynamic> sports = [];
  void getSports() {
    emit(NewsGetSportsLodingState());
    DioHelper.getData(path: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'sports',
      'apiKey': '372ac5c8751f4bb0a0624f15df043f98'
    }).then((value) {
      sports = value.data['articles'];
      emit(NewsGetSportsSuccessState());
    }).catchError((error) {
      // ignore: avoid_print
      print(error.toString());
      emit(NewsGetSportsErrorState());
    });
  }

  List<dynamic> science = [];
  void getScience() {
    emit(NewsGetScienceLodingState());
    DioHelper.getData(path: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'science',
      'apiKey': '372ac5c8751f4bb0a0624f15df043f98'
    }).then((value) {
      science = value.data['articles'];
      emit(NewsGetScienceSuccessState());
    }).catchError((error) {
    
      print(error.toString());
      emit(NewsGetScienceErrorState());
    });
  }

  List<dynamic> search = [];
   var totalResults = 0;
  // ignore: prefer_typing_uninitialized_variables
  var searchValue;
  void getSearch({required String  value}) {
    emit(NewsGetSearchLodingState());
    DioHelper.getData(
            path: 'v2/everything',
            query: {'q': value, 
            'apiKey': '372ac5c8751f4bb0a0624f15df043f98'})
        .then((value) {
      search = value.data['articles'];
      searchValue = value;
       totalResults = value.data['totalResults'];
       print(value.data['totalResults']);
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      
      print(error.toString());
      emit(NewsGetSearchErrorState());
    });
  }
  bool isDark=false;
  // ignore: non_constant_identifier_names
  ChingDarkMode({bool? fromSheard ,Context} ) async {
    if(fromSheard!=null){
      isDark=fromSheard;
 emit(ChingDarkState());
    }
    else{
 isDark=!isDark;
     CachHelper.putBoolean(key:'isDark' ,value:isDark );
     emit(ChingDarkState());
    }
    
  }
}
