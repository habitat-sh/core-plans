@{
    # Excluded PSScriptAnalyzer rules
    #
    # Rule: PSUseDeclaredVarsMoreThanAssignments
    # Reason: Plan variables in plan.ps1 are flagged as unused variables
    ExcludeRules=@('PSUseDeclaredVarsMoreThanAssignments')
}