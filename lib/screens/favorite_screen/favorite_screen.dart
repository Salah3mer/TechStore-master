import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech/screens/product_screen/product_screen.dart';
import 'package:tech/shared/components/components.dart';
import 'package:tech/shared/cubit/app_cubit.dart';
import 'package:tech/shared/cubit/app_states.dart';
import 'package:tech/shared/styles/icon_broken.dart';

class FavoriteScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        var c= AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Favourites",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600,color: Colors.black),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: Icon(IconBroken.Arrow___Left_2,color: Colors.indigo,size: 35,),
              onPressed: () {
                c.currentIndex=0;
                c.changeBottomNav(c.currentIndex);
                },
            ),
            actions: [
              InkWell(
                onTap: () {
                  c.currentIndex=3;
                  c.changeBottomNav(c.currentIndex);
                },
                child: Padding(
                  padding:
                  const EdgeInsets.only(right: 10, top: 6),
                  child: CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.indigo,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 22.5,
                      child:  CachedNetworkImage(
                        imageUrl:
                        c.userdata.image
                        ,
                        placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        width: 42,
                        height: 42,
                        imageBuilder:(context, imageProvider)=> CircleAvatar(
                          backgroundImage: imageProvider,
                          radius: 21.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          body:
             Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 5.0),
                physics: BouncingScrollPhysics(),
                itemCount: c.fav.length,
                itemBuilder: (context, index) => ConditionalBuilder(
                  condition: c.fav[index]==true,
                  builder:(context) =>Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 20.0),
                    child: InkWell(
                      onTap: (){
                        c.currentProductIndex=index;
                      navegatTo(context, ProductScreen());
                      },
                      child: Container(
                        width: double.infinity,
                        height: 105,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.grey[100],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                child: CachedNetworkImage(
                                  imageUrl: c.product[index].urlImage,
                                  fit: BoxFit.cover,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) => Center(
                                    child: CircularProgressIndicator(
                                      value: downloadProgress.progress,
                                      strokeWidth: 3,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => Icon(Icons.error,color: Colors.indigo,),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      c.product[index].name,
                                      style: TextStyle(fontSize: 14),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${c.product[index].price} EGP',
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: (){
                                            c.changeFav(c.product[index].id, index);
                                          },
                                          child: Icon(
                                            IconBroken.Delete,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                ),
              ),
            ),
        );
      },
    );
  }
}

