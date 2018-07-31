<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Happy_birthday</fullName>
        <ccEmails>ksb994@gmail.com</ccEmails>
        <ccEmails>pradeep.mounik@gmail.com</ccEmails>
        <description>Happy birthday</description>
        <protected>false</protected>
        <recipients>
            <recipient>aravind@salesforce.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>ksb994@salesforce.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>pradeep.mounik@gmail.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>ramireddypradeepreddy@gmail.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Apex_test</template>
    </alerts>
    <rules>
        <fullName>Happy Birthday</fullName>
        <actions>
            <name>Happy_birthday</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>1</booleanFilter>
        <criteriaItems>
            <field>Contact.Birthdate</field>
            <operation>equals</operation>
            <value>12/10/2017</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <offsetFromField>Contact.Birthdate</offsetFromField>
            <timeLength>-1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
</Workflow>
