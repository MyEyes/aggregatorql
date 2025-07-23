import base.query
import default_model


module MakeQuery<TagPropSubjSig ModelDefinition, ResultQuerySig<ModelDefinition> ResultQuery>
{
    import AggregationQueriesFromResultQuery<ModelDefinition, ResultQuery>
}

module MakeQueryInstance<TagPropSubjSig ModelDefinition, ResultQuerySig<ModelDefinition> ResultQuery>
{
    private module internalQueries = AggregationQueriesFromResultQuery<ModelDefinition, ResultQuery>;
}