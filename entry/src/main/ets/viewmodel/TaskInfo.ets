//TaskInfo它由于需要去做这个数据的一个双向绑定，因为它在数组里边，为了让我们在遍历过程中能够监测到这个对象变化所以加了@Observed
@Observed
export default class TaskInfo{
  id: number
  // 任务名称
  name: string
  // 任务状态：是否完成
  finished: boolean

  constructor(id: number, name: string) {
    this.id = id
    this.name = name
    this.finished = false
  }
}