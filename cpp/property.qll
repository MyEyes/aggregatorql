import cpp
import base.base_properties

// Default Property Kinds
external predicate property_kind_predicate(string name, string description, boolean is_matching);

predicate isContainingFilePropertyKind(string name, string description, boolean is_matching)
{
    name = "ContainingFile"
    and description = "Filename of file containing this object"
    and is_matching = true
}

predicate isContainingPathPropertyKind(string name, string description, boolean is_matching)
{
    name = "ContainingPath"
    and description = "Path of file containing this object"
    and is_matching = true
}

predicate isContainingDirPropertyKind(string name, string description, boolean is_matching)
{
    name = "ContainingDir"
    and description = "Path of directory containing this object"
    and is_matching = true
}

predicate isBasePropertyKind(string name, string description, boolean is_matching)
{
    //It's fine if the .csv file duplicates these, they are explicitly included here to make sure the
    //`PropertyKind` for file, path and dir properties exist
    property_kind_predicate(name, description, is_matching)
    or isContainingFilePropertyKind(name, description, is_matching)
    or isContainingPathPropertyKind(name, description, is_matching)
    or isContainingDirPropertyKind(name, description, is_matching)
}


//Default Property Values

//This external predicate only really makes sense to use for things that have a limited value range. 
//(That's why the default_properties.csv file is empty)
//Version number or vendor name might make sense for example, because that is likely unique per run
//But for something that will depend on the subject or result in relation to the database it is more practical
//to query the database like below
external predicate property_predicate(string kind, string value);

predicate isContainingPathProperty(string kind, string value)
{
    kind = "ContainingPath"
    and exists(File f|f.getRelativePath() = value)
}

predicate isContainingFileProperty(string kind, string value)
{
    kind = "ContainingFile"
    and exists(File f|f.getBaseName() = value)
}

predicate isContainingDirProperty(string kind, string value)
{
    kind = "ContainingDir"
    and exists(Folder f|f.getAbsolutePath() = value)
}

predicate isBaseProperty(string kind, string value)
{
    property_predicate(kind, value)
    or isContainingFileProperty(kind, value)
    or isContainingPathProperty(kind, value)
    or isContainingDirProperty(kind, value)
}

module DefaultPropertyModule = GenericProperty<isBasePropertyKind/3, isBaseProperty/2>;
class DefaultPropertyKind = DefaultPropertyModule::PropertyKind;
class DefaultProperty = DefaultPropertyModule::Property;