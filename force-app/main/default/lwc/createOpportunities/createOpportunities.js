import { LightningElement } from 'lwc';
import createAmountOfOpportunities from '@salesforce/apex/OpportunityService.createAmountOfOpportunities';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

const columns = [
    { label: 'Opportunity Name', fieldName: 'nameUrl', type: 'url', typeAttributes: {label: { fieldName: 'Name' }, target: '_blank'},},
    { label: 'Stage', fieldName: 'StageName'},
    { label: 'Close Date', fieldName: 'CloseDate'},
    { label: 'Tracking Number', fieldName: 'TrackingNumber__c'},
    { label: 'Order Number', fieldName: 'OrderNumber__c'},
    
];

const stages = [
    { label: 'Prospecting', value: 'Prospecting' },
    { label: 'Qualification', value: 'Qualification' },
    { label: 'Closed Won', value: 'Closed Won' },
    { label: 'Closed Lost', value: 'Closed Lost'},
];

export default class CreateOpportunities extends LightningElement {

    //Stage names
    stages = stages;

    //Data Table
    columns = columns;

    //Object records
    opportunities;

    //Value inputs
    inputValue;
    inputValue2;
    inputValue3;
    closeDate;
    inputValue5;
    inputValue6;

    handleClick(){ 

        if(this.inputValue <= 0){
            const evt = new ShowToastEvent({
                title: 'error!',
                message: 'Value must be greater than 0!',
                variant: 'error',
            });
            this.dispatchEvent(evt);
        }else{

        createAmountOfOpportunities({
            i : this.inputValue, 
            name : this.inputValue2, 
            stage : this.inputValue3, 
            closeDate : this.closeDate, 
            trackingNumber : this.inputValue5, 
            orderNumber : this.inputValue6})
            .then(result => {
                let nameUrl;
                this.opportunities = result.map(row => { 
                    nameUrl = `/${row.Id}`;
                    return {...row , nameUrl} 
                })

                this.dispatchEvent(new ShowToastEvent({
                    title: 'Success!',
                    message: `${this.inputValue} opportunities have been created!`,
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
    
    handleInputChange2(event){

        this.inputValue2 = event.target.value;
    }

    handleStageName(event) {

        this.inputValue3 = event.target.value;
    }

    handleCloseDate(event){

        this.closeDate = event.target.value;
        console.log(this.closeDate);
    }

    handleInputChange5(event){

        this.inputValue5 = event.target.value;
    }

    handleInputChange6(event){

        this.inputValue6 = event.target.value;
    }

}