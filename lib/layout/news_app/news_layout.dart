import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/cubit/cubit.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:news_app/modules/search/search_screen.dart';
import 'package:news_app/network/remote/dio_helper.dart';
import 'package:news_app/shared/components/components.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit ,NewsStates>(
      listener: (context , state){},
      builder: (context , state){
        var cubit = NewsCubit.get(context);
        return Scaffold(
        appBar:AppBar(
          title: Text('News App'),
          actions: [
            IconButton(onPressed: (){
              navigateTo(context , SearchScreen());
            }, icon: Icon(Icons.search)),
            IconButton(onPressed: (){
              NewsCubit.get(context).changeNewsMode();
            }, icon: Icon(Icons.brightness_4_outlined))
          ],
        ),

        body: cubit.screens[cubit.currentIndex],

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: cubit.currentIndex,
          onTap: (index){
             cubit.changeBottomNavBar(index);
          },
          items: cubit.bottomItems,
        ),
      );
      },
    );
  }
}