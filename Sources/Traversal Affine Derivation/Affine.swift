import Optic

@attached(member, names: arbitrary)
public macro Affine() = #externalMacro(
    module: "Traversal_Affine_Derivation_Macros",
    type: "Macro"
)
