import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/status.dart';
import 'package:news_app/shared/componant/componants.dart';

class ScienceScreen extends StatelessWidget {
  const ScienceScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsState>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=NewsCubit.get(context);
        return Scaffold(
            body:ConditionalBuilder(
              condition:cubit.science.isNotEmpty ,
              builder:(context)=>ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context,index)=>buildItembulder(context,cubit.science[index],index),
               separatorBuilder: (context,index)=>myDrive(),
                itemCount: cubit.science.length) ,
              fallback:(context)=>const Center(child: CircularProgressIndicator()) ,
            )
        );
      },
  
    );
  }
}