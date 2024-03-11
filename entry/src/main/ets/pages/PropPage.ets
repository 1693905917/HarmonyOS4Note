//任务表
class Task{
  static id:number=1
  //任务名称
  name:string =`任务${Task.id++}`
  //任务状态：是否完成
  finished:boolean=false
}

//统一的卡片样式
@Styles function card(){
  .width('95%')
  .padding(20)
  .backgroundColor(Color.White)
  .borderRadius(15)
  .shadow({radius:6,color:'#1F000000',offsetX:2,offsetY:4})
}

//任务完成样式
@Extend(Text) function finishedTask(){
  .decoration({type:TextDecorationType.LineThrough})//删除线
  .fontColor('#B1B2B1')
}


@Entry
@Component
struct PropPage{
  //总任务数量
  @State totalTask:number=0
  //己完成任务数量
  @State finishTask:number=0
  //任务数组
  @State tasks:Task[]=[]

  build(){
    Column({space:10}){
      //1.任务角度卡片
      Row(){
        Text('任务进度')
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
        Stack(){ //叠加容器
          Progress({
            value:this.finishTask,
            total:this.totalTask,
            type:ProgressType.Ring //环形圆环样式
          }).width(100)
          Row(){
            Text(this.finishTask.toString())
              .fontSize(24)
              .fontColor('#36D')
            Text('/'+this.totalTask.toString())
              .fontSize(24)
          }
        }
      }
      .card()//卡片样式背景
      .margin({top:20,bottom:10})
      .justifyContent(FlexAlign.SpaceEvenly)

      //2.新增任务按钮
      Button('新增任务')
        .width(200)
        .onClick(()=>{
          //1.新增任务数据
          this.tasks.push(new Task())
          //2.更新任务总数量
          this.handleTaskChange()
        })
      //3.任务列表
      List({space:10}){ //实现动态滑动
        ForEach(
          this.tasks,
          (item:Task,index)=>{
            ListItem(){
              Row(){
              Text(item.name)
                .fontSize(20)
              Checkbox()
                .select(item.finished)
                .onChange(val=>{
                  //1.更新当前任务状态
                  item.finished=val;
                  //2.更新已完成任务数量
                  this.handleTaskChange()
                })
            }
            .card()//卡片样式背景
            .justifyContent(FlexAlign.SpaceBetween)
            }
            .swipeAction({
              end:this.DeleteButton(index)
            })
          }
        )
      }
      .alignListItem(ListItemAlign.Center).width('100%').layoutWeight(1)
    }.width('100%').height('100%').backgroundColor('@F1F2F3')
  }
  @Builder DeleteButton(index:number){
    Button(){
      Image($r('app.media.ic_public_delete_filled'))
        .fillColor(Color.White)
        .width(20)
    }
    .width(40)
    .height(40)
    .type(ButtonType.Circle)
    .backgroundColor(Color.Red)
    .margin(5)
    .onClick(()=>{
      this.tasks.splice(index,1)
      this.handleTaskChange()
    })
  }



  handleTaskChange(){
    //1.更新任务总数量
    this.totalTask=this.tasks.length
    //2.更新已完成任务数量
    this.finishTask=this.tasks.filter(item=>item.finished).length;//将任务已经完成的过滤出来
  }
}