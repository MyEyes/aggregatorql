import base.base_tags

external predicate tag_predicate(string name, string shortname, string color, string description);

predicate isDefaultOrCustomTag(string name, string shortname, string color, string description)
{
    isDefaultTag(name, shortname, color, description)
    or tag_predicate(name,shortname,color,description)

}

module DefaultTags = GenericTag<isDefaultTag/4>;
class Tag = DefaultTags::Tag;