import 'package:crud_operation/course_list_page.dart';
import 'package:crud_operation/db_helper.dart';
import 'package:flutter/material.dart';

class UpdateDeletePage extends StatefulWidget {

  final int id;
  final String orgCourseName;
  final String orgCourseTime;
  final String orgCoursePrice;


  UpdateDeletePage({required this.id, required this.orgCourseName, required this.orgCourseTime, required this.orgCoursePrice, });

  @override
  _UpdateDeletePageState createState() => _UpdateDeletePageState();
}

class _UpdateDeletePageState extends State<UpdateDeletePage> {

  final _FormKey = GlobalKey<FormState>();

  var courseName="";
  var coursePrice="";
  var courseTime="";

  final courseNameController=TextEditingController();
  final coursePriceController=TextEditingController();
  final courseTimeController=TextEditingController();

  Future<void>UpdateCourse(int id,String courseName,String coursePrice,String courseTime)async{
    await DBHelper.updateCourses(id, courseName, courseTime, coursePrice);
    Navigator.pop(context);
  }

  Future<void>DeleteCourse(int id) async{
    await DBHelper.deleteCourse(id);
    Navigator.pop(context);
  }



  @override
  Widget build(BuildContext context) {

    courseNameController.text= widget.orgCourseName;
    coursePriceController.text = widget.orgCoursePrice;
    courseTimeController.text = widget.orgCourseTime;

    return Scaffold(

      appBar: AppBar(title: const Text("Update & Delete Course"),),
      body:  SingleChildScrollView(
        child: Form(
          key: _FormKey,
          child: Column(
            children: [
              const SizedBox(height: 80,),
              const Text("Update/Delete Course ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),

              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                  TextFormField(
                  controller: courseNameController,
                    keyboardType: TextInputType.text,
                  decoration: const InputDecoration(labelText: "CourseName",hintText: "Enter CourseName"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'CourseName cannot be Empty';
                    }
                    return null;
                  },
                ),
                TextFormField(
                    controller: courseTimeController,
                  keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: "CourseTime",hintText: "Enter CourseTime"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'CourseTime cannot be Empty';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: coursePriceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "CoursePrice",hintText: "Enter CoursePrice",),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'CoursePrice cannot be Empty';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  ElevatedButton(
                    child:const Text("UPDATE"),
                    onPressed: (){
                      if(_FormKey.currentState!.validate()){
                      };
                      setState(() {
                        courseName = courseNameController.text;
                        coursePrice = coursePriceController.text;
                        courseTime = courseTimeController.text;
                        UpdateCourse(widget.id,courseName, courseTime, coursePrice);
                      });
                    },
                    style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                  ),
                  SizedBox(width:20),
                  ElevatedButton(
                    child:const Text("DELETE"),
                    onPressed: (){
                      if(_FormKey.currentState!.validate()){
                      };
                      setState(() {
                        DeleteCourse(widget.id);
                      });
                    },
                    style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                  ),

                ],
              )

            ],
          ),
        ),
        ],
    ),
    ),
      ),
    );

  }
}
