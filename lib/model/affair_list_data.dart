class AffairListData {
  AffairListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.subTxt = "",
    this.navigateScreen = '',
  });

  String imagePath;
  String titleTxt;
  String subTxt;
  String navigateScreen;

  static List<AffairListData> affairList = <AffairListData>[
    AffairListData(
      imagePath: 'assets/rotcs/rotcs_2.jpg',
      titleTxt: 'ผ่อนผันเข้ารับราชการทหาร',
      subTxt: 'ข้อมูลผ่อนผันเข้ารับราชการทหาร ',
      navigateScreen: '/rotcsextend',
    ),
    AffairListData(
      imagePath: 'assets/rotcs/rotcs_1.jpg',
      titleTxt: 'ทะเบียนฝึกวิชาทหาร',
      subTxt: 'ข้อมูลลงทะเบียนฝึกวิชาทหาร ',
      navigateScreen: '/rotcsregister',
    ),
    AffairListData(
      imagePath: 'assets/fitness_app/A6.png',
      titleTxt: 'ทุนการศึกษา',
      subTxt: 'ข้อมูลทุนการศึกษาของนักศึกษา',
      navigateScreen: '/affair',
    ),
    AffairListData(
      imagePath: 'assets/fitness_app/A6.png',
      titleTxt: 'จัดหางาน',
      subTxt: 'ข้อมูลจัดหางานของนักศึกษา',
      navigateScreen: '/affair',
    ),
    AffairListData(
      imagePath: 'assets/fitness_app/A6.png',
      titleTxt: 'การเข้าร่วมกิจกรรม',
      subTxt: 'ข้อมูลการเข้าร่วมกิจกรรมของนักศึกษา',
      navigateScreen: '/affair',
    ),
    AffairListData(
      imagePath: 'assets/fitness_app/A6.png',
      titleTxt: 'ประกันอุบัติเหตุ',
      subTxt: 'ข้อมูลประกันอุบัติเหตุของนักศึกษา',
      navigateScreen: '/affair',
    ),
  ];
}
