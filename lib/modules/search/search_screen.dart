import 'package:flutter/material.dart';
import 'package:news_app/layout/news_app/cubit/cubit.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit , NewsStates>(
      listener: (context , state ){},
      builder: (context , state ){
        var list = NewsCubit.get(context).search;
        return Scaffold(
        appBar: AppBar(),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
                          controller: searchController,
                          keyboardType: TextInputType.text,
                          onChanged: (value){
                            NewsCubit.get(context).getsearch(value);
                          },
                          validator: (String? vlaue) {
                            if (vlaue!.isEmpty) {
                              return 'Search must not be empty';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Search',
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(),
                          ),
                          ),
          ),
          Expanded(child: articleBuilder(list, context , isSearch: true))
        ],),
      );
      },
      
    );
  }
}