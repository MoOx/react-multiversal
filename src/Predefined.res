open ReactNative

let isClient: bool = %raw(`typeof window !== "undefined"`)

// https://github.com/necolas/react-native-web/pull/1351
let hairlineWidth = isClient
  ? {
      let hairlineWidth = PixelRatio.roundToNearestPixel(0.4)
      if hairlineWidth === 0. {
        1. /. PixelRatio.get()
      } else {
        hairlineWidth
      }

      // don't use 1 because I guess most people have retina
      // at least the scope I have...
      // @todo allow to config that
    }
  : 0.5
// beside this, some browser round to 0 something like 0.3333333333, instead of 0.34...)
let hairlineWidthMaxPrecision = 6.
let hairlineWidth =
  Js.Math.round(hairlineWidth *. 10. ** hairlineWidthMaxPrecision) /.
  10. ** hairlineWidthMaxPrecision

// https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/typography/
// module Fonts = {
//   open Style;
//   Style	Weight	Size (Points)	Leading (Points)	Tracking (1/1000em)
//   Large Title	Regular	34	41	+11
//   Title 1	Regular	28	34	+13
//   Title 2	Regular	22	28	+16
//   Title 3	Regular	20	25	+19
//   Headline	Semi-Bold	17	22	-24
//   Body	Regular	17	22	-24
//   Callout	Regular	16	21	-20
//   Subhead	Regular	15	20	-16
//   Footnote	Regular	13	18	-6
//   Caption 1	Regular	12	16	0
//   Caption 2	Regular	11	13	+6
// };

// https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/color/
module Colors = {
  let black = "#000"
  let dark = "rgb(51, 51, 51)"
  let white = "#fff"
  let grey = "#909192"
  let lightGrey = "rgb(242, 242, 242)"
  let separator = "#A2A9AC"

  // https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/color/
  module Ios = {
    type t = {
      blue: string,
      green: string,
      indigo: string,
      orange: string,
      pink: string,
      purple: string,
      red: string,
      teal: string,
      yellow: string,
      gray: string,
      gray2: string,
      gray3: string,
      gray4: string,
      gray5: string,
      gray6: string,
    }

    let light = {
      blue: "rgb(0,122,255)",
      green: "rgb(52,199,89)",
      indigo: "rgb(88,86,214)",
      orange: "rgb(255,149,0)",
      pink: "rgb(255,45,85)",
      purple: "rgb(175,82,222)",
      red: "rgb(255,59,48)",
      teal: "rgb(90,200,250)",
      yellow: "rgb(255,204,0)",
      gray: "rgb(142,142,147)",
      gray2: "rgb(174,174,178)",
      gray3: "rgb(199,199,204)",
      gray4: "rgb(209,209,214)",
      gray5: "rgb(229,229,234)",
      gray6: "rgb(242,242,247)",
    }

    let dark = {
      blue: "rgb(10,132,255)",
      green: "rgb(48,209,88)",
      indigo: "rgb(94,92,230)",
      orange: "rgb(255,159,10)",
      pink: "rgb(255,55,95)",
      purple: "rgb(191,90,242)",
      red: "rgb(255,69,58)",
      teal: "rgb(100,210,255)",
      yellow: "rgb(255,214,10)",
      gray: "rgb(142,142,147)",
      gray2: "rgb(99,99,102)",
      gray3: "rgb(72,72,74)",
      gray4: "rgb(58,58,60)",
      gray5: "rgb(44,44,46)",
      gray6: "rgb(28,28,30)",
    }
  }
}

let styles = {
  open Style
  {
    "flex": style(~flexGrow=1., ~flexShrink=1., ()),
    "flex1": style(~flexGrow=1., ~flexShrink=1., ~flexBasis=0.->Style.dp, ()),
    "flexGrow": style(~flexGrow=1., ()),
    "flexShrink": style(~flexShrink=1., ()),
    "center": style(~alignItems=#center, ~justifyContent=#center, ()),
    "justifyCenter": style(~justifyContent=#center, ()),
    "justifyStart": style(~justifyContent=#flexStart, ()),
    "justifyEnd": style(~justifyContent=#flexEnd, ()),
    "alignCenter": style(~alignItems=#center, ()),
    "alignStart": style(~alignItems=#flexStart, ()),
    "alignEnd": style(~alignItems=#flexEnd, ()),
    "col": style(~flexDirection=#column, ()),
    "colCenter": style(~flexDirection=#column, ~justifyContent=#center, ~alignItems=#center, ()),
    "colSpaceBetween": style(
      ~flexDirection=#column,
      ~justifyContent=#spaceBetween,
      ~alignItems=#center,
      (),
    ),
    "row": style(~flexDirection=#row, ()),
    "rowCenter": style(~flexDirection=#row, ~justifyContent=#center, ~alignItems=#center, ()),
    "rowSpaceBetween": style(
      ~flexDirection=#row,
      ~justifyContent=#spaceBetween,
      ~alignItems=#center,
      (),
    ),
    "rowWrap": style(~flexDirection=#row, ~flexWrap=#wrap, ()),
    "rowWrapCenter": style(
      ~flexDirection=#row,
      ~flexWrap=#wrap,
      ~justifyContent=#center,
      ~alignItems=#center,
      (),
    ),
    "rowWrapSpaceBetween": style(
      ~flexDirection=#row,
      ~flexWrap=#wrap,
      ~justifyContent=#spaceBetween,
      ~alignItems=#center,
      (),
    ),
  }
}->StyleSheet.create
