import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech/shared/components/components.dart';
import 'package:tech/shared/cubit/app_cubit.dart';
import 'package:tech/shared/cubit/app_states.dart';
import 'package:tech/shared/styles/icon_broken.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formkey = GlobalKey<FormState>();
    var address = TextEditingController();
    var credit = TextEditingController();
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is OrderSucessState)
          toast(text: 'Order Success', state: FlutterToastState.success);
      },
      builder: (context, state) {
        var c = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "CheckOut",
              style: Theme.of(context).appBarTheme.titleTextStyle,
            ),
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                IconBroken.Arrow___Left_2,
                color: Theme.of(context).appBarTheme.iconTheme.color,
                size: 35,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Text(
                      'Shoping Address',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    myFormField(
                        controller: address,
                        label: 'address',
                        validate: (String val) {
                          if (val.isEmpty) {
                            return 'Address can\'t  be Empty';
                          }
                        }),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Payment Method',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Container(
                        width: double.infinity,
                        height: 60,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: MaterialButton(
                          color: Theme.of(context).backgroundColor,
                          onPressed: () {
                            c.changeRadio(1);
                            c.isVisible = false;
                          },
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Image(image: NetworkImage('https://cdn-icons-png.flaticon.com/512/6491/6491623.png'),),
                              ),
                              SizedBox(width:10,),
                              Text(
                                'On Delivery',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Radio(
                                value: 1,
                                groupValue: c.value,
                                onChanged: (val) {
                                  c.changeRadio(val);
                                  c.isVisible = false;
                                },
                              ),
                            ],
                          ),
                          minWidth: double.infinity,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Container(
                        width: double.infinity,
                        height: 60,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: MaterialButton(
                          color: Theme.of(context).backgroundColor,
                          onPressed: () {
                            c.changeRadio(2);
                            c.isVisible = true;
                          },
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Image(image: NetworkImage('https://cdn-icons-png.flaticon.com/512/1198/1198350.png'),),
                              ),
                              SizedBox(width:10,),
                              Text(
                                'Credit Card',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Radio(
                                  value: 2,
                                  groupValue: c.value,
                                  onChanged: (val) {
                                    c.changeRadio(val);
                                    c.isVisible = true;
                                  })
                            ],
                          ),
                          minWidth: double.infinity,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Visibility(
                      visible: c.isVisible,
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).backgroundColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Text(
                                  'Add Your Credit Card ',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                myFormField(
                                    controller: credit,
                                    maxleanth: 14,
                                    validate: (String val) {
                                      if (val.length<14) {
                                        return 'Credit can\'t  be Empty';
                                      }
                                    }),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
                        Text(
                          'Total:',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
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
                    defaultButton(
                        text: 'Order Now',
                        function: () {
                          if(formkey.currentState.validate()){
                          if (c.isVisible == true) {
                            c.sendCredit(credit.text);
                            c.order(c.totalPrice(c.cartItem).toString(), address.text,
                                c.cartItem, c.isVisible);
                          } else {
                            c.order(c.totalPrice(c.cartItem).toString(), address.text,
                                c.cartItem, c.isVisible);

                          }
                        }})
                  ],
                ),
              ),
            ),
            elevation: 10,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        );
      },
    );
  }
}
