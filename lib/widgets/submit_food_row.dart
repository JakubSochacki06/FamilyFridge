import 'package:flutter/material.dart';

class SubmitFoodRow extends StatefulWidget {
  final String foodName;
  final onChangedQuantity;
  final onChangedMonth;
  final onChangedYear;

  SubmitFoodRow({required this.foodName, required this.onChangedQuantity, required this.onChangedMonth, required this.onChangedYear});

  @override
  State<SubmitFoodRow> createState() => _SubmitFoodRowState();
}

class _SubmitFoodRowState extends State<SubmitFoodRow> {
  late TextEditingController quantityController;
  late TextEditingController expMonthController;
  late TextEditingController expYearController;
  String text = '';

  @override
  void initState() {
    quantityController = TextEditingController();
    expMonthController = TextEditingController();
    expYearController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    quantityController.dispose();
    expMonthController.dispose();
    expYearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Container(
          width: width * 0.23,
          child: Text(
            widget.foodName,
            style: TextStyle(fontSize: 20),
          ),
        ),
        Container(
          height: 50,
          width: width * 0.13,
          child: TextField(
            controller: quantityController,
            onChanged: widget.onChangedQuantity,
            maxLength: 2,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              counterText: '',
              focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color(0xFF71C9CE), width: 2.0),
                borderRadius: BorderRadius.circular(12.0),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(color: Colors.black12),
              ),
              hintText: 'Qty',
              hintStyle: const TextStyle(color: Colors.black12),
            ),
          ),
        ),
        SizedBox(
          width: width*0.01,
        ),
        Container(
          height: 50,
          width: width * 0.12,
          child: Text('Expiry date:', textAlign: TextAlign.center,),
        ),
        SizedBox(
          width: width*0.01,
        ),
        Container(
          height: 50,
          width: width * 0.20,
          child: TextField(
            controller: expMonthController,
            onChanged: widget.onChangedMonth,
            maxLength: 2,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              counterText: '',
              focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color(0xFF71C9CE), width: 2.0),
                borderRadius: BorderRadius.circular(12.0),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(color: Colors.black12),
              ),
              hintText: 'Month',
              hintStyle: const TextStyle(color: Colors.black12),
            ),
          ),
        ),
        Container(
          height: 50,
          width: width * 0.17,
          child: TextField(
            controller: expYearController,
            maxLength: 4,
            onChanged: widget.onChangedYear,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              counterText: '',
              focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color(0xFF71C9CE), width: 2.0),
                borderRadius: BorderRadius.circular(12.0),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(color: Colors.black12),
              ),
              hintText: 'Year',
              hintStyle: const TextStyle(color: Colors.black12),
            ),
          ),
        ),
      ],
    );
  }
}
