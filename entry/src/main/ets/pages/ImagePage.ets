import {Header} from '../components/components/CommonComponents'
@Entry
@Component
struct Index {
  @State imageWidth: number = 150;

  build() {
    //整个大框架应该是从上而下的Column组件
    Column() {
      Header({title:'图片案例'})
        .margin({bottom:20})
      Row(){
        //本地图片
        Image($r('app.media.icon'))
          .width(this.imageWidth)
          .interpolation(ImageInterpolation.High)
      }.width('100%')
      .height(400)
      // .backgroundColor("#36D")
      .justifyContent(FlexAlign.Center)

      Row(){
        Text($r('app.string.Width_label'))
          .fontSize(20)
          .fontWeight(FontWeight.Bold);
        //.toFixed(0)将整型转换为字符串类型并且给予的参数0表示保留0位小数
        TextInput({text:this.imageWidth.toFixed(0)})
          .width(150)
           .backgroundColor('#FFF')
          .type(InputType.Number)
          .onChange( value=>{
            this.imageWidth=parseInt(value)
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      // .padding(20)//第一种：直接给padding方法里添加数值参数，是对于四个方向的距离都是20
      .padding({left:20,right:20})//第二种：指定哪个边的距离进行调整即可

      Divider().width('91%')//内置组件：分割线

      Row(){
        Button('缩小')
          .width(80)
          .fontSize(20)
          .onClick(()=>{
            if(this.imageWidth>=10){
              this.imageWidth-=10;
            }
          })
        Button('放大')
          .width(80)
          .fontSize(20)
          .onClick(()=>{
            if(this.imageWidth<300){
              this.imageWidth+=10;
            }
          })
      }.width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .margin({ top:35,bottom:35})//外边距设置属性：margin  设置参数方法与padding相类似


      Slider({
        min:100,
        max:300,
        value:this.imageWidth,
        step:10
      })
        .width('100%')
        .blockColor('#36D')
        .trackThickness(7)//设置滑轨的粗细
        .showTips(true)
        .onChange(value=>{
          this.imageWidth=value
        })
    }
    .width('100%')
    .height('100%')
  }
} 