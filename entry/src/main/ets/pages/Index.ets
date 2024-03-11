@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .onClick(()=>{
            this.message='Hello ArkTS'
          })
          .fontColor('#36D')
        //网络图片
        Image('https://wx4.sinaimg.cn/mw690/006qkfXVly1g40uatj4lsj30sg0sgact.jpg')
          .width(250);

        //本地图片
        // Image($r('app.media.icon')).width(250);
      }
      .width('100%')
    }
    .height('100%')
  }
}