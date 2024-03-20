import PreferencesUtil from '../components/util/PreferencesUtil'

@Component
export default struct IndexFontSizePanel {
  @Consume fontSize: number
  fontSizLabel: object = {
    14: '小',
    16: '标准',
    18: '大',
    20: '特大',
  }

  build() {
    Column() {
      Text(this.fontSizLabel[this.fontSize]).fontSize(20)
      Row({ space: 5 }) {
        Text('A').fontSize(14).fontWeight(FontWeight.Bold)
        Slider({
          min: 14,
          max: 20,
          step: 2,
          value: this.fontSize
        })
          .showSteps(true)
          .trackThickness(6)
          .layoutWeight(1)
          .onChange(val => {
            // 修改字体大小
            this.fontSize = val
            // 写入Preferences
            PreferencesUtil.putPreferenceValue('MyPreferences', 'IndexFontSize', val)
          })
        Text('A').fontSize(20).fontWeight(FontWeight.Bold)
      }.width('100%')
    }
    .width('100%')
    .padding(15)
    .backgroundColor('#fff1f0f0')
    .borderRadius(20)
  }
}