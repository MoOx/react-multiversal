open ReactNative
open ReactNative.Style

type acceptedMode = [#light | #dark | #auto]
type t = [#light | #dark]

type themed<'t> = {
  light: 't,
  dark: 't,
}

type styleSheet<'s> = 's
type styleSheets<'s> = themed<styleSheet<'s>>

type colorMap = {
  back: string,
  backDark: string,
  main: string,
  text: string,
  textLight1: string,
  textLight2: string,
  textOnDarkLight: string,
  textOnMain: string,
}

type fullColorMap = {
  systemBlue: string,
  systemGreen: string,
  systemIndigo: string,
  systemOrange: string,
  systemPink: string,
  systemPurple: string,
  systemRed: string,
  systemTeal: string,
  systemYellow: string,
  systemGray: string,
  systemGray2: string,
  systemGray3: string,
  systemGray4: string,
  systemGray5: string,
  systemGray6: string,
  back: string,
  backDark: string,
  main: string,
  text: string,
  textLight1: string,
  textLight2: string,
  textOnDarkLight: string,
  textOnMain: string,
}

type themedColors = themed<colorMap>

type theme<'c> = {
  mode: t,
  styles: styleSheet<'c>,
  colors: fullColorMap,
}

type themes<'a> = themed<theme<'a>>

module type T = {
  let colors: themedColors
}

module Default = {
  let colors = {
    light: {
      back: "#fff",
      backDark: "#f2f2f7",
      main: Predefined.Colors.Ios.light.indigo,
      text: "#111",
      textLight1: Predefined.Colors.Ios.light.gray,
      textLight2: Predefined.Colors.Ios.light.gray2,
      textOnDarkLight: "rgba(0,0,0,0.5)",
      textOnMain: "#fff",
    },
    dark: {
      back: Predefined.Colors.Ios.dark.gray6,
      backDark: "#000",
      main: Predefined.Colors.Ios.dark.indigo,
      text: "rgba(255,255,255,0.98)",
      textLight1: Predefined.Colors.Ios.light.gray,
      textLight2: Predefined.Colors.Ios.light.gray2,
      textOnDarkLight: "rgba(255,255,255,0.5)",
      textOnMain: "rgba(255,255,255,0.98)",
    },
  }
}

let htmlKey = "react-multiversal"
let htmlId = htmlKey ++ "--root"
let htmlCssId = htmlKey ++ "-css"

