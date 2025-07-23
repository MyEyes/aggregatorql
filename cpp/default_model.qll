import subject
import tag
import property
import cpp
import base.model

module DefaultQueryModel implements TagPropSubjSig
{
    class Tag = DefaultTags::Tag;
    class PropertyKind = DefaultPropertyKind;
    class Property = DefaultProperty;
    class Subject = DefaultSubject;
}
