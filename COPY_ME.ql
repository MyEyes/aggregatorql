//If you implement a QueryDefinition module (see example.ql) you can copy 
//this block of code to get all of the required result sets in the bqrs output
module QueryBase = MakeQuery<DefaultQueryModel, QueryDefinition>;

//Unfortunately you can't easily create generic query type queries,
//you can just copy and paste this if you've created a QueryBase module
query predicate tags(QueryBase::InternalModel::Tag tag, string name, string shortname, string description, string color){QueryBase::tags(tag,name,shortname,description,color)}
query predicate property_kinds(QueryBase::InternalModel::PropertyKind kind, string name, boolean is_matching, string description){QueryBase::property_kinds(kind, name, is_matching, description)}
query predicate properties(QueryBase::InternalModel::Property property, QueryBase::InternalModel::PropertyKind kind, string value){QueryBase::properties(property, kind, value)}
query predicate subjects(QueryBase::InternalModel::Subject subject, string name, string hash_val){QueryBase::subjects(subject, name, hash_val)}
query predicate subject_properties(QueryBase::InternalModel::Subject subject, QueryBase::InternalModel::Property property){QueryBase::subject_properties(subject, property)}
query predicate subject_tags(QueryBase::InternalModel::Subject subject, QueryBase::InternalModel::Tag tag){QueryBase::subject_tags(subject, tag)}
query predicate subject_parents(QueryBase::InternalModel::Subject subject, QueryBase::InternalModel::Subject parent){QueryBase::subject_parents(subject, parent)}
query predicate results(QueryBase::InternalModel::Result aresult, QueryBase::InternalModel::Subject subject, string title, string description, string hash_val){QueryBase::results(aresult, subject, title, description, hash_val)}
query predicate result_properties(QueryBase::InternalModel::Result aresult, QueryBase::InternalModel::Property property){QueryBase::result_properties(aresult, property)}
query predicate result_tags(QueryBase::InternalModel::Result aresult, QueryBase::InternalModel::Tag tag){QueryBase::result_tags(aresult, tag)}