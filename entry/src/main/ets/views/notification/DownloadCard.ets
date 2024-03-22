import notify from '@ohos.notificationManager'
import wantAgent, { WantAgent } from '@ohos.app.ability.wantAgent'
import promptAction from '@ohos.promptAction'

enum DownloadState {
  NOT_BEGIN = '未开始',
  DOWNLOADING = '下载中',
  PAUSE = '已暂停',
  FINISHED = '已完成',
}

@Component
export default struct DownloadCard {
  // 下载进度
  @State progressValue: number = 0
  progressMaxValue: number = 100
  // 任务状态
  @State state: DownloadState = DownloadState.NOT_BEGIN

  // 下载的文件名
  filename: string = '圣诞星.mp4'

  // 模拟下载的任务的id
  taskId: number = -1

  // 通知id
  notificationId: number = 999

  isSupport: boolean = false

  wantAgentInstance: WantAgent

  async aboutToAppear(){
    // 1.判断当前系统是否支持进度条模板
    this.isSupport = await notify.isSupportTemplate('downloadTemplate')
    // 2.创建拉取当前应用的行为意图
    // 2.1.创建wantInfo信息
    let wantInfo: wantAgent.WantAgentInfo = {
      wants: [
        {
          bundleName: 'com.example.myapplication',
          abilityName: 'EntryAbility',
        }
      ],
      requestCode: 0,
      operationType: wantAgent.OperationType.START_ABILITY,
      wantAgentFlags: [wantAgent.WantAgentFlags.CONSTANT_FLAG]
    }
    // 2.2.创建wantAgent实例
    this.wantAgentInstance = await wantAgent.getWantAgent(wantInfo)
  }

  build() {
    Row({ space: 10 }) {
      Image($r('app.media.ic_files_video')).width(50)
      Column({ space: 5 }) {
        Row() {
          Text(this.filename)
          Text(`${this.progressValue}%`).fontColor('#c1c2c1')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

        Progress({
          value: this.progressValue,
          total: this.progressMaxValue,
        })

        Row({ space: 5 }) {
          Text(`${(this.progressValue * 0.43).toFixed(2)}MB`)
            .fontSize(14).fontColor('#c1c2c1')
          Blank()
          if (this.state === DownloadState.NOT_BEGIN) {
            Button('开始').downloadButton()
              .onClick(() => this.download())

          } else if (this.state === DownloadState.DOWNLOADING) {
            Button('取消').downloadButton().backgroundColor('#d1d2d3')
              .onClick(() => this.cancel())

            Button('暂停').downloadButton()
              .onClick(() => this.pause())

          } else if (this.state === DownloadState.PAUSE) {
            Button('取消').downloadButton().backgroundColor('#d1d2d3')
              .onClick(() => this.cancel())

            Button('继续').downloadButton()
              .onClick(() => this.download())
          } else {
            Button('打开').downloadButton()
              .onClick(() => this.open())
          }
        }.width('100%')
      }
      .layoutWeight(1)
    }
    .width('100%')
    .borderRadius(20)
    .padding(15)
    .backgroundColor(Color.White)
  }


  cancel() {
    // 取消定时任务
    if(this.taskId > 0){
      clearInterval(this.taskId);
      this.taskId = -1
    }
    // 清理下载任务进度
    this.progressValue = 0
    // 标记任务状态：未开始
    this.state = DownloadState.NOT_BEGIN
    // 取消通知
    notify.cancel(this.notificationId)
  }

  download() {
    // 清理旧任务
    if(this.taskId > 0){
      clearInterval(this.taskId);
    }
    // 开启定时任务，模拟下载
    this.taskId = setInterval(() => {
      // 判断任务进度是否达到100
      if(this.progressValue >= 100){
        // 任务完成了，应该取消定时任务
        clearInterval(this.taskId)
        this.taskId = -1
        // 并且标记任务状态为已完成
        this.state = DownloadState.FINISHED
        // 发送通知
        this.publishDownloadNotification()
        return
      }
      // 模拟任务进度变更
      this.progressValue += 2
      // 发送通知
      this.publishDownloadNotification()
    }, 500)
    // 标记任务状态：下载中
    this.state = DownloadState.DOWNLOADING
  }

  pause() {
    // 取消定时任务
    if(this.taskId > 0){
      clearInterval(this.taskId);
      this.taskId = -1
    }
    // 标记任务状态：已暂停
    this.state = DownloadState.PAUSE
    // 发送通知
    this.publishDownloadNotification()
  }

  open() {
    promptAction.showToast({
      message: '功能未实现'
    })
  }

  publishDownloadNotification(){
    // 1.判断当前系统是否支持进度条模板
    if(!this.isSupport){
      // 当前系统不支持进度条模板
      return
    }
    // 2.准备进度条模板的参数
    let template = {
      name: 'downloadTemplate',
      data: {
        progressValue: this.progressValue,
        progressMaxValue: this.progressMaxValue
      }
    }
    let request: notify.NotificationRequest = {
      id: this.notificationId,
      template: template,
      wantAgent: this.wantAgentInstance,
      content: {
        contentType: notify.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
        normal: {
          title: this.filename + ':  ' + this.state,
          text: '',
          additionalText: this.progressValue + '%'
        }
      }
    }
    // 3.发送通知
    notify.publish(request)
      .then(() => console.log('test', '通知发送成功'))
      .catch(reason => console.log('test', '通知发送失败！', JSON.stringify(reason)))
  }
}

@Extend(Button) function downloadButton() {
  .width(75).height(28).fontSize(14)
}