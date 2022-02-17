// ignore_for_file: constant_identifier_names

const api_server_ip = 'http://101.101.218.67:8000/';
const Map<String, String> request_headers = {
  'Content-Type': 'application/json',
  'Accept': 'application/json'
};
const List<String> method_type = [
  "manual_start",
  "get_pos",
  "remove_pos",
  "manual_stop",
  "plan_save",
  "manual_end",
  "get_method",
  "confirm_method",
  "set_method",
  "exec_method",
  "exec_method_wo_camera",
  "error_clear",
];

const List<String> method_type_not_dev = [
  "set_method",
  "exec_method",
  "exec_method_wo_camera",
  "error_clear",
];
