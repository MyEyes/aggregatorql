import model


signature module AggregationQueriesSig<FullDefSig ModelDefinition>
{
    predicate tags(ModelDefinition::Tag tag, string name, string shortname, string description, string color);
    predicate property_kinds(ModelDefinition::PropertyKind kind, string name, boolean is_matching, string description);
    predicate properties(ModelDefinition::Property property, ModelDefinition::PropertyKind kind, string value);
    predicate subjects(ModelDefinition::Subject subject, string name, string hash_val);
    predicate subject_properties(ModelDefinition::Subject subject, ModelDefinition::Property property);
    predicate subject_tags(ModelDefinition::Subject subject, ModelDefinition::Tag tag);
    predicate subject_parents(ModelDefinition::Subject subject, ModelDefinition::Subject parent);
}

module TagQueriesMake<FullDefSig ModelDefinition>
{
    predicate tags(ModelDefinition::Tag tag, string name, string shortname, string description, string color){
        tag.getName() = name
        and tag.getShortName() = shortname
        and tag.getDescription() = description
        and tag.getColor() = color
    }
}

module TagQueriesMakeRestrict<FullDefSig ModelDefinition>
{
    predicate tags(ModelDefinition::Tag tag, string name, string shortname, string description, string color){
        tag.getName() = name
        and tag.getShortName() = shortname
        and tag.getDescription() = description
        and tag.getColor() = color
        and exists(ModelDefinition::Result res | res.getATag() = tag or res.getSubject().getATag() = tag)
    }
}

module PropertyQueriesMake<FullDefSig ModelDefinition>
{
    predicate property_kinds(ModelDefinition::PropertyKind kind, string name, boolean is_matching, string description)
    {
        kind.getName() = name
        and kind.isMatching() = is_matching
        and kind.getDescription() = description
    }
    predicate properties(ModelDefinition::Property property, ModelDefinition::PropertyKind kind, string value){
        property.getKind() = kind
        and property.getValue() = value
    }
}

module PropertyQueriesMakeRestrict<FullDefSig ModelDefinition>
{
    predicate property_kinds(ModelDefinition::PropertyKind kind, string name, boolean is_matching, string description)
    {
        kind.getName() = name
        and kind.isMatching() = is_matching
        and kind.getDescription() = description
        and exists(ModelDefinition::Result res | res.getAProperty().getKind() = kind or res.getSubject().getAProperty().getKind() = kind)
    }
    predicate properties(ModelDefinition::Property property, ModelDefinition::PropertyKind kind, string value){
        property.getKind() = kind
        and property.getValue() = value
        and exists(ModelDefinition::Result res | res.getAProperty() = property or res.getSubject().getAProperty() = property)
    }
}

module SubjectQueriesMake<FullDefSig ModelDefinition>
{
    predicate subjects(ModelDefinition::Subject subject, string name, string hash_val)
    {
        subject.getName() = name
        and subject.getHashVal() = hash_val
    }

    predicate subject_properties(ModelDefinition::Subject subject, ModelDefinition::Property property) {
        subject.getAProperty() = property
    }

    predicate subject_tags(ModelDefinition::Subject subject, ModelDefinition::Tag tag)
    {
        subject.getATag() = tag
    }

    predicate subject_parents(ModelDefinition::Subject subject, ModelDefinition::Subject parent) {
        subject.getParent() = parent
    }
}

module SubjectQueriesMakeRestrict<FullDefSig ModelDefinition>
{
    predicate subjects(ModelDefinition::Subject subject, string name, string hash_val){
        subject.getName() = name
        and subject.getHashVal() = hash_val
        and exists(ModelDefinition::Result res | res.getSubject() = subject)
    }

    predicate subject_properties(ModelDefinition::Subject subject, ModelDefinition::Property property) {
        subject.getAProperty() = property
        and exists(ModelDefinition::Result res | res.getSubject() = subject)
    }

    predicate subject_tags(ModelDefinition::Subject subject, ModelDefinition::Tag tag)
    {
        subject.getATag() = tag
        and exists(ModelDefinition::Result res | res.getSubject() = subject)
    }

    predicate subject_parents(ModelDefinition::Subject subject, ModelDefinition::Subject parent) {
        subject.getParent() = parent
        and exists(ModelDefinition::Result res | res.getSubject() = subject)
    }
}

module ResultQueriesMake<FullDefSig ModelDefinition>
{
    predicate results(ModelDefinition::Result aresult, ModelDefinition::Subject subject, string title, string description, string hash_val){
        aresult.getSubject()=subject
        and aresult.getTitle() = title 
        and aresult.getDescription() = description
        and aresult.getHashValue() = hash_val
    }

    predicate results_properties(ModelDefinition::Result aresult, ModelDefinition::Property property) {
        aresult.getAProperty() = property
    }

    predicate results_tags(ModelDefinition::Result aresult, ModelDefinition::Tag tag) {
        aresult.getATag() = tag
    }
}

module AggregationQueriesMake<FullDefSig ModelDefinition> implements AggregationQueriesSig<ModelDefinition>
{
    import TagQueriesMake<ModelDefinition>
    import PropertyQueriesMake<ModelDefinition>
    import SubjectQueriesMake<ModelDefinition>
    import ResultQueriesMake<ModelDefinition>
}

signature module ResultQuerySig<TagPropSubjSig ModelDefinition>
{
    class ResultAnchor;
    predicate results(ResultAnchor aresult, ModelDefinition::Subject subject, string title, string description, string hash_val);
    default predicate results_properties(ResultAnchor aresult, ModelDefinition::Property property){none()}
    default predicate results_tags(ResultAnchor aresult, ModelDefinition::Tag tag){none()}
}

module AggregationQueriesFromResultQuery<TagPropSubjSig ModelDefinition, ResultQuerySig<ModelDefinition> QueryDefinition>
{
    module InternalModel implements FullDefSig
    {
        class Tag = ModelDefinition::Tag;
        class PropertyKind = ModelDefinition::PropertyKind;
        class Property = ModelDefinition::Property;
        class Subject = ModelDefinition::Subject;

        additional final class AnchorAlias = QueryDefinition::ResultAnchor;
        class Result extends AnchorAlias
        {
            private final string title;
            private final string description;
            private final string hash_val;
            private final Subject subject;
            Result(){
                QueryDefinition::results(this, subject, title, description, hash_val)
            }

            string getTitle(){result = title}
            string getDescription(){result = description}
            Subject getSubject(){result = subject}
            string getHashValue(){result = hash_val}
            Tag getATag(){QueryDefinition::results_tags(this, result)}
            Property getAProperty(){QueryDefinition::results_properties(this, result)}
            string toString(){result="Result: "+getTitle()}
        }
    }
    //We use the restrict variants to not always dump all possible tag and property values, just the ones that are actually in use
    import TagQueriesMakeRestrict<InternalModel>
    import PropertyQueriesMakeRestrict<InternalModel>
    import SubjectQueriesMakeRestrict<InternalModel>
    import ResultQueriesMake<InternalModel>
}