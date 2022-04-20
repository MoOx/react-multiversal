open ReactNative
open ReactNative.Style

type weight = [
  | #bold
  | #normal
  | #_100
  | #_200
  | #_300
  | #_400
  | #_500
  | #_600
  | #_700
  | #_800
  | #_900
]

let thin = #_100
let ultralight = #_200
let light = #_300
let regular = #_400
let medium = #_500
let semibold = #_600
let bold = #_700
let heavy = #_800
let black = #_900

// Font weight mapping explanation:
// iOS: no comment, weight are perfect
// Android: only has 100/300/400/500/700/900
// it's a fucking total mess depanding on brands...
// Oppo (ColorsOS) is supposed to have roboto (which it has, but doesn't handle all fontName/fontWeight exactly like Pixel)
// OnePlus have 6 variants like Roboto, but in practise, it's impossible (using generic sans-serif-* variant name) to have a similar mapping
// some render sans-serif-bold without weight as regular, when some with fontWeight 700 as heavy
// and each OS flavor have their own weirdness
// Recap feeling (according to mapping below made on
//    stock: vanilla android (pixel 3)
//    colorsos: oppo A15
//    oxygenos: oneplus n100
// key | st. | oppo | 1+
// 100 | 100 | 100 | 200
// 200 | 300 | 300 | 300
// 300 | 300 | 300 | 300
// 400 | 400 | 400 | 400
// 500 | 500 | 500 | 500
// 600 | 500 | 500 | 500
// 700 | 700 | 700 | 700
// 800 | 700 | 700 | 900
// 900 | 800 | 800 | 900

// This is a map that can safely be used on all platforms
// when a weight is not available, it will be mapped to the closest one

module Weight = {
  type props = {family: string, weight: weight}

  let props = weight =>
    if Platform.os === Platform.android {
      switch weight {
      | #_100 => {family: "sans-serif-thin", weight: #_100}
      | #_200 => {family: "sans-serif-light", weight: #_200}
      | #_300 => {family: "sans-serif-light", weight: #_300}
      | #normal
      | #_400 => {family: "sans-serif", weight: #_400}
      | #_500 => {family: "sans-serif-medium", weight: #_500}
      | #bold
      | #_600 => {family: "sans-serif-medium", weight: #_600}
      // reminder: oneplus handle sans-serif-regular / 700 != sans-serif / 700 !!
      | #_700 => {family: "sans-serif-regular", weight: #_700}
      | #_800 => {family: "sans-serif-bold", weight: #_700}
      | #_900 => {family: "sans-serif-black", weight: #_900}
      }
    } else {
      switch weight {
      | #_100 => {family: "System", weight: #_100}
      | #_200 => {family: "System", weight: #_200}
      | #_300 => {family: "System", weight: #_300}
      | #normal
      | #_400 => {family: "System", weight: #_400}
      | #_500 => {family: "System", weight: #_500}
      | #bold
      | #_600 => {family: "System", weight: #_600}
      | #_700 => {family: "System", weight: #_700}
      | #_800 => {family: "System", weight: #_800}
      | #_900 => {family: "System", weight: #_900}
      }
    }

  let propsToStyle = ({family, weight}) => textStyle(~fontFamily=family, ~fontWeight=weight, ())
}
// stylesheets
let weight = {
  open Weight
  {
    // numeric
    "100": #_100->props->propsToStyle,
    "200": #_200->props->propsToStyle,
    "300": #_300->props->propsToStyle,
    "400": #_400->props->propsToStyle,
    "500": #_500->props->propsToStyle,
    "600": #_600->props->propsToStyle,
    "700": #_700->props->propsToStyle,
    "800": #_800->props->propsToStyle,
    "900": #_900->props->propsToStyle,
    // named
    "thin": #_100->props->propsToStyle,
    "ultralight": #_200->props->propsToStyle,
    "light": #_300->props->propsToStyle,
    "regular": #_400->props->propsToStyle,
    "medium": #_500->props->propsToStyle,
    "semibold": #_600->props->propsToStyle,
    "bold": #_700->props->propsToStyle,
    "heavy": #_800->props->propsToStyle,
    "black": #_900->props->propsToStyle,
  }
}->StyleSheet.create

