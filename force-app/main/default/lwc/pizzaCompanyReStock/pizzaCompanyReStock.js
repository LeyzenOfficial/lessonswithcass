import { LightningElement } from 'lwc';

import updateReStock from '@salesforce/apex/PizzaOrderService.updateReStock';

//Toast import
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

const PICKLIST_VALUES = [
    { label: 'Bacon', value: 'Bacon' },
    { label: 'Cheese', value: 'Cheese' },
    { label: 'Dough', value: 'Dough' },
    { label: 'Mushroom', value: 'Mushroom' },
    { label: 'Pepperoni', value: 'Pepperoni' },
    { label: 'Pineapple', value: 'Pineapple' },
];

export default class PizzaCompanyReStock extends LightningElement {

    ingredientType = '';
    numberOfIngredients = '';

    get picklistValues(){
        return PICKLIST_VALUES;
    }

    handleRestockIngredientsButtonClick() {

        if(this.handleErrors()){
            return;
        }


        updateReStock({ingredient : this.ingredientType, numberOfIngredients : this.numberOfIngredients})
        .then(() => {

            const evt = new ShowToastEvent({
                title: 'Success!',
                message: `${this.ingredientType} has been re-stocked`,
                variant: 'success',
            });
            this.dispatchEvent(evt);

            this.ingredientType = null;
            this.numberOfIngredients = null;

        })
        .catch(error => {
            console.error(error);

            this.showErrorToast(error.body.message);
        });
    }



    handleingredientTypeChange(event) {
        this.ingredientType = event.detail.value;
    }

    handleNumberOfIngredientsChange(event) {
        this.numberOfIngredients = event.detail.value;
    }

    showErrorToast(message){

        const evt = new ShowToastEvent({
            title: 'ERROR!',
            message: message,
            variant: 'error',
        });
        this.dispatchEvent(evt);

    }

    handleErrors(){

        if(!this.numberOfIngredients){

            this.showErrorToast('Amount of ingredients is empty!');
            return true;

        } else if (!this.ingredientType){

            this.showErrorToast('Ingredient type is empty!')
            return true;
        }
        
        
    }

}