awscli es list-domain-names --output table --query "sort_by(DomainNames,&DomainName)[$(auto_filter DomainName -- $@)].{\"1.Name\":DomainName}"
