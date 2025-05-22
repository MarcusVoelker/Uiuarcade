~ "cfa.ua" ~ CFA
~ "ir.ua" ~ AExpr BExpr Frag
Reads ← |1 (
  ⍣({°AExpr~Variable}
  | {}◌°AExpr~Constant
  | ⊂∩Reads°AExpr~Plus
  | ⊂∩Reads°AExpr~Minus
  | ⊂∩Reads°AExpr~Times
  | Reads°AExpr~Not
  | ⊂∩Reads°BExpr~Equals
  | ⊂∩Reads°BExpr~Greater
  | ⊂∩Reads°BExpr~And
  | Reads°BExpr~Not
  )
)

PhiSkip ← °Frag~Skip◌◌
PhiAssign ← (
  ◌◌
  °Frag~Assign
  □⊂⊃(▽¬⊸⌕⊃(□⊙⋅◌|°□⋅⋅∘)|Reads⋅⊙◌)
)
PhiAssume ← (
  ◌◌
  °Frag~Assume
  □⊂Reads⊙°□
)
PhiIO ← (
  ⊙⊙°Frag~IO
  □⊂⊃(▽¬≡⊸∊⊃(¤⊙⋅◌|°□⋅⋅∘)|⋅⊙◌)
)

PhiEdge ← (
  CFA~Edge~Label
  ⊃(⋅⋅⊙∘|⊙⊙⋅◌)
  ⍜°□◴⍣(PhiSkip|PhiAssign|PhiAssume|PhiIO)
)

Run ← (
  ⊙⊙CFA~Reverse
  ⊃(CFA~Edges⋅⋅∘|map⟜≡(□{}◌)CFA~Vertices⋅⋅∘|⊙⊙CFA~Edges)
  ⍢(⊃(PhiEdge ⟜(getCFA~Edge~Source)⊙⋅⊙⊙∘|CFA~Edge~Dest ⊙⊙⊙⊙∘)°⊂
    ◡(¬∧×:1≡˜∊⊙¤⊙get⊙⊙⋅∘)
    ⨬(◌◌
    | ⊃(◴⊂⊃(▽⊸(=⊙≡CFA~Edge~Source)⊙⋅∘|⋅⊙◌)⋅⊙⊙⋅⋅⋅∘
      | ⍜get⍜∩°□(◴⊂)⊃⋅⊙⋅∘⊙⋅⋅◌
      | ⋅⋅⋅⋅⊙⊙∘)
    )
  | ±⧻)
  ⋅⊙⋅⋅◌
)
