import { Header } from '../components/components/CommonComponents'
import ShopInfo from  '../viewmodel/ShopInfo'
import ShopItem from '../views/ShopItem'
import ShopModel from '../model/ShopModel'
@Entry
@Component
struct ShopPage {
  @State shops: ShopInfo[] = []
  isLoading: boolean = false
  isMore: boolean = true
  //aboutToAppear是生命周期钩子的一个方法 之前讲过
  aboutToAppear() {
    // 加载商品数据
    this.loadShopInfo()
  }
  build() {
    Column({ space: 10 }) {
      Header({ title: '商铺列表' })
      List({ space: 10 }) {
        ForEach(this.shops, shop => {
          ListItem() {
            ShopItem({ shop: shop })
          }
        })
      }
      .width('100%')
      .layoutWeight(1)
      //onReachEnd()细说：
      //1.当列表刷到低时触发的事件，这个事件一般会触发两次，刷到低时一次，鼠标放到又会触发一次
      //2.所以我们要只需要一次触发时进行数据请求操作
      .onReachEnd(() => {
        console.log('触底了！')
        //3.!this.isLoading:上面声明isLoading: boolean = false防止发生触发事件中发送两次数据请求操作
        //4.this.isMore:防止数据已经查到低了就停止查询数据操作
        if(!this.isLoading && this.isMore){
          this.isLoading = true
          // 翻页
          ShopModel.pageNo++
          this.loadShopInfo()
        }
      })
    }
    .width('100%')
    .height('100%')
    .padding(10)
    .backgroundColor('#e1e2e3')
  }
  loadShopInfo() {
    //加载数据
    ShopModel.getShopList()
      .then(shops=>{
        //给图片加上服务器地址前缀
        shops.forEach(s => {
          s.images.forEach((src, i) => {
            s.images[i] = 'http://localhost:3000' + src
          })
        })
        this.shops = this.shops.concat(shops);//实现将查询到的新数据拼接到原有数据的后面
        this.isLoading=false; //为下一次查询数据做好准备
        if(!shops||shops.length===0){//当查询的数据已经到最后一页时就停止查询
          this.isMore=false;
        }
      })

  }
}