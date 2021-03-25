open Belt
open ReactNative

let space = 20.

type size =
  | XXL
  | XL
  | L
  | M
  | S
  | XS
  | XXS
  | Custom(float)
  | None

let size = x =>
  switch x {
  | XXL => Some(space *. 4.)
  | XL => Some(space *. 3.)
  | L => Some(space *. 2.)
  | M => Some(space *. 1.)
  | S => Some(space *. 3. /. 4.)
  | XS => Some(space *. 2. /. 4.)
  | XXS => Some(space *. 1. /. 4.)
  | Custom(value) => Some(value)
  | None => None
  }

@react.component
let make = (
  ~vertical: size=M,
  ~horizontal: size=M,
  ~style as styl=?,
  ~pointerEvents=#auto,
  ~children,
) =>
  <View
    style={
      open Style
      arrayOption([
        vertical->size->Option.map(s => style(~paddingVertical=s->dp, ())),
        horizontal->size->Option.map(s => style(~paddingHorizontal=s->dp, ())),
        styl,
      ])
    }
    pointerEvents>
    children
  </View>
