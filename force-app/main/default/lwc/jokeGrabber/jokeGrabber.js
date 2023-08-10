import { LightningElement } from 'lwc';
import getCallout from '@salesforce/apex/JokesCallOut.getCallout';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';


export default class JokeGrabber extends LightningElement {

    //Objects
    joke;

    getJoke(){
        getCallout()
            .then(result => {
                this.joke = result;
                console.log('yooo this one', result);

                const evt = new ShowToastEvent({
                    title: 'Success!',
                    message: 'Joke successfully loaded!',
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
}
