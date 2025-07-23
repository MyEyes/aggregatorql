bindingset[this]
abstract class BaseTag extends string
{
    abstract string getName();
    abstract string getShortName();
    abstract string getColor();
    abstract string getDescription();
}

signature predicate genericTagPred(string name, string shortname, string color, string description);

module GenericTag<genericTagPred/4 tagPredicate>
{
    class Tag extends string
    {
        private final string shortname;
        private final string color;
        private final string description;
        Tag(){
            tagPredicate(this,shortname,color,description)
        }
        string getName(){result=this}
        string getShortName(){result = shortname}

        string getColor(){result=color}
        string getDescription(){result=description}
    }
}

predicate isDefaultTag(string name, string shortname, string color, string description)
{
    (name = "open" and shortname = "open" and color="lightblue" and description="Not yet manually inspected")
    or (name = "rejected" and shortname = "rejected" and color="darkred" and description="False positive")
    or (name = "accepted" and shortname = "accepted" and color="darkgreen" and description="True positive")
    or (name = "codeql" and shortname = "cql" and color="purple" and description="Submitted from codeQL")
    or (name = "function" and shortname = "func" and color="purple" and description="Is a function")
    or (name = "file" and shortname = "file" and color="purple" and description="Is a file")
    or (name = "dir" and shortname = "dir" and color="purple" and description="Is a directory")
}