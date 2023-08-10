import { LightningElement } from 'lwc';
import createAccounts from '@salesforce/apex/AccountService.createAccounts';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

const columns = [
    { label: 'Account Name', fieldName: 'nameUrl', type: 'url', typeAttributes: {label: { fieldName: 'Name' }, target: '_blank'},},
    { label: 'Website', fieldName: 'Website'},
    { label: 'Phone', fieldName: 'Phone'},
    { label: 'Account Rating', fieldName: 'Rating'},
    
];

//FUNCTION = METHOD
//PROPERTY = VARIABLE

export default class MassCreateAccount extends LightningElement {

    //DataTable
    columns = columns;

    //Object records
    accounts;

    //Value inputs
    inputValue;

    handleClick(){ 

        if(this.inputValue <= 0){
            const evt = new ShowToastEvent({
                title: 'error!',
                message: 'Value must be greater than 0!',
                variant: 'error',
            });
            this.dispatchEvent(evt);
        }else{

        createAccounts({int : this.inputValue})
            .then(result => {
                let nameUrl;
                this.accounts = result.map(row => { 
                    nameUrl = `/${row.Id}`;
                    return {...row , nameUrl} 
                })

                this.dispatchEvent(new ShowToastEvent({
                    title: 'Success!',
                    message: `${this.inputValue} accounts have been created!`,
                    variant: 'success'
                }));
            })
            .catch(error => {
                console.error(error);
                this.dispatchEvent(new ShowToastEvent({
                    title: 'Error',
                    message: error.body.message,
                    variant: 'error'
                }));
            });
    }
}

    handleInputChange(event){

        this.inputValue = event.target.value;
    }
}