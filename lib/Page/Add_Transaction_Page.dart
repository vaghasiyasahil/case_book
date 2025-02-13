import 'package:case_book/Model/Transaction_History.dart';
import 'package:case_book/Page/Home_Page.dart';
import 'package:case_book/Page/Main_Page.dart';
import 'package:case_book/Services/dbHelper.dart';
import 'package:case_book/Services/preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Services/AllData.dart';

class AddTransactionPage extends StatefulWidget {
  String transactionType;
  TransactionHistory? UpdateData;
  AddTransactionPage({required this.transactionType,this.UpdateData,super.key});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {

  TextEditingController value=TextEditingController();
  TextEditingController notes=TextEditingController();
  var date=DateTime.now();
  String time="${DateTime.now().hour}:${DateTime.now().minute} ${DateTime.now().hour>=12?'PM':'AM'}";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.UpdateData==null){
      date=DateTime.now();
      time="${DateTime.now().hour}:${DateTime.now().minute} ${DateTime.now().hour>=12?'PM':'AM'}";
    }else{
      // date=DateTime.now();
      if(widget.UpdateData!.income!=0.0){
        value.text=widget.UpdateData!.income.toString();
      }else{
        value.text=widget.UpdateData!.expense.toString();
      }
      notes.text=widget.UpdateData!.notes!;
      time=widget.UpdateData!.time??"";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AllData.bgBlueColor,
        iconTheme: IconThemeData(color: AllData.bgBlueFgColor),
        title: Text(
          widget.transactionType,
          style: TextStyle(
              color: AllData.bgBlueFgColor
          ),
        ),
      ),
      backgroundColor: Color.fromARGB( 225, 255, 255, 255),
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: AllData.bgWhiteColor,
                    borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                widget.transactionType="Cash In";
                                setState(() {});
                              },
                              child: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.all(5),
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: widget.transactionType=="Cash In"?AllData.bgBlueColor:Colors.grey,
                                    borderRadius: BorderRadius.all(Radius.circular(5))
                                ),
                                child: Text(
                                  "Cash In",
                                  style: TextStyle(
                                      color: widget.transactionType=="Cash In"?AllData.bgBlueFgColor:Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                widget.transactionType="Cash Out";
                                setState(() {});
                              },
                              child: Container(
                                margin: EdgeInsets.all(5),
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: widget.transactionType=="Cash Out"?AllData.bgBlueColor:Colors.grey,
                                    borderRadius: BorderRadius.all(Radius.circular(5))
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "Cash Out",
                                  style: TextStyle(
                                      color: widget.transactionType=="Cash Out"?AllData.bgBlueFgColor:Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                        margin: EdgeInsets.all(5),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 3,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(left: 10,top: 5,bottom: 5),
                                  child: Text(
                                    widget.transactionType,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                )
                            ),
                            Expanded(
                                flex: 3,
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  child: TextField(
                                    controller: value,
                                    style: TextStyle(
                                      color: AllData.bgBlueColor
                                    ),
                                    cursorColor: AllData.bgBlueColor,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "0"
                                    ),
                                  ),
                                )
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        child: TextField(
                          controller: notes,
                          style: TextStyle(
                              color: AllData.bgBlueColor
                          ),
                          cursorColor: AllData.bgBlueColor,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide()
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AllData.bgBlueColor
                                )
                              ),
                              label: Text("Notes"),
                            labelStyle: TextStyle(color: AllData.bgBlueColor)
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all()
                                ),
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: InkWell(onTap: () {
                                        setState(() {
                                          date = date.subtract(Duration(days: 1));
                                        });
                                      },child: Icon(CupertinoIcons.left_chevron)),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Text(
                                          "${date.day}-${date.month}-${date.year}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: InkWell(onTap: () {
                                        setState(() {
                                          date = date.add(Duration(days: 1));
                                        });
                                      },child: Icon(CupertinoIcons.right_chevron)),
                                    ),
                                    Flexible(
                                      child: IconButton(onPressed: () async {
                                        DateTime? selectedDate=await showDatePicker(context: context, firstDate: DateTime(1990), lastDate: DateTime(DateTime.now().year+1));
                                        if(selectedDate!=null){
                                          date = selectedDate;
                                        }
                                        setState(() {});
                                      }, icon: Icon(Icons.calendar_month,color: AllData.bgBlueColor,)),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all()
                                ),
                                margin: EdgeInsets.only(left: 2),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        time,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      )
                                    ),
                                    Flexible(
                                      child: IconButton(onPressed: () async {
                                        TimeOfDay? selectedTime=await showTimePicker(context: context, initialTime: TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().year));
                                        if(selectedTime!=null){
                                          time="${selectedTime.hour}:${selectedTime.minute} ${selectedTime.hour>=12?'PM':'AM'}";
                                        }
                                        setState(() {});
                                        }, icon: Icon(CupertinoIcons.time,color: AllData.bgBlueColor,)),
                                    )
                                  ],
                                ),
                              )
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container()
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    if(widget.UpdateData!=null){
                      showDialog(barrierDismissible: false,context: context, builder: (context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                          title: Text("Delete Transaction"),
                          actions: [
                            TextButton(onPressed: () {
                              Navigator.pop(context);
                            }, child: Text("CANCEL")),
                            TextButton(onPressed: () {
                              dbHelper.deleteTransaction(widget.UpdateData!.id!);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(),));
                            }, child: Text("DELETE"))
                          ],
                        );
                      },);
                    }else{
                      if(addTransaction()) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(),));
                      }
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: AllData.bgWhiteColor,
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    child: Text(
                        "${widget.UpdateData!=null?"DELETE":"Save and Exit"}",
                      style: TextStyle(
                        color: AllData.bgWhiteFgColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    if(widget.UpdateData!=null){
                        updateTransaction();
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(),));
                    }else{
                      if(addTransaction()) {
                        value.text="";
                        notes.text="";
                      }
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: AllData.bgBlueColor,
                      borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "${widget.UpdateData!=null?"SAVE":"Save and Continue"}",
                      style: TextStyle(
                        color: AllData.bgBlueFgColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  addTransaction(){
    if(value.text!="" && notes.text!=""){
      dbHelper.insertTransaction(
          income: widget.transactionType=="Cash In"?double.parse(value.text):0,
          expense: widget.transactionType=="Cash Out"?double.parse(value.text):0,
          notes: notes.text,
          transactionType: widget.transactionType,
          date: date.toString().split(" ")[0],
          time: time,
          userAcName: "${preferences.getAccount()}"
      );
      return true;
    }else{
      AllData.showToast("Please File All The Details.");
      return false;
    }

  }

  bool updateTransaction() {
    if(value.text!="" && notes.text!=""){
      dbHelper.updateTransaction(
          id: widget.UpdateData!.id!,
          income: widget.transactionType=="Cash In"?double.parse(value.text):0,
          expense: widget.transactionType=="Cash Out"?double.parse(value.text):0,
          notes: notes.text,
          transactionType: widget.transactionType,
          date: date.toString().split(" ")[0],
          time: time,
          userAcName: "${preferences.getAccount()}"
      );
      return true;
    }else{
      AllData.showToast("Please File All The Details.");
      return false;
    }
  }

}
