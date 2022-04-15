import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech/shared/cubit/app_cubit.dart';
import 'package:tech/shared/cubit/app_states.dart';

class HomeLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener:(context, state) {},
        builder:(context, state) {
          var c = AppCubit.get(context);
          Size size = MediaQuery.of(context).size;
          return Scaffold(
            backgroundColor: Colors.grey.shade50,
            body: Stack(
              children: [
              c.screens[c.currentIndex],
              Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.all(20),
                  height: size.width * .155,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.15),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: ListView.builder(
                    itemCount: 4,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: size.width * .024),
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        c.changeBottomNav(index);
                        print(index);
                      },
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AnimatedContainer(
                            duration: Duration(milliseconds: 1500),
                            curve: Curves.fastLinearToSlowEaseIn,
                            margin: EdgeInsets.only(
                              bottom: index == c.currentIndex ? 0 : size.width * .029,
                              right: size.width * .0422,
                              left: size.width * .0422,
                            ),
                            width: size.width * .128,
                            height: index == c.currentIndex ? size.width * .014 : 0,
                            decoration: const BoxDecoration(
                              color: Colors.lightBlue,
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(10),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              c.listOfIcons[index],
                              size: size.width * .076,
                              color: index == c.currentIndex
                                  ? Colors.lightBlue
                                  : Colors.blueGrey,
                            ),
                          ),
                          SizedBox(height: size.width * .03),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],),

          );
        },
        );
  }
}
