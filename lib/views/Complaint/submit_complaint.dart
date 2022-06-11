import 'package:flutter/material.dart';
import 'package:geoapp/constants/module.dart';
import 'package:geoapp/models/module.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';
//import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import '../../services/module.dart';
import 'package:provider/provider.dart';

class SubmitComplaint extends StatefulWidget{
  SubmitComplaint({Key? key}):super(key: key);

  @override
  SubmitComplaintState createState()=> SubmitComplaintState();
}

class SubmitComplaintState extends State<SubmitComplaint>{

  TextEditingController name_controller=TextEditingController();
  TextEditingController id_number_controller=TextEditingController();
  TextEditingController date_of_incident_controller=TextEditingController();
  TextEditingController incident_details_controller=TextEditingController();
  Validation validation=Validation();
  DateTime _selectedDate=DateTime.now();
  //File? objFile;
  PlatformFile? objFile=null;
  //PickedFile? imageFile;
  //ImagePicker imagePicker=ImagePicker();
  String temp_passport_name='';
  String temp_id_name='';
  DetailsRepository detailsRepository=DetailsRepository();
  bool isLoading=false;
  GlobalKey<FormState> form_key=GlobalKey<FormState>();
  String error_message='';
 // Validation validation=Validation();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: AppConstants.primaryColor,
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios,color: Colors.white,size: 30,),
            ),
          ),
          body:Form(
            key: form_key,
            child:  Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 00.0),
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.10,
                          color: AppConstants.primaryColor,
                          child: const Center(
                            child: Text("Submit Report",style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.w800
                            ),),
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 0.0),
                        child: Column(
                          children: [
                            Padding(
                              padding:const  EdgeInsets.only(top: 0.0,left: 20.0,right: 20.0),
                              child: Card(
                                elevation: 0,
                                color: Colors.transparent,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0,bottom: 5.0),
                                      child: Text("Name",style: TextStyle(
                                          color: AppConstants.primaryColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600
                                      ),),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(bottom: 5.0,left: 0.0,right: 0.0),
                                        child: Container(
                                          width: MediaQuery.of(context).size.width,
                                          //    height: 48,
                                          child: TextFormField(
                                            controller: name_controller,
                                            validator: (text){
                                              return validation.nameValidator(text ?? '', context);
                                            },
                                            decoration:  InputDecoration(
                                              filled: true,
                                              fillColor: Colors.white,
                                              hintText: 'Name',
                                              contentPadding: const EdgeInsets.all(9),
                                              hintStyle: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14,fontWeight: FontWeight.w500
                                              ),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.grey.shade300),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.grey.shade300),
                                              ),
                                            ),
                                          ),
                                        )
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 20.0),
                        child: Column(
                          children: [
                            Padding(
                              padding:const  EdgeInsets.only(top: 0.0),
                              child: Card(
                                elevation: 0,
                                color: Colors.transparent,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0,bottom: 5.0),
                                      child: Text("Identity Number",style: TextStyle(
                                          color: AppConstants.primaryColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600
                                      ),),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(bottom: 5.0),
                                        child: Container(
                                          width: MediaQuery.of(context).size.width,
                                          //    height: 48,
                                          child: TextFormField(
                                            controller: id_number_controller,
                                            validator: (text){
                                              return validation.nameValidator(text ?? '', context);
                                            },
                                            decoration:  InputDecoration(
                                              filled: true,
                                              fillColor: Colors.white,
                                              hintText: 'Identity Number',
                                              contentPadding: const EdgeInsets.all(9),
                                              hintStyle: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14,fontWeight: FontWeight.w500
                                              ),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.grey.shade300),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.grey.shade300),
                                              ),
                                            ),
                                          ),
                                        )
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 20.0),
                        child: Column(
                          children: [
                            Padding(
                              padding:const  EdgeInsets.only(top: 0.0),
                              child: Card(
                                elevation: 0,
                                color: Colors.transparent,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0,bottom: 5.0),
                                      child: Text("Date of incident",style: TextStyle(
                                          color: AppConstants.primaryColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600
                                      ),),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(bottom: 5.0),
                                        child: GestureDetector(
                                          onTap: (){
                                            _selectDate(context);
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context).size.width,
                                            //    height: 48,
                                            child: TextFormField(
                                              controller: date_of_incident_controller,
                                              validator: (text){
                                                return validation.nameValidator(text ?? '', context);
                                              },
                                              decoration:  InputDecoration(
                                                filled: true,
                                                enabled: false,
                                                fillColor: Colors.white,
                                                hintText: 'Date of Incident',
                                                contentPadding: const EdgeInsets.all(9),
                                                hintStyle: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 14,fontWeight: FontWeight.w500
                                                ),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.grey.shade300),
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.grey.shade300),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 20.0),
                        child: Column(
                          children: [
                            Padding(
                              padding:const  EdgeInsets.only(top: 0.0),
                              child: Card(
                                elevation: 0,
                                color: Colors.transparent,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0,bottom: 5.0),
                                      child: Text("Incident Details",style: TextStyle(
                                          color: AppConstants.primaryColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600
                                      ),),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(bottom: 5.0),
                                        child: Container(
                                          width: MediaQuery.of(context).size.width,
                                          //    height: 48,
                                          child: TextFormField(
                                            controller: incident_details_controller,
                                            validator: (text){
                                            //  return validation.nameValidator(text ?? '', context);
                                              return validation.wordsValidator(text ?? '', context);
                                            },
                                            maxLines: 6,
                                            minLines: 6,
                                            decoration:  InputDecoration(
                                              filled: true,
                                              fillColor: Colors.white,
                                              hintText: 'Max 500 words',
                                              contentPadding: const EdgeInsets.all(9),
                                              hintStyle: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14,fontWeight: FontWeight.w500
                                              ),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.grey.shade300),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.grey.shade300),
                                              ),
                                            ),
                                          ),
                                        )
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      error_message.isNotEmpty ?
                      Padding(
                        padding: EdgeInsets.only(top: 10.0,left: 22.0,right: 20.0),
                        child: Text(
                          error_message,style: TextStyle(color: Colors.red.shade500,fontSize: 12,fontWeight:
                        FontWeight.w400,),
                        ),
                      ): Container(),
                      objFile!=null ?
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 20.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.07,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(5.0)
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Text(objFile!.name,style: const TextStyle(color: Colors.teal,
                                            fontSize: 11,fontWeight: FontWeight.w400),),
                                        Text((objFile!.size/1000).toString() + ' kb',style: TextStyle(
                                            color: Colors.teal.shade400,
                                            fontSize: 11,fontWeight: FontWeight.w400
                                        ),)
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          objFile=null;
                                        });
                                      },
                                      child: const Icon(CupertinoIcons.clear,color: Colors.teal,
                                        size: 20,),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ):
                      Padding(
                        padding: EdgeInsets.only(
                            top: 10.0,left: 20.0
                        ),
                        child: Center(
                            child: GestureDetector(
                              onTap: (){
                                getFile1();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Upload PDF/Image',style: TextStyle(color: Colors.grey,
                                    fontSize: 14,),),
                                  Icon(
                                    Icons.upload_file,
                                    color: Colors.black,
                                  )
                                ],
                              )
                            )
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 30.0,bottom: 10.0,left: 10.0,right: 10.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 52,
                          child: TextButton(
                            onPressed: () async{
                              if(form_key.currentState!.validate() && date_of_incident_controller.text.isNotEmpty
                              && objFile!=null){
                                setState(() {
                                  error_message='';
                                  isLoading=true;
                                });
                                await insertComplaint().then((value){
                                  setState(() {
                                    isLoading=false;
                                  });
                                  if(value is int){
                                    if(value==200){

                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    }

                                    else{
                                     // Navigator.pop(context);
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar1);
                                    }
                                  }

                                  else{
                                    print("Value is not int");
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar1);
                                  }
                                });
                              }

                              else if(date_of_incident_controller.text.isEmpty){
                                setState(() {
                                  isLoading=false;
                                  error_message='Please fill in all details';
                                });
                              }

                              else if(objFile==null){
                                setState(() {
                                  isLoading=false;
                                  error_message='No Document uploaded';
                                });
                              }

                              else{
                                setState(() {
                                  isLoading=false;
                                  error_message='Error Occured.Please try again';
                                });
                              }
                            },
                            child: const Text("Submit a report",style: TextStyle(color: Colors.white,
                              fontSize: 14,),),
                            style: TextButton.styleFrom(
                                backgroundColor: AppConstants.primaryColor
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            ),
          )
        ),
        isLoading ?
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.black.withOpacity(0.4),
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppConstants.primaryColor),
            ),
          ),
        ) :Container()
      ],
    );
  }

  _selectDate(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2040),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: AppConstants.primaryColor,
                onPrimary: Colors.white,
                surface: Colors.blueGrey,
                onSurface: Colors.white,
              ),
              dialogBackgroundColor: Colors.blue[500],
            ),
            child: child!,
          );
        });

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      //  date_from= DateFormat.yMMMd().format(_selectedDate);
      DateFormat date_format=DateFormat("yyyy-MM-dd 00:00:00");
      setState((){
        date_of_incident_controller.text=date_format.format(_selectedDate).substring(0,10);
      });



    }
  }

  Future<void> getFile1() async{
    var picked=await FilePicker.platform.pickFiles();

    if(picked !=null){
      setState(() {
        objFile=picked.files.single;
      });
    }
  }

  deleteFile(){
    setState(() {
      objFile=null;
      temp_id_name='';
    });
  }

  Future<dynamic> insertComplaint() async{
    var result= await detailsRepository.insertComplaint(objFile, Provider.of<Preferences>(context,listen: false)
        .user!.user_id!, name_controller.text, id_number_controller.text, incident_details_controller
        .text, incident_details_controller.text);

    return result;
  }

  final snackBar = const SnackBar(content: Text('Complaint file successfully',style: TextStyle(
      color: Colors.green
  ),));

  final snackBar1 = const SnackBar(content: Text('Unable to add Complaint!',style: TextStyle(
      color: Colors.redAccent
  ),));
}