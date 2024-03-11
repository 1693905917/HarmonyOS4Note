@Component
export struct Header{
  build(){
    Row(){
      Image($r('app.media.ic_public_back'))
        .width(30)
      Text('商品列表')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
      Blank() //就是在这个容器内部,你们的其他元素占有了一定的空间,那剩下没有沾满的，我一个人给你撑满
      Image($r('app.media.ic_public_refresh'))
        .width(30)
    }
    .width('100%')
    //.margin({bottom:20}) //既然是公共组件，到底这个标题跟其他的外界之间距离设置，由用这个组件的人来自定义
    .height(30)  //给予“商品列表”一个固定长度
  }
}