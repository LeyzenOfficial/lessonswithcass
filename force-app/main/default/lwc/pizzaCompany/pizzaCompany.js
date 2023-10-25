import { LightningElement, wire } from 'lwc';

import { getPicklistValues, getObjectInfo } from 'lightning/uiObjectInfoApi';

//Apex method imports
import createPizzaOrder from '@salesforce/apex/PizzaOrderService.createPizzaOrder';
import updateToOrderProcessed from '@salesforce/apex/PizzaOrderService.updateToOrderProcessed';
import updateToOrderDone from '@salesforce/apex/PizzaOrderService.updateToOrderDone';
import updateToOrderDelivered from '@salesforce/apex/PizzaOrderService.updateToOrderDelivered';
import getPizzaTypeUrl from '@salesforce/apex/PizzaCompanyService.getPizzaTypeUrl';

import PIZZA_ORDER_OBJECT from '@salesforce/schema/Pizza_Order__c';
import PIZZA_TYPE_FIELD from '@salesforce/schema/Pizza_Order__c.Pizza_type__c';


//Toast import
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

const ORDERED_STATUS = 'Ordered';
const IN_PROCESS_STATUS = 'In Process';
const DONE_STATUS = 'Done';
const DELIVERED_STATUS = 'Delivered';

export default class PizzaCompany extends LightningElement {

    pizzaType = '';

    //Pizza Visibility
    showPizzaImage = false;

    //Pizza Images
    pizzaImageSource;

    //Disable buttons
    disableCreateOrderButton = false;
    disableProcessOrderButton = false;
    disableDeliverOrder = false;
    disablePizzaIsReadyButton = false;


    //Is order processed?
    showProcessOrderButton = false;
    showDeliveryPizzaButton = false;
    showPlaceNewOrderButton = false;
    showPizzaIsReadyButton = false;


    //HandleValues
    numberOfPizzas;

    //Pizza order return
    pizzaOrder;

    picklistValues = [];

    // Wire the getPicklistValues function to retrieve the picklist values
    @wire(getPicklistValues, { recordTypeId: '$objectInfo.data.defaultRecordTypeId', fieldApiName: PIZZA_TYPE_FIELD })
    picklistValuesData({ error, data }) {
        if (data) {
            this.picklistValues = data.values.map(picklistValue => {
                return {
                    label: picklistValue.label,
                    value: picklistValue.value
                };
            });
        } else if (error) {
            console.error('Error loading picklist values:', error);
        }
    }

    @wire(getObjectInfo, { objectApiName: PIZZA_ORDER_OBJECT })
    objectInfo;


    //Create order button
    handleOrderPizzaButtonClick(){

        if(this.numberOfPizzas && this.pizzaType != null){

            createPizzaOrder({pizzaType : this.pizzaType, amount : this.numberOfPizzas, status : ORDERED_STATUS})
            .then(result => {
                
                this.pizzaOrder = result;

                console.log(this.pizzaOrder);

                const evt = new ShowToastEvent({
                    title: 'Success!',
                    message: 'Order created!',
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


            this.showProcessOrderButton = true;
            this.disableCreateOrderButton = true;

        } else {
                const evt = new ShowToastEvent({
                    title: 'ERROR!',
                    message: 'Please fill out all the fields before proceeding!',
                    variant: 'error',
                });
                this.dispatchEvent(evt);
        }
    }

    //Process order button
    handleProcessOrderButtonClick(){

        this.pizzaOrder.Status__c = IN_PROCESS_STATUS;

        console.log(this.pizzaOrder);

        updateToOrderDone({pizzaOrder : this.pizzaOrder})
            .then(result => {
                
                this.pizzaOrder = result;

                console.log(this.pizzaOrder);

                const evt = new ShowToastEvent({
                    title: 'Success!',
                    message: 'Order processed!',
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
        

        this.showDeliveryPizzaButton = true;
        this.disableProcessOrderButton = true;

    }
    //Deliver order button
    handleDeliveryPizzaButtonClick(){

        this.pizzaOrder.Status__c = DONE_STATUS;

        console.log(this.pizzaOrder);

        updateToOrderProcessed({pizzaOrder : this.pizzaOrder})
            .then(result => {
                
                this.pizzaOrder = result;

                console.log(this.pizzaOrder);

                const evt = new ShowToastEvent({
                    title: 'Success!',
                    message: 'Order done!',
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

        this.showPizzaIsReadyButton = true;
        this.disableDeliverOrder = true;

    }
    handlePizzaIsReadyButtonClick(){

        this.pizzaOrder.Status__c = DELIVERED_STATUS;

        console.log(this.pizzaOrder);

        updateToOrderDelivered({pizzaOrder : this.pizzaOrder})
            .then(result => {
                
                this.pizzaOrder = result;

                console.log(this.pizzaOrder);

                const evt = new ShowToastEvent({
                    title: 'Success!',
                    message: 'Order Delivered!',
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

        this.showPlaceNewOrderButton = true;
        this.disablePizzaIsReadyButton = true;

    }
    //Restart the LWC
    handleRefreshOrderClick(){

        this.showPlaceNewOrderButton = false; 
        this.showProcessOrderButton = false;
        this.showDeliveryPizzaButton = false;
        this.showPizzaIsReadyButton = false;

        this.disableCreateOrderButton = false;
        this.disableProcessOrderButton = false;
        this.disableDeliverOrder = false;
        this.disablePizzaIsReadyButton = false;

        this.showPizzaImage = false;

        this.pizzaType = null;
        this.numberOfPizzas = null;
    }

    handlePizzaTypeChange(event){

        this.pizzaType = event.detail.value; 

        getPizzaTypeUrl({pizzaType : this.pizzaType})
            .then(result => {
                
                if(result){

                    this.pizzaImageSource = result.Pizza_Image_URL__c;
                    this.showPizzaImage = true;

                    console.log(this.pizzaImageSource);

                } else {
                    this.showPizzaImage = false;

                    const evt = new ShowToastEvent({
                        title: 'WARNING!',
                        message: 'No image was found for this pizza! Contact your local admin!',
                        variant: 'warning',
                    });
                    this.dispatchEvent(evt);
                }
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

    handleNumberOfPizzas(event){

        this.numberOfPizzas = event.detail.value; 

    }
}