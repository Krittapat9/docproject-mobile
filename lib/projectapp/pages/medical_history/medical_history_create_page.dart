import 'package:code/projectapp/models/appliances.dart';
import 'package:code/projectapp/models/medicine.dart';
import 'package:code/projectapp/models/patient.dart';
import 'package:code/projectapp/sevices/auth.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:code/projectapp/models/type_of_diversion.dart';
import 'package:code/projectapp/models/stoma_construction.dart';
import 'package:code/projectapp/models/stoma_color.dart';
import 'package:code/projectapp/models/stoma_characteristics.dart';
import 'package:code/projectapp/models/stoma_shape.dart';
import 'package:code/projectapp/models/stoma_protrusion.dart';
import 'package:code/projectapp/models/peristomal_skin.dart';
import 'package:code/projectapp/models/mucocutaneous_suture_line.dart';
import 'package:code/projectapp/models/stoma_effluent.dart';
import 'package:select_dialog/select_dialog.dart';

class MedicalHistoryCreatePage extends StatefulWidget {
  final int surgeryId;

  MedicalHistoryCreatePage({super.key, required this.surgeryId});

  @override
  State<MedicalHistoryCreatePage> createState() => _MedicalHistoryCreatePage();
}

class _MedicalHistoryCreatePage extends State<MedicalHistoryCreatePage> {
  TextEditingController typeOfDiversionNoteOtherController =
      TextEditingController();
  TextEditingController stomaSizeWidthController = TextEditingController();
  TextEditingController stomaSizeLengthController = TextEditingController();
  TextEditingController stomaCharacteristicsNoteOtherController =
      TextEditingController();
  TextEditingController mucocutaneousSutureLineNoteOtherController =
      TextEditingController();

  void clearForm() {
    typeOfDiversionNoteOtherController.text = '';
    stomaSizeWidthController.text = '';
    stomaSizeLengthController.text = '';
    stomaCharacteristicsNoteOtherController.text = '';
    mucocutaneousSutureLineNoteOtherController.text = '';
  }

  Future<void> _createMedical() async {
    final dio = Dio();
    final response = await dio.post(
      "http://10.0.2.2:3000/surgery/${widget.surgeryId}/medical_history",
      data: {
        'staff_id': Auth.currentUser?.id,
        'type_of_diversion_id': typeOfDiversionId,
        'type_of_diversion_note_other': typeOfDiversionNoteOtherController.text,
        'stoma_construction_id': stomaColorId,
        'stoma_color_id': stomaColorId,
        'stoma_size_width_mm': stomaSizeWidthController.text,
        'stoma_size_length_mm': stomaSizeLengthController.text,
        'stoma_characteristics_id': stomaCharacteristicsId,
        'stoma_characteristics_note_other':
            stomaCharacteristicsNoteOtherController.text,
        'stoma_shape_id': stomaShapeId,
        'stoma_protrusion_id': stomaProtrusionId,
        'peristomal_skin_id': peristomalSkinId,
        'mucocutaneous_suture_line_id': mucocutaneousSutureLineId,
        'mucocutaneous_suture_line_note_other':
            mucocutaneousSutureLineNoteOtherController.text,
        'stoma_effluent_id': stomaEffluentId,
        'appliances_id': appliancesId,
        'medicine_id': medicineId,
      },
    );
    if (response.statusCode == 200) {
      print('Medical created successfully!');
      clearForm();
      Navigator.of(context).pop();
      setState(() {});
    } else {
      print('Error creating patient: ${response.data}');
    }
  }

  //get Type of diversion
  List<TypeOfDiversion> typeOfDiversionList = [];
  int typeOfDiversionId = 0;

  //get Stoma construction
  List<StomaConstruction> stomaConstructionList = [];
  int stomaConstructionId = 0;

  //get Stoma color
  List<StomaColor> stomaColorList = [];
  int stomaColorId = 0;

  //get Stoma characteristics
  List<StomaCharacteristics> stomaCharacteristicsList = [];
  int stomaCharacteristicsId = 0;

  //get Stoma shape
  List<StomaShape> stomaShapeList = [];
  int stomaShapeId = 0;

  //get Stoma protrusion
  List<StomaProtrusion> stomaProtrusionList = [];
  int stomaProtrusionId = 0;

  //get Peristomal skin
  List<PeristomalSkin> peristomalSkinList = [];
  int peristomalSkinId = 0;

  // get Mucocutaneous Suture Line
  List<MucocutaneousSutureLine> mucocutaneousSutureLineList = [];
  int mucocutaneousSutureLineId = 0;

  //get stoma effluent
  List<StomaEffluent> stomaEffluentList = [];
  int stomaEffluentId = 0;

