import 'package:flutter/material.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/busniess/busniess_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/settings_screen/setting_screen.dart';
import 'package:news_app/modules/sports/sport_screen.dart';
import 'package:news_app/network/local/cache_helper.dart';
import 'package:news_app/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  ThemeMode appMode = ThemeMode.dark;

  void changeNewsMode({bool? fromShared}){
    if (fromShared != null) {
      isDark = fromShared;
      emit(NewsChangeModeState());
    }else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
      emit(NewsChangeModeState());
    });
    }
    
    
  }

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.business,
      ),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: 'Spots',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Science',
    ),
    // BottomNavigationBarItem(
    //   icon: Icon(
    //     Icons.settings,
    //   ),
    //   label: 'Settings',
    // ),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    // if(index == 1)
    //   getSports();
    // if(index == 2)
    //   getScience();  
    emit(NewsBottomNavState());
  }

  List<Widget> screens = [
    BusniessScreen(),
    SportScreen(),
    ScienceScreen(),
    //SettingsScreen(),
  ];

  List<dynamic> business = [];

  void getBusiness() 
  {
    emit(NewsGetBusinessLodingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'business',
      'apiKey': 'ae5296fd13544292a8708c191d3783c0',
    }).then((value) {
      //print(value.data.toString());
      business = value.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSports() 
  {
    emit(NewsGetBusinessLodingState());
    if (sports.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'sports',
      'apiKey': 'ae5296fd13544292a8708c191d3783c0',
    }).then((value) {
      //print(value.data.toString());
      sports = value.data['articles'];
      print(sports[0]['title']);
      emit(NewsGetSportsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSportsErrorState(error.toString()));
    });
    } else {
      emit(NewsGetSportsSuccessState());
    }
    
    
  }

  List<dynamic> science = [];

  void getScience() 
  {
    emit(NewsGetBusinessLodingState());
    if (science.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'science',
      'apiKey': 'ae5296fd13544292a8708c191d3783c0',
    }).then((value) {
      //print(value.data.toString());
      science = value.data['articles'];
      print(science[0]['title']);
      emit(NewsGetScienceSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetScienceErrorState(error.toString()));
    });
    } else {
      emit(NewsGetScienceSuccessState());
    }
    
    
  }

  List<dynamic> search = [];

  void getsearch(String value) 
  {
    emit(NewsGetSearchLodingState());

    DioHelper.getData(url: 'v2/everything', query: {
      'q': '$value',
      'apiKey': 'ae5296fd13544292a8708c191d3783c0',
    }).then((value) {
      //print(value.data.toString());
      search = value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
    
    
  }
}
