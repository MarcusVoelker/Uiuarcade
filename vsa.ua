~ "ir.ua" ~ AExpr BExpr Frag
~ "cfa.ua" ~ CFA
~ "dfa.ua" ~ Run‼‼

IAdd   ← +
ISub   ← -⊙⇌
ITimes ← [⊃/↧/↥]⊞×
INot ← (
  ⍣([]°[]
  | [1 1] °[0 0]
  | [⊃(0|×⊃(≤0⊢|≥0⊣))]
  )
)

Valuate ← |2 (
  ⍣(get□°AExpr~Variable
  | ⊟.°AExpr~Constant
  | IAdd ∩⌟Valuate°AExpr~Plus
  | ISub ∩⌟Valuate°AExpr~Minus
  | ITimes ∩⌟Valuate°AExpr~Times
  | INot¬Valuate°AExpr~Not
  )
)

PhiSkip ← °Frag~Skip◌◌
PhiAssign ← (
  °Frag~Assign◌◌
)
PhiAssume ← (
  ◌°Frag~Assume◌◌
)
PhiIO ← (
  ⊙⊙°Frag~IO
)

PhiEdge ← (
  CFA~Edge~Label
  ⊃(⋅⋅⊙∘|⊙⊙⋅◌)
  ⍜°□◴⍣(PhiSkip|PhiAssign|PhiAssume|PhiIO)
)

Compare ← ∧×:1≡˜∊⊙¤
Join    ← ⍜∩°□(◴⊂)
Iota ← (
  °CFA
  map⟜≡(□{}◌)CFA~Vertices
)

Run ← Run‼‼(PhiEdge|Iota|Compare|Join)
