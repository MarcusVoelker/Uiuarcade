~ "ir.ua" ~ AExpr BExpr Frag
~ "cfa.ua" ~ CFA
~ "dfa.ua" ~ Run‼!

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

Compare ← ∧×:1≡˜∊⊙¤
Join    ← ⍜∩°□(◴⊂)

Run ← Run‼!(PhiEdge|Compare|Join)⊙⊙CFA~Reverse
