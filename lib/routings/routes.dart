// ignore_for_file: constant_identifier_names

const RootRoute = "/";

//overview
const OverViewPageDisplayName = "Overview";
const OverViewPageRoute = "/overview";

//robot
const RobotPageDisplayName = "Robot";
const RobotPageRoute = "/robot";

//factory
const FactoryPageDisplayName = "Factory";
const FactoryPageRoute = "/factory";

//method
const MethodPageDisplayName = "Method";
const MethodPageRoute = "/method";

//factory info
const FactoryDetailPageDisplayName = "Factory Info";
const FactoryDetailPageRoute = "/factory/info";

//robot detail
const RobotDetailPageDisplayName = "RobotDetail";
const RobotDetailPageRoute = "/robot/info/";

//Authentication
const AuthenticationPageDisplayName = "Log Out";
const AuthenticationPageRoute = "/auth";

const EnrollPageDisplayName = "Enroll";
const EnrollPageRoute = "/enroll";

class MenuItem {
  final String name;
  final String route;

  MenuItem(this.name, this.route);
}

List<MenuItem> sideMenuItems = [
  MenuItem(OverViewPageDisplayName, OverViewPageRoute),
  MenuItem(FactoryPageDisplayName, FactoryPageRoute),
  MenuItem(RobotPageDisplayName, RobotPageRoute),
  MenuItem(MethodPageDisplayName, MethodPageRoute),
  MenuItem(AuthenticationPageDisplayName, AuthenticationPageRoute)
];
