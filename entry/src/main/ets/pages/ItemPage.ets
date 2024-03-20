class Item {
  name: string
  image: ResourceStr
  price: number
  discount:number

  //对于参数discount:number=0的解释：当没有折扣，我默认是0，当然如果有传入的值就用传入的，没有就默认为0
  constructor(name: string, image: ResourceStr, price: number,discount:number=0) {
    this.name = name
    this.image = image
    this.price = price
    this.discount=discount
  }
}
// @Component
// struct Header{
//   build(){
//     Row(){
//       Image($r('app.media.ic_public_back'))
//         .width(30)
//       Text('商品列表')
//         .fontSize(30)
//         .fontWeight(FontWeight.Bold)
//       Blank() //就是在这个容器内部,你们的其他元素占有了一定的空间,那剩下没有沾满的，我一个人给你撑满
//       Image($r('app.media.ic_public_refresh'))
//         .width(30)
//     }
//     .width('100%')
//     //.margin({bottom:20}) //既然是公共组件，到底这个标题跟其他的外界之间距离设置，由用这个组件的人来自定义
//     .height(30)  //给予“商品列表”一个固定长度
//   }
// }
import {Header} from '../components/components/CommonComponents'

//全局自定义构建函数
// @Builder
// function ItemCard(item: Item) {
//   Row({ space: 10 }) {
//     Image(item.image)
//       .width(100)
//     Column({ space: 4 }) {
//       Text(item.name)
//         .fontSize(20)
//         .fontWeight(FontWeight.Bold)
//       //利用之前所学习到的在TypeScript中，空字符串、数字0、null、undefined.
//       //都被认为是false,其它值则为true
//       if (item.discount) {
//         Text('原价：￥ ' + item.price)
//           .fontColor('#CCC')//字体变灰色
//           .fontSize(14)//将字体变小
//           .decoration({ type: TextDecorationType.LineThrough }) //添加删除线
//         Text('折扣价：￥ ' + (item.price - item.discount))
//           .fontColor('#F36')
//           .fontSize(18)
//         Text('补贴￥ ' + item.discount)
//           .fontColor('#F36')
//           .fontSize(18)
//       } else {
//         Text('￥ ' + item.price)
//           .fontColor('#F36')
//           .fontSize(18)
//       }
//     }.height('100%')
//     .width('100%')
//     .alignItems(HorizontalAlign.Start)
//   }
// }
//全局公共样式函数
// @Styles function fillScreen(){
//   .width('100%')
//   .height('100%')
//   .backgroundColor('#EFEFEF')
//   .padding(20)
// }

@Extend(Text) function priceText(){
  .fontColor('#F36')
  .fontSize(18)
}
@Entry
@Component
struct ItemPage {
  // 商品数据
  private items: Array<Item> = [
    //增加折扣
    new Item('华为Mate60', $r('app.media.mate60'),6999,500),
    new Item('MateBookProX', $r('app.media.mateBookProX'),13999),
    new Item('WatchGT4', $r('app.media.watchGT4'),1438),
    new Item('FreeBuds Pro3', $r('app.media.freeBudsPro3'),1499),
    new Item('FreeBuds Pro3', $r('app.media.freeBudsPro3'),1499),
    new Item('Mate X5', $r('app.media.mateX5'),12999)
  ]
  build() {
    Column({space: 8}){
      // 商品列表部分
      // Row(){
      //   Image($r('app.media.ic_public_back'))
      //     .width(30)
      //   Text('商品列表')
      //     .fontSize(30)
      //     .fontWeight(FontWeight.Bold)
      //   Blank() //就是在这个容器内部,你们的其他元素占有了一定的空间,那剩下没有沾满的，我一个人给你撑满
      //   Image($r('app.media.ic_public_refresh'))
      //     .width(30)
      // }
      //  .width('100%')
      //  .margin({bottom:20})
      //  .height(30)  //给予“商品列表”一个固定长度
      Header({title:'商品列表'})
        .margin({bottom:20})
      //List:也属于容器
      List({space:8}){
        //ForEach的遍历使用
        ForEach(
          this.items,
          //要想item在item.时有提示，标识表明item的类型 (item:Item)
          (item:Item)=>{
            ListItem(){
              this.ItemCard(item)
            }
            .width('100%')
            .backgroundColor('#FFF')
            .borderRadius(20)
            .height(120)
            .padding(10)
          }
        )
      }.width('100%')
      //layoutWeight：权重比设置，将“商品列表”的高度固定以后，整个手机剩下的高度就归我一个用，默认值为0
      //默认值为0则由于.height(30)来管理
      //如果“商品列表”的layoutWeight也是1，那么咱俩评分手机的高度
      .layoutWeight(1)
    }
    .fillScreen()
    // .width('100%')
    // .height('100%')
    // .backgroundColor('#EFEFEF')
    // .padding(20)
  }
  @Builder
  ItemCard(item: Item) {
    Row({ space: 10 }) {
      Image(item.image)
        .width(100)
      Column({ space: 4 }) {
        Text(item.name)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
        //利用之前所学习到的在TypeScript中，空字符串、数字0、null、undefined.
        //都被认为是false,其它值则为true
        if (item.discount) {
          Text('原价：￥ ' + item.price)
            .fontColor('#CCC')//字体变灰色
            .fontSize(14)//将字体变小
            .decoration({ type: TextDecorationType.LineThrough }) //添加删除线
          Text('折扣价：￥ ' + (item.price - item.discount))
            .priceText()
          Text('补贴￥ ' + item.discount)
            .priceText()
        } else {
          Text('￥ ' + item.price)
            .priceText()
        }
      }.height('100%')
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
  }
  //局部公共样式函数
  @Styles  fillScreen(){
  .width('100%')
  .height('100%')
  .backgroundColor('#EFEFEF')
  .padding(20)
}
}