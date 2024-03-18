import http from '@ohos.net.http'
import ShopInfo from '../viewmodel/ShopInfo'
class ShopModel{
  baseURL: string = 'http://localhost:3000'
  pageNo: number = 1
  //创建方法：我们是异步调用，那么我们这个getShopList函数就应该也是异步返回
  getShopList():Promise<ShopInfo[]>{
    //resolve:通知成功   reject:通知失败
    return new Promise((resolve,reject)=>{
      //1.创建http的请求对象   注意：http.createHttp()是不可复用的，也就是说，创建了一次http请求，下一次需要创建新的http请求
      //一个http请求只能用一次，用过以后需要重新http.createHttp()
      let httpRequest = http.createHttp()
      //2.发送请求
      httpRequest.request(
        `${this.baseURL}/shops?pageNo=${this.pageNo}&pageSize=5`,
        {
          method: http.RequestMethod.GET
        }
      )
        //请求成功
        .then((resp:http.HttpResponse)=>{
          if(resp.responseCode===200){
            //JSON.parse功能：把一个JSON的字符串转成一个对象
            console.log('查询商铺成功！',resp.result)
           resolve(JSON.parse(resp.result.toString())); //通知成功
          }else{
            console.log('查询商铺信息失败！error:',JSON.stringify(resp))
            reject('查询商铺失败')
          }
        })
          //请求失败
        .catch((err:Error)=>{
          //JSON.stringify将err对象转换成字符串
          console.log('查询商铺信息失败！error:',JSON.stringify(err))
          reject('查询商铺失败')
        })
    })
  }
}
//我们直接给它封装好对象，然后再导出
const  shopModel =new ShopModel();
export  default  shopModel as ShopModel;