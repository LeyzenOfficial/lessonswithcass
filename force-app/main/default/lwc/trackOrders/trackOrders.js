import { LightningElement } from 'lwc';

import trackOrder from '@salesforce/apex/PizzaOrderService.trackOrderNumber';

//Toast import
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

const columns = [
    { label: 'Pizza Order', fieldName: 'Name'},
    { label: 'Status', fieldName: 'Status__c'},
    { label: 'Pizza Type', fieldName: 'Pizza_type__c'},
    { label: 'Amount of pizzas', fieldName: 'Amount__c'},
    
];

export default class TrackOrders extends LightningElement {

    orderNumber;
    orders;

    //Data Table
    columns = columns;

    handleTrackOrderButtonClick(){ 
        trackOrder({orderNumber : this.orderNumber})
            .then(result => {

                let list = [];
                list.push(result);

                this.orders = list;



                console.log('result', result);

                this.dispatchEvent(new ShowToastEvent({
                    title: 'Success!',
                    message: 'Order has been found!',
                    variant: 'success'
                }));
            })
            .catch(error => {

                this.dispatchEvent(new ShowToastEvent({
                    title: 'Error',
                    message: error.body.message,
                    variant: 'error'
                }));
            });
    } 


    handleOrderNumber(event){

        this.orderNumber = event.target.value;
    }

}