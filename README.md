# Salesforce DX Project: Next Steps

Now that you’ve created a Salesforce DX project, what’s next? Here are some documentation resources to get you started.

## How Do You Plan to Deploy Your Changes?

Do you want to deploy a set of changes, or create a self-contained application? Choose a [development model](https://developer.salesforce.com/tools/vscode/en/user-guide/development-models).

## Configure Your Salesforce DX Project

The `sfdx-project.json` file contains useful configuration information for your project. See [Salesforce DX Project Configuration](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_ws_config.htm) in the _Salesforce DX Developer Guide_ for details about this file.

## Read All About It

- [Salesforce Extensions Documentation](https://developer.salesforce.com/tools/vscode/)
- [Salesforce CLI Setup Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_intro.htm)
- [Salesforce DX Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_intro.htm)
- [Salesforce CLI Command Reference](https://developer.salesforce.com/docs/atlas.en-us.sfdx_cli_reference.meta/sfdx_cli_reference/cli_reference.htm)


# API Refferent of Project - ARCHITECT STRUCTURE

## /classes - controller

As the main package in Java, classes will includes multiple layer as controller, services, data, model.

### AccountApiController - /services/apexrest/Account/v1

- HttpGet "/:name": return listing of Account (SObject). If @pathvariable name == null will return all records of listing (will update Limit follow the scope of project after) Else return list of Account with Name Like @pathvariable name.

### ContactApiController - /services/apexrest/Contact/v1

- HttpGet "/:name": return listing of Contact (SObject). If @pathvariable name == null will return all records of listing (will update Limit follow the scope of project after) Else return list of Contact with Name Like @pathvariable name.
- HttpPost "/" : API create new Contact with body is Contact (SObject).
- HttpPatch "/": API support match Contact with Account. with body include 2 fields { accountId, contactId }.
- HttpPut "/": API support soft delete the Contact(SObject) give the Active field is false. Body include one field { contactId }

### RecordsSearchController - /services/apexrest/Records/Search

- HttpPost "/" : API search the RecordModel Listing, the body include one field { name }. This API will search the @name at body from 2 SObjects is Contact (Name) and Account (Name), the Apex like always support check case-sensitive.

### RecordsGraphQLController - /services/apexrest/Records/v1/query

- HttpPost "/" : API support increasement the Counter__c of RecordModel. the body include 2 fields { Id, RecordType }. Id is the selected Id from Table UI, RecordType is Account(SObject) or Contact (SObject). After active, the Counter__c will increase 1 number.
- HttpPatch "/" : API support batch update the Contact Listing. Likely MongoDB Driver Service, using the BatchUpdateContactRequestdata include 2 field { query , setter }, @query is the List<String> Id will update, @setter is Contact(SObject) with the field should updated isnot null.

## /classes - data

Include data should convertted from SObject. Two main folder is "response" and "request".

## /classes - service

The core of business login will be defined on the service layer.

## /classes - model

## /aura

## /lwc

You can write new Lightning web components and add them to apps that contain Aura components. Or, you can iteratively migrate on your schedule by replacing individual Aura components in your app with Lightning web components.

Lightning web components and Aura components can work together, but there are limitations that you must understand.

## /triggers

Include 3 triggers focus to handle DML of SObject with Database. In this project include 3 trigger is:

- BatchUpdateContactsTrigger.
- ContactTrigger.
- DeactiveContactTigger.