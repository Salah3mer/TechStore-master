import 'package:cached_network_image/cached_network_image.dart';
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
                              for(int i =0 ;i<=c.product.length;i++){
                                if(c.catproduct[index].id == c.product[i].id){
                                  c.favIndex =i;
                                  c.currentProductIndex=i;
                                  navegatTo(context, ProductScreen());
                                  print(i);
                                }
                              }

                              },
                              child: CatGrid(c.catproduct[index],context,index)),
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
  Widget CatGrid(  model,context,index) => Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(30),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(.06),
          blurRadius: 20,
          offset: const Offset(0, 5),
        ),
      ],),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child:Container(
              width: double.infinity,
              height: 170,
              child: CachedNetworkImage(
                imageUrl: model.urlImage,
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
                width: 42,
                height: 42,
                imageBuilder:(context, imageProvider)=>  Image(
                  image: imageProvider,
                  width: double.infinity,
                  height: 170,
                ),
              ),
            ),
          ),
          Text(
            model.name,
            style: const TextStyle(overflow: TextOverflow.ellipsis),
            maxLines: 2,
          ),
          SizedBox(height: 5,),
          Row(
            children: [
              Text(
                '${model.price.round()} EGP',
                style: const TextStyle(
                    fontSize: 12,
                    color: Colors.lightBlue,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis),
                maxLines: 1,
              ),
              const SizedBox(
                width: 20,
              ),
              Spacer(),
             Icon(IconBroken.Arrow___Right_2,color: Colors.lightBlue,),
            ],
          ),
        ],
      ),
    ),
  );

}

