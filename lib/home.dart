import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:samiha/services.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  File? _pickedImage;

  Future<void> pickImage(ImageSource source) async {
    setState(() {
      result = "";
    });
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile == null) return;

      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    } catch (e) {
      print("Error picking image: $e");
    }
  }
  
  String result = '';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 23, 83, 203),
        title: const Text(
          "Cancer detection", 
          style: TextStyle(
            color: Colors.white, 
            fontWeight: FontWeight.bold, 
            fontSize: 21
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(15), 
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Select Image", 
                style: TextStyle(
                  color: Colors.black, 
                  fontWeight: FontWeight.bold, 
                  fontSize: 15
                ),
              ),
              const SizedBox(height: 15,), 
              DottedBorder(
                borderType: BorderType.RRect,
                radius: Radius.circular(15),
                padding: EdgeInsets.all(0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  child: GestureDetector(
                    onTap: () => pickImage(ImageSource.camera),
                    child: Container(
                      width: width*0.9,
                      height: height*0.4, 
                      child: Center(
                        child: _pickedImage != null? 
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.file(
                            width: width*0.87,
                            height: height*0.37,
                            _pickedImage!,
                            fit: BoxFit.cover,
                          )
                        )
                        :const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_a_photo_outlined, 
                              size: 33, 
                            ),
                            SizedBox(height: 15,), 
                            Text(
                              "Type to take picture",
                              style: TextStyle(
                                fontSize: 21, 
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                      )
                    ),
                  ),
                ),
              ), 
              const SizedBox(height: 15,),
              const Text(
                "Or", 
                style: TextStyle(
                  color: Colors.black, 
                  fontWeight: FontWeight.bold, 
                  fontSize: 15
                ),
              ),
              const SizedBox(height: 15,),
              GestureDetector(
                onTap: () => pickImage(ImageSource.gallery),
                child: Container(
                  width: width*0.9, 
                  height: 55, 
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15), 
                    border: Border.all(
                      width: 1.5,
                      color: Color.fromARGB(255, 18, 58, 138), 
                    ),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(1, 1), 
                        color: Color.fromARGB(255, 227, 227, 227), 
                        blurRadius: 5
                      )
                    ], 
                  ),
                  child: const Center(
                      child: Text(
                        "Add from gallery",
                        style: TextStyle(
                          fontSize: 17, 
                          color: Color.fromARGB(255, 18, 58, 138), 
                          fontWeight: FontWeight.bold
                        ),
                      ), 
                  ),
                ),
              ), 
              SizedBox(height: height*0.05,),
              result==""?Text(result)
              :Row(
                children: [
                  const Text(
                    "Predicted Class: ", 
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(width: 15,),
                  Expanded(
                    child: Text(
                      result, 
                      style: const TextStyle(
                        fontWeight: FontWeight.bold, 
                        color: Colors.red
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      softWrap: false,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height*0.05,),
              GestureDetector(
                onTap: () async{
                  await sendImage(_pickedImage!);
                  String _result = await sendImage(_pickedImage!);
                  setState(() {
                    result = _result;
                  });
                },
                child: Container(
                  width: width*0.9, 
                  height: 55, 
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 18, 58, 138), 
                        Color.fromARGB(255, 22, 73, 173), 
                        Color.fromARGB(255, 28, 91, 216), 
                        Color.fromARGB(255, 33, 105, 248),
                      ]
                    ),
                    borderRadius: BorderRadius.circular(15), 
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(1, 1), 
                        color: const Color.fromARGB(255, 227, 227, 227), 
                        blurRadius: 5
                      )
                    ], 
                  ),
                  child: const Center(
                      child: Text(
                        "View results",
                        style: TextStyle(
                          fontSize: 17, 
                          color: Colors.white, 
                          fontWeight: FontWeight.bold
                        ),
                      ), 
                  ),
                ),
              ),
            ],
          ),
      ),
    );
  }
}