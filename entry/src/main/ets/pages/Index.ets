import router from '@ohos.router';
import RouterItem from '../views/RouterItem'
import IndexFontSizePanel from '../views/IndexFontSizePanel'
import PreferencesUtil from '../components/util/PreferencesUtil'
import RouterInfo from '../viewmodel/RouterInfo'

const routers: RouterInfo[] = [
  new RouterInfo('pages/ImagePage', '图片查看案例'),
  new RouterInfo('pages/ItemPage', '商品列表案例'),
  new RouterInfo('pages/StatePage', 'Jack和他的女友案例'),
  new RouterInfo('pages/PropPage', '任务列表案例'),
  new RouterInfo('pages/AnimationPage', '小鱼动画案例'),
  new RouterInfo('pages/LifeCirclePage', '生命周期案例1'),
  new RouterInfo('pages/TestPage1', '生命周期案例2'),
  new RouterInfo('pages/DocumentListPage', 'UIAbility启动模式案例'),
  new RouterInfo('pages/ShopPage', '查询商铺案例'),
  new RouterInfo('pages/TaskManagePage', '任务列表持久化案例')
]

@Entry
@Component
struct Index {
  @State message: string = '页面列表'
  @State showPanel: boolean = false
  //数据同步修改，父与子操作：与IndexFontSizePanel.ets中的@Consume fontSize: number同步
  @Provide fontSize: number = 16


  async aboutToAppear(){
    //为什么要as number？
    // 答：PreferencesUtil.getPreferenceValue('MyPreferences', 'IndexFontSize', 16)返回的是preferences.ValueType类型的数据
    //所以要进行数据类型转换
    this.fontSize = await PreferencesUtil.getPreferenceValue('MyPreferences', 'IndexFontSize', 16) as number
  }

  build() {
    Column() {
      // 顶部标题
      this.Title()

      // 导航列表
      this.RouterList()

      // 字体修改面板
      if(this.showPanel){
        IndexFontSizePanel()
          .transition({
            translate: { y: 115 }
          })
      }
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  Title() {
    Row() {
      Text(this.message)
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .height(80)
      Image($r('app.media.ic_public_settings'))
        .width(30)
        .onClick(() => {
          animateTo({ duration: 500, curve: Curve.EaseOut }, () => this.showPanel = !this.showPanel)
        })
    }
    .justifyContent(FlexAlign.SpaceAround)
    .width('100%')
  }

  @Builder
  RouterList() {
    List({ space: 15 }) {
      ForEach(
        routers,
        (router, index) => {
          ListItem() {
            RouterItem({ r: router, i: index + 1 })
          }
        }
      )
    }
    .layoutWeight(1)
    .alignListItem(ListItemAlign.Center)
    .width('100%')
  }
}