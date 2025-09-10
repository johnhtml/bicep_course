# Instalaciones iniciales
instalar azure cli
instalar extensión bicep en visual studio code

Comandos con azure cli
az deployment sub create --location eastus --template-file 01ResourceGroup.bicep  
az deployment group create -g rg-bicep-dev -f 00Main.bicep -p 00Main.parameters.json --debug

