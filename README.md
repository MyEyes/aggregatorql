# aggregatorql
CodeQL library to make it easy to generate conformant bqrs result sets for the aggregation tooling

This README only discusses the structure and codeQL specific aspects, but **assumes you are already familiar** with the core concepts of the [Aggregator](https://github.com/MyEyes/Aggregator).  
If you want to learn about the core aspects of the Aggregator tool, please head over to that repo.

## Structure
This qlpack implements the **generic interfaces** in `base` and anything **c/cpp** specific in the `cpp` subfolder.

The main benefit of using the modules is that they will guarantee that the generated `bqrs` file has the correct format for the [`codeql_agg`](https://github.com/MyEyes/codeql_agg) tool to submit them to the [aggregator](https://github.com/MyEyes/Aggregator) API.

Unfortunately `codeql` doesn't allow deferred binding when using the `query` keyword, so there's a blob of query declarations that need to be copied into your query manually (See [COPY_ME.ql](COPY_ME.ql) or [example.ql](example.ql)). If I come up with a way around this I will of course implement that instead.

You can see the required structure for a compatible query in [base/query.qll](base/query.qll).
You could implement the module signature fully yourself, but I have created many sensible default implementations that you should be able to use out of the box or at the very least use as an example to start from.

Since `Tag`, `PropertyKind` and `Property` are really only fancy strings they extend `string` and in the `DefaultQueryModel` can also be supplied via `external` predicates.
Some `Properties` like `FilePath` are not independent of the underlying database and are therefore implemented in the `cpp` subtree.

The topographic order of the classes interdependencies is as follows:
```
`Tag`            
`PropertyKind`  --> `Property` -> Subject -> Result
```
If you don't want to use the `DefaultQueryModel` you can reuse the existing default `Tags` and `Properties` and only create your own `Subject` class for example

## Getting started
The simplest way to produce an automated query is to implement the `ResultQuerySig<DefaultQueryModel>` which you can see in `example.ql`.
*Note that all predicates here are called `results_foo` not `result_foo`.*

This signature only requires declaring a `ResultAnchor` type, which is used to associate a result with its `Subject` and the following predicate:
* `predicate results(ResultAnchor aresult, DefaultQueryModel::Subject subject, string title, string description, string hash_val)`
    * This predicate should bind each result to its subject, title, description and the identifying hash value (as a string).

Optionally the following two predicates can be implemented:
* `predicate results_properties(ResultAnchor aresult, ModelDefinition::Property property)`
    * This predicate should bind each result to all of its properties. Think of it as basically `Result.getAProperty` just in predicate form.
* `predicate results_tags(ResultAnchor aresult, ModelDefinition::Tag tag)`
    * This predicate should bind each result to all of its tags. Think of it as basically `Result.getATag` just in predicate form.
If these aren't defined the results simply won't have properties and tags, so if you don't plan to use them you just need to create the `results` predicate.

You can probably just copy the `example.ql` or `example_min.ql` contents and modify them as needed.

## Custom Tags
If you want to add additional tags, the simplest way is to use the default Tag class while providing the  
`external predicate tag_predicate(string name, string shortname, string color, string description)`  
in a csv file via the `--external=tag_predicate=` option in `codeql query run`.

You can use `cpp/default_tags.csv` as a reference for both default tags and the required structure of the csv file.

## Custom PropertyKinds/Properties
If you want to add additional properties or propertyKinds, you can also do so via a `csv` file with the `--external=property_predicate=` and `--external=property_kind_predicate=` options respectively.

These predicates have the following signatures:
```
external predicate property_kind_predicate(string name, string description, boolean is_matching);
external predicate property_predicate(string kind, string value);
```

**If your properties represent something that's stored in the codeQL database, you can't really do this sensibly for the actual property values.**  
(Unless you generate the csv yourself from queries first, which may make sense in some scenarios, I guess)
In those cases use `cpp/property.qll` as a reference for how to implement custom properties that depend on the database.

## Custom Subjects
If you want to implement your own types of subjects or want to add additional properties or tags to them, you will need to implement your own `Subject` class.  
I'd recommend `cpp/subject.qll` as a reference.

## Templating
The fields of `Subjects` and `Results` support templating via `jinja2` and have some helpers implemented in the `template_helpers.qll` files.  
The specifics can be found in the documentation of [`codeql_agg`](https://github.com/MyEyes/codeql_agg).