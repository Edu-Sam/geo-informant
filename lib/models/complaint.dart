

class Complaint{
  int id;
  int complainant_id;
  int complainee_id;
  String complainee_name;
  String complainee_type;
  String complaint_register;
  int complaint_category;
  String complaint_type;
  String short_description;
  String long_description;
  String date_of_incident;
  String file;
  String status;
  String status_update_date;
  String? decline_reason;
  String created_at;
  String updated_at;


  Complaint({required this.id,required this.complainant_id,required this.complainee_id,required
  this.complainee_name,required this.complainee_type,required this.complaint_register,required
  this.complaint_category,required this.complaint_type,required this.short_description,
  required this.long_description,required this.date_of_incident,required this.file,
  required this.status,required this.status_update_date,required this.decline_reason,
  required this.created_at,required this.updated_at});


  factory Complaint.fromJson(Map<String,dynamic> parsedJson){
    return Complaint(
      id: parsedJson['id'],
      complainant_id: parsedJson['complainant_id'],
      complainee_id: parsedJson['complainee_id'],
      complainee_name: parsedJson['complainee_name'],
      complainee_type: parsedJson['complainee_type'],
      complaint_register: parsedJson['complaint_registrar'],
      complaint_category: parsedJson['complaint_category']==null ? 0 : parsedJson['complaint_category'],
      complaint_type: parsedJson['complaint_type'],
      short_description: parsedJson['short_description']==null ? '': parsedJson['short_description'],
      long_description: parsedJson['long_description'],
      date_of_incident: parsedJson['date_of_incident'],
      file: parsedJson['file'],
      status: parsedJson['status'],
      status_update_date: parsedJson['status_update_date'],
      decline_reason: parsedJson['decline_reason'],
      created_at: parsedJson['created_at'],
      updated_at: parsedJson['updated_at']
    );
  }
}