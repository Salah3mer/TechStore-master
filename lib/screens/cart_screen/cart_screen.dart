import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech/screens/product_screen/product_screen.dart';
import 'package:tech/shared/components/components.dart';
import 'package:tech/shared/cubit/app_cubit.dart';
import 'package:tech/shared/cubit/app_states.dart';
import 'package:tech/shared/styles/icon_broken.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var formkey = GlobalKey<FormState>();
    var address =TextEditingController();
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){
        if (state is OrderSucessState)
          toast(text: 'Order Success', state: FlutterToastState.success);
      },
      builder: (context,state){
        var c= AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("My Cart",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600,color: Colors.black),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: Icon(IconBroken.Arrow___Left_2,color: Colors.indigo,size: 35,),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              InkWell(
                onTap: () {

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
                        "https://miro.medium.com/max/250/1*rd_veZDE2LL02Ov9uxfsRg.png"
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
          body:  ConditionalBuilder(
            condition: c.cartItem.length>0,
            builder:(context)=> Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 5.0),
                physics: BouncingScrollPhysics(),
                itemCount: c.cartItem.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 20.0),
                  child: InkWell(
                    onTap: (){

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
                                imageUrl: c.cartItem[index].urlImage,
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
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          c.cartItem[index].name,
                                          style: TextStyle(fontSize: 14),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 2.0),
                                        child: InkWell(
                                          onTap: (){
                                            c.RemoveFromCart(c.cartItem[index]);
                                          },
                                          child: Icon(
                                            IconBroken.Delete,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: (){
                                              c.subtract(c.cartItem[index]);
                                            },
                                            child: Container(
                                              child: Center(child: Text('-',style: TextStyle(color: Colors.white),)),
                                              width: 30,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(6.0),
                                                color: Colors.lightBlueAccent.shade400,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                            child: Text(c.cartItem[index].quantity.toString(),style: TextStyle(color: Colors.blue,fontSize: 20),),
                                          ),
                                          InkWell(
                                            onTap: (){
                                              c.add(c.cartItem[index]);
                                            },
                                            child: Container(
                                              child: Center(child: Text('+',style: TextStyle(color: Colors.white),)),
                                              width: 30,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color: Colors.lightBlueAccent.shade400,
                                                  borderRadius: BorderRadius.circular(6.0),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ), Text(
                                        '${c.subPrice(c.cartItem[index])} EGP',
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 12,
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
            fallback:(context)=> Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(IconBroken.Bag_2,size: 50,),
                  Text('Add Product To Cart'),
                ],
              ),
            ) ,
          ),
          bottomNavigationBar: BottomAppBar(
            child: Container(
              height: 135,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total:',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),

                        Text(
                          '${c.totalPrice(c.cartItem)} EGP',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    defaultButton(text: 'Check Out',function: (){
                      showDialog(context: context, builder: (context) => Form(
                        key: formkey,
                        child: AlertDialog(
                          titlePadding:EdgeInsets.all(5),
                          title: Column(
                            children: [
                              Text('Submit Order'),
                              SizedBox(height: 5,),
                              Text(
                                'Total Price ${c.totalPrice(c.cartItem)} EGP',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),

                            ],
                          ),
                          content: myFormField(controller: address,hint: 'Add Delivery Address',nonFocseBorder: true,validate: (String val) {
                        if (val.isEmpty) {
                        return 'Address can\'t  be Empty';
                        }

                          }),
                          actions: [
                            TextButton(onPressed: (){
                              if(formkey.currentState.validate()){
                                c.order(c.totalPrice(c.cartItem).toString(), address.text, c.cartItem);
                              }
                            }, child: Text('Submit')),
                            TextButton(onPressed: (){
                              navegatBack(context, CartScreen());
                            }, child: Text('No')),
                          ],

                        ),
                      ),);
                    })
                  ],
                ),
              ),
            ),
            elevation: 10,
            color: Colors.white,
          ),
        );
      },
    );
  }
}



