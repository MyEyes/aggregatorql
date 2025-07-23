import cpp
import tag
import property
import template_helpers
import base.model

module DefaultSubjectModelDefinition implements TagPropSig
{
    class Tag = DefaultTags::Tag;
    class Property = DefaultProperty;
    class PropertyKind = DefaultPropertyKind;
}

module MakeDefaultSubjects<TagPropSig ModelDefinition> implements TagPropSubjSig
{
    class Tag = ModelDefinition::Tag;
    class Property = ModelDefinition::Property;
    class PropertyKind = ModelDefinition::PropertyKind;

    abstract class Subject instanceof Element
    {
        //Name of the subject
        abstract string getName();
        //Value that will be hashed and used to identify identical subjects
        abstract string getHashVal();
        //Parent of this subject if it exists
        Subject getParent() {none()}
        //A Property of this subject
        ModelDefinition::Property getAProperty() {none()}
        //A tag attached to this subject
        ModelDefinition::Tag getATag() {none()}

        string toString(){result = "Subject: "+getName()}
    }

    additional final class ExtFunction = Function;

    additional class FunctionSubject extends Subject instanceof ExtFunction
    {
        override Tag getATag() {
            result.getName() = "function"
        }

        override string getHashVal(){result = exportLocation(this.(Function).getLocation())}

        override string getName(){result = this.(Function).getName()}

        override Property getAProperty() {result.getValue() = this.(Function).getFile().getRelativePath()}
    }

    additional class FileSubject extends Subject instanceof File
    {
        override Tag getATag() {
            result.getName() = "file"
        }
        override string getHashVal(){result = this.(File).getRelativePath()}
        override string getName(){result = this.(File).getBaseName()}
    }
}

class DefaultSubject = MakeDefaultSubjects<DefaultSubjectModelDefinition>::Subject;