import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech/screens/category_screen/category_screen.dart';
import 'package:tech/screens/product_screen/product_screen.dart';
import 'package:tech/shared/components/components.dart';
import 'package:tech/shared/cubit/app_cubit.dart';
import 'package:tech/shared/cubit/app_states.dart';
import 'package:tech/shared/styles/icon_broken.dart';

class SingleCategoryScreen extends StatelessWidget {
  var search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){
      },
      builder: (context,state){
        var  c=AppCubit.get(context);
        String titel =c.category[c.catIndex].name;
        return Scaffold(
          appBar: AppBar(
            title: Text('${titel}',style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold
            ),),
            centerTitle:true,
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(color: Colors.blueGrey,
              onPressed: (){
              navegatBack(context, CategoryScreen());
              },
              icon:Icon( IconBroken.Arrow___Left_Circle,
              color: Colors.black,
                size: 35,
              )
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: List.generate(
                      c.catproduct.length,
                          (index) => InkWell(
                            onTap: (){
                              c.currentProductIndex=index;
                              navegatTo(context, ProductScreen());
                            },
                              child: homeGrid(c.catproduct[index],context,index)),
                    ),
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    childAspectRatio: 1 / 1.5,
                  ),
                ),
              ),
            ),
          )
        );

      },
    );
  }
}

