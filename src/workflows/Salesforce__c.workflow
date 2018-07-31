<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Reddy_Added</fullName>
        <ccEmails>pradeep.mounik@gmail.com</ccEmails>
        <ccEmails>ramireddypradeepkumarreddy@gmail.com</ccEmails>
        <description>Student Reddy Added</description>
        <protected>false</protected>
        <recipients>
            <recipient>ramireddypradeepreddy@gmail.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SalesNewCustomerEmail</template>
    </alerts>
    <fieldUpdates>
        <fullName>Reddy_Added</fullName>
        <field>Male__c</field>
        <literalValue>1</literalValue>
        <name>Reddy Added</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Reddy_Email</fullName>
        <field>Personal_Email__c</field>
        <formula>&quot;pradeep@gmail.com&quot;</formula>
        <name>Reddy Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Rule 1</fullName>
        <actions>
            <name>Reddy_Added</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Reddy_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Salesforce__c.Total_number_of_cars__c</field>
            <operation>equals</operation>
            <value>4</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
