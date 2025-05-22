┌─╴AExpr
  |Variable {Name}
  |Constant {Value}
  |Plus {Lhs Rhs}
  |Minus {Lhs Rhs}
  |Times {Lhs Rhs}
  |Not {Arg}
└─╴
┌─╴BExpr
  |Equals {Lhs Rhs}
  |Greater {Lhs Rhs}
  |And {Lhs Rhs}
  |Not {Arg}
└─╴
┌─╴Stmt
  |Skip
  |Asgn {Lhs Rhs}
  |Seq {Lhs Rhs}
  |If {Cond Then Else}
  |While {Cond Body}
  |IO
└─╴
┌─╴Frag
  |Skip
  |Assign {Lhs Rhs}
  |Assume {Cond}
  |IO
└─╴

Variable ← AExpr~Variable
Constant ← AExpr~Constant
Plus     ← AExpr~Plus
Minus    ← AExpr~Minus
Times    ← AExpr~Times
Equals   ← BExpr~Equals
Greater  ← BExpr~Greater
And      ← BExpr~And
Skip     ← Stmt~Skip
Asgn     ← Stmt~Asgn
Seq      ← Stmt~Seq
If       ← Stmt~If
While    ← Stmt~While
IO       ← Stmt~IO
