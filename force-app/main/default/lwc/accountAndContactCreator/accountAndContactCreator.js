import { LightningElement } from 'lwc';

//Apex method imports
import createAccountsAndContacts from '@salesforce/apex/AccountAndContactController.createAccountsAndContacts';

//Toast import
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

const accountColumns = [
    { label: 'Account Name', fieldName: 'Name'},
    { label: 'Website', fieldName: 'Website'},
    { label: 'Phone', fieldName: 'Phone'},
    { label: 'Account Rating', fieldName: 'Rating'},
    
];

const contactsColumns = [
    { label: 'Contact Name', fieldName: 'LastName'},
    { label: 'Account name', fieldName: 'accountName'},
    { label: 'Phone', fieldName: 'Phone'},
    { label: 'Account Rating', fieldName: 'Rating'},
    
];

export default class AccountAndContactCreator extends LightningElement {

    //DataTable
    accountColumns = accountColumns;
    contactsColumns = contactsColumns;

    //Object records
    account;
    contacts;

    //Record Values
    numberOfContacts;
    nameOfAccountAndContacts;

    createRecords(){ 
            
        createAccountsAndContacts({i : this.numberOfContacts, s : this.nameOfAccountAndContacts})
            .then(result => {
    
                this.account = result.accounts;

                this.contacts = result.contacts.map(row => { 
                    const accountName = `${row.Account.Name}`;
                    return {...row, accountName};
                });
                
                const evt = new ShowToastEvent({
                    title: 'Success!',
                    message: 'Accounts successfully loaded!',
                    variant: 'success',
                });
                this.dispatchEvent(evt);

            })
            .catch(error => {
                console.error(error);
                const evt = new ShowToastEvent({
                    title: 'ERROR!',
                    message: error.body.message,
                    variant: 'error',
                });
                this.dispatchEvent(evt);
            });
    }


    handleNumberOfContactsChange(event){

        this.numberOfContacts = event.target.value;
    }

    handleNameOfAccountAndContactsChange(event){

        this.nameOfAccountAndContacts = event.target.value;
    }
}