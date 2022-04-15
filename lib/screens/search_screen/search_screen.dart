import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech/shared/components/components.dart';
import 'package:tech/shared/cubit/app_cubit.dart';
import 'package:tech/shared/cubit/app_states.dart';
import 'package:tech/shared/styles/icon_broken.dart';

class SearchScreen extends StatelessWidget {
  var search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        var  c=AppCubit.get(context);
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.06),
                            blurRadius: 20,
                            offset: const Offset(0, 5),
                          ),
                        ]),
                    child: IconButton(onPressed: (){
                      Navigator.pop(context);
                    }, icon: Icon(IconBroken.Arrow___Left_Circle,size: 30,color: Colors.blueGrey,)),
                  ),
                  Container(
                      width: 300,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.06),
                              blurRadius: 20,
                              offset: const Offset(0, 5),
                            ),
                          ]),
                      child: myFormField(
                          autofocus: true,
                          controller: search,
                          prefix: IconBroken.Search,
                          label: 'Search'
                      )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

