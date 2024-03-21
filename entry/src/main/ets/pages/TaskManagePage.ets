import { Header } from '../components/components/CommonComponents'
import TaskList from '../views/task/TaskList'
import TaskStatistics from '../views/task/TaskStatistics'

@Entry
@Component
struct TaskManagePage {
  @State totalTask: number = 0
  @State finishTask: number = 0

  build() {
    Column({space: 10}){
      // 1.顶部导航
      Header()
      // 2.任务进度卡片
      TaskStatistics({totalTask: this.totalTask, finishTask: this.finishTask})
      // 3.任务列表
      TaskList({totalTask: $totalTask, finishTask: $finishTask})
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F2F3')
  }
}
