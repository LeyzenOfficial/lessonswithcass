import { LightningElement, wire } from 'lwc';

import { getPicklistValues, getObjectInfo } from 'lightning/uiObjectInfoApi';

//Apex method imports
import createPizzaOrder from '@salesforce/apex/PizzaOrderService.createPizzaOrder';
import updatePizzaOrder from '@salesforce/apex/PizzaOrderService.updatePizzaOrder';
import getPizzaTypeUrl from '@salesforce/apex/PizzaOrderService.getPizzaTypeUrl';
import updatePizzaStock from '@salesforce/apex/PizzaOrderService.updatePizzaStock';
import doesCpfExist from '@salesforce/apex/PizzaOrderService.doesCustomerCPFExist';
import insertNewCustomer from '@salesforce/apex/PizzaOrderService.insertNewCustomer';

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
    disableNewCustomerInsert = false;


    //Is order processed?
    showProcessOrderButton = false;
    showDeliveryPizzaButton = false;
    showPlaceNewOrderButton = false;
    showPizzaIsReadyButton = false;


    //HandleValues
    numberOfPizzas;
    customerCPF;
    customer;
    customerIsNull = false;

    newCustomerName;
    newCustomerCpf;
    newCustomerPhone;

    showCpf = false;

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


    handleNewCustomerInsert(){

        insertNewCustomer({newCustomerCpf : this.newCustomerCpf, newCustomerName : this.newCustomerName, newCustomerPhone : this.newCustomerPhone})
            .then(result => {

                this.customerIsNull = false;
        
                this.dispatchEvent(new ShowToastEvent({
                    title: 'Success!',
                    message: 'New customer has been created!',
                    variant: 'success'
                }));
            })
            .catch(error => {

                //error.body.message custom variable
                let errorMessage = error.body.message;

                if(errorMessage.includes('Invalid CPF')){
                    errorMessage = 'Invalid CPF!';
                }


                this.dispatchEvent(new ShowToastEvent({
                    title: 'Error',
                    message: errorMessage,
                    variant: 'error'
                }));
            });
    }

    //Create order button
    handleOrderPizzaButtonClick(){

        console.log('inside button worked');

        if(this.numberOfPizzas && this.pizzaType != null){

            if(this.NewCustomerCpf){
                this.customerCPF = this.NewCustomerCpf;
            }

            //Checking if the cpf exists
            doesCpfExist({cpf : this.customerCPF})
            .then(result => {

                this.customer = result;

                if(this.customer == null){

                    this.disableCreateOrderButton = false;
                    this.customerIsNull = true;

                    return;
                }

                this.updateIngredientStock();
                this.insertPizzaOrder();
                
                this.showProcessOrderButton = true;
                this.disableCreateOrderButton = true;
                this.disableNewCustomerInsert = true;

                this.dispatchEvent(new ShowToastEvent({
                    title: 'Success!',
                    message: 'Customer found!',
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
            //Checking if the cpf exist

            

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

        this.updatePizza('The order has been processed!');
        
        this.showPizzaIsReadyButton = true;
        this.disableProcessOrderButton = true;

    }
    //Deliver order button
    handlePizzaIsReadyButtonClick(){

        this.pizzaOrder.Status__c = DONE_STATUS;

        console.log(this.pizzaOrder);

        this.updatePizza('The pizza is ready!');

        this.showDeliveryPizzaButton = true;
        this.disablePizzaIsReadyButton = true;

    }
    handleDeliveryPizzaButtonClick(){

        this.pizzaOrder.Status__c = DELIVERED_STATUS;

        console.log(this.pizzaOrder);

        this.updatePizza('The pizza has been delivered!');

        this.showPlaceNewOrderButton = true;
        this.disableDeliverOrder = true;
        this.customerIsNull = false;

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
        this.customerIsNull = false;

        this.showPizzaImage = false;
        this.showCpf = false;

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

                    ////////
                    this.showCpf = true;
                    ////////

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

    handleCustomerCpf(event){

        this.customerCPF = event.detail.value; 

    }

    handleNewCustomerName(event){

        this.newCustomerName = event.detail.value;
    }

    handleNewCustomerCpf(event){

        this.newCustomerCpf = event.detail.value;
    }

    handleNewCustomerPhone(event){

        this.newCustomerPhone = event.detail.value;
    }

    updatePizza(message){

        updatePizzaOrder({pizzaOrder : this.pizzaOrder})
            .then(result => {
                
                this.pizzaOrder = result;

                console.log(this.pizzaOrder);

                const evt = new ShowToastEvent({
                    title: 'Success!',
                    message: message,
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

    updateIngredientStock(){

        updatePizzaStock({ pizzaType: this.pizzaType, numberOfPizzas: this.numberOfPizzas})
            .then(result => {

                console.log('Stock updated');

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
    insertPizzaOrder(){

        createPizzaOrder({pizzaType : this.pizzaType, amount : this.numberOfPizzas, status : ORDERED_STATUS, customer : this.customer})
            .then(result => {
                
                this.pizzaOrder = result;

                console.log(this.pizzaOrder);

                const evt = new ShowToastEvent({
                    title: 'Success!',
                    message: 'The order has been created!',
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

    handleCloseModalClick(){

        this.customerIsNull = false;
        
    }

    get cpf(){
        return this.customerCPF;
    }
}