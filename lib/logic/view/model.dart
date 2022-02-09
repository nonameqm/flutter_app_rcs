// ignore_for_file: non_constant_identifier_names

class AuthInfo {
  String token;
  String company_name;
  String user_type;
  AuthInfo({this.token, this.company_name, this.user_type});
  factory AuthInfo.fromJson(Map<String, dynamic> json) => AuthInfo(
      token: json["authorization"],
      company_name: json["company"],
      user_type: json["type"]);
}

class RobotType {
  String type;
  RobotType({this.type});
  factory RobotType.fromJson(Map<String, dynamic> json) =>
      RobotType(type: json["type"]);
}

class RobotTypeList {
  List<RobotType> robottypeList;
  RobotTypeList({this.robottypeList});

  factory RobotTypeList.fromJson(List<dynamic> json) {
    List<RobotType> robottypes =
        json.map((item) => RobotType.fromJson(item)).toList();
    return RobotTypeList(robottypeList: robottypes);
  }
}

class Robot {
  int id;
  String serial;
  String type;
  String ip;
  int method_id;
  int factory_id;
  int status;
  int error_code;
  String factory_name;

  Robot({
    this.id,
    this.serial,
    this.type,
    this.ip,
    this.method_id,
    this.factory_id,
    this.status,
    this.error_code,
    this.factory_name,
  });
  factory Robot.fromJson(Map<String, dynamic> json) => Robot(
      id: json["id"],
      serial: json["serial"],
      type: json["type"],
      ip: json["ip"],
      method_id: json["method_id"],
      factory_id: json["factory_id"],
      status: json["status"],
      error_code: json["error_code"],
      factory_name: json["factory_name"]);
}

class RobotList {
  List<Robot> robots;
  RobotList({
    this.robots,
  });

  factory RobotList.fromJson(List<dynamic> json) {
    List<Robot> robots = json.map((item) => Robot.fromJson(item)).toList();

    return RobotList(robots: robots);
  }
}

class RobotData {
  String createdAt;
  String robotType;
  int robotId;
  String robotDataType;
  double robotDataValue;

  RobotData(
      {this.createdAt,
      this.robotType,
      this.robotId,
      this.robotDataType,
      this.robotDataValue});
  factory RobotData.fromJson(Map<String, dynamic> json) {
    return RobotData(
        createdAt: json["created_at"],
        robotType: json["RobotType"],
        robotId: json["RobotID"],
        robotDataType: json["RobotDataType"],
        robotDataValue: json["RobotDataValue"]);
  }
}

class RobotDataList {
  List<RobotData> robotDataList;
  RobotDataList({this.robotDataList});
  factory RobotDataList.fromJson(List<dynamic> json) {
    List<RobotData> robotDatas =
        json.map((item) => RobotData.fromJson(item)).toList();

    return RobotDataList(robotDataList: robotDatas);
  }
}

class Factory {
  int id;
  String name;
  int company_id;
  String loc;
  int total_robot;
  int run_robot;

  Factory(
      {this.id,
      this.name,
      this.company_id,
      this.loc,
      this.total_robot,
      this.run_robot});

  factory Factory.fromJson(Map<String, dynamic> json) {
    return Factory(
      id: json["id"],
      name: json["name"],
      company_id: json["company_id"],
      loc: json["loc"],
      total_robot: json["total_robot"],
      run_robot: json["run_robot"],
    );
  }
}

class FactoryList {
  List<Factory> factoryList;
  FactoryList({this.factoryList});

  factory FactoryList.fromJson(List<dynamic> json) {
    List<Factory> factoryList =
        json.map((item) => Factory.fromJson(item)).toList();

    return FactoryList(factoryList: factoryList);
  }
}

class Method {
  String created_at;
  String maker;
  String subject_type;
  String robot_type;
  String name;
  Map<dynamic, dynamic> data;

  Method(
      {this.created_at,
      this.maker,
      this.subject_type,
      this.robot_type,
      this.name,
      this.data});

  factory Method.fromJson(Map<String, dynamic> json) {
    return Method(
        created_at: json["created_at"],
        maker: json["maker"],
        subject_type: json["subject_type"],
        robot_type: json["robot_type"],
        name: json["name"],
        data: json["data"]);
  }
}

class MethodList {
  List<Method> methodList;
  MethodList({this.methodList});

