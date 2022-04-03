import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_todo_list/main.dart';
import 'package:sizer/sizer.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController updateController = TextEditingController();

  Box? todo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todo = Hive.box("title");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff05595B),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onPressed: () {
          dialogBox(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 8.w,
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              child: ValueListenableBuilder(
            valueListenable: Hive.box("title").listenable(),
            builder: (context, box, widget) {
              return ListView.builder(
                  itemCount: todo!.keys.toList().length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
                      child: Card(
                          color: Color(0xffF7F5F2),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: Icon(Icons.today_outlined),
                              dense: true,
                              title: Text(
                                todo!.getAt(index).toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.sp),
                              ),
                              trailing: Container(
                                width: 100,
                                child: Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          updatedialogBox(context, index);
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.green,
                                          size: 5.w,
                                        )),
                                    IconButton(
                                        onPressed: () async {
                                          await todo!.deleteAt(index);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                            "Delete Done!",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13.sp),
                                          )));
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                          size: 5.w,
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          )),
                    );
                  });
            },
          ))
        ],
      )),
    );
  }

  dialogBox(context) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextFormField(
                    hintText: "title",
                    controller: titleController,
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        final title = titleController.text;
                        await todo!.add(title);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                          "Done",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13.sp),
                        )));

                        setState(() {
                          titleController.clear();
                          Navigator.pop(context);
                        });
                      },
                      child: Text("Add"),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  updatedialogBox(context, index) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextFormField(
                    hintText: "title",
                    controller: titleController,
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        todo!.putAt(index, updateController.text);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                          "Update Done!",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13.sp),
                        )));
                        Navigator.pop(context);
                      },
                      child: Text("Add"),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

class CustomTextFormField extends StatelessWidget {
  final String hintText;

  final TextEditingController controller;

  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
      child: TextFormField(
        controller: controller,
        style: TextStyle(
          fontSize: 15.sp,
        ),
        decoration: InputDecoration(
            hintText: hintText,
            contentPadding: EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.black),
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.black)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.black))),
      ),
    );
  }
}
