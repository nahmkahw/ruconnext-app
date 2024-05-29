class OtherListData {
  OtherListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.subTxt = "",
    this.navigateScreen = '',
  });

  String imagePath;
  String titleTxt;
  String subTxt;
  String navigateScreen;

  static List<OtherListData> otherList = <OtherListData>[
    OtherListData(
      imagePath: 'assets/fitness_app/A7.png',
      titleTxt: 'ผ่อนผันเข้ารับราชการทหาร',
      subTxt: 'ข้อมูลผ่อนผันเข้ารับราชการทหาร ',
      navigateScreen: '/rotcsextend',
    ),
    OtherListData(
      imagePath: 'assets/fitness_app/A8.png',
      titleTxt: 'ทะเบียนฝึกวิชาทหาร',
      subTxt: 'ข้อมูลลงทะเบียนฝึกวิชาทหาร ',
      navigateScreen: '/rotcsregister',
    ),
    OtherListData(
      imagePath: 'assets/fitness_app/A9.png',
      titleTxt: 'ทุนการศึกษา',
      subTxt: 'ข้อมูลทุนการศึกษาของนักศึกษา',
      navigateScreen: '/rotcs',
    ),
    OtherListData(
      imagePath: 'assets/fitness_app/A7.png',
      titleTxt: 'จัดหางาน',
      subTxt: 'ข้อมูลจัดหางานของนักศึกษา',
      navigateScreen: '/rotcs',
    ),
    OtherListData(
      imagePath: 'assets/fitness_app/A8.png',
      titleTxt: 'การเข้าร่วมกิจกรรม',
      subTxt: 'ข้อมูลการเข้าร่วมกิจกรรมของนักศึกษา',
      navigateScreen: '/rotcs',
    ),
    OtherListData(
      imagePath: 'assets/fitness_app/A9.png',
      titleTxt: 'ประกันอุบัติเหตุ',
      subTxt: 'ข้อมูลประกันอุบัติเหตุของนักศึกษา',
      navigateScreen: '/rotcs',
    ),
  ];
}
