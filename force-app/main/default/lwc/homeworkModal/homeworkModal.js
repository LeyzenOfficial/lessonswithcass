import { LightningElement, api, wire } from 'lwc';
import { CloseActionScreenEvent } from 'lightning/actions';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';
import createContact from '@salesforce/apex/ContactService.createContact';

export default class HomeworkModal extends NavigationMixin(LightningElement) {


    //Object records
    contact;

    //record id
    @api recordId;

    //Record Values
    inputValue;


    handleClick(){ 
        createContact({conName : this.inputValue, accountId : this.recordId})
            .then(result => {
                this.navigateToWebPage();
                this.closeModal();
                const evt = new ShowToastEvent({
                    title: 'Success!',
                    //message: this.account.Name + ' has been created!',
                    message: `Contact has been created!`,
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

    // Navigation to web page 
    navigateToWebPage() {
        this[NavigationMixin.Navigate]({
            "type": "standard__webPage",
            "attributes": {
                "url": "https://sdadasd-dev-ed.develop.lightning.force.com/lightning/r/Account/001Dn00000EVajTIAT/view"
            }
        });
    }

    closeModal() {
        // Close the modal window and display a success toast
        this.dispatchEvent(new CloseActionScreenEvent());
    }
}