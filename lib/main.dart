import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/network/local/cache_helper.dart';
import 'package:news_app/network/remote/dio_helper.dart';
import 'package:news_app/shared/bloc_observer.dart';
import 'layout/news_app/news_layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/layout/news_app/cubit/cubit.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
 BlocOverrides.runZoned(
    ()async {
      // Use blocs...
       DioHelper.init();
   await CacheHelper.init();
    bool? isDark = CacheHelper.getBoolean(key: 'isDark');
    runApp( MyApp(isDark));
  
      
    },
    blocObserver: MyBlocObserver(),
    
  );
 
}

class MyApp extends StatelessWidget {

  final bool? isDark;
   MyApp(this.isDark);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: ((context) => NewsCubit()..getBusiness()..getSports()..getScience()..changeNewsMode(fromShared: isDark)),
      child: BlocConsumer<NewsCubit , NewsStates>(
        listener: (context , state) {},
        builder: (context, state){
          return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor:Colors.white,
          primarySwatch: Colors.deepOrange,
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color:Colors.black),
            backgroundColor:Colors.white,
            elevation: 0,
            titleTextStyle: TextStyle(
              color:Colors.black,
              fontSize: 20,
            fontWeight: FontWeight.bold,
            ),
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
            )
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
             type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.deepOrange,
            unselectedItemColor: Colors.grey,
            elevation: 20,
            backgroundColor: Colors.white,
          ),
          textTheme: TextTheme(
            bodyText1: TextStyle(
              fontSize:18,
              fontWeight:FontWeight.w600,
              color:Colors.black,
            ),
          ),
        ),
        darkTheme: ThemeData(
          primarySwatch: Colors.deepOrange,
          appBarTheme:  AppBarTheme(
            iconTheme: IconThemeData(color:Colors.white),
            backgroundColor: HexColor('333739'),
            elevation: 0,
            titleTextStyle: TextStyle(
              color:Colors.white,
              fontSize: 20,
            fontWeight: FontWeight.bold,
            ),
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: HexColor('333739'),
              statusBarIconBrightness: Brightness.light,
            )
          ),
          scaffoldBackgroundColor: HexColor('333739'),
          bottomNavigationBarTheme:  BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.deepOrange,
            unselectedItemColor: Colors.grey,
            elevation: 20,
            backgroundColor: HexColor('333739'),
          ),
          textTheme: TextTheme(
            bodyText1: TextStyle(
              fontSize:18,
              fontWeight:FontWeight.w600,
              color:Colors.white,
            ),
          ),
          ),
        themeMode: NewsCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
        home:const NewsLayout(),
      );
        },
      )
    );
  }
}

