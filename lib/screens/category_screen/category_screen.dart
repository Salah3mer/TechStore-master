import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech/models/category_model.dart';
import 'package:tech/screens/single_category_screen/single_category_screen.dart';
import 'package:tech/shared/components/components.dart';
import 'package:tech/shared/cubit/app_cubit.dart';
import 'package:tech/shared/cubit/app_states.dart';
import 'package:tech/shared/styles/icon_broken.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var c = AppCubit.get(context);
        Widget buildCategoryItem(CategoryModel model) => Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.06),
                      blurRadius: 20,
                      offset: const Offset(0, 5),
                    ),
                  ]),
              child: Row(
                children: [
                  Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: NetworkImage(
                        model.urlImage,
                      ),
                      fit: BoxFit.fitHeight,
                    )),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    model.name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  const Icon(
                    IconBroken.Arrow___Right_Circle,
                    color: Colors.black,
                    size: 30,
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                ],
              ),
            );
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: SafeArea(
            child: Column(
              children: [
                const Text(
                  'All Categories',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: ListView.separated(
                      physics: BouncingScrollPhysics(),
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
                          child: buildCategoryItem(c.category[index])),
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                      itemCount: c.category.length),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
