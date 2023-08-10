import { LightningElement } from 'lwc';
import createAccount from '@salesforce/apex/AccountService.createAccount';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class CreateAccount extends LightningElement {

    //Object records
    account;

    //Record Values
    inputValue;



    handleClick(){ 
        createAccount({accName : this.inputValue})
            .then(result => {
                this.account = result;
                const evt = new ShowToastEvent({
                    title: 'Success!',
                    //message: this.account.Name + ' has been created!',
                    message: `${this.account.Name} has been created!`,
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
    

    handleInputChange(event){

        this.inputValue = event.target.value;
    }
}