import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:find_bmi/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();

  File? selectedImage;
  bool? isImageUploaded = false;
  Future pickImage(ImageSource source) async {
    try {
      print('hello');
      final selectedImage = await ImagePicker().pickImage(source: source);
      if (selectedImage == null) return;

      final imageTemporary = File(selectedImage.path);
      setState(() {
        this.selectedImage = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> imageList = [
      'assets/images/gym1.jpg',
      'assets/images/gym2.jpg',
      'assets/images/gym3.jpg',
    ];
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/gymbg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // extendBodyBehindAppBar: true,
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   title: const Text(
        //     '',
        //     style: TextStyle(color: Colors.purple),
        //   ),
        //   elevation: 0,
        // ),
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  child: CarouselSlider(
                    items: imageList
                        .map((e) => ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.asset(
                                    e,
                                    width: 1050,
                                    height: 350,
                                    fit: BoxFit.cover,
                                  )
                                ],
                              ),
                            ))
                        .toList(),
                    options: CarouselOptions(
                        enlargeCenterPage: true,
                        enableInfiniteScroll: true,
                        autoPlay: true),
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width * 2 / 3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(143, 54, 54, 54),
                    ),
                    child: Column(
                      children: [
                        Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                style: TextStyle(
                                    fontSize: 22, color: Colors.white),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: 'Weight',
                                    filled: true,
                                    fillColor:
                                        Color.fromARGB(87, 187, 222, 251),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    )),
                                // The validator receives the text that the user has entered.
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                maxLines: 3,
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                                decoration: InputDecoration(
                                    hintText: 'Comments',
                                    filled: true,
                                    fillColor:
                                        Color.fromARGB(87, 187, 222, 251),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    )),
                                // The validator receives the text that the user has entered.
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                              ),
                              IconButton(
                                onPressed: () => pickImage(ImageSource.gallery),
                                icon: Icon(Icons.image_outlined),
                                color: Colors.orange,
                                iconSize: 50,
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // Validate returns true if the form is valid, or false otherwise.
                                  if (_formKey.currentState!.validate()) {
                                    // If the form is valid, display a snackbar. In the real world,
                                    // you'd often call a server or save the information in a database.
                                    // ScaffoldMessenger.of(context).showSnackBar(
                                    //   const SnackBar(
                                    //       content: Text('Processing Data')),
                                    // );
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) => Result())));
                                  }
                                },
                                child: const Text('Submit'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
