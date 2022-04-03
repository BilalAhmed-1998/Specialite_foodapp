import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:specialite_foodapp/dummyData.dart';
import 'package:specialite_foodapp/screens/profile_homepage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:specialite_foodapp/screens/profile_picture.dart';



class profile_edit extends StatefulWidget {
  static const routeName = '/profile_edit';
  @override
  _profile_editState createState() => _profile_editState();
}

class _profile_editState extends State<profile_edit> {


  TextEditingController controller1;
  TextEditingController controller2;
  String proName;
  String proEmail;
  String proPassword;
  final ImagePicker _picker = ImagePicker();

  _imageCamera() async {
    final XFile photo = await _picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      setState(()  {
        myimage = File(photo.path);
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context)
            {
              return profile_picture();

            });

      });
    }
  }

  _imageGallery() async {
    final XFile image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        myimage = File(image.path);
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context)
            {
              return profile_picture();

            });
      });
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text('Choose from library'),
                      onTap: () {
                        _imageGallery();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Camera'),
                    onTap: () {
                      _imageCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 1,

        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
           title:
           Row(
             children: [
               InkWell(
                 onTap: () {
                   Navigator.popAndPushNamed(context, profile_homepage.routeName);
                 },
                 child: SizedBox(
                   height: 24.h,
                   width: 24.w,
                   child: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 20,
                    ),
                 ),
               ),
               SizedBox(
                 width: 12.w,
               ),
               Text(
                 'Profile',
                 style: TextStyle(
                   color: const Color(0xff121212),
                   fontSize: 18.sp,
                   fontFamily: 'regular',
                   fontWeight: FontWeight.w500,

                 ),
               ),

             ],
           ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 24.w,vertical: 20.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(

                  height: 150.h,
                  width: 342.w,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xff8a959e).withOpacity(0.2),
                        spreadRadius: 0,
                        blurRadius: 40,
                        offset: const Offset(0,8),

                      )],
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,

                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      myimage!=null?
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: SizedBox(
                          height: 80.h,
                          width: 80.w,
                          child: Image.file(
                            myimage,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ):
                      Container(
                          decoration: const BoxDecoration(
                              color: Color(0xffFDB601),
                              shape: BoxShape.circle
                          ),
                          height: 80.h,
                          width: 80.w,
                          child: const ImageIcon(
                            AssetImage("assets/images/pro1.png"),
                            color: Color(0xFF262626),
                          )
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 32.w,
                          ),
                          Text(
                            'Edit Pofile',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontFamily: 'regular',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          InkWell(
                            enableFeedback: true,
                            child: ImageIcon(
                              const AssetImage("assets/images/pro2.png"),
                              size: 24.sp,
                              color: const Color(0xffFDB601),
                            ),
                            onTap: (){
                              _showPicker(context);


                            },
                          )
                        ],
                      )
                    ],
                  ),

                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  height: 60.h,
                  width: 342.w,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xff8a959e).withOpacity(0.2),
                        spreadRadius: 0,
                        blurRadius: 40,
                        offset: const Offset(0,8),

                      )],
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,

                  ),
                  child: Center(
                    child: TextField(
                      controller: controller1,
                      onChanged: (text){
                        proName=text;
                      },
                      decoration: InputDecoration(
                        //contentPadding: EdgeInsets.symmetric(vertical: 10),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'Name',
                          hintStyle: TextStyle(
                            color: const Color(0xff121212),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'regular'
                          ),
                          border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Container(
                  height: 60.h,
                  width: 342.w,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xff8a959e).withOpacity(0.2),
                        spreadRadius: 0,
                        blurRadius: 40,
                        offset: const Offset(0,8),

                      )],
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,

                  ),
                  child: Center(
                    child: TextField(
                      controller: controller2,
                      onChanged: (text){
                        proEmail=text;
                      },
                      decoration: InputDecoration(

                        //contentPadding: EdgeInsets.symmetric(vertical: 10),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'Email ID',
                          hintStyle: TextStyle(
                              fontSize: 16.sp,
                              color: const Color(0xff121212),
                              fontWeight: FontWeight.w400,
                              fontFamily: 'regular'
                          ),
                          border: InputBorder.none,
                          // enabledBorder: UnderlineInputBorder(
                          //   borderRadius: BorderRadius.circular(8),
                          // )
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Container(
                  height: 60.h,
                  width: 342.w,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xff8a959e).withOpacity(0.2),
                        spreadRadius: 0,
                        blurRadius: 40,
                        offset: const Offset(0,8),

                      )],
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,

                  ),
                  child: Center(
                    child: TextField(
                      controller: controller2,
                      onChanged: (text){
                        proPassword=text;
                      },
                      decoration: InputDecoration(

                        //contentPadding: EdgeInsets.symmetric(vertical: 10),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Password',
                        hintStyle: TextStyle(
                            fontSize: 16.sp,
                            color: const Color(0xff121212),
                            fontWeight: FontWeight.w400,
                            fontFamily: 'regular'
                        ),
                        border: InputBorder.none,
                        // enabledBorder: UnderlineInputBorder(
                        //   borderRadius: BorderRadius.circular(8),
                        // )
                      ),
                    ),
                  ),
                ),


              ],
            ),
            InkWell(
              enableFeedback: true,
              onTap: (){
                name=proName;
                emailId=proEmail;
                password=proPassword;
              },
              child: Container(
                height: 56.h,
                width: 342.w,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xff8a959e).withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 40,
                      offset: const Offset(0,8),

                    )],
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xffFDB601),
                ),
                child: Center(
                  child: Text(
                    'Done',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'regular',
                      color: const Color(0xff121212),
                    ),
                  ),
                ),

              ),
            )
          ],
        ),

      ),

    );
  }
}
