import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:signature/signature.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: HomeController(),
        id: "Signature",
        builder: (_) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('SIGNATURE'),
              centerTitle: true,
              actions: [
                // IconButton(
                //   icon: const Icon(Icons.history),
                //   onPressed: () {},
                //   tooltip: 'Undo',
                // ),
                const SizedBox(width: 8)
              ],
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Card(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Signature(controller: controller.controllerSignature,  height: 270, backgroundColor: controller.bgColor),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: FilledButton(
                            onPressed: () async {
                              await controller.saveSignature();
                            },
                            style: ButtonStyle(backgroundColor: const MaterialStatePropertyAll(Colors.green), shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)))),
                            child: const Text('Download', style: TextStyle(color: Colors.white, fontSize: 20)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: FilledButton(
                            onPressed: () {
                              controller.clearSign();
                            },
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF800000)), shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0), side: const BorderSide(color: Colors.red)))),
                            child: const Text('clear', style: TextStyle(color: Colors.white, fontSize: 20)),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(12)),
                              child: IconButton(
                                icon: const Icon(Icons.undo),
                                onPressed: () {
                                  controller.controllerSignature.undo();
                                },
                                tooltip: 'Undo',
                              ),
                            ),
                            const Text("Undo")
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(12)),
                              child: IconButton(
                                icon: const Icon(Icons.redo),
                                onPressed: () {
                                  controller.controllerSignature.redo();
                                },
                                tooltip: 'Redo',
                              ),
                            ),
                            const Text("Redo")
                          ],
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap: controller.bgColorPicker,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                margin: const EdgeInsets.only(bottom: 8),
                                decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(12)),
                                child: Card(elevation: 2, color: controller.bgColor, child: Container(height: 30, width: 30, decoration: BoxDecoration(shape: BoxShape.rectangle, color: controller.bgColor, borderRadius: BorderRadius.circular(15)))),
                              ),
                            ),
                            const Text("Background")
                          ],
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap: controller.penColorPicker,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                margin: const EdgeInsets.only(bottom: 8),
                                decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(12)),
                                child: Card(elevation: 2, color: controller.penColor, child: Container(height: 30, width: 30, decoration: BoxDecoration(shape: BoxShape.rectangle, color: controller.penColor, borderRadius: BorderRadius.circular(15)))),
                              ),
                            ),
                            const Text("Pen")
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