module Size = {
  type props = {size: float, line: float, spacing: float, weight: weight, weightEm: weight}
  // Apple HIG for macOS
  // https://developer.apple.com/design/human-interface-guidelines/macos/visual-design/typography/
  /* unused for now, really focused on Desktop App, which is different from Desktop Website
  module Macos = {
    let largeTitle = {size: 26., line: 32., spacing: 0.22, weight: regular, weightEm: bold}
    let title1 = {size: 22., line: 26., spacing: -0.26, weight: regular, weightEm: bold}
    let title2 = {size: 17., line: 22., spacing: -0.43, weight: regular, weightEm: bold}
    let title3 = {size: 15., line: 20., spacing: -0.23, weight: regular, weightEm: semibold}
    let headline = {size: 13., line: 16., spacing: -0.08, weight: bold, weightEm: heavy}
    let subhead = {size: 11., line: 14., spacing: 0.06, weight: regular, weightEm: semibold}
    let body = {size: 13., line: 16., spacing: -0.08, weight: regular, weightEm: semibold}
    let callout = {size: 12., line: 15., spacing: 0.0, weight: regular, weightEm: semibold}
    let footnote = {size: 10., line: 13., spacing: 0.12, weight: regular, weightEm: semibold}
    let caption1 = {size: 10., line: 13., spacing: 0.12, weight: regular, weightEm: medium}
    let caption2 = {size: 10., line: 13., spacing: 0.12, weight: medium, weightEm: semibold}
  }
 */
  // Apple HIG for iOS
  // https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/typography/
  module Ios = {
    let s = v => Platform.os === Platform.ios ? v : 0.
    let largeTitle = {size: 34., line: 41., spacing: 0.40->s, weight: regular, weightEm: bold}
    let title1 = {size: 28., line: 34., spacing: 0.38->s, weight: regular, weightEm: bold}
    let title2 = {size: 22., line: 28., spacing: -0.26->s, weight: regular, weightEm: bold}
    let title3 = {size: 20., line: 25., spacing: -0.45->s, weight: regular, weightEm: semibold}
    let headline = {size: 17., line: 22., spacing: -0.43->s, weight: semibold, weightEm: heavy}
    let body = {size: 17., line: 22., spacing: -0.43->s, weight: regular, weightEm: semibold}
    let callout = {size: 16., line: 21., spacing: -0.31->s, weight: regular, weightEm: semibold}
    let subhead = {size: 15., line: 20., spacing: -0.23->s, weight: regular, weightEm: semibold}
    let footnote = {size: 13., line: 18., spacing: -0.08->s, weight: regular, weightEm: semibold}
    let caption1 = {size: 12., line: 16., spacing: 0.0->s, weight: regular, weightEm: medium}
    let caption2 = {size: 11., line: 13., spacing: 0.06->s, weight: regular, weightEm: semibold}
  }
  // Google Material Design
  // https://material.io/design/typography/the-type-system.html#type-scale
  module Android = {
    let l = v => v *. 1.2
    // line = nothing defined, web guide show "normal", which is approx 1.2
    let headline1 = {size: 96., line: 96.->l, spacing: -1.5, weight: light, weightEm: medium}
    let headline2 = {size: 60., line: 60.->l, spacing: -0.5, weight: light, weightEm: medium}
    let headline3 = {size: 48., line: 48.->l, spacing: 0., weight: regular, weightEm: bold}
    let headline4 = {size: 34., line: 34.->l, spacing: 0.25, weight: regular, weightEm: bold}
    let headline5 = {size: 24., line: 24.->l, spacing: 0., weight: regular, weightEm: bold}
    let headline6 = {size: 20., line: 20.->l, spacing: 0.15, weight: medium, weightEm: semibold}
    let subtitle1 = {size: 16., line: 16.->l, spacing: 0.15, weight: regular, weightEm: semibold}
    let subtitle2 = {size: 14., line: 14.->l, spacing: 0.1, weight: regular, weightEm: semibold}
    let body1 = {size: 16., line: 16.->l, spacing: 0.5, weight: regular, weightEm: medium}
    let body2 = {size: 14., line: 14.->l, spacing: 0.25, weight: regular, weightEm: medium}
    let button = {size: 14., line: 14.->l, spacing: 1.25, weight: medium, weightEm: semibold}
    let caption = {size: 12., line: 12.->l, spacing: 0.4, weight: regular, weightEm: medium}
    let overline = {size: 10., line: 10.->l, spacing: 1.5, weight: regular, weightEm: medium}
  }