  factory MethodList.fromJson(List<dynamic> json) {
    List<Method> methodList =
        json.map((item) => Method.fromJson(item)).toList();
    return MethodList(methodList: methodList);
  }
}

class MethodData {
  List<dynamic> pose;
  int time_delay;
  MethodData({this.pose, this.time_delay});

  factory MethodData.fromJson(Map<String, dynamic> json) {
    return MethodData(pose: json['pose'], time_delay: json['delay']);
  }
}

class MethodDataList {
  List<MethodData> methoddataList;
  MethodDataList({this.methoddataList});

  factory MethodDataList.fromJson(List<dynamic> json) {
    List<MethodData> methoddataList =
        json.map((item) => MethodData.fromJson(item)).toList();
    return MethodDataList(methoddataList: methoddataList);
  }
}

class RobotCurrent {
  String time;
  double robot_current1;
  double robot_current2;
  double robot_current3;
  double robot_current4;
  double robot_current5;
  double robot_current6;
  String robot_serial;
  String robot_ip;
  RobotCurrent(
      {this.time,
      this.robot_current1,
      this.robot_current2,
      this.robot_current3,
      this.robot_current4,
      this.robot_current5,
      this.robot_current6,
      this.robot_ip,
      this.robot_serial});

  factory RobotCurrent.fromJson(Map<String, dynamic> json) {
    return RobotCurrent(
        time: json["time"],
        robot_current1: json["robot_current1"],
        robot_current2: json["robot_current2"],
        robot_current3: json["robot_current3"],
        robot_current4: json["robot_current4"],
        robot_current5: json["robot_current5"],
        robot_current6: json["robot_current6"],
        robot_serial: json["robot_serial"],
        robot_ip: json["robot_ip"]);
  }
}

class RobotCurrentList {
  List<RobotCurrent> current_list;
  RobotCurrentList({this.current_list});
  factory RobotCurrentList.fromJson(List<dynamic> json) {
    List<RobotCurrent> currentlist =
        json.map((item) => RobotCurrent.fromJson(item)).toList();
    return RobotCurrentList(current_list: currentlist);
  }
}

class RobotVoltage {
  String time;
  double robot_voltage1;
  double robot_voltage2;
  double robot_voltage3;
  double robot_voltage4;
  double robot_voltage5;
  double robot_voltage6;
  String robot_serial;
  String robot_ip;
  RobotVoltage(
      {this.time,
      this.robot_voltage1,
      this.robot_voltage2,
      this.robot_voltage3,
      this.robot_voltage4,
      this.robot_voltage5,
      this.robot_voltage6,
      this.robot_ip,
      this.robot_serial});

  factory RobotVoltage.fromJson(Map<String, dynamic> json) {
    return RobotVoltage(
        time: json["time"],
        robot_voltage1: json["robot_voltage1"],
        robot_voltage2: json["robot_voltage2"],
        robot_voltage3: json["robot_voltage3"],
        robot_voltage4: json["robot_voltage4"],
        robot_voltage5: json["robot_voltage5"],
        robot_voltage6: json["robot_voltage6"],
        robot_serial: json["robot_serial"],
        robot_ip: json["robot_ip"]);
  }
}

class RobotVoltageList {
  List<RobotVoltage> voltage_list;
  RobotVoltageList({this.voltage_list});
  factory RobotVoltageList.fromJson(List<dynamic> json) {
    List<RobotVoltage> voltagelist =
        json.map((item) => RobotVoltage.fromJson(item)).toList();
    return RobotVoltageList(voltage_list: voltagelist);
  }
}

class TestResult {
  int id;
  String start_at;
  String end_at;
  bool result;
  int robot_id;
  String robot_serial;

  TestResult(
      {this.id,
      this.start_at,
      this.end_at,
      this.result,
      this.robot_id,
      this.robot_serial});

  factory TestResult.fromJson(Map<String, dynamic> json) {
    return TestResult(
        id: json["id"],
        start_at: json["start_at"],
        end_at: json["end_at"],
        result: json["result"],
        robot_id: json["robot_id"],
        robot_serial: json["robot_serial"]);
  }
}

class TestResultList {
  List<TestResult> result_list;
  TestResultList({this.result_list});

  factory TestResultList.fromJson(List<dynamic> json) {
    List<TestResult> test_list =
        json.map((item) => TestResult.fromJson(item)).toList();
    return TestResultList(result_list: test_list);
  }
}
