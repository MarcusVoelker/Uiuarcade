# Experimental!
~ "ir.ua" ~ AExpr And Asgn BExpr Constant Equals Greater IO If Minus Plus Seq Skip Stmt Times Variable While

D ↚ ×⊃(≥@0|≤@9)
L ↚ ∨∩×⊃(≥@A|≤@Z|≥@a|≤@z)

MakeToken ↚ (
  K ← {"skip" "if" "then" "else" "fi" "IO" "while" "do" "od"}
  ⍣({0 ˜⊗K} ⍤.⊸∊K
  | {1 ∘} ⍤.L◇⊸⊢
  | {2 ⋕} ⍤.D◇⊸⊢
  | {3 ˜⊗{":=" ";" "+" "-" "*" "=" ">" ">=" "<" "<=" "?" "!" "&&" "(" ")"}}
  )
)

TRun ↚ (
  AT ← ⊂⊃(°□⊡₂)⊡₀◌
  SW! ← {⊃(¤|^0|AT)}
  CC! ← {⊃(˜◇⊂⊙⊡₀|^0|°□⋅⊡₂)}
  GC‼! ← ⍣(
    {""0AT}⊸°@ 
  | ^0⍤.⊸L
  | ^1⍤.⊸D
  | ^2
  )
  {"" 0 []}
  ˜∧(⨬(
      GC‼!CC!1CC!2CC!3
    | GC‼!CC!1CC!1SW!3
    | GC‼!SW!1CC!2SW!3
    | GC‼!SW!1SW!2CC!3
    )◡⋅(°□⊡1))
  ⊸(°□⊡1)
  ⍣(°□⊡2°0
  | ⊂⊃(°□⊡2)⊡₀◌
  )
  ≡MakeToken
)

PAx ↚ |1.2 (
  ⍣(Variable °{1∘} °⊂
  | Constant °{2∘} °⊂
  | :°(⊂{3 14}) : PAx °{3 13} °⊂
  | AExpr~Not PAx °{3 11} °⊂
  )
  ⍣(Plus⊙(⍩PAx°{3 2}°⊂)
  | Minus⊙(⍩PAx°{3 3}°⊂)
  | Times⊙(⍩PAx°{3 4}°⊂)
  | ∘
  )
)
PBx ↚ |1.2 (
  ⍣(:°{3 14}°⊂:PBx°{3 13}°⊂
  | BExpr~Not PBx°{3 11}°⊂
  | Equals⊙(⍩PAx°(⊂{3 5}))PAx
  | Greater⊙(⍩PAx°(⊂{3 6}))PAx
  )
  ⍣(And⊙(⍩PBx°(⊂{3 12})))
)
PI! ↚ :⊙(If:⊙::)°{0 4}°⊂:^0°{0 3}°⊂:^0°{0 2}°⊂:PBx
PW! ↚ :⊙(While:)°{0 8}°⊂:^0°{0 7}°⊂:PBx
PA  ↚ Asgn⊙(PAx°{3 0}°⊂)°{1∘}°⊂
PS ↚ |1.2 (
  °⊂
  ⍣(⍩PI!PS°{0 1}
  | ⍩PW!PS°{0 6}
  | IO°{0 5}
  | Skip°{0 0}
  | ⍩PA⊂
  )
  ⍣(Seq⊙(PS°{3 1}°⊂))
)

Run ← ⊙(⍤"Did not consume full input"=1⧻)PS˜⊂{4 0}TRun

Run "IO;while 16 > x1y do if x = 0 then x := x + 1 else skip fi od"
