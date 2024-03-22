import notify from '@ohos.notificationManager'
import image from '@ohos.multimedia.image'
import DownloadCard from '../views/notification/DownloadCard'
import { Header } from '../components/components/CommonComponents'

@Entry
@Component
struct NotificationPage {
  // 全局任务id
  idx: number = 100
  // 图象
  pixel: PixelMap

  async aboutToAppear() {
    // 获取资源管理器
    let rm = getContext(this).resourceManager;
    // 读取图片
    let file = await rm.getMediaContent($r('app.media.watchGT4'))
    // 创建PixelMap
    image.createImageSource(file.buffer).createPixelMap()
      .then(value => this.pixel = value)
      .catch(reason => console.log('testTag', '加载图片异常', JSON.stringify(reason)))
  }

  build() {
    Column({space: 20}) {
      Header({title: '通知功能'})

      Button(`发送normalText通知`)
        .onClick(() => this.publishNormalTextNotification())
      Button(`发送longText通知`)
        .onClick(() => this.publishLongTextNotification())
      Button(`发送multiLine通知`)
        .onClick(() => this.publishMultiLineNotification())
      Button(`发送Picture通知`)
        .onClick(() => this.publishPictureNotification())

      // 下载功能卡片
      DownloadCard()
    }
    .width('100%')
    .height('100%')
    .padding(5)
    .backgroundColor('#f1f2f3')
  }

  publishNormalTextNotification() {
    let request: notify.NotificationRequest = {
      id: this.idx++,
      content: {
        //普通文本：就是因为它这个通知的内容，通知内容就是一个简单的单行文本 注意是单行文本
        //而且,这个文本的内容如果太长,超出了通知栏边界的话，它是会把它隐藏掉的，也就是说你都看不全
        contentType: notify.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
        normal: {
          title: '通知标题' + this.idx,
          text: '通知内容详情',
          additionalText: '通知附加内容'
        }
      },
      //showDeliveryTime：就是要不要展示投递时间
      showDeliveryTime: true,
      //deliveryTime:投递时间，也就是你发的这个通知啥时候发的，可以把这个时间给展示出来，deliveryTime需要搭配showDeliveryTime来进行展示
      deliveryTime: new Date().getTime(),
      //groupName作用：就是说我们的通知是可以有分组的一个概念的，默认情况下每个通知都属于自己一个组，
      //所以你会发现这些通知相互之间都是隔离开的,而groupName的作用，如果有多个通知，而它们的他们的group name是一样的，这多个通知就会在一个组内展示的
      groupName: 'wechat',
      //通知提示功能
      slotType: notify.SlotType.SOCIAL_COMMUNICATION
    }
    this.publish(request)
  }

  publishLongTextNotification() {
    let request: notify.NotificationRequest = {
      id: this.idx++,
      content: {
        contentType: notify.ContentType.NOTIFICATION_CONTENT_LONG_TEXT,
        longText: {
          //title是在为点击”展开按钮“之前给你展示的标题
          title: '通知标题' + this.idx,
          text: '通知内容详情',
          additionalText: '通知附加内容',
          longText: '通知中的长文本，我很长，我很长，我很长，我很长，我很长，我很长，我很长',
          briefText: '通知概要和总结', //briefText没啥用
          //expandedTitle是在为点击”展开按钮“之后给你展示的标题
          expandedTitle: '通知展开后的标题' + this.idx
        }
      }
    }
    this.publish(request)
  }

  publishMultiLineNotification() {
    let request: notify.NotificationRequest = {
      id: this.idx++,
      content: {
        contentType: notify.ContentType.NOTIFICATION_CONTENT_MULTILINE,
        multiLine: {
          //title是在为点击”展开按钮“之前给你展示的标题
          title: '通知标题' + this.idx,
          text: '通知内容详情',
          additionalText: '通知附加内容',
          briefText: '通知概要和总结',//briefText没啥用
          //longTitle是在为点击”展开按钮“之后给你展示的标题
          longTitle: '展开时的标题，我很宽，我很宽，我很宽',
          lines: [
            '第一行',
            '第二行',
            '第三行',
            '第四行',
          ]
        }
      }
    }
    this.publish(request)
  }

  publishPictureNotification() {
    let request: notify.NotificationRequest = {
      id: this.idx++,
      content: {
        contentType: notify.ContentType.NOTIFICATION_CONTENT_PICTURE,
        picture: {
          //title是在为点击”展开按钮“之前给你展示的标题
          title: '通知标题' + this.idx,
          text: '通知内容详情',
          additionalText: '通知附加内容',
          briefText: '通知概要和总结',//briefText没啥用
          //expandedTitle是在为点击”展开按钮“之后给你展示的标题
          expandedTitle: '展开后标题' + this.idx,
          //这里图片资源获取是利用我们之前学习图片资源获取的第二种方式：像素图
          picture: this.pixel
        }
      }
    }
    this.publish(request)
  }

  private publish(request: notify.NotificationRequest) {
    notify.publish(request)
      .then(() => console.log('notify test', '发送通知成功'))
      .then(reason => console.log('notify test', '发送通知失败', JSON.stringify(reason)))
  }
}