  //get appliances
  List<Appliances> appliancesList = [];
  int appliancesId = 0;
  Appliances appliances = Appliances(
      id: 0,
      type: '',
      name: '',
      brand: '',
      name_flange: '',
      name_pouch: '',
      size: '');

  //get medicine
  List<Medicine> medicineList = [];
  int medicineId = 0;
  Medicine medicine = Medicine(id: 0, name: '', details: '');

  Future<bool> loadDataMedical() async {
    //get type of diversion
    try {
      final dio = Dio();
      final response = await dio.get("http://10.0.2.2:3000/type_of_diversion");
      log('data:${response.data}');
      if (response.statusCode == 200) {
        List jsonList = response.data;
        typeOfDiversionList =
            jsonList.map((json) => TypeOfDiversion.fromJson(json)).toList();
      }
    } catch (error) {
      log('err:$error');
    }

    //get stoma construction
    try {
      final dio = Dio();
      final response = await dio.get("http://10.0.2.2:3000/stoma_construction");
      log('data:${response.data}');
      if (response.statusCode == 200) {
        List jsonList = response.data;
        stomaConstructionList =
            jsonList.map((json) => StomaConstruction.fromJson(json)).toList();
      }
    } catch (error) {
      log('err:$error');
    }

    //get stoma color
    try {
      final dio = Dio();
      final response = await dio.get("http://10.0.2.2:3000/stoma_color");
      log('data:${response.data}');
      if (response.statusCode == 200) {
        List jsonList = response.data;
        stomaColorList =
            jsonList.map((json) => StomaColor.fromJson(json)).toList();
      }
    } catch (error) {
      log('err:$error');
    }

    //get stoma characteristics
    try {
      final dio = Dio();
      final response =
          await dio.get("http://10.0.2.2:3000/stoma_characteristics");
      log('data:${response.data}');
      if (response.statusCode == 200) {
        List jsonList = response.data;
        stomaCharacteristicsList = jsonList
            .map((json) => StomaCharacteristics.fromJson(json))
            .toList();
      }
    } catch (error) {
      log('err:$error');
    }

    //get stoma shape
    try {
      final dio = Dio();
      final response = await dio.get("http://10.0.2.2:3000/stoma_shape");
      log('data:${response.data}');
      if (response.statusCode == 200) {
        List jsonList = response.data;
        stomaShapeList =
            jsonList.map((json) => StomaShape.fromJson(json)).toList();
      }
    } catch (error) {
      log('err:$error');
    }

    //get stoma protrusion
    try {
      final dio = Dio();
      final response = await dio.get("http://10.0.2.2:3000/stoma_protrusion");
      log('data:${response.data}');
      if (response.statusCode == 200) {
        List jsonList = response.data;
        stomaProtrusionList =
            jsonList.map((json) => StomaProtrusion.fromJson(json)).toList();
      }
    } catch (error) {
      log('err:$error');
    }

    //get peristomal skin
    try {
      final dio = Dio();
      final response = await dio.get("http://10.0.2.2:3000/peristomal_skin");
      log('data:${response.data}');
      if (response.statusCode == 200) {
        List jsonList = response.data;
        peristomalSkinList =
            jsonList.map((json) => PeristomalSkin.fromJson(json)).toList();
      }
    } catch (error) {
      log('err:$error');
    }

    //get mucocutaneous_suture_line
    try {
      final dio = Dio();
      final response =
          await dio.get("http://10.0.2.2:3000/mucocutaneous_suture_line");
      log('data:${response.data}');
      if (response.statusCode == 200) {
        List jsonList = response.data;
        mucocutaneousSutureLineList = jsonList
            .map((json) => MucocutaneousSutureLine.fromJson(json))
            .toList();
      }
    } catch (error) {
      log('err:$error');
    }
    //get stoma effluent
    try {
      final dio = Dio();
      final response = await dio.get("http://10.0.2.2:3000/stoma_effluent");
      log('data:${response.data}');
      if (response.statusCode == 200) {
        List jsonList = response.data;
        stomaEffluentList =
            jsonList.map((json) => StomaEffluent.fromJson(json)).toList();
      }
    } catch (error) {
      log('err:$error');
    }

    //get appliances
    try {
      final dio = Dio();
      final response = await dio.get("http://10.0.2.2:3000/appliances");
      log('data:${response.data}');
      if (response.statusCode == 200) {
        List jsonList = response.data;
        appliancesList =
            jsonList.map((json) => Appliances.fromJson(json)).toList();
      }
    } catch (error) {
      log('err:$error');
    }

    //get medicine
    try {
      final dio = Dio();
      final response = await dio.get("http://10.0.2.2:3000/medicine");
      log('data:${response.data}');
      if (response.statusCode == 200) {
        List jsonList = response.data;
        medicineList = jsonList.map((json) => Medicine.fromJson(json)).toList();
      }
    } catch (error) {
      log('err:$error');
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(62, 28, 162, 1.0),
        title: const Text(
          'Add Medical',
          style: const TextStyle(
            fontSize: 18.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Color set here
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: loadDataMedical(),
          builder: (context, snapshot) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: Column(
                  children: [
                    Center(
                      child: Text('เพิ่มการรักษา',
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 19)),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Type of Diversion',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                        DropdownButton(
                          value: typeOfDiversionId,
                          items: [
                            DropdownMenuItem(
                              value: 0,
                              child: Text(
                                'Please Select',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 16),
                              ),
                            ),
                            ...typeOfDiversionList
                                .map((e) => DropdownMenuItem(
                                    value: e.id, child: Text(e.name)))
                                .toList(),
                          ],
                          onChanged: (val) {
                            print('type_of_diversion:$val');
                            setState(() {
                              typeOfDiversionId = val!;
                            });
                          },
                        ),
                      ],
                    ),
                    Container(
                      height: 35,
                      width: 400,
                      child: TextField(
                        controller: typeOfDiversionNoteOtherController,
                        decoration: InputDecoration(
                          labelText: 'Other',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Stoma Construction',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                        DropdownButton(
                          value: stomaConstructionId,
                          items: [
                            DropdownMenuItem(
                              value: 0,
                              child: Text(
                                'Please Select',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 16),
                              ),
                            ),
                            ...stomaConstructionList
                                .map((e) => DropdownMenuItem(
                                    value: e.id, child: Text(e.name)))
                                .toList(),
                          ],
                          onChanged: (val) {
                            print('stoma_construction:$val');
                            setState(() {
                              stomaConstructionId = val!;
                            });
                          },
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Stoma Color',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                        DropdownButton(
                          value: stomaColorId,
                          items: [
                            DropdownMenuItem(
                              value: 0,
                              child: Text(
                                'Please Select',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 16),
                              ),
                            ),
                            ...stomaColorList
                                .map((e) => DropdownMenuItem(
                                    value: e.id, child: Text(e.name)))
                                .toList(),
                          ],
                          onChanged: (val) {
                            print('stoma_color:$val');
                            setState(() {
                              stomaColorId = val!;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 35,
                          width: 100,
                          child: TextField(
                            controller: stomaSizeWidthController,
                            decoration: InputDecoration(
                              labelText: 'กว้าง',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 35,
                          width: 100,
                          child: TextField(
                            controller: stomaSizeLengthController,
                            decoration: InputDecoration(
                              labelText: 'ยาว',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Stoma Characteristics',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                        DropdownButton(
                          value: stomaCharacteristicsId,
                          items: [
                            DropdownMenuItem(
                              value: 0,
                              child: Text(
                                'Please Select',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 16),
                              ),
                            ),
                            ...stomaCharacteristicsList
                                .map((e) => DropdownMenuItem(
                                    value: e.id, child: Text(e.name)))
                                .toList(),
                          ],
                          onChanged: (val) {
                            print('stoma_characteristics:$val');
                            setState(() {
                              stomaCharacteristicsId = val!;
                            });
                          },
                        ),
                      ],
                    ),
                    Container(
                      height: 35,
                      width: 400,
                      child: TextField(
                        controller: stomaCharacteristicsNoteOtherController,
                        decoration: InputDecoration(
                          labelText: 'Other',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Stoma Shape',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                        DropdownButton(
                          value: stomaShapeId,
                          items: [
                            DropdownMenuItem(
                              value: 0,
                              child: Text(
                                'Please Select',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 16),
                              ),
                            ),
                            ...stomaShapeList
                                .map((e) => DropdownMenuItem(
                                    value: e.id, child: Text(e.name)))
                                .toList(),
                          ],
                          onChanged: (val) {
                            print('stoma_shape:$val');
                            setState(() {
                              stomaShapeId = val!;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Stoma Protrusion',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                        DropdownButton(
                          value: stomaProtrusionId,
                          items: [
                            DropdownMenuItem(
                              value: 0,
                              child: Text(
                                'Please Select',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 16),
                              ),
                            ),
                            ...stomaProtrusionList
                                .map((e) => DropdownMenuItem(
                                    value: e.id, child: Text(e.name)))
                                .toList(),
                          ],
                          onChanged: (val) {
                            print('stoma_protrusion:$val');
                            setState(() {
                              stomaProtrusionId = val!;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Peristomal Skin',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                        DropdownButton(
                          value: peristomalSkinId,
                          items: [
                            DropdownMenuItem(
                              value: 0,
                              child: Text(
                                'Please Select',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 16),
                              ),
                            ),
                            ...peristomalSkinList
                                .map((e) => DropdownMenuItem(
                                    value: e.id, child: Text(e.name)))
                                .toList(),
                          ],
                          onChanged: (val) {
                            print('peristomal_skin:$val');
                            setState(() {
                              peristomalSkinId = val!;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Mucocutaneous Suture Line',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                        DropdownButton(
                          value: mucocutaneousSutureLineId,
                          items: [
                            DropdownMenuItem(
                              value: 0,
                              child: Text(
                                'Please Select',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 16),
                              ),
                            ),
                            ...mucocutaneousSutureLineList
                                .map((e) => DropdownMenuItem(
                                    value: e.id, child: Text(e.name)))
                                .toList(),
                          ],
                          onChanged: (val) {
                            print('mucocutaneous_suture_line:$val');
                            setState(() {
                              mucocutaneousSutureLineId = val!;
                            });
                          },
                        ),
                      ],
                    ),
                    Container(
                      height: 35,
                      width: 400,
                      child: TextField(
                        controller: mucocutaneousSutureLineNoteOtherController,
                        decoration: InputDecoration(
                          labelText: 'Other',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Stoma Effluent',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                        DropdownButton(
                          value: stomaEffluentId,
                          items: [
                            DropdownMenuItem(
                              value: 0,
                              child: Text(
                                'Please Select',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 16),
                              ),
                            ),
                            ...stomaEffluentList
                                .map((e) => DropdownMenuItem(
                                    value: e.id, child: Text(e.name)))
                                .toList(),
                          ],
                          onChanged: (val) {
                            print('stoma_effluent:$val');
                            setState(() {
                              stomaEffluentId = val!;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          'Appliances',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          child: ElevatedButton(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  Text(
                                    appliances.name.isEmpty
                                        ? "Please Select"
                                        : '${appliances.name}\nType: ${appliances.type}',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Icon(
                                    Icons.add,
                                    size: 30,
                                    color: Color.fromRGBO(62, 28, 162, 1.0),
                                  )
                                ],
                              ),
                            ),
                            onPressed: () {
                              SelectDialog.showModal<Appliances>(
                                context,
                                backgroundColor: Colors.grey[50],
                                showSearchBox: true,
                                onFind: (find) async => await appliancesList
                                    .where((e) => e.name
                                        .toLowerCase()
                                        .contains(find.toLowerCase()))
                                    .toList(),
                                selectedValue: appliances,
                                itemBuilder: ((context, item, selected) {
                                  return Column(
                                    children: [
                                      ListTile(
                                        title: Text(
                                          item.name,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                          'Type: ${item.type}',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.black,
                                        endIndent: 0,
                                      ),
                                    ],
                                  );
                                }),
                                items: appliancesList,
                                onChange: (Appliances selected) {
                                  setState(() {
                                    appliances = selected;
                                    appliancesId = selected.id;
                                  });
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              side: BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Row(
                    //   children: [
                    //     Padding(
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: Text('Appliances',
                    //           style: TextStyle(
                    //               fontWeight: FontWeight.bold, fontSize: 16)),
                    //     ),
                    //     DropdownButton(
                    //       value: appliancesId,
                    //       items: [
                    //         DropdownMenuItem(
                    //           value: 0,
                    //           child: Text(
                    //             'Please Select',
                    //             style:
                    //                 TextStyle(color: Colors.grey, fontSize: 16),
                    //           ),
                    //         ),
                    //         ...appliancesList
                    //             .map((e) => DropdownMenuItem(
                    //                 value: e.id, child: Text(e.name)))
                    //             .toList(),
                    //       ],
                    //       onChanged: (val) {
                    //         print('appliances:$val');
                    //         setState(() {
                    //           appliancesId = val!;
                    //         });
                    //       },
                    //     ),
                    //   ],
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Medicine',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                        DropdownButton(
                          value: medicineId,
                          items: [
                            DropdownMenuItem(
                              value: 0,
                              child: Text(
                                'Please Select',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 16),
                              ),
                            ),
                            ...medicineList
                                .map((e) => DropdownMenuItem(
                                    value: e.id, child: Text(e.name)))
                                .toList(),
                          ],
                          onChanged: (val) {
                            print('medicine:$val');
                            setState(() {
                              medicineId = val!;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await _createMedical();
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50.0),
                          backgroundColor:
                              const Color.fromRGBO(62, 28, 168, 1.0),
                          textStyle: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
