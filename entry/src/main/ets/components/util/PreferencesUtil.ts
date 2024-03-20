import preferences from '@ohos.data.preferences';


class PreferencesUtil{

  //更加方便使得一个上下文里存储对应多个preferences实例 一个preferences实例对应多个key-value
  prefMap: Map<string, preferences.Preferences> = new Map()

  //同步方法：第一步首先将该方法标记为异步方法：也就是说这个方法将来会被异步处理，然后在这个方法内部我们就可以去同步调用了
  async  loadPreference(context,name:string){
    //异步方法：创建preferences
    // preferences.getPreferences(context,name)
    //   .then(pref=>{
    //     this.prefMap.set(name,pref)
    //     console.log('testTag', `加载Preferences[${name}]成功`)
    //   })
    //   .catch(reason=>{
    //     console.log('testTag', `加载Preferences[${name}]失败`, JSON.stringify(reason))
    //   })

    //同步方法：第二步preferences.getPreferences(context,name)方法返回是promise
    //那么这个promise它是一个将来的结果,但是我现在不想要将来结果,我想等,等到你加载成功为止,所以要加await关键字，等待结果返回
    //所以pref是直接就拿到了结果
    try {
      //成功
      let pref = await preferences.getPreferences(context, name)
      this.prefMap.set(name, pref)
      console.log('testTag', `加载Preferences[${name}]成功`)
    } catch (e) {
      //失败
      console.log('testTag', `加载Preferences[${name}]失败`, JSON.stringify(e))
    }
  }

  //添加数据
  async putPreferenceValue(name: string, key: string, value: preferences.ValueType){
    if (!this.prefMap.has(name)) {
      console.log('testTag', `Preferences[${name}]尚未初始化！`)
      return
    }
    try {
      let pref = this.prefMap.get(name)
      // 写入数据
      await pref.put(key, value)
      // 刷盘
      await pref.flush()
      console.log('testTag', `保存Preferences[${name}.${key} = ${value}]成功`)
    } catch (e) {
      console.log('testTag', `保存Preferences[${name}.${key} = ${value}]失败`, JSON.stringify(e))
    }
  }

  //获取数据
  async getPreferenceValue(name: string, key: string, defaultValue: preferences.ValueType){
    if (!this.prefMap.has(name)) {
      console.log('testTag', `Preferences[${name}]尚未初始化！`)
      return
    }
    try {
      let pref = this.prefMap.get(name)
      // 读数据
      let value = await pref.get(key, defaultValue)
      console.log('testTag', `读取Preferences[${name}.${key} = ${value}]成功`)
      return value
    } catch (e) {
      console.log('testTag', `读取Preferences[${name}.${key} ]失败`, JSON.stringify(e))
    }
  }

}

const preferencesUtil = new PreferencesUtil()

export default preferencesUtil as PreferencesUtil



