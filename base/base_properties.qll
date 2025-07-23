signature predicate genericPropertyKindPred(string name, string description, boolean is_matching);
signature predicate genericPropertyPred(string value, string kind_name);

module MakePropertyKind<genericPropertyKindPred/3 kindPredicate>
{
    class PropertyKind extends string
    {
        private final string description;
        private final boolean is_matching;
        PropertyKind(){
            kindPredicate(this,description, is_matching)
        }
        string getName(){result=this}
        string getDescription(){result=description}
        boolean isMatching(){result=is_matching}
    }
}


module GenericProperty<genericPropertyKindPred/3 kindPredicate, genericPropertyPred/2 propPredicate>
{
    import MakePropertyKind<kindPredicate/3>

    class Property extends string
    {
        private final PropertyKind kind;
        Property(){
            propPredicate(this, kind.getName())
        }
        string getValue(){result=this}
        PropertyKind getKind(){result = kind}
    }
}