import TaskInfo from '../../viewmodel/TaskInfo'
import TaskItem from './TaskItem'
import TaskModel from '../../model/TaskModel'

@Component
export default struct TaskList {
  // 总任务数量
  @Link totalTask: number
  @Link finishTask: number
  // 任务数组
  @State tasks: TaskInfo[] = []

  idx: number = 1
  // 任务信息弹窗
  dialogController: CustomDialogController = new CustomDialogController({
    builder: TaskInfoDialog({onTaskConfirm: this.handleAddTask.bind(this)}),
  })

  aboutToAppear() {
    //TODO 查询任务列表
    console.log('testTag', '初始化组件，查询任务列表')
    // 更新任务状态
    this.handleTaskChange()
  }

  handleTaskChange(){
    // 1.更新任务总数量
    this.totalTask = this.tasks.length
    // 2.更新已完成任务数量
    this.finishTask = this.tasks.filter(item => item.finished).length
  }

  handleAddTask(name: string) {
    // TODO 1.新增任务
    console.log('testTag', '处理新增任务: ', name)
    // 回显到数组页面
    this.tasks.push(new TaskInfo(this.idx++, name))
    // 2.更新任务完成状态
    this.handleTaskChange()
    // 3.关闭对话框
    this.dialogController.close()

  }

  build() {
    Column(){
      // 1.新增任务按钮
      Button('新增任务')
        .width(200)
        .margin({bottom: 10})
        .onClick(() => {
          // 打开新增表单对话框
          this.dialogController.open()
        })

      // 2.任务列表
      List({space: 10}){
        ForEach(
          this.tasks,
          (item: TaskInfo, index) => {
            ListItem(){
              TaskItem({item: item as TaskInfo, onTaskChange: this.handleTaskChange.bind(this)})
            }
            .swipeAction({end: this.DeleteButton(index, item.id)})
          }
        )
      }
      .width('100%')
      .layoutWeight(1)
      .alignListItem(ListItemAlign.Center)
    }
  }

  @Builder
  DeleteButton(index: number, id: number) {
    Button() {
      Image($r('app.media.ic_public_delete_filled'))
        .fillColor(Color.White)
        .width(20)
    }
    .width(40)
    .height(40)
    .type(ButtonType.Circle)
    .backgroundColor(Color.Red)
    .margin(5)
    .onClick(() => {
      //TODO 删除任务
      this.tasks.splice(index, 1)
      console.log('testTag', `尝试删除任务，index: ${index}`)
      this.handleTaskChange()
    })
  }
}

//弹窗按钮
@CustomDialog
struct TaskInfoDialog{

  name: string = ''
  onTaskConfirm : (name: string) => void
  controller: CustomDialogController

  build(){
    Column({space: 20}){
      TextInput({placeholder: '输入任务名'})
        .onChange(val => this.name = val)
      Row(){
        Button('确定')
          .onClick(() => {
            this.onTaskConfirm(this.name)
          })
        Button('取消')
          .backgroundColor(Color.Grey)
          .onClick(() => {
            this.controller.close()
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
    }
    .width('100%')
    .padding(20)
  }
}