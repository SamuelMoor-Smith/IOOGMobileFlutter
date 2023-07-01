

// Future<void> fillFields(IOOGInstrument instrument) async {
//   try {
//     var url = Uri.parse(APIConstants.apiUrl!);
//     var response = await http.post(url,
//         body: fieldsFillBody(instrument), headers: APIConstants.headers());

//     if (response.statusCode == 200) {
//       List<dynamic> rawRecords = json.decode(response.body);
//       if (rawRecords.isNotEmpty) {
//         instrument
//             .getAllFieldWidgets()
//             .forEach((fieldWidget) => fieldWidget.fillField(rawRecords[0]));
//       }
//     }
//   } catch (e) {
//     printError(e.toString());
//   }
// }

// Future<void> fillFieldsFromRecord(
//     IOOGInstrument instrument, dynamic record) async {
//   try {
//     instrument
//         .getAllFieldWidgets()
//         .forEach((fieldWidget) => fieldWidget.fillField(record));
//   } catch (e) {
//     printError(e.toString());
//   }
// }

// Future<void> fillForms(IOOGInstrument instrument) async {
//   try {
//     var url = Uri.parse(APIConstants.apiUrl!);
//     var response = await http.post(url,
//         body: fieldsFillBody(instrument), headers: APIConstants.headers());

//     if (response.statusCode == 200) {
//       List<dynamic> rawRecords = json.decode(response.body);
//       if (rawRecords.isNotEmpty) {
//         for (dynamic record in rawRecords) {
//           switch (instrument.getName()) {
//             case "preop_data":
//               if (record["preop_data_complete"] == "2") {
//                 instrument.addForm(
//                     record['date_preop'], record['side_preop'], record);
//               }
//               break;
//             case "postop_data":
//               if (record["postop_data_complete"] == "2") {
//                 instrument.addForm(
//                     record['date_preop'], record['side_preop'], record);
//               }
//               break;
//             case "surgical_information":
//               if (record["surgical_information_complete"] == "2") {
//                 instrument.addForm(
//                     record['date_surgery'], record['side_surgery'], record);
//               }
//               break;
//           }
//         }
//       }
//     }
//   } catch (e) {
//     printError(e.toString());
//   }
// }
