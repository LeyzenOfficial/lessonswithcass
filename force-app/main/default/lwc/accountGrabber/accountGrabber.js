import { LightningElement } from 'lwc';
//Apex method imports
import accGrabber from '@salesforce/apex/AccountService.accountGrabber';
import conGrabber from '@salesforce/apex/ContactService.contactGrabber';
import oppGrabber from '@salesforce/apex/OpportunityService.opportunityGrabber';
import taskGrabber from '@salesforce/apex/TaskService.taskGrabber';
import customTesterGrabber from '@salesforce/apex/CustomTesterService.customTesterGrabber';
//Toast import
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import { NavigationMixin } from 'lightning/navigation';

const columns = [
    { label: 'Account Name', fieldName: 'nameUrl', type: 'url', typeAttributes: {label: { fieldName: 'Name' }, target: '_blank'},},
    { label: 'Website', fieldName: 'Website'},
    { label: 'Phone', fieldName: 'Phone'},
    { label: 'Account Rating', fieldName: 'Rating'},
    
];

export default class AccountGrabber extends NavigationMixin(LightningElement) {

    //DataTable
    columns = columns;

    //Object records
    accounts;
    contacts;
    opportunities;
    tasks;
    customTesters;

    //Boolean

    showSpinner = false;

    //Record Values
    inputValue;
    inputValue2;
    inputValue3;
    inputValue4;
    inputValue5;

    //On click grabs account
    getAccount(){ 

        if(this.inputValue <= 0){
            const evt = new ShowToastEvent({
                title: 'error!',
                message: 'Value must be greater than 0!',
                variant: 'error',
            });
            this.dispatchEvent(evt);
        }else{
            this.showSpinner = true; 
            accGrabber({i : this.inputValue})
                .then(result => {
                    let nameUrl;
                    this.accounts = result.map(row => { 
                        nameUrl = `/${row.Id}`;
                        return {...row , nameUrl} 
                    })

                    //this.navigateToWebPage();    
                    const evt = new ShowToastEvent({
                        title: 'Success!',
                        message: 'Accounts successfully loaded!',
                        variant: 'success',
                    });
                    this.dispatchEvent(evt);
                    this.showSpinner = false;

                })
                .catch(error => {
                    console.error(error);
                    const evt = new ShowToastEvent({
                        title: 'ERROR!',
                        message: error.body.message,
                        variant: 'error',
                    });
                    this.dispatchEvent(evt);
                    this.showSpinner = false;
                });
        }
    }
    //On click grabs contact
    getContact(){ 
        conGrabber({i : this.inputValue2})
            .then(result => {
                let nameUrl;
                this.contacts = result.map(row => { 
                    nameUrl = `/${row.Id}`;
                    return {...row , nameUrl} 
                })

                const evt = new ShowToastEvent({
                    title: 'Success!',
                    message: 'Contacts successfully loaded!',
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
    //On click grabs opportunity
    getOpportunity(){ 
        oppGrabber({i : this.inputValue3})
            .then(result => {
                let nameUrl;
                this.opportunities = result.map(row => { 
                    nameUrl = `/${row.Id}`;
                    return {...row , nameUrl} 
                })

                const evt = new ShowToastEvent({
                    title: 'Success!',
                    message: 'Opportunities successfully loaded!',
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
    //On click grabs a task
    getTask(){ 
        taskGrabber({i : this.inputValue4})
            .then(result => {
                let nameUrl;
                this.tasks = result.map(row => { 
                    nameUrl = `/${row.Id}`;
                    return {...row , nameUrl} 
                })

                const evt = new ShowToastEvent({
                    title: 'Success!',
                    message: 'Tasks successfully loaded!',
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
    //On click grabs Custom tester
    getCustomTester(){ 
        customTesterGrabber({i : this.inputValue5})
            .then(result => {
                let nameUrl;
                this.customTesters = result.map(row => { 
                    nameUrl = `/${row.Id}`;
                    return {...row , nameUrl} 
                })

                const evt = new ShowToastEvent({
                    title: 'Success!',
                    message: 'Custom testers successfully loaded!',
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

    handleInputChange2(event){

        this.inputValue2 = event.target.value;
    }

    handleInputChange3(event){

        this.inputValue3 = event.target.value;
    }

    handleInputChange4(event){

        this.inputValue4 = event.target.value;
    }

    handleInputChange5(event){

        this.inputValue5 = event.target.value;
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
}