  // lets do this: allow people to use HIG or MD naming on any platform
  type all = {
    largeTitle: props,
    title1: props,
    title2: props,
    title3: props,
    headline: props,
    body: props,
    callout: props,
    subhead: props,
    footnote: props,
    caption1: props,
    caption2: props,
    headline1: props,
    headline2: props,
    headline3: props,
    headline4: props,
    headline5: props,
    headline6: props,
    subtitle1: props,
    subtitle2: props,
    body1: props,
    body2: props,
    button: props,
    caption: props,
    overline: props,
  }
  let ios = {
    // Apple HIG mapping
    largeTitle: Ios.largeTitle,
    title1: Ios.title1,
    title2: Ios.title2,
    title3: Ios.title3,
    headline: Ios.headline,
    body: Ios.body,
    callout: Ios.callout,
    subhead: Ios.subhead,
    footnote: Ios.footnote,
    caption1: Ios.caption1,
    caption2: Ios.caption2,
    // Google Material Design inversed mapping
    headline1: Ios.largeTitle, // @todo ?
    headline2: Ios.largeTitle, // @todo ?
    headline3: Ios.largeTitle,
    headline4: Ios.title1,
    headline5: Ios.title2,
    headline6: Ios.title3,
    subtitle1: Ios.headline,
    subtitle2: Ios.subhead,
    body1: Ios.body,
    body2: Ios.callout,
    button: Ios.callout, // @todo ?
    caption: Ios.caption1,
    overline: {size: 14., line: 16., spacing: 0.06, weight: regular, weightEm: semibold},
  }
  let android = {
    // Apple HIG mapping (inversed)
    largeTitle: Android.headline3,
    title1: Android.headline4,
    title2: Android.headline5,
    title3: Android.headline6,
    headline: Android.subtitle1,
    body: Android.body1,
    callout: Android.button,
    subhead: Android.subtitle2,
    footnote: Android.caption,
    caption1: Android.caption,
    caption2: Android.caption,
    // Google Material Design
    headline1: Android.headline1,
    headline2: Android.headline2,
    headline3: Android.headline3,
    headline4: Android.headline4,
    headline5: Android.headline5,
    headline6: Android.headline6,
    subtitle1: Android.subtitle1,
    subtitle2: Android.subtitle2,
    body1: Android.body1,
    body2: Android.body2,
    button: Android.button,
    caption: Android.caption,
    overline: Android.overline,
  }
  let propsToStyle = ({size, line, spacing, weight: w}) => {
    let {family, weight} = w->Weight.props
    textStyle(
      ~fontSize=size,
      ~lineHeight=line,
      ~letterSpacing=spacing,
      ~fontWeight=weight,
      ~fontFamily=family,
      (),
    )
  }
  let propsToStyleEm = ({size, line, spacing, weightEm: w}) => {
    let {family, weight} = w->Weight.props
    textStyle(
      ~fontSize=size,
      ~lineHeight=line,
      ~letterSpacing=spacing,
      ~fontWeight=weight,
      ~fontFamily=family,
      (),
    )
  }
}

let ios = {
  "largeTitle": Size.ios.largeTitle->Size.propsToStyle,
  "title1": Size.ios.title1->Size.propsToStyle,
  "title2": Size.ios.title2->Size.propsToStyle,
  "title3": Size.ios.title3->Size.propsToStyle,
  "headline": Size.ios.headline->Size.propsToStyle,
  "body": Size.ios.body->Size.propsToStyle,
  "callout": Size.ios.callout->Size.propsToStyle,
  "subhead": Size.ios.subhead->Size.propsToStyle,
  "footnote": Size.ios.footnote->Size.propsToStyle,
  "caption1": Size.ios.caption1->Size.propsToStyle,
  "caption2": Size.ios.caption2->Size.propsToStyle,
  "headline1": Size.ios.headline1->Size.propsToStyle,
  "headline2": Size.ios.headline2->Size.propsToStyle,
  "headline3": Size.ios.headline3->Size.propsToStyle,
  "headline4": Size.ios.headline4->Size.propsToStyle,
  "headline5": Size.ios.headline5->Size.propsToStyle,
  "headline6": Size.ios.headline6->Size.propsToStyle,
  "subtitle1": Size.ios.subtitle1->Size.propsToStyle,
  "subtitle2": Size.ios.subtitle2->Size.propsToStyle,
  "body1": Size.ios.body1->Size.propsToStyle,
  "body2": Size.ios.body2->Size.propsToStyle,
  "button": Size.ios.button->Size.propsToStyle,
  "caption": Size.ios.caption->Size.propsToStyle,
  "overline": Size.ios.overline->Size.propsToStyle,
}->StyleSheet.create
let android = {
  "largeTitle": Size.android.largeTitle->Size.propsToStyle,
  "title1": Size.android.title1->Size.propsToStyle,
  "title2": Size.android.title2->Size.propsToStyle,
  "title3": Size.android.title3->Size.propsToStyle,
  "headline": Size.android.headline->Size.propsToStyle,
  "body": Size.android.body->Size.propsToStyle,
  "callout": Size.android.callout->Size.propsToStyle,
  "subhead": Size.android.subhead->Size.propsToStyle,
  "footnote": Size.android.footnote->Size.propsToStyle,
  "caption1": Size.android.caption1->Size.propsToStyle,
  "caption2": Size.android.caption2->Size.propsToStyle,
  "headline1": Size.android.headline1->Size.propsToStyle,
  "headline2": Size.android.headline2->Size.propsToStyle,
  "headline3": Size.android.headline3->Size.propsToStyle,
  "headline4": Size.android.headline4->Size.propsToStyle,
  "headline5": Size.android.headline5->Size.propsToStyle,
  "headline6": Size.android.headline6->Size.propsToStyle,
  "subtitle1": Size.android.subtitle1->Size.propsToStyle,
  "subtitle2": Size.android.subtitle2->Size.propsToStyle,
  "body1": Size.android.body1->Size.propsToStyle,
  "body2": Size.android.body2->Size.propsToStyle,
  "button": Size.android.button->Size.propsToStyle,
  "caption": Size.android.caption->Size.propsToStyle,
  "overline": Size.android.overline->Size.propsToStyle,
}->StyleSheet.create

