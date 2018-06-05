# `polyply` - an R package for manipulation of multiple data-frames in a single magrittr pipeline

I've talked about these ideas on twitter and biostars recently, but haven't put the code together yet.

`dplyr` really shines in the manipulation of single data-frames and has functions for merging
existing data-frames together, similar to how tables are combined in relational databases.
The `dplyr` syntax gets rather heavy-handed when you need to both manipulate and merge more than
one data-frame in a single pipeline. 

An example might be illustrative:

Suppose data-frames `A`, `B`, and `C` exist that contain information related to a gene-expression
experiment. Any number of other applications could have been chosen.

`A` might contain annotation information for the genes that were studied (IDs in
external databases, gene lengths etc). 
`B` might contain information about the experimental samples
that were studied (was the sample treated with a particular treatment; where were the samples
sourced etc). 
`C` might contain the expression level for each gene in each sample.

Assume the three datasets are 'tidy'. There's a single row for each gene in `A`, there's a single
row for each sample in `B` and there's a single row for each gene/sample combination in `C`.

Suppose I want to extract the expression information for all patients sourced from Glasgow,
for genes that are longer than 2 kilobases. Then I want to pass that expression data into
ggplot2 and make a well-annotated scatter plot (the annotations using information from
both the gene-metadata `A` and the biological-samples-metadata `B`).

There's many ways to do this using standard tidyverse approaches.

~~~~
# prefilter, constructing superfluous data-frames
glasgow_samples <- filter(B, source == "Glasgow")
long_genes <- filter(A, gene_length > 2000)
expression_data <- C %>%
  inner_join(glasgow_samples, by = "sample_id") %>%
  inner_join(long_genes, by = "feature_id") %>%
  ggplot(...)
~~~~

~~~~
# filter within the join
C %>%
  inner_join(filter(B, source == "Glasgow"), by = "sample_id") %>%
  inner_join(filter(A, gene_length > 2000)) %>%
  ggplot(...)
~~~~

~~~~
# post-filter, making a huge temporary data-frame
C %>%
  inner_join(B, by = "sample_id") %>%
  inner_join(A, by = "feature_id") %>%
  filter(source == "Glasgow" & gene_length > 2000) %>%
  ggplot(...)
~~~~

All of the above are perfectly valid approaches.

If you do them once.

And if your data-frames are sufficently small.

But 'doing things just once' always seems like the exception rather than the rule,
and working with manageably-sized data-frames is another rarity.

So, to  mitigate against duplication, which bits of the above code should be
abstracted away?

Since the 'datasets used' will change less rapidly than the 'questions asked', I'm
more likely to need to change the filters / selections / mutations that are
applied to the individual data-frames than I am to change the pipeline for
joining-together the different datasets. Hell, there's a logical connection
between the different data-frames that is unaffected by filtering any given
data-frame - so surely joining on that logical connection should be abstracted out
first.

With-respect-to-the-above, we want to define a single merging function 
that will take the collestion of data-frames (assume a list of data-frames for now),
and return a single data-frame for filtering / selection etc or for use in `ggplot`.
This might look like:

~~~~
list(genes = A, samples = B, expressions = C) %>%
  my_merging_function() %>%
  filter(source == "Glasgow" & gene_length > 2000) %>%
  ggplot(...)
~~~~

Here, the merging function works similarly to how a View works in SQL - it's a
virtual specification for how data-tables should be combined together. But unlike
in SQL, there's no optimisation performed in R and so that query would create the
same huge temporary inner-join data-frame described above. Given that, something
like the following would be more memory efficient in R:

~~~~
list(
  genes = filter(A, ...),
  samples = filter(B, ...),
  expressions = C
) %>%
  my_merging_function() %>%
  ggplot(...)
~~~~

But but, what if you could do this:

~~~~
list(
  genes = A,
  samples = B,
  expressions = C
) %>%
  filter_a_specific_dataframe_within_that_collection(...) %>%
  filter_a_different_dataframe(...) %>%
  my_merging_function() %>%
  ggplot(...)
~~~~

... and have it behave algebraically identically to the two previous calls.
This would limit memory burden, limit the need to store intermediate results
but also allow you store intermediate results etc.

But but but, doesn't tidygraph do something similar already? in tidygraph, 
there are a couple of data-frames (one for edges and one for nodes) stored
inside a tbl_graph object, and you can mutate / filter / etc each of these
data-frames independently. To indicate which of the tables you want to work
with, you use 'activate'. So we could generalise the code from tidygraph
in a way that allows the following workflow:

~~~~
some_collection(genes = A, samples = B, expressions = C) %>%
  activate(genes) %>%
    filter(gene_length > 2000) %>%
  activate(samples) %>%
    filter(source == "Glasgow") %>%
  my_merging_function() %>%
  [... other filtering / mutation / selection steps ...] %>%
  [... downstream output maker ...]
~~~~

Happy to take criticism of the idea.
