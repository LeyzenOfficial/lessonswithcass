import { LightningElement } from 'lwc';
import { CloseActionScreenEvent } from 'lightning/actions';
 
export default class FirstModal extends LightningElement {

   closeModal() {
        // Close the modal window and display a success toast
        this.dispatchEvent(new CloseActionScreenEvent());
   }
}