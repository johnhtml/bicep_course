param pSqlServerName string
param pSqlDBName string = 'sql-server-bicep-test-998987987'
param location string

param administratorLogin string
@secure()
param administratorLoginPassword string

resource sqlServer 'Microsoft.Sql/servers@2014-04-01' ={
  name: pSqlServerName
  location: location
  properties: {
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorLoginPassword
  }
}


resource sqlServerFirewallRules 'Microsoft.Sql/servers/firewallRules@2021-02-01-preview' = {
  parent: sqlServer
  name: 'Development Ip Address'
  properties: {
    startIpAddress: '1.1.1.1'
    endIpAddress: '1.1.1.1'
  }
}


resource sqlServerDatabase 'Microsoft.Sql/servers/databases@2014-04-01' = {
  parent: sqlServer
  name: pSqlDBName
  location: location
  properties: {
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    edition: 'Basic'
    maxSizeBytes: '2147483648'
    requestedServiceObjectiveName: 'Basic'
  }
}
