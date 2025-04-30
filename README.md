# Instalaciones iniciales
instalar azure cli
instalar extensión bicep en visual studio code

# Inicio de sesión y selección de suscripción
    az login
no olvides seleccionar la suscripción correcta, por ejemplo:

    az account set --subscription 2b5290c0-b6ac-42f8-9759-427611a5b36a

con el comando despliega el template:

    az deployment group create --resource-group rs_bicep --template-file arm_template.json

    az deployment group create --resource-group rs_bicep --template-file biceptemplate.bicep

# Desplegar grupos de recursos

    az deployment sub create --location eastus --template-file 01ResourceGroup.bicep

# AZURE BICEP PLAYGROUND
what is azure bicep playground?
    The tool allows us to search for a bicep template that suits our requirements
    it will convert an ARM templete to bicep format

    https://azure.github.io/bicep/
Tiene muuuchas plantillas de buena calidad :)


y para crear un grupo de recursos:

     az deployment sub create -l eastus -f 01ResourceGroup.bicep

para crear el app service plan:

    az deployment group create -g rg-bicep-test -f 02AppServicePlant.bicep


# WHAT IF FUNCTION
Los siguientes dos comandos hacen los mismo:

    az deployment group create -g rg-bicep-test -f 02AppServicePlant.bicep --confirm-with-what-if
    az deployment group create -g rg-bicep-test -f 02AppServicePlant.bicep -c

# Creación de la DB
Para la propiedad

    maxSizeBytes: '2147483648'
para que sea basic

    collation: 'SQL_Latin1_General_CP1_CI_AS'


    az deployment group create -g rg-bicep-test -f .\03SQLdatabase.bicep -c

También se debe crear una whitelist para que se pueda acceder desde determinada
IP o grupo de IPs

# Modules

    az deployment group create -g rg-bicep-test -f 00Main.bicep


# From bicep to ARM

    bicep build 00Main.bicep

Del arhivo ARM se puede crear fácilmente el archivo de parámetros
click sobre la sección y generar un nuevo archivo

para correr el main.bicep en donde este tome los parámetros guardados en el
archivo de parámetros se usa el siguiente comando:

    az deployment group create -g rg-bicep-test -f 00Main.bicep -p 00Main.parameters.json


## Ambientes
### Script .bat para despliegues en diferentes ambientes

Puedes usar el siguiente archivo `.bat` para automatizar los despliegues en los diferentes ambientes:

```bat
@echo off
:: Script para desplegar en diferentes ambientes

echo Desplegando en el entorno DEV...
az deployment group create -g rg-bicep-dev-test -f 00Main.bicep -p 00MainDev.parameters.json

echo Desplegando en el entorno STG...
az deployment group create -g rg-bicep-stg-test -f 00Main.bicep -p 00MainStg.parameters.json

echo Desplegando en el entorno PRD...
az deployment group create -g rg-bicep-prd-test -f 00Main.bicep -p 00MainPrd.parameters.json

echo Despliegues completados.
pause
