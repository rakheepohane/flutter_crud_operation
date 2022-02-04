
import 'package:crud_operation/db_helper.dart';
import 'package:flutter/material.dart';

class AddNewCourse extends StatefulWidget {
 // const AddNewCourse({Key? key}) : super(key: key);

  @override
  _AddNewCourseState createState() => _AddNewCourseState();
}

class _AddNewCourseState extends State<AddNewCourse> {
  final _FormKey = GlobalKey<FormState>();

  var courseName="";
  var coursePrice="";
  var courseTime="";

  final courseNameController=TextEditingController();
  final coursePriceController=TextEditingController();
  final courseTimeController=TextEditingController();


  Future<void>addCourse(String courseName,String courseTime, String coursePrice)async{
    await DBHelper.addNewCourses(courseName, courseTime, coursePrice);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        // height: 400,
        // width: 300,
            child: Material(
              child: Form(
              key: _FormKey,
              child: Column(
                children: [
                  const SizedBox(height: 10,),
                  const Text("Add Course ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),

                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: courseNameController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(labelText: "CourseName",hintText: "Enter CourseName",),
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
                          decoration: const InputDecoration(labelText: "CourseDuration",hintText: "Enter CourseDuration",),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'CourseDuration cannot be Empty';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: coursePriceController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(labelText: "CoursePrice",hintText: "Enter CoursePrice"),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'CoursePrice cannot be Empty';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 20,),
                        ElevatedButton(
                          child:const Text("ADD"),
                          onPressed: (){
                            if(_FormKey.currentState!.validate()){
                              setState(() {
                                courseName = courseNameController.text;
                                coursePrice = coursePriceController.text;
                                courseTime = courseTimeController.text;
                                addCourse(courseName, courseTime, coursePrice);
                              });
                            };
                            },
                          style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
        ),
            ),
          ),
    );
    //   ),
    // );


  }
}
