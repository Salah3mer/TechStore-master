import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tech/models/category_model.dart';
import 'package:tech/screens/cart_screen/cart_screen.dart';
import 'package:tech/screens/product_screen/product_screen.dart';
import 'package:tech/screens/search_screen/search_screen.dart';
import 'package:tech/screens/single_category_screen/single_category_screen.dart';
import 'package:tech/shared/components/components.dart';
import 'package:tech/shared/cubit/app_cubit.dart';
import 'package:tech/shared/cubit/app_states.dart';
import 'package:tech/shared/styles/icon_broken.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
        return BlocConsumer<AppCubit, AppStates>(
            listener: (context, state) {
            },
            builder: (context, state) {
              var c = AppCubit.get(context);
              Widget category(CategoryModel model,) => Container(
                    width: 170,
                    height: 60,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.06),
                          blurRadius: 20,
                          offset: const Offset(0, 5),
                        ),
                      ],
                      color:Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              width: 40,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image: NetworkImage(model.urlImage),
                                fit: BoxFit.fitHeight,
                              )),
                            ),
                          ),
                          SizedBox(width: 5,),
                          Expanded(
                            flex: 2,
                            child: Text(
                              model.name,
                              style:Theme.of(context).textTheme.bodyText1,
                              maxLines: 1,

                            ),
                          ),
                        ],
                      ),
                    ),
                  );
              return ConditionalBuilder(
                condition: state is !GetProductLoadingState,
                builder: (context)=>Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SafeArea(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.indigo,
                                  radius: 28.3,
                                  child: Container(
                                    width:double.infinity,
                                    height: 54,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40)
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl:c.userdata.image!=null?c.userdata.image:'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQagAOppyMeA7F5Dv98mR8mvCbPtCXO5bI_F-Q3aYg21g&s',

                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                      errorWidget: (context, url, error) => Icon(Icons.error),
                                      width: 42,
                                      height: 42,
                                      imageBuilder:(context, imageProvider)=> CircleAvatar(
                                        backgroundImage: imageProvider,
                                      ),
                                    ),
                                  ),

                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Hi ${c.userdata.name} !',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                const Spacer(),
                                Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color:Theme.of(context).backgroundColor,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(.06),
                                            blurRadius: 20,
                                            offset: const Offset(0, 5),
                                          ),
                                        ]),
                                    child: IconButton(
                                        onPressed: () {
                                          navegatTo(context, CartScreen());
                                        },
                                        icon: const Icon(
                                          IconBroken.Buy,
                                          size: 30,
                                          color: Colors.blueGrey,
                                        )))
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(.06),
                                  blurRadius: 20,
                                  offset: const Offset(0, 5),
                                ),
                              ]),
                              child: myFormField(
                                  labelColor:  c.isDark==false?Colors.black:Colors.white30,
                                  label: 'Search',
                                  readonly: true,
                                  onTap:(){
                                    navegatTo(context, SearchScreen());
                                  } ,
                                  prefix: IconBroken.Search,
                                  prefixColor:  c.isDark==false?Colors.black:Colors.white30,
                                  myColor: c.isDark==false?Colors.white: HexColor('1e2336'))),
                          const SizedBox(
                            height: 15,
                          ),
                          CarouselSlider.builder(
                              itemCount: c.banner.length,
                              itemBuilder: (context, index, ind) => Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(.06),
                                        blurRadius: 20,
                                        offset: const Offset(0, 5),
                                      ),
                                    ],
                                    image: DecorationImage(
                                        image: NetworkImage(c.banner[index].urlImage),
                                        fit: BoxFit.fill)),
                              ),
                              options: CarouselOptions(
                                autoPlay: true,
                                enlargeCenterPage: true,
                                disableCenter: true,
                                aspectRatio: 2.0,
                              )),
                          const SizedBox(
                            height: 15,
                          ),
                           Text(
                            'Categories',
                            style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 20,fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 60,
                            width: double.infinity,
                            child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) => InkWell(
                                    onTap: () {
                                      navegatTo(context, SingleCategoryScreen());
                                      c.catIndex=index;
                                      c.catproduct = [];
                                      for (int i = 0; i <= c.product.length; i++) {
                                        if (c.category[index].id == c.product[i].catId) {
                                          c.catproduct.add(c.product[i]);
                                        }
                                      }
                                    },
                                    highlightColor: Colors.lightBlue,
                                    child: category(
                                      c.category[index],
                                    )),
                                separatorBuilder: (context, index) => const SizedBox(
                                  width: 15,
                                ),
                                itemCount: c.category.length),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                           Text(
                            'All Product',
                            style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 20,fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: GridView.count(
                                crossAxisCount: 2,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                children: List.generate(
                                  c.product.length,
                                      (index) => InkWell(
                                          onTap: (){
                                            c.currentProductIndex=index;
                                            navegatTo(context, ProductScreen());
                                          },
                                          child: homeGrid(c.product[index],context,index)),
                                ),
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5,
                                childAspectRatio: 1 / 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                fallback: (context)=> const Center(child: CircularProgressIndicator( color: Colors.lightBlue,)),
              );
            },
        );

  }
}
