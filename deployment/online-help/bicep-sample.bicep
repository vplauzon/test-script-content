param forceUpdateTag string = utcNow()
param continueOnErrors bool = false
param clusterName string
param databaseName string
param scriptName string

resource cluster 'Microsoft.Kusto/clusters@2022-02-01' existing = {
    name: clusterName
}

resource db 'Microsoft.Kusto/clusters/databases@2022-02-01' existing = {
    name: databaseName
    parent: cluster
}

resource perfTestDbs 'Microsoft.Kusto/clusters/databases/scripts@2022-02-01' = {
    name: scriptName
    parent: db
    properties: {
        scriptContent: loadTextContent('script.kql')
        continueOnErrors: continueOnErrors
        forceUpdateTag: forceUpdateTag
    }
}