let iosEm = {
  "largeTitle": Size.ios.largeTitle->Size.propsToStyleEm,
  "title1": Size.ios.title1->Size.propsToStyleEm,
  "title2": Size.ios.title2->Size.propsToStyleEm,
  "title3": Size.ios.title3->Size.propsToStyleEm,
  "headline": Size.ios.headline->Size.propsToStyleEm,
  "body": Size.ios.body->Size.propsToStyleEm,
  "callout": Size.ios.callout->Size.propsToStyleEm,
  "subhead": Size.ios.subhead->Size.propsToStyleEm,
  "footnote": Size.ios.footnote->Size.propsToStyleEm,
  "caption1": Size.ios.caption1->Size.propsToStyleEm,
  "caption2": Size.ios.caption2->Size.propsToStyleEm,
  "headline1": Size.ios.headline1->Size.propsToStyleEm,
  "headline2": Size.ios.headline2->Size.propsToStyleEm,
  "headline3": Size.ios.headline3->Size.propsToStyleEm,
  "headline4": Size.ios.headline4->Size.propsToStyleEm,
  "headline5": Size.ios.headline5->Size.propsToStyleEm,
  "headline6": Size.ios.headline6->Size.propsToStyleEm,
  "subtitle1": Size.ios.subtitle1->Size.propsToStyleEm,
  "subtitle2": Size.ios.subtitle2->Size.propsToStyleEm,
  "body1": Size.ios.body1->Size.propsToStyleEm,
  "body2": Size.ios.body2->Size.propsToStyleEm,
  "button": Size.ios.button->Size.propsToStyleEm,
  "caption": Size.ios.caption->Size.propsToStyleEm,
  "overline": Size.ios.overline->Size.propsToStyleEm,
}->StyleSheet.create

let androidEm = {
  "largeTitle": Size.android.largeTitle->Size.propsToStyleEm,
  "title1": Size.android.title1->Size.propsToStyleEm,
  "title2": Size.android.title2->Size.propsToStyleEm,
  "title3": Size.android.title3->Size.propsToStyleEm,
  "headline": Size.android.headline->Size.propsToStyleEm,
  "body": Size.android.body->Size.propsToStyleEm,
  "callout": Size.android.callout->Size.propsToStyleEm,
  "subhead": Size.android.subhead->Size.propsToStyleEm,
  "footnote": Size.android.footnote->Size.propsToStyleEm,
  "caption1": Size.android.caption1->Size.propsToStyleEm,
  "caption2": Size.android.caption2->Size.propsToStyleEm,
  "headline1": Size.android.headline1->Size.propsToStyleEm,
  "headline2": Size.android.headline2->Size.propsToStyleEm,
  "headline3": Size.android.headline3->Size.propsToStyleEm,
  "headline4": Size.android.headline4->Size.propsToStyleEm,
  "headline5": Size.android.headline5->Size.propsToStyleEm,
  "headline6": Size.android.headline6->Size.propsToStyleEm,
  "subtitle1": Size.android.subtitle1->Size.propsToStyleEm,
  "subtitle2": Size.android.subtitle2->Size.propsToStyleEm,
  "body1": Size.android.body1->Size.propsToStyleEm,
  "body2": Size.android.body2->Size.propsToStyleEm,
  "button": Size.android.button->Size.propsToStyleEm,
  "caption": Size.android.caption->Size.propsToStyleEm,
  "overline": Size.android.overline->Size.propsToStyleEm,
}->StyleSheet.create

// @todo for the web, we should use this
// https://webkit.org/blog/3709/using-the-system-font-in-web-content/
// font: -apple-system-body
// font: -apple-system-headline
// font: -apple-system-subhead
// font: -apple-system-caption1
// font: -apple-system-caption2
// font: -apple-system-footnote
// font: -apple-system-short-body
// font: -apple-system-short-headline
// font: -apple-system-short-subhead
// font: -apple-system-short-caption1
// font: -apple-system-short-footnote
// font: -apple-system-tall-body 
