import 'dart:io';

const mockImage = 'http://baishan.oversketch.com/2019/11/05/1f676c8e4036fa5080892c5294c8e90b.PNG';
const mockVideo = 'http://baishan.oversketch.com/2019/11/05/d07f2f1440e51b9680f4bcfe63b0ab67.MP4';

const String mV1= 'https://aweme.snssdk.com/aweme/v1/playwm/?video_id=v0300f9f0000bu2s2i292j26ke4it0qg&ratio=720p&line=0';
const String mV2 = 'https://aweme.snssdk.com/aweme/v1/playwm/?video_id=v0200f570000btobo3qu42phdsjq2150&ratio=720p&line=0';
const String mV3 = 'https://aweme.snssdk.com/aweme/v1/playwm/?video_id=v0200f9f0000bth38ar6tfk7si85ug5g&ratio=720p&line=0';
const String mV4 = 'https://aweme.snssdk.com/aweme/v1/playwm/?video_id=v0300fbf0000bu0jbo20hgrk3sbn6580&ratio=720p&line=0';
const String mV5 = 'https://aweme.snssdk.com/aweme/v1/playwm/?video_id=v0300f100000bu2mdpptjb63d9dbkhcg&ratio=720p&line=0';
const String mV6 = 'https://aweme.snssdk.com/aweme/v1/playwm/?video_id=v0200f220000br85tto9lr7821rpo37g&ratio=720p&line=0';
const String mV7= 'https://aweme.snssdk.com/aweme/v1/playwm/?video_id=v0300fd10000bu2n3qrmli63dmqukmf0&ratio=720p&line=0';
const String mV8= 'https://aweme.snssdk.com/aweme/v1/playwm/?video_id=v0200fc40000bu2itpou7drglvbs0e70&ratio=720p&line=0';

class UserVideo {
  final String url;
  final String image;
  final String desc;

  UserVideo({
    this.url: mockVideo,
    this.image: mockImage,
    this.desc,
  });

  static UserVideo get test =>
      UserVideo(image: '', url: mV2, desc: 'MV_TEST_2');

  static List<UserVideo> fetchVideo() {
    List<UserVideo> list = [];
    list.add(UserVideo(image: 'assets/images/pic_1.jpg', url: mV1, desc: '111111111111111111111'));
    list.add(UserVideo(image: 'assets/images/pic_2.jpg', url: mV2, desc: '222222222222222222222222222'));
    list.add(UserVideo(image: 'assets/images/pic_3.jpg', url: mV3, desc: '3333333333333333333333333'));
    list.add(UserVideo(image: 'assets/images/pic_4.jpg', url: mV4, desc: '44444444444444444'));
    return list;
  }


  @override
  String toString() {
    return 'image:$image' '\nvideo:$url';
  }
}
