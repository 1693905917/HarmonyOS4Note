import {Header} from '../components/components/CommonComponents'
class Person{
  name:string
  age:number
  gf:Person

  constructor(name:string,age:number,gf?: Person) {//gf可选
    this.name=name;
    this.age=age;
    this.gf=gf;
  }
}
@Entry
@Component
struct StatePage {
  idx:number=1
  @State p:Person=new Person('Jack',21,new Person('Rose',18))
  @State gfs:Person[]=[
    new Person('柔丝',18),
    new Person('露西',19)
  ]
  build() {
    Column() {
      Header({title:'女友列表'}).margin({bottom:20})
      Text(`${this.p.name} : ${this.p.age}`)
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .onClick(()=>{
          this.p.age++;
        }).fontColor('#36D')
      Button('添加').onClick(()=>{
          this.gfs.push(new Person('女友'+this.idx++,20)) //给数组添加新元素方法
        })
      Text('=女友列表=').fontSize(50).fontWeight(FontWeight.Bold)
      ForEach(
        this.gfs,
        (p,index)=> {
         Row(){
           Text(`${p.name} : ${p.age}`)
             .fontSize(30)
             .fontWeight(FontWeight.Bold)
             .onClick(() => {
               // this.p.age++;
               this.gfs[index]=new Person(p.name,p.age+1)
             })
             .fontColor('#36D')
           Button('删除').onClick(() => {
               this.gfs.splice(index, 1) //给数组删除对应索引下的数据，并且只删一个
             })
         }.width('100%').justifyContent(FlexAlign.SpaceAround)
        }
      )
    }
    .width('100%')
    .height('100%')
    .padding(20)
  }
}