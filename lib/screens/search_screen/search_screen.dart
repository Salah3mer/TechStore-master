import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech/shared/components/components.dart';
import 'package:tech/shared/cubit/app_cubit.dart';
import 'package:tech/shared/cubit/app_states.dart';
import 'package:tech/shared/styles/icon_broken.dart';

import '../product_screen/product_screen.dart';

class SearchScreen extends StatelessWidget {
  var search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var c = AppCubit.get(context);
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                    children: [
                  Row(
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
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              IconBroken.Arrow___Left_Circle,
                              size: 30,
                              color: Colors.blueGrey,
                            )),
                      ),
                      Container(
                          width: 300,
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.06),
                              blurRadius: 20,
                              offset: const Offset(0, 5),
                            ),
                          ]),
                          child: myFormField(
                              autofocus: true,
                             onChange: (val){
                                c.getSearch(val);
                             },
                              prefix: IconBroken.Search,
                              label: 'Search')),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: ConditionalBuilder(
                      condition: state is !GetSearchLoadingState,
                      builder: (context) => ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(top: 5.0),
                        physics: BouncingScrollPhysics(),
                        itemCount: c.search.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 20.0),
                          child: InkWell(
                            onTap: () {
                              for (int i = 0; i <= c.product.length; i++) {
                                if (c.search[index].id == c.product[i].id) {
                                  c.favIndex = i;
                                  c.currentProductIndex = i;
                                  navegatTo(context, ProductScreen());
                                  print(i);
                                }
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              height: 105,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Theme.of(context).backgroundColor,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      child: CachedNetworkImage(
                                        imageUrl: c.search[index].urlImage,
                                        fit: BoxFit.cover,
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) =>
                                            Center(
                                              child: CircularProgressIndicator(
                                                value: downloadProgress.progress,
                                                strokeWidth: 3,
                                              ),
                                            ),
                                        errorWidget: (context, url, error) =>
                                            Icon(
                                              Icons.error,
                                              color: Colors.indigo,
                                            ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            c.search[index].name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '${c.search[index].price} EGP',
                                                style: TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              Icon(
                                                IconBroken.Arrow___Right_2,
                                                color: Colors.blueAccent,
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
                      fallback: (context)=>Center(child: CircularProgressIndicator(color: Colors.blueAccent,)),
                    ),
                  ),
                ]),
              ),
            ),
          ),
        );
      },
    );
  }
}
