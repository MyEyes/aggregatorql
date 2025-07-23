signature module TagPropSig
{
    class Tag
    {
        //Name of the tag
        string getName();
        //Short name of the tag
        string getShortName();
        //Description of the tag (optional)
        string getDescription();
        //Color of the tag
        string getColor();
    }

    class PropertyKind
    {
        //Name of this kind of property
        string getName();
        //Optional description of this kind of property
        string getDescription();
        //Should this kind of property be used to match results and subjects
        boolean isMatching();
    }

    class Property
    {
        //Value of this property instance
        string getValue();
        //Kind/Type of this property instance
        PropertyKind getKind();
    }
}

signature module TagPropSubjSig
{
    class Tag
    {
        //Name of the tag
        string getName();
        //Short name of the tag
        string getShortName();
        //Description of the tag (optional)
        string getDescription();
        //Color of the tag
        string getColor();
    }

    class PropertyKind
    {
        //Name of this kind of property
        string getName();
        //Optional description of this kind of property
        string getDescription();
        //Should this kind of property be used to match results and subjects
        boolean isMatching();
    }

    class Property
    {
        //Value of this property instance
        string getValue();
        //Kind/Type of this property instance
        PropertyKind getKind();
    }

    class Subject{
        //Name of the subject
        string getName();
        //Value that will be hashed and used to identify identical subjects
        string getHashVal();
        //Parent of this subject if it exists
        Subject getParent();
        //A Property of this subject
        Property getAProperty();
        //A tag attached to this subject
        Tag getATag();
    }
}

signature module FullDefSig
{
    class Subject{
        //Name of the subject
        string getName();
        //Value that will be hashed and used to identify identical subjects
        string getHashVal();
        //Parent of this subject if it exists
        Subject getParent();
        //A Property of this subject
        Property getAProperty();
        //A tag attached to this subject
        Tag getATag();
    }

    class Tag
    {
        //Name of the tag
        string getName();
        //Short name of the tag
        string getShortName();
        //Description of the tag (optional)
        string getDescription();
        //Color of the tag
        string getColor();
    }

    class PropertyKind
    {
        //Name of this kind of property
        string getName();
        //Optional description of this kind of property
        string getDescription();
        //Should this kind of property be used to match results and subjects
        boolean isMatching();
    }

    class Property
    {
        //Value of this property instance
        string getValue();
        //Kind/Type of this property instance
        PropertyKind getKind();
    }

    class Result
    {
        //Value whose hash will be used to determine identical results in the aggregator
        string getHashValue();
        //Title of the result
        string getTitle();
        //The subject containing this result
        Subject getSubject();

        //One of the tags belonging to this result
        Tag getATag();
        //One of the properties belonging to this result
        Property getAProperty();
        //The description of this result. (Supports markdown)
        string getDescription();
    }
}