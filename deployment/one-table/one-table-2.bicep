/**************************************************/
//  Deploy a database with one table in it

@description('Name of the cluster to deploy DBs under')
param clusterName string
@description('Region override')
param region string

var actualRegion = length(region)==0 ? resourceGroup().location : region

resource cluster 'Microsoft.Kusto/clusters@2021-01-01' existing = {
  name: clusterName
}

resource perfTestDbs 'Microsoft.Kusto/clusters/databases@2021-01-01' = {
  name: 'one-table'
  location: actualRegion
  parent: cluster
  kind: 'ReadWrite'

  resource dbScript 'scripts@2022-02-01' = {
    name: 'myscript'
    properties: {
      scriptContent: '.create table SimpleTable(Id:int, Name:string, Salary:real)'
    }
  }
}