module MakeTheme = (Th: T) => {
  include Th
  let webCss = ref("")
  let colorsLight = {
    systemBlue: Predefined.Colors.Ios.light.blue,
    systemGreen: Predefined.Colors.Ios.light.green,
    systemIndigo: Predefined.Colors.Ios.light.indigo,
    systemOrange: Predefined.Colors.Ios.light.orange,
    systemPink: Predefined.Colors.Ios.light.pink,
    systemPurple: Predefined.Colors.Ios.light.purple,
    systemRed: Predefined.Colors.Ios.light.red,
    systemTeal: Predefined.Colors.Ios.light.teal,
    systemYellow: Predefined.Colors.Ios.light.yellow,
    systemGray: Predefined.Colors.Ios.light.gray,
    systemGray2: Predefined.Colors.Ios.light.gray2,
    systemGray3: Predefined.Colors.Ios.light.gray3,
    systemGray4: Predefined.Colors.Ios.light.gray4,
    systemGray5: Predefined.Colors.Ios.light.gray5,
    systemGray6: Predefined.Colors.Ios.light.gray6,
    back: Th.colors.light.back,
    backDark: Th.colors.light.backDark,
    main: Th.colors.light.main,
    text: Th.colors.light.text,
    textLight1: Th.colors.light.textLight1,
    textLight2: Th.colors.light.textLight2,
    textOnDarkLight: Th.colors.light.textOnDarkLight,
    textOnMain: Th.colors.light.textOnMain,
  }
  let colorsDark = {
    systemBlue: Predefined.Colors.Ios.dark.blue,
    systemGreen: Predefined.Colors.Ios.dark.green,
    systemIndigo: Predefined.Colors.Ios.dark.indigo,
    systemOrange: Predefined.Colors.Ios.dark.orange,
    systemPink: Predefined.Colors.Ios.dark.pink,
    systemPurple: Predefined.Colors.Ios.dark.purple,
    systemRed: Predefined.Colors.Ios.dark.red,
    systemTeal: Predefined.Colors.Ios.dark.teal,
    systemYellow: Predefined.Colors.Ios.dark.yellow,
    systemGray: Predefined.Colors.Ios.dark.gray,
    systemGray2: Predefined.Colors.Ios.dark.gray2,
    systemGray3: Predefined.Colors.Ios.dark.gray3,
    systemGray4: Predefined.Colors.Ios.dark.gray4,
    systemGray5: Predefined.Colors.Ios.dark.gray5,
    systemGray6: Predefined.Colors.Ios.dark.gray6,
    back: Th.colors.dark.back,
    backDark: Th.colors.dark.backDark,
    main: Th.colors.dark.main,
    text: Th.colors.dark.text,
    textLight1: Th.colors.dark.textLight1,
    textLight2: Th.colors.dark.textLight2,
    textOnDarkLight: Th.colors.dark.textOnDarkLight,
    textOnMain: Th.colors.dark.textOnMain,
  }
  let colorsDynamic = if Platform.os === #web {
    let prefix = `--${htmlKey}-theme-`
    webCss :=
      `
    .${htmlId} {
      ${prefix}systemBlue: ${Predefined.Colors.Ios.light.blue};
      ${prefix}systemGreen: ${Predefined.Colors.Ios.light.green};
      ${prefix}systemIndigo: ${Predefined.Colors.Ios.light.indigo};
      ${prefix}systemOrange: ${Predefined.Colors.Ios.light.orange};
      ${prefix}systemPink: ${Predefined.Colors.Ios.light.pink};
      ${prefix}systemPurple: ${Predefined.Colors.Ios.light.purple};
      ${prefix}systemRed: ${Predefined.Colors.Ios.light.red};
      ${prefix}systemTeal: ${Predefined.Colors.Ios.light.teal};
      ${prefix}systemYellow: ${Predefined.Colors.Ios.light.yellow};
      ${prefix}systemGray: ${Predefined.Colors.Ios.light.gray};
      ${prefix}systemGray2: ${Predefined.Colors.Ios.light.gray2};
      ${prefix}systemGray3: ${Predefined.Colors.Ios.light.gray3};
      ${prefix}systemGray4: ${Predefined.Colors.Ios.light.gray4};
      ${prefix}systemGray5: ${Predefined.Colors.Ios.light.gray5};
      ${prefix}systemGray6: ${Predefined.Colors.Ios.light.gray6};
      ${prefix}back: ${Th.colors.light.back};
      ${prefix}backDark: ${Th.colors.light.backDark};
      ${prefix}main: ${Th.colors.light.main};
      ${prefix}text: ${Th.colors.light.text};
      ${prefix}textLight1: ${Th.colors.light.textLight1};
      ${prefix}textLight2: ${Th.colors.light.textLight2};
      ${prefix}textOnDarkLight: ${Th.colors.light.textOnDarkLight};
      ${prefix}textOnMain: ${Th.colors.light.textOnMain};
    }
    @media (prefers-color-scheme: dark) { .${htmlId} {
      ${prefix}systemBlue: ${Predefined.Colors.Ios.dark.blue};
      ${prefix}systemGreen: ${Predefined.Colors.Ios.dark.green};
      ${prefix}systemIndigo: ${Predefined.Colors.Ios.dark.indigo};
      ${prefix}systemOrange: ${Predefined.Colors.Ios.dark.orange};
      ${prefix}systemPink: ${Predefined.Colors.Ios.dark.pink};
      ${prefix}systemPurple: ${Predefined.Colors.Ios.dark.purple};
      ${prefix}systemRed: ${Predefined.Colors.Ios.dark.red};
      ${prefix}systemTeal: ${Predefined.Colors.Ios.dark.teal};
      ${prefix}systemYellow: ${Predefined.Colors.Ios.dark.yellow};
      ${prefix}systemGray: ${Predefined.Colors.Ios.dark.gray};
      ${prefix}systemGray2: ${Predefined.Colors.Ios.dark.gray2};
      ${prefix}systemGray3: ${Predefined.Colors.Ios.dark.gray3};
      ${prefix}systemGray4: ${Predefined.Colors.Ios.dark.gray4};
      ${prefix}systemGray5: ${Predefined.Colors.Ios.dark.gray5};
      ${prefix}systemGray6: ${Predefined.Colors.Ios.dark.gray6};
      ${prefix}back: ${Th.colors.dark.back};
      ${prefix}backDark: ${Th.colors.dark.backDark};
      ${prefix}main: ${Th.colors.dark.main};
      ${prefix}text: ${Th.colors.dark.text};
      ${prefix}textLight1: ${Th.colors.dark.textLight1};
      ${prefix}textLight2: ${Th.colors.dark.textLight2};
      ${prefix}textOnDarkLight: ${Th.colors.dark.textOnDarkLight};
      ${prefix}textOnMain: ${Th.colors.dark.textOnMain};
    } }
    `
    {
      systemBlue: `var(${prefix}systemBlue)`,
      systemGreen: `var(${prefix}systemGreen)`,
      systemIndigo: `var(${prefix}systemIndigo)`,
      systemOrange: `var(${prefix}systemOrange)`,
      systemPink: `var(${prefix}systemPink)`,
      systemPurple: `var(${prefix}systemPurple)`,
      systemRed: `var(${prefix}systemRed)`,
      systemTeal: `var(${prefix}systemTeal)`,
      systemYellow: `var(${prefix}systemYellow)`,
      systemGray: `var(${prefix}systemGray)`,
      systemGray2: `var(${prefix}systemGray2)`,
      systemGray3: `var(${prefix}systemGray3)`,
      systemGray4: `var(${prefix}systemGray4)`,
      systemGray5: `var(${prefix}systemGray5)`,
      systemGray6: `var(${prefix}systemGray6)`,
      back: `var(${prefix}back)`,
      backDark: `var(${prefix}backDark)`,
      main: `var(${prefix}main)`,
      text: `var(${prefix}text)`,
      textLight1: `var(${prefix}textLight1)`,
      textLight2: `var(${prefix}textLight2)`,
      textOnDarkLight: `var(${prefix}textOnDarkLight)`,
      textOnMain: `var(${prefix}textOnMain)`,
    }
  } else {
    // @todo using PlatformColor ?!
    colorsLight
  }
  let stylesDynamic = {
    "back": viewStyle(~backgroundColor=colorsDynamic.back, ()),
    "backDark": viewStyle(~backgroundColor=colorsDynamic.backDark, ()),
    "backGray": viewStyle(~backgroundColor=colorsDynamic.systemGray, ()),
    "backGray2": viewStyle(~backgroundColor=colorsDynamic.systemGray2, ()),
    "backGray3": viewStyle(~backgroundColor=colorsDynamic.systemGray3, ()),
    "backGray4": viewStyle(~backgroundColor=colorsDynamic.systemGray4, ()),
    "backGray5": viewStyle(~backgroundColor=colorsDynamic.systemGray5, ()),
    "backGray6": viewStyle(~backgroundColor=colorsDynamic.systemGray6, ()),
    "backMain": viewStyle(~backgroundColor=colorsDynamic.main, ()),
    "separatorLightOnBack": viewStyle(~backgroundColor=colorsDynamic.systemGray4, ()),
    "separatorOnBack": viewStyle(~backgroundColor=colorsDynamic.systemGray3, ()),
    "text": textStyle(~color=colorsDynamic.text, ()),
    "textBlue": textStyle(~color=colorsDynamic.systemBlue, ()),
    "textGray": textStyle(~color=colorsDynamic.systemGray, ()),
    "textGray2": textStyle(~color=colorsDynamic.systemGray2, ()),
    "textGray3": textStyle(~color=colorsDynamic.systemGray3, ()),
    "textGray4": textStyle(~color=colorsDynamic.systemGray4, ()),
    "textGray5": textStyle(~color=colorsDynamic.systemGray5, ()),
    "textGray6": textStyle(~color=colorsDynamic.systemGray6, ()),
    "textGreen": textStyle(~color=colorsDynamic.systemGreen, ()),
    "textIndigo": textStyle(~color=colorsDynamic.systemIndigo, ()),
    "textLight1": textStyle(~color=colorsDynamic.textLight1, ()),
    "textLight2": textStyle(~color=colorsDynamic.textLight2, ()),
    "textMain": textStyle(~color=colorsDynamic.main, ()),
    "textOnDarkLight": textStyle(~color=colorsDynamic.textOnDarkLight, ()),
    "textOnMain": textStyle(~color=colorsDynamic.textOnMain, ()),
    "textOrange": textStyle(~color=colorsDynamic.systemOrange, ()),
    "textPink": textStyle(~color=colorsDynamic.systemPink, ()),
    "textPurple": textStyle(~color=colorsDynamic.systemPurple, ()),
    "textRed": textStyle(~color=colorsDynamic.systemRed, ()),
    "textTeal": textStyle(~color=colorsDynamic.systemTeal, ()),
    "textYellow": textStyle(~color=colorsDynamic.systemYellow, ()),
  }->StyleSheet.create
  let stylesLight = {
    "back": viewStyle(~backgroundColor=colorsLight.back, ()),
    "backDark": viewStyle(~backgroundColor=colorsLight.backDark, ()),
    "backGray": viewStyle(~backgroundColor=colorsLight.systemGray, ()),
    "backGray2": viewStyle(~backgroundColor=colorsLight.systemGray2, ()),
    "backGray3": viewStyle(~backgroundColor=colorsLight.systemGray3, ()),
    "backGray4": viewStyle(~backgroundColor=colorsLight.systemGray4, ()),
    "backGray5": viewStyle(~backgroundColor=colorsLight.systemGray5, ()),
    "backGray6": viewStyle(~backgroundColor=colorsLight.systemGray6, ()),
    "backMain": viewStyle(~backgroundColor=colorsLight.main, ()),
    "separatorLightOnBack": viewStyle(~backgroundColor=colorsLight.systemGray4, ()),
    "separatorOnBack": viewStyle(~backgroundColor=colorsLight.systemGray3, ()),
    "text": textStyle(~color=colorsLight.text, ()),
    "textBlue": textStyle(~color=colorsLight.systemBlue, ()),
    "textGray": textStyle(~color=colorsLight.systemGray, ()),
    "textGray2": textStyle(~color=colorsLight.systemGray2, ()),
    "textGray3": textStyle(~color=colorsLight.systemGray3, ()),
    "textGray4": textStyle(~color=colorsLight.systemGray4, ()),
    "textGray5": textStyle(~color=colorsLight.systemGray5, ()),
    "textGray6": textStyle(~color=colorsLight.systemGray6, ()),
    "textGreen": textStyle(~color=colorsLight.systemGreen, ()),
    "textIndigo": textStyle(~color=colorsLight.systemIndigo, ()),
    "textLight1": textStyle(~color=colorsLight.textLight1, ()),
    "textLight2": textStyle(~color=colorsLight.textLight2, ()),
    "textMain": textStyle(~color=colorsLight.main, ()),
    "textOnDarkLight": textStyle(~color=colorsLight.textOnDarkLight, ()),
    "textOnMain": textStyle(~color=colorsLight.textOnMain, ()),
    "textOrange": textStyle(~color=colorsLight.systemOrange, ()),
    "textPink": textStyle(~color=colorsLight.systemPink, ()),
    "textPurple": textStyle(~color=colorsLight.systemPurple, ()),
    "textRed": textStyle(~color=colorsLight.systemRed, ()),
    "textTeal": textStyle(~color=colorsLight.systemTeal, ()),
    "textYellow": textStyle(~color=colorsLight.systemYellow, ()),
  }->StyleSheet.create
  let stylesDark = {
    "back": viewStyle(~backgroundColor=colorsDark.back, ()),
    "backDark": viewStyle(~backgroundColor=colorsDark.backDark, ()),
    "backGray": viewStyle(~backgroundColor=colorsDark.systemGray, ()),
    "backGray2": viewStyle(~backgroundColor=colorsDark.systemGray2, ()),
    "backGray3": viewStyle(~backgroundColor=colorsDark.systemGray3, ()),
    "backGray4": viewStyle(~backgroundColor=colorsDark.systemGray4, ()),
    "backGray5": viewStyle(~backgroundColor=colorsDark.systemGray5, ()),
    "backGray6": viewStyle(~backgroundColor=colorsDark.systemGray6, ()),
    "backMain": viewStyle(~backgroundColor=colorsDark.main, ()),
    "separatorLightOnBack": viewStyle(~backgroundColor=colorsDark.systemGray5, ()),
    "separatorOnBack": viewStyle(~backgroundColor=colorsDark.systemGray4, ()),
    "text": textStyle(~color=colorsDark.text, ()),
    "textBlue": textStyle(~color=colorsDark.systemBlue, ()),
    "textGray": textStyle(~color=colorsDark.systemGray, ()),
    "textGray2": textStyle(~color=colorsDark.systemGray2, ()),
    "textGray3": textStyle(~color=colorsDark.systemGray3, ()),
    "textGray4": textStyle(~color=colorsDark.systemGray4, ()),
    "textGray5": textStyle(~color=colorsDark.systemGray5, ()),
    "textGray6": textStyle(~color=colorsDark.systemGray6, ()),
    "textGreen": textStyle(~color=colorsDark.systemGreen, ()),
    "textIndigo": textStyle(~color=colorsDark.systemIndigo, ()),
    "textLight1": textStyle(~color=colorsDark.textLight1, ()),
    "textLight2": textStyle(~color=colorsDark.textLight2, ()),
    "textMain": textStyle(~color=colorsDark.main, ()),
    "textOnDarkLight": textStyle(~color=colorsDark.textOnDarkLight, ()),
    "textOnMain": textStyle(~color=colorsDark.textOnMain, ()),
    "textOrange": textStyle(~color=colorsDark.systemOrange, ()),
    "textPink": textStyle(~color=colorsDark.systemPink, ()),
    "textPurple": textStyle(~color=colorsDark.systemPurple, ()),
    "textRed": textStyle(~color=colorsDark.systemRed, ()),
    "textTeal": textStyle(~color=colorsDark.systemTeal, ()),
    "textYellow": textStyle(~color=colorsDark.systemYellow, ()),
  }->StyleSheet.create
  let themeLight = {
    mode: #light,
    styles: stylesLight,
    colors: colorsLight,
  }
  let themeDark = {
    mode: #dark,
    styles: stylesDark,
    colors: colorsDark,
  }

  let useTheme = (~mode as currentMode=#auto, ()): theme<'a> => {
    let colorScheme = Appearance.useColorScheme()
    let mode = switch currentMode {
    | #auto =>
      switch colorScheme {
      | Some(#dark) => #dark
      | _ => #light
      }
    | #light => #light
    | #dark => #dark
    }
    if currentMode === #auto && Platform.os === #web {
      {
        mode,
        styles: stylesDynamic,
        colors: colorsDynamic,
      }
    } else {
      switch mode {
      | #light => themeLight
      | #dark => themeDark
      }
    }
  }

  let getThemeStyleSheet = () =>
    <style dangerouslySetInnerHTML={{"__html": webCss.contents}} id={htmlCssId} />

  let getThemeHtmlId = () => htmlId
}

module Radius = {
  let button = 10.
  let card = 6.
}

module StatusBar = {
  @module("react-native") @scope("Platform")
  external versionIos: string = "Version"
  @module("react-native") @scope("Platform")
  external versionAndroid: int = "Version"

  let barsStyle = (theme, barStyle) =>
    switch (theme, barStyle) {
    | (#light, #lightContent) => #"light-content"
    | (#light, #darkContent) => #"dark-content"
    | (#dark, #darkContent) => #"light-content"
    | (#dark, #lightContent) => #"dark-content"
    }

  let barStyle = (theme, barStyle) =>
    switch (theme, barStyle) {
    | (#light, #lightContent) => #lightContent
    | (#light, #darkContent) => #darkContent
    | (#dark, #darkContent) => #lightContent
    | (#dark, #lightContent) => #darkContent
    }

  let isFormSheetSupported = Platform.os === #ios && versionIos > "13"

  let formSheetSafeArea = isFormSheetSupported ? false : true
}
