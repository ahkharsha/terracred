import 'package:flutter/material.dart';
import 'package:terracred/const/constants.dart';
import 'package:terracred/multi-language/classes/language_constants.dart';

class Pharmacy extends StatelessWidget {
  final Function? onMapFunction;

  const Pharmacy({Key? key, this.onMapFunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              onMapFunction!('pharmacies near me');
            },
            child: Card(
              color: boxColor,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              child: Container(
                height: 50,
                width: 50,
                child: Center(
                  child: Image.asset(
                    'assets/images/services/pharmacy.png',
                    height: 32,
                  ),
                ),
              ),
            ),
          ),
          Text(translation(context).pharmacy)
        ],
      ),
    );
  }
}
