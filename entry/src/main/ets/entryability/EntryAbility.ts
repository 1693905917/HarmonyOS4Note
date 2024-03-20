import AbilityConstant from '@ohos.app.ability.AbilityConstant';
import hilog from '@ohos.hilog';
import UIAbility from '@ohos.app.ability.UIAbility';
import Want from '@ohos.app.ability.Want';
import window from '@ohos.window';
import PreferencesUtil from '../components/util/PreferencesUtil'

export default class EntryAbility extends UIAbility {
 async  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam){
    //0x0000,'testTag'的作用都是一样的，就是个用来标识的一个参数，
    // 也就是，你在将来不同的模块里，你可以用不同的一个标识的一个数字，将来在查日志的时候，可以用0x0000,'testTag'来进行过滤处当前模块的运行日志
    //'%{public}s':%s相当于我们的转义字符，将后面的'Ability onCreate'给打印出来，而{public}可以设置，这个信息是否要出现在日志中，如果是public就是可以公开显示，如果是private则会隐藏
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
   await PreferencesUtil.loadPreference(this.context,"MyPreferences")
  }

  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    windowStage.loadContent('pages/Index', (err, data) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
